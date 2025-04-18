import jwt from 'jsonwebtoken';

// Middleware to verify JWT and protect routes
export const protect = (req, res, next) => {
    // Get token from header
    const token = req.header('Authorization')?.replace('Bearer ', '');

    // Check if no token
    if (!token) {
        return res.status(401).json({ success: false, message: 'No token, authorization denied' });
    }

    // Verify token
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        // Add user from payload to request object
        // IMPORTANT: Rename req.auth to req.user to avoid conflict with old code/expectations
        req.user = decoded.user; 
        next();
    } catch (err) {
        console.error('Token verification failed:', err.message);
        res.status(401).json({ success: false, message: 'Token is not valid' });
    }
};

// Example middleware to protect educator routes (if you add roles)
// export const protectEducator = (req, res, next) => {
//     protect(req, res, () => { // First, verify token
//         if (req.user && req.user.role === 'educator') { // Then, check role
//             next();
//         } else {
//             res.status(403).json({ success: false, message: 'Forbidden: Educator access required' });
//         }
//     });
// };
