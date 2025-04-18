import Course from "../models/Course.js";
import { CourseProgress } from "../models/CourseProgress.js";
import { Purchase } from "../models/Purchase.js";
import User from "../models/User.js";
import Razorpay from 'razorpay';

// Initialize Razorpay
const razorpay = new Razorpay({
    key_id: process.env.RAZORPAY_KEY_ID,
    key_secret: process.env.RAZORPAY_KEY_SECRET,
});

// Get User Data
export const getUserData = async (req, res) => {
    try {
        // Use req.user.id from JWT payload
        const userId = req.user.id; 

        const user = await User.findById(userId);

        if (!user) {
            // It's unlikely a valid token exists for a non-existent user,
            // but check anyway. Maybe return 404?
            return res.status(404).json({ success: false, message: 'User Not Found' });
        }

        // Return only necessary, non-sensitive user data
        res.json({ 
            success: true, 
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                imageUrl: user.imageUrl,
                enrolledCourses: user.enrolledCourses
                // Add role if needed
            }
        });

    } catch (error) {
        console.error("Get User Data Error:", error);
        res.status(500).json({ success: false, message: 'Server error fetching user data.' });
    }
};

// Purchase Course
export const purchaseCourse = async (req, res) => {
    try {
        const { courseId } = req.body;
        const userId = req.user.id;
        const { origin } = req.headers; // Get origin for redirect URLs

        if (!courseId) {
            return res.status(400).json({ success: false, message: 'Course ID is required.' });
        }
        if (!origin) {
            console.warn('Origin header missing, using fallback success URL.');
        }

        const courseData = await Course.findById(courseId);
        const userData = await User.findById(userId);

        if (!userData) {
            return res.status(404).json({ success: false, message: 'User not found.' });
        }
        if (!courseData) {
            return res.status(404).json({ success: false, message: 'Course not found.' });
        }

        // Check if already purchased/enrolled
        if (userData.enrolledCourses.includes(courseId)) {
            return res.status(400).json({ success: false, message: 'Course already purchased.' });
        }

        // Calculate final price (ensure it's in INR)
        const amount = Math.round(parseFloat((courseData.coursePrice - (courseData.discount || 0) * courseData.coursePrice / 100).toFixed(2)) * 100);

        // Create Purchase record
        const purchaseData = {
            courseId: courseData._id,
            userId,
            amount,
        };
        const newPurchase = await Purchase.create(purchaseData);

        // Create Razorpay order
        const options = {
            amount: amount,  // amount in the smallest currency unit
            currency: "INR",
            receipt: newPurchase._id.toString(), // Use purchase ID as receipt
        };

        razorpay.orders.create(options, function (err, order) {
            if (err) {
                console.error("Razorpay Order Error:", err);
                return res.status(500).json({ success: false, message: 'Error creating Razorpay order.' });
            }

            //Send the razorpay order id to the client
            res.json({
                success: true,
                razorpayOrderId: order.id,
                courseId: courseId
            });

        });

    } catch (error) {
        console.error("Purchase Course Error:", error);
        res.status(500).json({ success: false, message: 'Server error during course purchase.' });
    }
};

// Get User's Enrolled Courses 
export const userEnrolledCourses = async (req, res) => {
    try {
        // Use req.user.id from JWT payload
        const userId = req.user.id;

        const userData = await User.findById(userId)
            .populate({ // Populate enrolled courses with selected fields
                path: 'enrolledCourses',
                select: 'courseTitle courseDescription thumbnailUrl coursePrice discount' // Select fields you need
            });

        if (!userData) {
            return res.status(404).json({ success: false, message: 'User not found.' });
        }

        res.json({ success: true, enrolledCourses: userData.enrolledCourses || [] });

    } catch (error) {
        console.error("Get Enrolled Courses Error:", error);
        res.status(500).json({ success: false, message: 'Server error fetching enrolled courses.' });
    }
};

