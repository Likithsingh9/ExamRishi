import express from 'express';
import { getUserData, userEnrolledCourses, updateUserCourseProgress, getUserCourseProgress, addUserRating } from '../controllers/userController.js';
import { protect } from '../middlewares/authMiddleware.js';

const router = express.Router();

// @route   GET api/user/me
// @desc    Get logged in user data
// @access  Private
router.get('/me', protect, getUserData);

// @route   GET api/user/enrolled-courses
// @desc    Get user's enrolled courses
// @access  Private
router.get('/enrolled-courses', protect, userEnrolledCourses);

// @route   PUT api/user/progress
// @desc    Update user course progress
// @access  Private
router.put('/progress', protect, updateUserCourseProgress);

// @route   GET api/user/progress/:courseId
// @desc    Get user course progress for a specific course
// @access  Private
router.get('/progress/:courseId', protect, getUserCourseProgress);

// @route   POST api/user/rating
// @desc    Add user rating to a course
// @access  Private
router.post('/rating', protect, addUserRating);

export default router;