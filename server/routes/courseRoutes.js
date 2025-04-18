import express from 'express';
import { getAllCourse, getCourseId } from '../controllers/courseController.js';
import { protect } from '../middlewares/authMiddleware.js';

const router = express.Router();

// @route   GET api/course
// @desc    Get All Courses
// @access  Public
router.get('/', getAllCourse);

// @route   GET api/course/:id
// @desc    Get Course by Id
// @access  Public
router.get('/:id', getCourseId);

export default router;