// Update User Course Progress
export const updateUserCourseProgress = async (req, res) => {
    try {
        // Use req.user.id from JWT payload
        const userId = req.user.id;
        const { courseId, lectureId } = req.body;

        // Validate inputs
        if (!courseId || !lectureId) {
            return res.status(400).json({ success: false, message: 'Course ID and Lecture ID are required.' });
        }

        // Check if user is enrolled in the course (important!)
        const user = await User.findOne({ _id: userId, enrolledCourses: courseId });
        if (!user) {
            return res.status(403).json({ success: false, message: 'User not enrolled in this course.' });
        }

        // Find or create progress document atomically (upsert)
        const progressData = await CourseProgress.findOneAndUpdate(
            { userId, courseId },
            { $addToSet: { lectureCompleted: lectureId } }, // $addToSet prevents duplicates
            { new: true, upsert: true } // Return updated doc, create if not found
        );

        // Check if the lecture was actually added or already existed
        // The response from findOneAndUpdate with $addToSet might not directly indicate this,
        // but the operation ensures it's in the set.
        res.json({ success: true, message: 'Progress Updated', progressData });

    } catch (error) {
        console.error("Update Progress Error:", error);
        res.status(500).json({ success: false, message: 'Server error updating course progress.' });
    }
};

// Get User Course Progress for a Specific Course
export const getUserCourseProgress = async (req, res) => {
    try {
        // Use req.user.id from JWT payload
        const userId = req.user.id;
        // Get courseId from route parameters or query string for RESTful practice
        // Modify the corresponding route in userRoutes.js to include :courseId
        const { courseId } = req.params; 

        if (!courseId) {
            return res.status(400).json({ success: false, message: 'Course ID is required in the URL path.' });
        }

        // Optional: Check if user is enrolled before fetching progress
        const user = await User.findOne({ _id: userId, enrolledCourses: courseId });
        if (!user) {
            return res.status(403).json({ success: false, message: 'User not enrolled in this course.' });
        }

        const progressData = await CourseProgress.findOne({ userId, courseId });

        // If no progress record exists, return default/empty state
        if (!progressData) {
            return res.json({ success: true, progressData: { userId, courseId, lectureCompleted: [] } });
        }

        res.json({ success: true, progressData });

    } catch (error) {
        console.error("Get Progress Error:", error);
        res.status(500).json({ success: false, message: 'Server error getting course progress.' });
    }
};

// Add or Update User Rating for a Course
export const addUserRating = async (req, res) => {
    // Use req.user.id from JWT payload
    const userId = req.user.id;
    const { courseId, rating } = req.body;

    // Validate inputs
    if (!courseId || !rating || rating < 1 || rating > 5) {
        return res.status(400).json({ success: false, message: 'Valid Course ID and Rating (1-5) are required.' });
    }

    try {
        // Find the course and check if the user is enrolled
        // We need the course to update ratings, and user to check enrollment
        const course = await Course.findById(courseId);
        const user = await User.findOne({ _id: userId, enrolledCourses: courseId });

        if (!course) {
            return res.status(404).json({ success: false, message: 'Course not found.' });
        }

        if (!user) {
            return res.status(403).json({ success: false, message: 'User must be enrolled to rate this course.' });
        }

        // Find existing rating by this user for this course
        const existingRatingIndex = course.courseRatings.findIndex(r => r.userId.toString() === userId);

        if (existingRatingIndex > -1) {
            // Update the existing rating
            course.courseRatings[existingRatingIndex].rating = rating;
        } else {
            // Add a new rating object (ensure userId is stored correctly)
            course.courseRatings.push({ userId: userId, rating: rating });
        }

        // Optional: Recalculate average rating here if storing it directly on the Course model
        // course.averageRating = calculateAverage(course.courseRatings);

        await course.save();

        // Return the updated course or just success message
        return res.json({ success: true, message: 'Rating submitted successfully.', courseRatings: course.courseRatings }); // Optionally return updated ratings

    } catch (error) {
        console.error("Add Rating Error:", error);
        res.status(500).json({ success: false, message: 'Server error adding course rating.' });
    }
};