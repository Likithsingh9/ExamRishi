import React, { useState, useContext } from 'react';
import apiRequest, { setToken } from '../utils/api.js';
import { AppContext } from '../../context/AppContext.jsx';
import { useNavigate } from 'react-router-dom';

const VerifyCode = () => {
    const [email, setEmail] = useState('');
    const [code, setCode] = useState('');
    const [message, setMessage] = useState('');
    const [error, setError] = useState('');
    const { setUser } = useContext(AppContext);
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        setMessage('');
        setError('');

        try {
            const response = await apiRequest('/auth/verify-code', 'POST', { email, code });

            // Store JWT in sessionStorage or cookies
            setToken(response.token);

            // Set user data in context
            setUser(response.user);

            // Redirect user (example: to the home page)
            navigate('/');

        } catch (err) {
            setError(err.message);
        }
    };

    return (
        <div className="verify-code-container">
            <h2>Exam Rishi: Verify Code</h2>
            {message && <div className="success-message">{message}</div>}
            {error && <div className="error-message">{error}</div>}
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label htmlFor="email">Email:</label>
                    <input
                        type="email"
                        id="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                    />
                </div>
                <div className="form-group">
                    <label htmlFor="code">Verification Code:</label>
                    <input
                        type="text"
                        id="code"
                        value={code}
                        onChange={(e) => setCode(e.target.value)}
                        required
                    />
                </div>
                <button type="submit">Verify and Login</button>
            </form>
        </div>
    );
};

export default VerifyCode;