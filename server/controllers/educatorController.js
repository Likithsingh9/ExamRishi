import { v2 as cloudinary } from 'cloudinary';
import Course from '../models/Course.js';
import { Purchase } from '../models/Purchase.js';
import User from '../models/User.js';
// import { clerkClient } from '@clerk/express'; // No longer needed

// Update role to educator (NO LONGER NEEDED)
// This function is likely obsolete as we're not using Clerk for roles anymore.
// The role should be managed differently (e.g., a field in the User model).
// export const updateRoleToEducator = async (req, res) => {
//     try {
//         const userId = req.user.id; // Use req.user.id
//         // You would now update the User model directly to set role = 'educator'
//         // Example:  await User.findByIdAndUpdate(userId, { role: 'educator' });
//         // This function is removed because we can't use clerkClient
//         // await clerkClient.users.updateUserMetadata(userId, {
//         //     publicMetadata: {
//         //         role: 'educator',
//         //     },
//         // });
//
//         res.json({ success: true, message: 'Educator role updated (Clerk is no longer used for roles).', });
//     } catch (error) {
//         console.error("Update Role Error:", error);
//         res.status(500).json({ success: false, message: 'Server error updating educator role.' });
//     }
// };

// Add New Course
export const addCourse = async (req, res) => {
    try {
        const { courseData } = req.body;
        const imageFile = req.file;
        // Use req.user.id (ID of the logged-in educator)
        const educatorId = req.user.id;

        // Validate inputs
        if (!courseData) {
            return res.status(400).json({ success: false, message: 'Course data is required.' });
        }
        if (!imageFile) {
            return res.status(400).json({ success: false, message: 'Thumbnail image is required.' });
        }

        let parsedCourseData;
        try {
            parsedCourseData = JSON.parse(courseData);
        } catch (parseError) {
            return res.status(400).json({ success: false, message: 'Invalid course data format (must be valid JSON).', });
        }

        parsedCourseData.educator = educatorId; // Set educator ID from logged-in user

        const newCourse = await Course.create(parsedCourseData);

        const imageUpload = await cloudinary.uploader.upload(imageFile.path);

        newCourse.courseThumbnail = imageUpload.secure_url;

        await newCourse.save();

        res.status(201).json({ success: true, message: 'Course added successfully.' });

    } catch (error) {
        console.error("Add Course Error:", error);
        res.status(500).json({ success: false, message: 'Server error adding course.' });
    }
};

// Get Educator Courses
export const getEducatorCourses = async (req, res) => {
    try {
        // Use req.user.id
        const educatorId = req.user.id;

        const courses = await Course.find({ educator: educatorId });

        res.json({ success: true, courses });

    } catch (error) {
        console.error("Get Educator Courses Error:", error);
        res.status(500).json({ success: false, message: 'Server error fetching educator courses.' });
    }
};

// Get Educator Dashboard Data ( Total Earning, Enrolled Students, No. of Courses)
export const educatorDashboardData = async (req, res) => {
    try {
        // Use req.user.id
        const educatorId = req.user.id;

        const courses = await Course.find({ educator: educatorId });

        const totalCourses = courses.length;

        // Extract course IDs
        const courseIds = courses.map(course => course._id);

        // Calculate total earnings from purchases
        const purchases = await Purchase.find({
            courseId: { $in: courseIds },
            status: 'completed'
        });

        const totalEarnings = purchases.reduce((sum, purchase) => sum + purchase.amount, 0);

        // Efficiently collect unique enrolled student IDs (using Set for uniqueness) with their course titles
        const enrolledStudentsData = [];
        for (const course of courses) {
            // Populate enrolledStudents with name and imageUrl directly
            const populatedCourse = await Course.findById(course._id).populate({
                path: 'enrolledStudents',
                select: 'name imageUrl' // Select only the fields you need
            });

            if (populatedCourse) {
                populatedCourse.enrolledStudents.forEach(student => {
                    enrolledStudentsData.push({
                        courseTitle: course.courseTitle,
                        student: { // Structure the student object to match what the frontend expects
                            _id: student._id,
                            name: student.name,
                            imageUrl: student.imageUrl
                        }
                    });
                });
            }
        }

        res.json({
            success: true,
            dashboardData: {
                totalEarnings,
                enrolledStudentsData,
                totalCourses
            }
        });
    } catch (error) {
        console.error("Educator Dashboard Error:", error);
        res.status(500).json({ success: false, message: 'Server error fetching dashboard data.' });
    }
};

// Get Enrolled Students Data with Purchase Data
export const getEnrolledStudentsData = async (req, res) => {
    try {
        // Use req.user.id
        const educatorId = req.user.id;

        // Fetch all courses created by the educator
        const courses = await Course.find({ educator: educatorId });

        // Get the list of course IDs
        const courseIds = courses.map(course => course._id);

        // Fetch purchases with user and course data
        const purchases = await Purchase.find({
            courseId: { $in: courseIds },
            status: 'completed'
        }).populate('userId', 'name imageUrl').populate('courseId', 'courseTitle');

        // Structure enrolled students data
        const enrolledStudents = purchases.map(purchase => ({
            student: {
                _id: purchase.userId._id,
                name: purchase.userId.name,
                imageUrl: purchase.userId.imageUrl
            },
            courseTitle: purchase.courseId.courseTitle,
            purchaseDate: purchase.createdAt
        }));

        res.json({
            success: true,
            enrolledStudents
        });

    } catch (error) {
        console.error("Get Enrolled Students Error:", error);
        res.status(500).json({
            success: false,
            message: 'Server error fetching enrolled students data.'
        });
    }
};