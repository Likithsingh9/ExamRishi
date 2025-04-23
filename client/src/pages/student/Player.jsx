import React, { useContext, useEffect, useState } from 'react'
import { AppContext } from '../../context/AppContext'
import YouTube from 'react-youtube';
import { assets } from '../../assets/assets';
import { useParams } from 'react-router-dom';
import humanizeDuration from 'humanize-duration';
import axios from 'axios';
import { toast } from 'react-toastify';
import Rating from '../../components/student/Rating';
import Footer from '../../components/student/Footer';
import Loading from '../../components/student/Loading';
import { apiRequest } from '../../utils/api'; // Import apiRequest - FIXED

const Player = ({ }) => {
    const { enrolledCourses, backendUrl, /*getToken,*/ calculateChapterTime, user, fetchUserEnrolledCourses } = useContext(AppContext);
    const { courseId } = useParams();
    const [courseData, setCourseData] = useState(null);
    const [progressData, setProgressData] = useState(null);
    const [openSections, setOpenSections] = useState({});
    const [playerData, setPlayerData] = useState(null);
    const [initialRating, setInitialRating] = useState(0);

    const getCourseData = () => {
        enrolledCourses.forEach((course) => { // Use forEach instead of map if not returning anything
            if (course._id === courseId) {
                setCourseData(course);
                course.courseRatings?.forEach((item) => { // Use forEach and optional chaining
                    if (item.userId === user?._id) { // Use user from context and optional chaining
                        setInitialRating(item.rating);
                    }
                });
            }
        });
    };

    const toggleSection = (index) => {
        setOpenSections((prev) => ({
            ...prev,
            [index]: !prev[index],
        }));
    };

    useEffect(() => {
        if (enrolledCourses.length > 0 && user) { // Check for user existence
            getCourseData();
        }
    }, [enrolledCourses, user]); // Add user dependency

    const markLectureAsCompleted = async (lectureId) => {
        try {
            // const token = await getToken() // REMOVE
            const { data } = await apiRequest(
                '/user/progress', // Use correct route based on userRoutes.js
                'PUT',
                { courseId, lectureId }
            );

            if (data.success) {
                toast.success(data.message);
                getCourseProgress(); // Refresh progress after update
            } else {
                toast.error(data.message);
            }
        } catch (error) {
            console.error("Error marking lecture complete:", error);
            toast.error("Could not mark lecture complete: " + error.message);
        }
    };

    const getCourseProgress = async () => {
        try {
            // const token = await getToken() // REMOVE
            const { data } = await apiRequest(
                `/user/progress/${courseId}`, // Use correct route from userRoutes.js
                'GET' // Use GET method
            );

            if (data.success) {
                setProgressData(data.progressData);
            } else {
                toast.error(data.message);
            }
        } catch (error) {
            console.error("Error fetching course progress:", error);
            toast.error("Could not fetch course progress: " + error.message);
        }
    };

    const handleRate = async (rating) => {
        try {
            // const token = await getToken() // REMOVE
            const { data } = await apiRequest(
                '/user/rating', // Use correct route from userRoutes.js
                'POST',
                { courseId, rating }
            );

            if (data.success) {
                toast.success(data.message);
                fetchUserEnrolledCourses(); // Refresh enrolled courses to potentially update average rating display elsewhere
            } else {
                toast.error(data.message);
            }
        } catch (error) {
            console.error("Error adding rating:", error);
            toast.error("Could not add rating: " + error.message);
        }
    };

    useEffect(() => {
        // Fetch progress only if courseId is available
        if (courseId) {
            getCourseProgress();
        }
    }, [courseId]); // Depend on courseId

    return courseData ? (
        <>
            <div className='p-4 sm:p-10 flex flex-col-reverse md:grid md:grid-cols-2 gap-10 md:px-36' >
                <div className=" text-gray-800" >
                    <h2 className="text-xl font-semibold">Course Structure</h2>
                    <div className="pt-5">
                        {courseData?.courseContent?.map((chapter, index) => (
                            <div key={index} className="border border-gray-300 bg-white mb-2 rounded">
                                <div
                                    className="flex items-center justify-between px-4 py-3 cursor-pointer select-none"
                                    onClick={() => toggleSection(index)}
                                >
                                    <div className="flex items-center gap-2">
                                        <img src={assets.down_arrow_icon} alt="arrow icon" className={`transform transition-transform ${openSections[index] ? "rotate-180" : ""}`} />
                                        <p className="font-medium md:text-base text-sm">{chapter.chapterTitle}</p>
                                    </div>
                                    <p className="text-sm md:text-default">{chapter.chapterContent?.length || 0} lectures - {calculateChapterTime(chapter)}</p>
                                </div>

                                <div className={`overflow-hidden transition-all duration-300 ${openSections[index] ? "max-h-96" : "max-h-0"}`} >
                                    <ul className="list-disc md:pl-10 pl-4 pr-4 py-2 text-gray-600 border-t border-gray-300">
                                        {chapter.chapterContent?.map((lecture, i) => (
                                            <li key={i} className="flex items-start gap-2 py-1">
                                                <img src={progressData?.lectureCompleted?.includes(lecture.lectureId) ? assets.blue_tick_icon : assets.play_icon} alt="bullet icon" className="w-4 h-4 mt-1" />
                                                <div className="flex items-center justify-between w-full text-gray-800 text-xs md:text-default">
                                                    <p>{lecture.lectureTitle}</p>
                                                    <div className='flex gap-2'>
                                                        {lecture.lectureUrl && (
                                                        <p onClick={() => setPlayerData({ ...lecture, chapter: index + 1, lecture: i + 1 })} className='text-blue-500 cursor-pointer'>Watch</p>
                                                        )}
                                                        <p>{humanizeDuration((lecture.lectureDuration || 0) * 60 * 1000, { units: ['h', 'm'] })}</p>
                                                    </div>
                                                </div>
                                            </li>
                                        ))}
                                    </ul>
                                </div>
                            </div>
                        ))}
                    </div>

                    <div className=" flex items-center gap-2 py-3 mt-10">
                        <h1 className="text-xl font-bold">Rate this Course:</h1>
                        <Rating initialRating={initialRating} onRate={handleRate} />
                    </div>
                </div>

                <div className='md:mt-10'>
                    {
                        playerData
                            ? (
                                <div>
                                    <YouTube iframeClassName='w-full aspect-video' videoId={playerData.lectureUrl.includes('youtube.com') ? playerData.lectureUrl.split('v=')[1]?.split('&')[0] : playerData.lectureUrl.split('/').pop()} />
                                    <div className='flex justify-between items-center mt-1'>
                                        <p className='text-xl '>{playerData.chapter}.{playerData.lecture} {playerData.lectureTitle}</p>
                                        <button onClick={() => markLectureAsCompleted(playerData.lectureId)} className='text-blue-600'>{progressData?.lectureCompleted?.includes(playerData.lectureId) ? 'Completed' : 'Mark Complete'}</button>
                                    </div>
                                </div>
                            )
                            : <img src={courseData?.courseThumbnail || ''} alt="Course thumbnail" className="w-full aspect-video object-cover" />
                    }
                </div>
            </div>
            <Footer />
        </>
    ) : <Loading />;
};

export default Player;