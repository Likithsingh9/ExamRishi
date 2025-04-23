import React, { useContext, useEffect, useState } from 'react'
import { assets } from '../../assets/assets'
import { AppContext } from '../../context/AppContext';
import axios from 'axios';
import { toast } from 'react-toastify';
import Loading from '../../components/student/Loading';
import { apiRequest } from '../../utils/api'; // Corrected Import: Use named import

const Dashboard = () => {

    const { backendUrl, isEducator, currency, /*getToken,*/ user } = useContext(AppContext) // Use user from context

    const [dashboardData, setDashboardData] = useState(null)

    const fetchDashboardData = async () => {
        try {
            // const token = await getToken() // REMOVE

            // Use apiRequest helper which includes the token
            const { data } = await apiRequest('/educator/dashboard', 'GET'); 

            if (data.success) {
                setDashboardData(data.dashboardData)
            } else {
                toast.error(data.message)
            }
        } catch (error) {
            console.error("Error fetching dashboard data:", error);
            toast.error(error.message || 'Failed to fetch dashboard data.')
        }
    }

    useEffect(() => {
        // Fetch data if user exists and is an educator
        if (user && isEducator) { 
            fetchDashboardData()
        }
    }, [user, isEducator]) // Add user dependency

    // Removed static studentsData array as it's now fetched

    return dashboardData ? (
        <div className='min-h-screen flex flex-col items-start justify-between gap-8 md:p-8 md:pb-0 p-4 pt-8 pb-0'>
            <div className='space-y-5'>
                <div className='flex flex-wrap gap-5 items-center'>
                    <div className='flex items-center gap-3 shadow-card border border-blue-500 p-4 w-56 rounded-md'>
                        <img src={assets.patients_icon} alt="Enrolments icon" />
                        <div>
                            <p className='text-2xl font-medium text-gray-600'>{dashboardData.enrolledStudentsData?.length || 0}</p>
                            <p className='text-base text-gray-500'>Total Enrolments</p>
                        </div>
                    </div>
                    <div className='flex items-center gap-3 shadow-card border border-blue-500 p-4 w-56 rounded-md'>
                        <img src={assets.appointments_icon} alt="Courses icon" />
                        <div>
                            <p className='text-2xl font-medium text-gray-600'>{dashboardData.totalCourses || 0}</p>
                            <p className='text-base text-gray-500'>Total Courses</p>
                        </div>
                    </div>
                    <div className='flex items-center gap-3 shadow-card border border-blue-500 p-4 w-56 rounded-md'>
                        <img src={assets.earning_icon} alt="Earnings icon" />
                        <div>
                            <p className='text-2xl font-medium text-gray-600'>{currency}{Math.floor(dashboardData.totalEarnings || 0)}</p>
                            <p className='text-base text-gray-500'>Total Earnings</p>
                        </div>
                    </div>
                </div>
                <div>
                    <h2 className="pb-4 text-lg font-medium">Latest Enrolments</h2>
                    {dashboardData.enrolledStudentsData?.length > 0 ? (
                        <div className="flex flex-col items-center max-w-4xl w-full overflow-hidden rounded-md bg-white border border-gray-500/20">
                            <table className="table-fixed md:table-auto w-full overflow-hidden">
                                <thead className="text-gray-900 border-b border-gray-500/20 text-sm text-left">
                                    <tr>
                                        <th className="px-4 py-3 font-semibold text-center hidden sm:table-cell">#</th>
                                        <th className="px-4 py-3 font-semibold">Student Name</th>
                                        <th className="px-4 py-3 font-semibold">Course Title</th>
                                    </tr>
                                </thead>
                                <tbody className="text-sm text-gray-500">
                                    {dashboardData.enrolledStudentsData.map((item, index) => (
                                        <tr key={item.student?._id || index} className="border-b border-gray-500/20"> {/* Use student ID for key if available */}
                                            <td className="px-4 py-3 text-center hidden sm:table-cell">{index + 1}</td>
                                            <td className="md:px-4 px-2 py-3 flex items-center space-x-3">
                                                <img
                                                    src={item.student?.imageUrl || assets.user_icon} // Fallback image
                                                    alt="Profile"
                                                    className="w-9 h-9 rounded-full object-cover"
                                                />
                                                <span className="truncate">{item.student?.name || 'N/A'}</span>
                                            </td>
                                            <td className="px-4 py-3 truncate">{item.courseTitle || 'N/A'}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                     ) : (
                        <p className="text-center text-gray-500">No enrolments yet.</p>
                    )}
                </div>
            </div>
        </div>
    ) : <Loading />;
};

export default Dashboard;