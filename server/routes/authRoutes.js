import express from 'express';
import { body } from 'express-validator';
import { requestAuthCode, verifyCodeAndLogin } from '../controllers/authController.js';

const router = express.Router();

// @route   POST api/auth/request-code
// @desc    Request a verification code via email
// @access  Public
router.post(
    '/request-code',
    [
        body('email', 'Please include a valid email').isEmail().normalizeEmail()
    ],
    requestAuthCode
);

// @route   POST api/auth/verify-code
// @desc    Verify code and login/register user, return JWT
// @access  Public
router.post(
    '/verify-code',
    [
        body('email', 'Please include a valid email').isEmail().normalizeEmail(),
        body('code', 'Verification code is required and must be 6 digits').isLength({ min: 6, max: 6 }).isNumeric()
    ],
    verifyCodeAndLogin
);

export default router;
