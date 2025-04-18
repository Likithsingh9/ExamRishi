\
import nodemailer from 'nodemailer';

// Configure the transporter using environment variables
const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST,
  port: parseInt(process.env.EMAIL_PORT || '587', 10), // Default to 587 if not set
  secure: parseInt(process.env.EMAIL_PORT || '587', 10) === 465, // true for 465, false for other ports
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

// Function to send the verification code email
export const sendVerificationCode = async (toEmail, code) => {
  const mailOptions = {
    from: process.env.EMAIL_FROM,
    to: toEmail,
    subject: 'Your Verification Code',
    text: `Your verification code is: ${code}. It will expire in 10 minutes.`,
    html: `<p>Your verification code is: <strong>${code}</strong>. It will expire in 10 minutes.</p>`,
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log('Verification email sent to:', toEmail);
    return true;
  } catch (error) {
    console.error('Error sending verification email:', error);
    return false;
  }
};

// Optional: Verify transporter configuration (call this once at startup if needed)
export const verifyEmailConfig = async () => {
    try {
        await transporter.verify();
        console.log('Email transporter configuration is valid.');
    } catch (error) {
        console.error('Error verifying email transporter configuration:', error);
    }
};
