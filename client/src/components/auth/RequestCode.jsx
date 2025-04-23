import React, { useState } from 'react';
import {apiRequest} from '../../utils/api.js'; // Corrected Path

const RequestCode = () => {
    const [email, setEmail] = useState('');
    const [message, setMessage] = useState('');
    const [error, setError] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();
        setMessage('');
        setError('');

        try {
            const response = await apiRequest('/auth/request-code', 'POST', { email });
            setMessage(response.message); // Display success message from API
            setEmail(''); // Clear the form
        } catch (err) {
            setError(err.message); // Display error from API
        }
    };

    return (
        <div className="request-code-container">
            <h2>Exam Rishi: Request Verification Code</h2>
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
                <button type="submit">Send Verification Code</button>
            </form>
        </div>
    );
};

export default RequestCode;