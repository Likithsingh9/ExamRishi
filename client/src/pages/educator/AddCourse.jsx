import React, { useContext, useEffect, useRef, useState } from 'react';
import { assets } from '../../assets/assets';
import { toast } from 'react-toastify';
import Quill from 'quill';
import uniqid from 'uniqid';
import axios from 'axios';
import { AppContext } from '../../context/AppContext';
import apiRequest from '../../utils/api'; // Import apiRequest

const AddCourse = () => {
    const editorRef = useRef(null);
    const quillRef = useRef(null);

    const { backendUrl, /*getToken,*/ user } = useContext(AppContext); // Get user from context

    const [courseTitle, setCourseTitle] = useState('');
    const [coursePrice, setCoursePrice] = useState(0);
    const [discount, setDiscount] = useState(0);
    const [image, setImage] = useState(null);
    const [chapters, setChapters] = useState([]);
    const [showPopup, setShowPopup] = useState(false);
    const [currentChapterId, setCurrentChapterId] = useState(null);
    const [lectureDetails, setLectureDetails] = useState({
        lectureTitle: '',
        lectureDuration: '',
        lectureUrl: '',
        isPreviewFree: false,
    });

    const handleChapter = (action, chapterId) => {
        if (action === 'add') {
            const title = prompt('Enter Chapter Name:');
            if (title) {
                const newChapter = {
                    chapterId: uniqid(),
                    chapterTitle: title,
                    chapterContent: [],
                    collapsed: false,
                    chapterOrder: chapters.length > 0 ? chapters.slice(-1)[0].chapterOrder + 1 : 1,
                };
                setChapters([...chapters, newChapter]);
            }
        } else if (action === 'remove') {
            setChapters(chapters.filter((chapter) => chapter.chapterId !== chapterId));
        } else if (action === 'toggle') {
            setChapters(
                chapters.map((chapter) =>
                    chapter.chapterId === chapterId ? { ...chapter, collapsed: !chapter.collapsed } : chapter
                )
            );
        }
    };

    const handleLecture = (action, chapterId, lectureIndex) => {
        if (action === 'add') {
            setCurrentChapterId(chapterId);
            setShowPopup(true);
        } else if (action === 'remove') {
            setChapters(
                chapters.map((chapter) => {
                    if (chapter.chapterId === chapterId) {
                        // Ensure chapterContent exists before splicing
                        chapter.chapterContent?.splice(lectureIndex, 1);
                    }
                    return chapter;
                })
            );
        }
    };

    const addLecture = () => {
        setChapters(
            chapters.map((chapter) => {
                if (chapter.chapterId === currentChapterId) {
                    const newLecture = {
                        ...lectureDetails,
                        // Ensure chapterContent exists before accessing
                        lectureOrder: chapter.chapterContent?.length > 0 ? chapter.chapterContent.slice(-1)[0].lectureOrder + 1 : 1,
                        lectureId: uniqid()
                    };
                    // Initialize chapterContent if it doesn't exist
                    if (!chapter.chapterContent) {
                        chapter.chapterContent = [];
                    }
                    chapter.chapterContent.push(newLecture);
                }
                return chapter;
            })
        );
        setShowPopup(false);
        setLectureDetails({
            lectureTitle: '',
            lectureDuration: '',
            lectureUrl: '',
            isPreviewFree: false,
        });
    };

    const handleSubmit = async (e) => {
        try {
            e.preventDefault();

            // Check if user is logged in (basic check)
            if (!user) {
                 toast.error('You must be logged in to add a course.');
                 return;
            }

            if (!image) {
                toast.error('Thumbnail Not Selected');
                return; // Prevent submission without image
            }
            if (!quillRef.current?.root.innerHTML || quillRef.current.root.innerHTML === '<p><br></p>') {
                toast.error('Course description cannot be empty.');
                return; // Prevent submission with empty description
            }
            if (chapters.length === 0) {
                 toast.error('Please add at least one chapter.');
                 return;
            }

            const courseData = {
                courseTitle,
                courseDescription: quillRef.current.root.innerHTML,
                coursePrice: Number(coursePrice),
                discount: Number(discount),
                courseContent: chapters,
                // Educator ID is set on the backend from the token
            };

            const formData = new FormData();
            formData.append('courseData', JSON.stringify(courseData));
            formData.append('image', image);

            // const token = await getToken() // REMOVE

            // Use apiRequest - it includes the token automatically
            const { data } = await apiRequest(
                '/educator/add-course', 
                'POST', 
                formData, // Send FormData directly
                true // Indicate it's FormData, skip JSON stringify
            );


            if (data.success) {
                toast.success(data.message);
                setCourseTitle('');
                setCoursePrice(0);
                setDiscount(0);
                setImage(null);
                setChapters([]);
                if (quillRef.current) {
                    quillRef.current.root.innerHTML = "";
                }
            } else {
                toast.error(data.message);
            }
        } catch (error) {
             console.error("Add Course Error:", error);
             toast.error(error.message || 'Failed to add course.');
        }
    };

    // Modify apiRequest to handle FormData
    const apiRequest = async (endpoint, method = 'POST', body = null, isFormData = false) => {
        const token = sessionStorage.getItem('jwtToken'); // Get token from sessionStorage
        const headers = {}; // Don't set Content-Type for FormData
        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        }
    
        const config = {
            method,
            headers,
        };
    
        if (body) {
            if (isFormData) {
                config.body = body;
            } else {
                headers['Content-Type'] = 'application/json';
                config.body = JSON.stringify(body);
            }
        }
    
        try {
            const response = await fetch(`${backendUrl}/api${endpoint}`, config); // Ensure backendUrl is defined
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || `HTTP error! Status: ${response.status}`);
            }
            return await response.json();
        } catch (error) {
            console.error('API request failed:', error);
            throw error;
        }
    };

    useEffect(() => {
        // Initiate Quill only once
        if (!quillRef.current && editorRef.current) {
            quillRef.current = new Quill(editorRef.current, {
                theme: 'snow',
            });
        }
    }, []);

    // useEffect(() => {
    //     console.log(chapters);
    // }, [chapters]);

    return (
        <div className='h-screen overflow-scroll flex flex-col items-start justify-between md:p-8 md:pb-0 p-4 pt-8 pb-0'>
            <form onSubmit={handleSubmit} className='flex flex-col gap-4 max-w-md w-full text-gray-500'>
                <div className='flex flex-col gap-1'>
                    <p>Course Title</p>
                    <input onChange={e => setCourseTitle(e.target.value)} value={courseTitle} type="text" placeholder='Type here' className='outline-none md:py-2.5 py-2 px-3 rounded border border-gray-500' required />
                </div>

                <div className='flex flex-col gap-1'>
                    <p>Course Description</p>
                    <div ref={editorRef} style={{ minHeight: '150px', border: '1px solid #ccc', borderRadius: '4px' }}></div>
                </div>

                <div className='flex items-center justify-between flex-wrap gap-4'>
                    <div className='flex flex-col gap-1'>
                        <p>Course Price (INR)</p>
                        <input onChange={e => setCoursePrice(e.target.value)} value={coursePrice} type="number" placeholder='0' min="0" step="0.01" className='outline-none md:py-2.5 py-2 w-28 px-3 rounded border border-gray-500' required />
                    </div>
                    <div className='flex md:flex-row flex-col items-center gap-3'>
                        <p>Course Thumbnail</p>
                        <label htmlFor='thumbnailImage' className='flex items-center gap-3 cursor-pointer'>
                            <img src={assets.file_upload_icon} alt="" className='p-3 bg-blue-500 rounded' />
                            <input type="file" id='thumbnailImage' onChange={e => setImage(e.target.files[0])} accept="image/*" hidden />
                            <img className='max-h-10 object-contain' src={image ? URL.createObjectURL(image) : ''} alt="Preview" />
                        </label>
                    </div>
                </div>

                <div className='flex flex-col gap-1'>
                    <p>Discount %</p>
                    <input onChange={e => setDiscount(e.target.value)} value={discount} type="number" placeholder='0' min={0} max={100} className='outline-none md:py-2.5 py-2 w-28 px-3 rounded border border-gray-500' required />
                </div>

                {/* Adding Chapters & Lectures */}
                <div>
                    <h3 className="text-lg font-semibold mb-2">Course Content</h3>
                    {chapters.map((chapter, chapterIndex) => (
                        <div key={chapter.chapterId} className="bg-white border rounded-lg mb-4">
                            <div className="flex justify-between items-center p-4 border-b">
                                <div className="flex items-center">
                                    <img className={`mr-2 cursor-pointer transition-all w-3.5 ${chapter.collapsed ? "-rotate-90" : ""} `} onClick={() => handleChapter('toggle', chapter.chapterId)} src={assets.dropdown_icon} alt="Toggle" />
                                    <span className="font-semibold">{chapterIndex + 1}. {chapter.chapterTitle}</span>
                                </div>
                                <div className="flex items-center gap-2">
                                     <span className="text-gray-500 text-sm">{chapter.chapterContent?.length || 0} Lectures</span>
                                     <img onClick={() => handleChapter('remove', chapter.chapterId)} src={assets.cross_icon} alt="Remove Chapter" className='cursor-pointer w-3.5' />
                                </div>
                            </div>
                            {!chapter.collapsed && (
                                <div className="p-4">
                                    {chapter.chapterContent?.map((lecture, lectureIndex) => (
                                        <div key={lecture.lectureId} className="flex justify-between items-center mb-2 text-sm">
                                            <span>{lectureIndex + 1}. {lecture.lectureTitle} - {lecture.lectureDuration} mins - <a href={lecture.lectureUrl} target="_blank" rel="noopener noreferrer" className="text-blue-500">Link</a> - {lecture.isPreviewFree ? 'Free Preview' : 'Paid'}</span>
                                            <img onClick={() => handleLecture('remove', chapter.chapterId, lectureIndex)} src={assets.cross_icon} alt="Remove Lecture" className='cursor-pointer w-3.5' />
                                        </div>
                                    ))}
                                    <div className="inline-flex bg-gray-100 p-2 rounded cursor-pointer mt-2 text-sm" onClick={() => handleLecture('add', chapter.chapterId)}>
                                        + Add Lecture
                                    </div>
                                </div>
                            )}
                        </div>
                    ))}
                    <div className="flex justify-center items-center bg-blue-100 p-2 rounded-lg cursor-pointer text-sm" onClick={() => handleChapter('add')}>
                        + Add Chapter
                    </div>

                    {showPopup && (
                        <div className="fixed inset-0 flex items-center justify-center bg-gray-800 bg-opacity-50 z-50">
                            <div className="bg-white text-gray-700 p-6 rounded relative w-full max-w-md">
                                <h2 className="text-lg font-semibold mb-4">Add Lecture Details</h2>
                                <div className="mb-3">
                                    <p>Lecture Title</p>
                                    <input
                                        type="text"
                                        className="mt-1 block w-full border rounded py-1.5 px-3"
                                        value={lectureDetails.lectureTitle}
                                        onChange={(e) => setLectureDetails({ ...lectureDetails, lectureTitle: e.target.value })}
                                        required
                                    />
                                </div>
                                <div className="mb-3">
                                    <p>Duration (minutes)</p>
                                    <input
                                        type="number"
                                        min="0"
                                        className="mt-1 block w-full border rounded py-1.5 px-3"
                                        value={lectureDetails.lectureDuration}
                                        onChange={(e) => setLectureDetails({ ...lectureDetails, lectureDuration: e.target.value })}
                                        required
                                    />
                                </div>
                                <div className="mb-3">
                                    <p>Lecture URL (e.g., YouTube)</p>
                                    <input
                                        type="text"
                                        className="mt-1 block w-full border rounded py-1.5 px-3"
                                        value={lectureDetails.lectureUrl}
                                        onChange={(e) => setLectureDetails({ ...lectureDetails, lectureUrl: e.target.value })}
                                        required
                                    />
                                </div>
                                <div className="flex items-center gap-2 my-4">
                                    <input
                                        id="isFreePreviewCheckbox"
                                        type="checkbox" 
                                        className='w-4 h-4 accent-blue-600'
                                        checked={lectureDetails.isPreviewFree}
                                        onChange={(e) => setLectureDetails({ ...lectureDetails, isPreviewFree: e.target.checked })}
                                    />
                                    <label htmlFor="isFreePreviewCheckbox">Is Preview Free?</label>
                                </div>
                                <button type='button' className="w-full bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded" onClick={addLecture}>Add Lecture</button>
                                <img onClick={() => setShowPopup(false)} src={assets.cross_icon} className='absolute top-4 right-4 w-4 cursor-pointer' alt="Close" />
                            </div>
                        </div>
                    )}
                </div>

                <button type="submit" className='bg-black hover:bg-gray-800 text-white w-max py-2.5 px-8 rounded my-4'>
                    ADD COURSE
                </button>
            </form>
        </div>
    );
};

export default AddCourse;