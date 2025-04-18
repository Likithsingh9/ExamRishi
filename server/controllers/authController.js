import jwt from 'jsonwebtoken';
import { validationResult } from 'express-validator';
import User from '../models/User.js';
import { sendVerificationCode } from '../utils/emailService.js';

// Simple in-memory store for verification codes (Replace with DB/Redis for production)
const verificationCodes = {}; // { email: { code: '123456', expires: timestamp } }
const CODE_EXPIRY_MINUTES = 10;

// Generate a random 6-digit code
const generateCode = () => {
    return Math.floor(100000 + Math.random() * 900000).toString();
};

// Request Authentication Code
export const requestAuthCode = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ success: false, errors: errors.array() });
    }

    const { email } = req.body;

    try {
        const code = generateCode();
        const expires = Date.now() + CODE_EXPIRY_MINUTES * 60 * 1000; // Expiry time

        // Store code (replace with DB/Redis later)
        verificationCodes[email.toLowerCase()] = { code, expires };

        // Send email
        const emailSent = await sendVerificationCode(email, code);

        if (!emailSent) {
            // Clean up code if email failed
            delete verificationCodes[email.toLowerCase()];
            return res.status(500).json({ success: false, message: 'Failed to send verification email.' });
        }

        // Prune expired codes occasionally (simple cleanup)
        Object.keys(verificationCodes).forEach(key => {
            if (verificationCodes[key].expires < Date.now()) {
                delete verificationCodes[key];
            }
        });

        res.json({ success: true, message: `Verification code sent to ${email}.` });

    } catch (error) {
        console.error('Request code error:', error);
        res.status(500).json({ success: false, message: 'Server error while requesting code.' });
    }
};

// Verify Auth Code and Login/Register User
export const verifyCodeAndLogin = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ success: false, errors: errors.array() });
    }

    const { email, code } = req.body;
    const lowerCaseEmail = email.toLowerCase();

    try {
        // Check if code exists and is valid
        const storedCodeData = verificationCodes[lowerCaseEmail];
        if (!storedCodeData) {
            return res.status(400).json({ success: false, message: 'Invalid or expired code. Please request a new one.' });
        }

        if (storedCodeData.expires < Date.now()) {
            delete verificationCodes[lowerCaseEmail]; // Clean up expired code
            return res.status(400).json({ success: false, message: 'Verification code has expired. Please request a new one.' });
        }

        if (storedCodeData.code !== code) {
            return res.status(400).json({ success: false, message: 'Invalid verification code.' });
        }

        // Code is valid, clear it
        delete verificationCodes[lowerCaseEmail];

        // Find or create user
        let user = await User.findOne({ email: lowerCaseEmail });

        if (!user) {
            // Create a new user if they don't exist
            // You might want to add default name/imageUrl or prompt user later
            user = new User({ email: lowerCaseEmail }); 
            await user.save();
            console.log(`New user created: ${user.email}`);
        }

        // Generate JWT
        const payload = {
            user: {
                id: user.id, // Use MongoDB's default _id
                email: user.email
                // Add role or other necessary info if needed
            },
        };

        const token = jwt.sign(
            payload,
            process.env.JWT_SECRET,
            { expiresIn: '1d' } // Token expiry (e.g., 1 day)
        );

        // Send token and user info (excluding sensitive data)
        res.json({
            success: true,
            token,
            user: {
                id: user.id,
                email: user.email,
                name: user.name, 
                imageUrl: user.imageUrl,
                enrolledCourses: user.enrolledCourses
                // Add role if you have one
            },
        });

    } catch (error) {
        console.error('Verify code error:', error);
        if (error.code === 11000) { // Handle potential duplicate email race condition during creation
             return res.status(400).json({ success: false, message: 'Email already exists.' });
        }
        res.status(500).json({ success: false, message: 'Server error during verification.' });
    }
};
