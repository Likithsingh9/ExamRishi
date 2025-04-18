// Helper function for making API requests with JWT

const API_BASE_URL = 'http://localhost:5000/api'; // Or your production API URL

let jwtToken = sessionStorage.getItem('jwtToken') || null;

export const setToken = (token) => {
    jwtToken = token;
    if (token) {
        sessionStorage.setItem('jwtToken', token);
    } else {
        sessionStorage.removeItem('jwtToken');
    }
};

export const apiRequest = async (endpoint, method = 'GET', body = null) => {
    const headers = {
        'Content-Type': 'application/json',
        'Authorization': jwtToken ? `Bearer ${jwtToken}` : '',
    };

    const config = {
        method,
        headers,
    };

    if (body) {
        config.body = JSON.stringify(body);
    }

    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, config);

        if (!response.ok) {
            // Handle HTTP errors (e.g., 401, 404, 500)
            const errorData = await response.json(); // Try to get error message from server
            throw new Error(errorData.message || `HTTP error! Status: ${response.status}`);
        }

        return await response.json(); // Parse JSON response
    } catch (error) {
        console.error('API request failed:', error);
        throw error; // Re-throw the error for component-level handling
    }
};
