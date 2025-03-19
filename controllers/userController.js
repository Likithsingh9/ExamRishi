const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const registerUser = async (req, res) => {
  const { name, email, password, usertypeID } = req.body;

  try {
    // Check if user already exists
    const existingUser = await User.findUserByEmail(email);
    if (existingUser) {
      return res.status(400).json({ message: 'User already exists' });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 12);

    // Create user
    const userId = await User.createUser({
      name,
      email,
      password: hashedPassword,
      usertypeID,
    });

    res.status(201).json({ message: 'User created successfully', userId });
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong', error: error.message });
  }
};

const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Find user by email
    const user = await User.findUserByEmail(email);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Check password
    const isPasswordCorrect = await bcrypt.compare(password, user.password);
    if (!isPasswordCorrect) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.sign({ email: user.email, id: user.userID }, 'your_secret_key', {
      expiresIn: '1h',
    });

    res.status(200).json({ result: user, token });
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong', error: error.message });
  }
};

module.exports = { registerUser, loginUser };