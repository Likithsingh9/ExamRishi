import express from 'express';
import cors from 'cors';
import 'dotenv/config';
import connectDB from './configs/mongodb.js';
import connectCloudinary from './configs/cloudinary.js';
// import { stripeWebhooks } from './controllers/webhooks.js'; // Keep Stripe webhook
import { razorpayWebhook } from './controllers/webhooks.js'; // Import Razorpay webhook

// Import your new routes and middleware
import authRoutes from './routes/authRoutes.js';
import userRoutes from './routes/userRoutes.js';
import educatorRoutes from './routes/educatorRoutes.js';
import courseRoutes from './routes/courseRoute.js'; // Renamed from courseRouter for consistency
import { protect } from './middlewares/authMiddleware.js'; // Import the protect middleware

// Initialize Express
const app = express();

// Connect to database & Cloudinary
await connectDB();
await connectCloudinary();

// Middlewares
app.use(cors());

// IMPORTANT:  Handle raw body for webhooks BEFORE express.json()
// This is crucial for webhook signature verification
app.post('/api/razorpay/webhook', express.raw({ type: 'application/json' }), razorpayWebhook);

// Stripe Webhook Route - REMOVE this
// app.post('/stripe', express.raw({ type: 'application/json' }), stripeWebhooks);

// IMPORTANT: Use express.json() AFTER the webhook route(s)
app.use(express.json());

// Public Routes
app.get('/', (req, res) => res.send("API Working"));
app.use('/api/auth', authRoutes); // Add the new authentication routes

// Protected Routes (Apply the 'protect' middleware)
// Make sure controllers within these routes are updated to use req.user.id
app.use('/api/educator', protect, educatorRoutes);
app.use('/api/course', protect, courseRoutes);     // Assuming course creation/modification needs auth
app.use('/api/user', protect, userRoutes);         // User-specific actions like getting enrollments

// Port
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});