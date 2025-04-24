import React, { useContext } from 'react';
import { assets } from '../../assets/assets';
import { Link } from 'react-router-dom';
import { AppContext } from '../../context/AppContext';
// import { UserButton, useUser } from '@clerk/clerk-react'; // REMOVE

const Navbar = ({ bgColor }) => {

    const { isEducator, user, logout, brandName } = useContext(AppContext);

    return isEducator && user ? (
        <div className={`flex items-center justify-between px-4 md:px-8 border-b border-gray-500 py-3 ${bgColor}`}>
            <Link to="/">
                <img src={assets.logo} alt="Logo" className="w-28 lg:w-32" />
            </Link>
            <div className="flex items-center gap-5 text-gray-500 relative">
                <p>Hi! {user.name}</p>
                <button onClick={logout} className="text-red-500">Logout</button>
            </div>
        </div>
    ) : null;
};
// just a change to the for place of angular

export default Navbar;