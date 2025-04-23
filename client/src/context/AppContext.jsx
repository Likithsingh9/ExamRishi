import axios from "axios";
import { createContext, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
// import { useAuth, useUser } from "@clerk/clerk-react"; // Remove Clerk imports
import { apiRequest, setToken } from '../utils/api.js'; // Corrected Import
import humanizeDuration from "humanize-duration";

export const AppContext = createContext();

export const AppContextProvider = (props) => {
    const backendUrl = import.meta.env.VITE_BACKEND_URL;
    const currency = import.meta.env.VITE_CURRENCY;

    const navigate = useNavigate();
    // const { getToken } = useAuth(); // Remove Clerk
    // const { user } = useUser(); // Remove Clerk

    const [showLogin, setShowLogin] = useState(false);
    const [isEducator, setIsEducator] = useState(false);
    const [allCourses, setAllCourses] = useState([]);
    // Replace Clerk user with our own user state
    const [user, setUser] = useState(null); // User object from our API
    // const [jwtToken, setJwtToken] = useState(localStorage.getItem('jwtToken') || null); // JWT from localStorage
    const [enrolledCourses, setEnrolledCourses] = useState([]);

    // Function to store JWT and user data
    const setAuthData = (token, userData) => {
        setToken(token)
        // localStorage.setItem('jwtToken', token);
        // setJwtToken(token);
        setUser(userData);
    };

    // Function to remove JWT and user data (logout)
    const logout = () => {
        setToken(null);
        setUser(null);
        navigate('/login'); // Redirect to login page
    };

    // Fetch All Courses
    const fetchAllCourses = async () => {
        try {
            const { data } = await axios.get(backendUrl + '/api/course');
            if (data.success) {
                setAllCourses(data.courses);
            } else {
                toast.error(data.message);
            }
        } catch (error) {
            toast.error(error.message);
        }
    };

    // Fetch UserData 
    const fetchUserData = async () => {
        try {

            const { data } = await apiRequest('/user/me');

            if (data.success) {
                setIsEducator(data.user.isEducator);
                setUserData(data.user);
            } else {
                toast.error(data.message);
            }
        } catch (error) {
            toast.error(error.message);
        }
    };

    // Fetch User Enrolled Courses
    const fetchUserEnrolledCourses = async () => {
        try {
            const { data } = await apiRequest('/user/enrolled-courses');
            if (data.success) {
                setEnrolledCourses(data.enrolledCourses.reverse());
            } else {
                toast.error(data.message);
            }
        } catch (error) {
            toast.error(error.message);
        }
    };

    // Function to Calculate Course Chapter Time
    const calculateChapterTime = (chapter) => {
        let time = 0;
        chapter.chapterContent.map((lecture) => time += lecture.lectureDuration);
        return humanizeDuration(time * 60 * 1000, { units: ["h", "m"] });
    };

    // Function to Calculate Course Duration
    const calculateCourseDuration = (course) => {
        let time = 0;
        course.courseContent.map(
            (chapter) => chapter.chapterContent.map(
                (lecture) => time += lecture.lectureDuration
            )
        );
        return humanizeDuration(time * 60 * 1000, { units: ["h", "m"] });
    };

    const calculateRating = (course) => {
        if (course.courseRatings.length === 0) {
            return 0;
        }
        let totalRating = 0;
        course.courseRatings.forEach(rating => {
            totalRating += rating.rating;
        });
        return Math.floor(totalRating / course.courseRatings.length);
    };

    const calculateNoOfLectures = (course) => {
        let totalLectures = 0;
        course.courseContent.forEach(chapter => {
            if (Array.isArray(chapter.chapterContent)) {
                totalLectures += chapter.chapterContent.length;
            }
        });
        return totalLectures;
    };

    useEffect(() => {
        fetchAllCourses();
    }, []);

    // Fetch User's Data if User is Logged In
    useEffect(() => {
        if (sessionStorage.getItem('jwtToken')) { // Check for JWT instead of Clerk user
            fetchUserData();
            fetchUserEnrolledCourses();
        }
    }, [sessionStorage.getItem('jwtToken')]); // Depend on JWT

    const value = {
        showLogin, setShowLogin,
        backendUrl, currency, navigate,
        user, setUser, setAuthData, logout, // Update context values
        allCourses, fetchAllCourses,
        enrolledCourses, fetchUserEnrolledCourses,
        calculateChapterTime, calculateCourseDuration,
        calculateRating, calculateNoOfLectures,
        isEducator, setIsEducator,
         brandName: 'Exam Rishi'
    };

    return (
        <AppContext.Provider value={value}>
            {props.children}
        </AppContext.Provider>
    );
};
