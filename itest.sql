CREATE TABLE `addons` (
  `addonsID` int(11) UNSIGNED NOT NULL,
  `package_name` varchar(180) DEFAULT NULL,
  `slug` varchar(180) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `version` varchar(11) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `init` longtext DEFAULT NULL,
  `files` longtext DEFAULT NULL,
  `preview_image` varchar(180) DEFAULT NULL,
  `date` datetime NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` varchar(100) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert`
--

CREATE TABLE `alert` (
  `alertID` int(11) UNSIGNED NOT NULL,
  `itemID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `itemname` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_template`
--

CREATE TABLE `certificate_template` (
  `certificate_templateID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `theme` int(11) NOT NULL,
  `top_heading_title` text DEFAULT NULL,
  `top_heading_left` text DEFAULT NULL,
  `top_heading_right` text DEFAULT NULL,
  `top_heading_middle` text DEFAULT NULL,
  `main_middle_text` text NOT NULL,
  `template` text NOT NULL,
  `footer_left_text` text DEFAULT NULL,
  `footer_right_text` text DEFAULT NULL,
  `footer_middle_text` text DEFAULT NULL,
  `background_image` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `classesID` int(11) UNSIGNED NOT NULL,
  `classes` varchar(60) NOT NULL,
  `classes_numeric` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `studentmaxID` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation_message_info`
--

CREATE TABLE `conversation_message_info` (
  `id` int(11) NOT NULL,
  `status` int(11) DEFAULT 0,
  `draft` int(11) DEFAULT 0,
  `fav_status` int(11) DEFAULT 0,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation_msg`
--

CREATE TABLE `conversation_msg` (
  `msg_id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `msg` text NOT NULL,
  `attach` text DEFAULT NULL,
  `attach_file_name` text DEFAULT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `start` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation_user`
--

CREATE TABLE `conversation_user` (
  `conversation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `is_sender` int(11) DEFAULT 0,
  `trash` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `documentID` int(11) NOT NULL,
  `title` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `file` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailsetting`
--

CREATE TABLE `emailsetting` (
  `fieldoption` varchar(100) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `emailsetting`
--

INSERT INTO `emailsetting` (`fieldoption`, `value`) VALUES
('email_engine', ''),
('smtp_password', ''),
('smtp_port', ''),
('smtp_security', ''),
('smtp_server', ''),
('smtp_username', '');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `eventID` int(11) UNSIGNED NOT NULL,
  `fdate` date NOT NULL,
  `ftime` time NOT NULL,
  `tdate` date NOT NULL,
  `ttime` time NOT NULL,
  `title` varchar(128) NOT NULL,
  `details` text NOT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `create_userID` int(11) NOT NULL DEFAULT 0,
  `create_usertypeID` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eventcounter`
--

CREATE TABLE `eventcounter` (
  `eventcounterID` int(11) UNSIGNED NOT NULL,
  `eventID` int(11) NOT NULL,
  `username` varchar(40) NOT NULL,
  `type` varchar(20) NOT NULL,
  `name` varchar(128) NOT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instruction`
--

CREATE TABLE `instruction` (
  `instructionID` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `itest_sessions`
--

CREATE TABLE `itest_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `itest_sessions`
--

INSERT INTO `itest_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('a31b23bc3358a00c0b8a33bd1275796da61eaf34', '121.44.11.230', 1706242043, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730363234323032343b656e676c6973687c4e3b6c6f67696e7573657249447c733a313a2231223b6e616d657c733a353a2261646d696e223b656d61696c7c733a31353a2261646d696e4061646d696e2e636f6d223b757365727479706549447c733a313a2231223b75736572747970657c733a353a2241646d696e223b757365726e616d657c733a353a2261646d696e223b70686f746f7c733a31313a2264656675616c742e706e67223b6c616e677c733a373a22656e676c697368223b64656661756c747363686f6f6c7965617249447c733a313a2231223b76617269667976616c6964757365727c623a313b6c6f67676564696e7c623a313b6765745f7065726d697373696f6e7c623a313b6d61737465725f7065726d697373696f6e5f7365747c613a39303a7b733a393a2264617368626f617264223b733a333a22796573223b733a373a2273747564656e74223b733a333a22796573223b733a31313a2273747564656e745f616464223b733a333a22796573223b733a31323a2273747564656e745f65646974223b733a333a22796573223b733a31343a2273747564656e745f64656c657465223b733a333a22796573223b733a31323a2273747564656e745f76696577223b733a333a22796573223b733a373a22706172656e7473223b733a333a22796573223b733a31313a22706172656e74735f616464223b733a333a22796573223b733a31323a22706172656e74735f65646974223b733a333a22796573223b733a31343a22706172656e74735f64656c657465223b733a333a22796573223b733a31323a22706172656e74735f76696577223b733a333a22796573223b733a373a2274656163686572223b733a333a22796573223b733a31313a22746561636865725f616464223b733a333a22796573223b733a31323a22746561636865725f65646974223b733a333a22796573223b733a31343a22746561636865725f64656c657465223b733a333a22796573223b733a31323a22746561636865725f76696577223b733a333a22796573223b733a373a22636c6173736573223b733a333a22796573223b733a31313a22636c61737365735f616464223b733a333a22796573223b733a31323a22636c61737365735f65646974223b733a333a22796573223b733a31343a22636c61737365735f64656c657465223b733a333a22796573223b733a373a2273656374696f6e223b733a333a22796573223b733a31313a2273656374696f6e5f616464223b733a333a22796573223b733a31323a2273656374696f6e5f65646974223b733a333a22796573223b733a31343a2273656374696f6e5f64656c657465223b733a333a22796573223b733a373a227375626a656374223b733a333a22796573223b733a31313a227375626a6563745f616464223b733a333a22796573223b733a31323a227375626a6563745f65646974223b733a333a22796573223b733a31343a227375626a6563745f64656c657465223b733a333a22796573223b733a31323a22636f6e766572736174696f6e223b733a333a22796573223b733a31343a227175657374696f6e5f67726f7570223b733a333a22796573223b733a31383a227175657374696f6e5f67726f75705f616464223b733a333a22796573223b733a31393a227175657374696f6e5f67726f75705f65646974223b733a333a22796573223b733a32313a227175657374696f6e5f67726f75705f64656c657465223b733a333a22796573223b733a31343a227175657374696f6e5f6c6576656c223b733a333a22796573223b733a31383a227175657374696f6e5f6c6576656c5f616464223b733a333a22796573223b733a31393a227175657374696f6e5f6c6576656c5f65646974223b733a333a22796573223b733a32313a227175657374696f6e5f6c6576656c5f64656c657465223b733a333a22796573223b733a31333a227175657374696f6e5f62616e6b223b733a333a22796573223b733a31373a227175657374696f6e5f62616e6b5f616464223b733a333a22796573223b733a31383a227175657374696f6e5f62616e6b5f65646974223b733a333a22796573223b733a32303a227175657374696f6e5f62616e6b5f64656c657465223b733a333a22796573223b733a31383a227175657374696f6e5f62616e6b5f76696577223b733a333a22796573223b733a31313a226f6e6c696e655f6578616d223b733a333a22796573223b733a31353a226f6e6c696e655f6578616d5f616464223b733a333a22796573223b733a31363a226f6e6c696e655f6578616d5f65646974223b733a333a22796573223b733a31383a226f6e6c696e655f6578616d5f64656c657465223b733a333a22796573223b733a31313a22696e737472756374696f6e223b733a333a22796573223b733a31353a22696e737472756374696f6e5f616464223b733a333a22796573223b733a31363a22696e737472756374696f6e5f65646974223b733a333a22796573223b733a31383a22696e737472756374696f6e5f64656c657465223b733a333a22796573223b733a31363a22696e737472756374696f6e5f76696577223b733a333a22796573223b733a363a226e6f74696365223b733a333a22796573223b733a31303a226e6f746963655f616464223b733a333a22796573223b733a31313a226e6f746963655f65646974223b733a333a22796573223b733a31333a226e6f746963655f64656c657465223b733a333a22796573223b733a31313a226e6f746963655f76696577223b733a333a22796573223b733a353a226576656e74223b733a333a22796573223b733a393a226576656e745f616464223b733a333a22796573223b733a31303a226576656e745f65646974223b733a333a22796573223b733a31323a226576656e745f64656c657465223b733a333a22796573223b733a31303a226576656e745f76696577223b733a333a22796573223b733a31323a226964636172647265706f7274223b733a333a22796573223b733a31363a226f6e6c696e656578616d7265706f7274223b733a333a22796573223b733a32343a226f6e6c696e656578616d7175657374696f6e7265706f7274223b733a333a22796573223b733a31373a2263657274696669636174657265706f7274223b733a333a22796573223b733a31323a2273747564656e7467726f7570223b733a333a22796573223b733a31363a2273747564656e7467726f75705f616464223b733a333a22796573223b733a31373a2273747564656e7467726f75705f65646974223b733a333a22796573223b733a31393a2273747564656e7467726f75705f64656c657465223b733a333a22796573223b733a32303a2263657274696669636174655f74656d706c617465223b733a333a22796573223b733a32343a2263657274696669636174655f74656d706c6174655f616464223b733a333a22796573223b733a32353a2263657274696669636174655f74656d706c6174655f65646974223b733a333a22796573223b733a32373a2263657274696669636174655f74656d706c6174655f64656c657465223b733a333a22796573223b733a32353a2263657274696669636174655f74656d706c6174655f76696577223b733a333a22796573223b733a31313a2273797374656d61646d696e223b733a333a22796573223b733a31353a2273797374656d61646d696e5f616464223b733a333a22796573223b733a31363a2273797374656d61646d696e5f65646974223b733a333a22796573223b733a31383a2273797374656d61646d696e5f64656c657465223b733a333a22796573223b733a31363a2273797374656d61646d696e5f76696577223b733a333a22796573223b733a31333a22726573657470617373776f7264223b733a333a22796573223b733a363a226261636b7570223b733a333a22796573223b733a31303a227065726d697373696f6e223b733a333a22796573223b733a363a22757064617465223b733a333a22796573223b733a373a2273657474696e67223b733a333a22796573223b733a31353a227061796d656e7473657474696e6773223b733a333a22796573223b733a31323a22656d61696c73657474696e67223b733a333a22796573223b733a33303a226f6e6c696e656578616d7175657374696f6e616e737765727265706f7274223b733a333a22796573223b733a363a226164646f6e73223b733a333a22796573223b733a31303a2262756c6b696d706f7274223b733a333a22796573223b733a32333a226f6e6c696e656578616d7061796d656e747265706f7274223b733a333a22796573223b7d);

-- --------------------------------------------------------

--
-- Table structure for table `loginlog`
--

CREATE TABLE `loginlog` (
  `loginlogID` int(11) NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `browser` varchar(128) DEFAULT NULL,
  `operatingsystem` varchar(128) DEFAULT NULL,
  `login` int(11) UNSIGNED DEFAULT NULL,
  `logout` int(11) UNSIGNED DEFAULT NULL,
  `usertypeID` int(11) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `loginlog`
--

INSERT INTO `loginlog` (`loginlogID`, `ip`, `browser`, `operatingsystem`, `login`, `logout`, `usertypeID`, `userID`) VALUES
(1, '121.44.11.230', 'Google Chrome', 'mac', 1706242024, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mailandsmstemplatetag`
--

CREATE TABLE `mailandsmstemplatetag` (
  `mailandsmstemplatetagID` int(11) UNSIGNED NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `tagname` varchar(128) NOT NULL,
  `mailandsmstemplatetag_extra` varchar(255) DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `mailandsmstemplatetag`
--

INSERT INTO `mailandsmstemplatetag` (`mailandsmstemplatetagID`, `usertypeID`, `tagname`, `mailandsmstemplatetag_extra`, `create_date`) VALUES
(1, 1, '[name]', NULL, '2016-12-10 14:36:33'),
(2, 1, '[dob]', NULL, '2016-12-10 14:37:31'),
(3, 1, '[gender]', NULL, '2016-12-10 14:37:31'),
(4, 1, '[religion]', NULL, '2016-12-10 14:39:51'),
(5, 1, '[email]', NULL, '2016-12-10 14:39:51'),
(6, 1, '[phone]', NULL, '2016-12-10 14:39:51'),
(7, 1, '[address]', NULL, '2016-12-10 14:39:51'),
(8, 1, '[jod]', NULL, '2016-12-10 14:39:51'),
(9, 1, '[username]', NULL, '2016-12-10 14:39:51'),
(10, 2, '[name]', NULL, '2016-12-10 14:40:50'),
(11, 2, '[designation]', NULL, '2016-12-10 14:43:27'),
(12, 2, '[dob]', NULL, '2016-12-10 14:46:21'),
(13, 2, '[gender]', NULL, '2016-12-10 14:46:21'),
(14, 2, '[religion]', NULL, '2016-12-10 14:46:21'),
(15, 2, '[email]', NULL, '2016-12-10 14:46:21'),
(16, 2, '[phone]', NULL, '2016-12-10 14:46:21'),
(17, 2, '[address]', NULL, '2016-12-10 14:46:21'),
(18, 2, '[jod]', NULL, '2016-12-10 14:46:21'),
(19, 2, '[username]', NULL, '2016-12-10 14:46:21'),
(20, 3, '[name]', NULL, '2016-12-10 14:47:09'),
(21, 3, '[dob]', NULL, '2016-12-10 14:55:54'),
(22, 3, '[gender]', NULL, '2016-12-10 14:55:54'),
(23, 3, '[blood_group]', NULL, '2016-12-10 14:55:54'),
(24, 3, '[religion]', NULL, '2016-12-10 14:55:54'),
(25, 3, '[email]', NULL, '2016-12-10 14:55:54'),
(26, 3, '[phone]', NULL, '2016-12-10 14:55:54'),
(27, 3, '[address]', NULL, '2016-12-10 14:55:54'),
(28, 3, '[state]', NULL, '2017-02-11 12:21:49'),
(29, 3, '[country]', NULL, '2017-02-11 12:21:27'),
(30, 3, '[class]', NULL, '2016-12-18 15:34:20'),
(31, 3, '[section]', NULL, '2016-12-10 14:55:54'),
(32, 3, '[group]', NULL, '2016-12-10 14:55:54'),
(33, 3, '[optional_subject]', NULL, '2016-12-10 14:55:54'),
(34, 3, '[register_no]', NULL, '2017-02-11 12:21:27'),
(35, 3, '[roll]', NULL, '2017-02-11 12:22:56'),
(36, 3, '[extra_curricular_activities]', NULL, '2017-02-11 12:22:56'),
(37, 3, '[remarks]', NULL, '2017-02-11 12:22:56'),
(38, 3, '[username]', NULL, '2016-12-10 14:55:54'),
(39, 3, '[result_table]', NULL, '2016-12-10 14:55:54'),
(40, 4, '[name]', NULL, '2016-12-10 14:57:31'),
(41, 4, '[father\'s_name]', NULL, '2016-12-10 15:04:19'),
(42, 4, '[mother\'s_name]', NULL, '2016-12-10 15:04:19'),
(43, 4, '[father\'s_profession]', NULL, '2016-12-10 15:04:19'),
(44, 4, '[mother\'s_profession]', NULL, '2016-12-10 15:04:19'),
(45, 4, '[email]', NULL, '2016-12-10 15:04:19'),
(46, 4, '[phone]', NULL, '2016-12-10 15:04:19'),
(47, 4, '[address]', NULL, '2016-12-10 15:04:19'),
(48, 4, '[username]', NULL, '2016-12-10 15:04:19'),
(49, 1, '[date]', NULL, '2018-05-11 04:12:12'),
(50, 2, '[date]', NULL, '2018-05-11 04:12:27'),
(51, 3, '[date]', NULL, '2018-05-11 04:12:36'),
(52, 4, '[date]', NULL, '2018-05-11 04:12:49');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menuID` int(11) NOT NULL,
  `menuName` varchar(128) NOT NULL,
  `link` varchar(512) NOT NULL,
  `icon` varchar(128) DEFAULT NULL,
  `pullRight` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `parentID` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 1000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menuID`, `menuName`, `link`, `icon`, `pullRight`, `status`, `parentID`, `priority`) VALUES
(1, 'dashboard', 'dashboard', 'fa-laptop', '', 1, 0, 2000),
(2, 'student', 'student', 'icon-student', '', 1, 0, 1000),
(3, 'parents', 'parents', 'fa-user', '', 1, 0, 1000),
(4, 'teacher', 'teacher', 'icon-teacher', '', 1, 0, 1000),
(5, 'main_academic', '#', 'icon-academicmain', '', 1, 0, 1000),
(6, 'conversation', 'conversation', 'fa-envelope', '', 1, 0, 1000),
(7, 'main_announcement', '#', 'icon-noticemain', '', 1, 0, 230),
(8, 'main_administrator', '#', 'icon-administrator', '', 1, 0, 140),
(9, 'classes', 'classes', 'fa-sitemap', '', 1, 5, 5000),
(10, 'section', 'section', 'fa-star', '', 1, 5, 4501),
(11, 'subject', 'subject', 'icon-subject', '', 1, 5, 4500),
(12, 'notice', 'notice', 'fa-calendar', '', 1, 7, 220),
(13, 'event', 'event', 'fa-calendar-check-o', '', 1, 7, 210),
(14, 'backup', 'backup', 'fa-download', '', 1, 8, 80),
(15, 'systemadmin', 'systemadmin', 'icon-systemadmin', '', 1, 8, 120),
(16, 'resetpassword', 'resetpassword', 'icon-reset_password', '', 1, 8, 110),
(17, 'permission', 'permission', 'icon-permission', '', 1, 8, 60),
(18, 'setting', 'setting', 'fa-gears', '', 1, 33, 100),
(19, 'update', 'update', 'fa-refresh', '', 1, 8, 50),
(20, 'studentgroup', 'studentgroup', 'fa-object-group', '', 1, 8, 129),
(21, 'question_group', 'question_group', 'fa-question-circle', '', 1, 27, 1000),
(22, 'question_level', 'question_level', 'fa-level-up', '', 1, 27, 1000),
(23, 'question_bank', 'question_bank', 'fa-qrcode', '', 1, 27, 1000),
(24, 'online_exam', 'online_exam', 'fa-slideshare', '', 1, 27, 1000),
(25, 'instruction', 'instruction', 'fa-map-signs', '', 1, 27, 1000),
(26, 'take_exam', 'take_exam', 'fa-user-secret', '', 1, 27, 1000),
(27, 'main_online_exam', '#', 'fa-graduation-cap', '', 1, 0, 1000),
(28, 'main_report', '#', 'fa-clipboard', '', 1, 0, 150),
(29, 'onlineexamreport', 'onlineexamreport', 'iniicon-onlineexamreport', '', 1, 28, 990),
(30, 'certificatereport', 'certificatereport', 'fa-diamond', '', 1, 28, 970),
(31, 'certificate_template', 'certificate_template', 'fa-certificate', '', 1, 8, 128),
(32, 'onlineexamquestionreport', 'onlineexamquestionreport', 'iniicon-marksheetreport', '', 1, 28, 980),
(33, 'main_settings', '#', 'fa-gavel', '', 1, 0, 120),
(34, 'paymentsettings', 'paymentsettings', 'icon-paymentsettings', '', 1, 33, 90),
(35, 'emailsetting', 'emailsetting', 'iniicon-ini-emailsetting', '', 1, 33, 80),
(36, 'idcardreport', 'idcardreport', 'iniicon-idcardreport', '', 1, 28, 1000),
(37, 'onlineexamquestionanswerreport', 'onlineexamquestionanswerreport', 'iniicon-onlineexamquestionreport', '', 1, 28, 970),
(38, 'addons', 'addons', 'fa-crosshairs', '', 1, 8, 55),
(39, 'import_question', 'bulkimport', 'fa-upload', '', 1, 27, 1000),
(40, 'paymenthistoryreport', 'onlineexampaymentreport', 'fa fa-credit-card', '', 1, 28, 991);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `version` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notice`
--

CREATE TABLE `notice` (
  `noticeID` int(11) UNSIGNED NOT NULL,
  `title` varchar(128) NOT NULL,
  `notice` text NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `date` date NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `create_userID` int(11) NOT NULL DEFAULT 0,
  `create_usertypeID` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam`
--

CREATE TABLE `online_exam` (
  `onlineExamID` int(11) NOT NULL,
  `name` varchar(512) NOT NULL,
  `description` text DEFAULT NULL,
  `classID` int(11) DEFAULT 0,
  `sectionID` int(11) DEFAULT 0,
  `studentGroupID` int(11) DEFAULT 0,
  `subjectID` int(11) DEFAULT 0,
  `userTypeID` int(11) DEFAULT 0,
  `instructionID` int(11) DEFAULT 0,
  `examStatus` varchar(11) NOT NULL,
  `schoolYearID` int(11) NOT NULL,
  `examTypeNumber` int(11) DEFAULT NULL,
  `startDateTime` datetime DEFAULT NULL,
  `endDateTime` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT 0,
  `random` int(11) DEFAULT 0,
  `public` int(11) DEFAULT 0,
  `status` int(11) DEFAULT 1,
  `markType` int(11) NOT NULL,
  `negativeMark` int(11) DEFAULT 0,
  `bonusMark` int(11) DEFAULT 0,
  `point` int(11) DEFAULT 0,
  `percentage` int(11) DEFAULT 0,
  `showMarkAfterExam` int(11) DEFAULT 0,
  `showResultAfterExam` int(11) DEFAULT 0,
  `judge` int(11) DEFAULT 1 COMMENT 'Auto Judge = 1, Manually Judge = 0',
  `paid` int(11) DEFAULT 0,
  `validDays` int(11) DEFAULT 0,
  `cost` decimal(16,6) DEFAULT 0.000000,
  `img` varchar(512) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  `published` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_payment`
--

CREATE TABLE `online_exam_payment` (
  `online_exam_paymentID` int(11) NOT NULL,
  `online_examID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `paymentamount` decimal(16,6) NOT NULL,
  `paymentmethod` varchar(128) NOT NULL,
  `paymentdate` date NOT NULL,
  `paymentday` varchar(11) NOT NULL,
  `paymentmonth` varchar(10) NOT NULL,
  `paymentyear` year(4) NOT NULL,
  `transactionID` text NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_question`
--

CREATE TABLE `online_exam_question` (
  `onlineExamQuestionID` int(11) NOT NULL,
  `onlineExamID` int(11) NOT NULL,
  `questionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_type`
--

CREATE TABLE `online_exam_type` (
  `onlineExamTypeID` int(11) NOT NULL,
  `title` varchar(512) DEFAULT NULL,
  `examTypeNumber` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `online_exam_type`
--

INSERT INTO `online_exam_type` (`onlineExamTypeID`, `title`, `examTypeNumber`, `status`) VALUES
(1, 'Date , Time and Duration', 5, 1),
(2, 'Date and Duration', 4, 1),
(3, 'Only Date', 3, 0),
(4, 'Only Duration', 2, 1),
(5, 'None', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_user_answer`
--

CREATE TABLE `online_exam_user_answer` (
  `onlineExamUserAnswerID` int(11) NOT NULL,
  `onlineExamQuestionID` int(11) NOT NULL,
  `onlineExamRegisteredUserID` int(11) DEFAULT NULL,
  `onlineExamID` int(11) NOT NULL,
  `examtimeID` int(11) NOT NULL,
  `userID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_user_answer_option`
--

CREATE TABLE `online_exam_user_answer_option` (
  `onlineExamUserAnswerOptionID` int(11) NOT NULL,
  `questionID` int(11) NOT NULL,
  `optionID` int(11) DEFAULT NULL,
  `typeID` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `time` datetime NOT NULL,
  `onlineExamID` int(11) NOT NULL,
  `examtimeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_user_status`
--

CREATE TABLE `online_exam_user_status` (
  `onlineExamUserStatus` int(11) NOT NULL,
  `onlineExamID` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `totalQuestion` int(11) NOT NULL,
  `totalAnswer` int(11) NOT NULL,
  `nagetiveMark` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `userID` int(11) NOT NULL,
  `classesID` int(11) DEFAULT NULL,
  `sectionID` int(11) DEFAULT NULL,
  `examtimeID` int(11) DEFAULT NULL,
  `totalCurrectAnswer` int(11) DEFAULT NULL,
  `totalMark` varchar(40) DEFAULT NULL,
  `totalObtainedMark` int(11) DEFAULT NULL,
  `totalPercentage` int(11) DEFAULT NULL,
  `statusID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE `parents` (
  `parentsID` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `father_name` varchar(60) NOT NULL,
  `mother_name` varchar(60) NOT NULL,
  `father_profession` varchar(40) NOT NULL,
  `mother_profession` varchar(40) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `phone` tinytext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(128) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(20) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `misc` longtext DEFAULT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `payment_gateways`
--

INSERT INTO `payment_gateways` (`id`, `name`, `slug`, `misc`, `status`) VALUES
(1, 'Paypal', 'paypal', NULL, 1),
(2, 'Stripe', 'stripe', '{\"input\":[\"stripe\\/stripe-input.php\"],\"js\":[\"stripe\\/stripe-js.php\"],\"submit\":true}', 1),
(3, 'Paystack', 'paystack', '{\"input\":[\"paystack\\/paystack-input.php\"],\"js\":[\"paystack\\/paystack-js.php\"],\"submit\":true}', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateway_option`
--

CREATE TABLE `payment_gateway_option` (
  `id` int(11) UNSIGNED NOT NULL,
  `payment_gateway_id` int(11) NOT NULL,
  `payment_option` varchar(100) NOT NULL,
  `payment_value` text DEFAULT NULL,
  `type` varchar(100) NOT NULL,
  `activities` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `payment_gateway_option`
--

INSERT INTO `payment_gateway_option` (`id`, `payment_gateway_id`, `payment_option`, `payment_value`, `type`, `activities`) VALUES
(1, 1, 'paypal_username', '', 'text', NULL),
(2, 1, 'paypal_password', '', 'text', NULL),
(3, 1, 'paypal_signature', '', 'text', NULL),
(4, 1, 'paypal_email', '', 'text', NULL),
(5, 1, 'paypal_demo', '1', 'select', '{\"0\":\"Off\", \"1\":\"On\"}'),
(6, 1, 'paypal_status', '0', 'select', '{\"0\":\"Disable\", \"1\":\"Enable\"}'),
(7, 2, 'stripe_key', '', 'text', NULL),
(8, 2, 'stripe_secret', '', 'text', NULL),
(9, 2, 'stripe_demo', '1', 'select', '{\"0\":\"Off\", \"1\":\"On\"}'),
(10, 2, 'stripe_status', '0', 'select', '{\"0\":\"Disable\", \"1\":\"Enable\"}'),
(11, 3, 'paystack_key', '', 'text', NULL),
(12, 3, 'paystack_secret', '', 'text', NULL),
(13, 3, 'paystack_demo', '1', 'select', '{\"0\":\"Off\", \"1\":\"On\"}'),
(14, 3, 'paystack_status', '0', 'select', '{\"0\":\"Disable\", \"1\":\"Enable\"}'),
(15, 3, 'paystack_currency', 'NGN', 'text', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permissionID` int(10) UNSIGNED NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '' COMMENT 'In most cases, this should be the name of the module (e.g. news)',
  `active` enum('yes','no') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permissionID`, `description`, `name`, `active`) VALUES
(501, 'Dashboard', 'dashboard', 'yes'),
(502, 'Student', 'student', 'yes'),
(503, 'Student Add', 'student_add', 'yes'),
(504, 'Student Edit', 'student_edit', 'yes'),
(505, 'Student Delete', 'student_delete', 'yes'),
(506, 'Student View', 'student_view', 'yes'),
(507, 'Parents', 'parents', 'yes'),
(508, 'Parents Add', 'parents_add', 'yes'),
(509, 'Parents Edit', 'parents_edit', 'yes'),
(510, 'Parents Delete', 'parents_delete', 'yes'),
(511, 'Parents View', 'parents_view', 'yes'),
(512, 'Teacher', 'teacher', 'yes'),
(513, 'Teacher Add', 'teacher_add', 'yes'),
(514, 'Teacher Edit', 'teacher_edit', 'yes'),
(515, 'Teacher Delete', 'teacher_delete', 'yes'),
(516, 'Teacher View', 'teacher_view', 'yes'),
(517, 'Class', 'classes', 'yes'),
(518, 'Class Add', 'classes_add', 'yes'),
(519, 'Class Edit', 'classes_edit', 'yes'),
(520, 'Class Delete', 'classes_delete', 'yes'),
(521, 'Section', 'section', 'yes'),
(522, 'Section Add', 'section_add', 'yes'),
(523, 'Section Edit', 'section_edit', 'yes'),
(524, 'Section Delete', 'section_delete', 'yes'),
(525, 'Subject', 'subject', 'yes'),
(526, 'Subject Add', 'subject_add', 'yes'),
(527, 'Subject Edit', 'subject_edit', 'yes'),
(528, 'Subject Delete', 'subject_delete', 'yes'),
(529, 'Message', 'conversation', 'yes'),
(530, 'Question Group', 'question_group', 'yes'),
(531, 'Question Group Add', 'question_group_add', 'yes'),
(532, 'Question Group Edit', 'question_group_edit', 'yes'),
(533, 'Question Group Delete', 'question_group_delete', 'yes'),
(534, 'Question Level', 'question_level', 'yes'),
(535, 'Question Level Add', 'question_level_add', 'yes'),
(536, 'Question Level Edit', 'question_level_edit', 'yes'),
(537, 'Question Level Delete', 'question_level_delete', 'yes'),
(538, 'Question Bank', 'question_bank', 'yes'),
(539, 'Question Bank Add', 'question_bank_add', 'yes'),
(540, 'Question Bank Edit', 'question_bank_edit', 'yes'),
(541, 'Question Bank Delete', 'question_bank_delete', 'yes'),
(542, 'Question Bank View', 'question_bank_view', 'yes'),
(543, 'Online Exam', 'online_exam', 'yes'),
(544, 'Online Exam Add', 'online_exam_add', 'yes'),
(545, 'Online Exam Edit', 'online_exam_edit', 'yes'),
(546, 'Online Exam Delete', 'online_exam_delete', 'yes'),
(547, 'Instruction', 'instruction', 'yes'),
(548, 'Instruction Add', 'instruction_add', 'yes'),
(549, 'Instruction Edit', 'instruction_edit', 'yes'),
(550, 'Instruction Delete', 'instruction_delete', 'yes'),
(551, 'Instruction View', 'instruction_view', 'yes'),
(552, 'Notice', 'notice', 'yes'),
(553, 'Notice Add', 'notice_add', 'yes'),
(554, 'Notice Edit', 'notice_edit', 'yes'),
(555, 'Notice Delete', 'notice_delete', 'yes'),
(556, 'Notice View', 'notice_view', 'yes'),
(557, 'Event', 'event', 'yes'),
(558, 'Event Add', 'event_add', 'yes'),
(559, 'Event Edit', 'event_edit', 'yes'),
(560, 'Event Delete', 'event_delete', 'yes'),
(561, 'Event View', 'event_view', 'yes'),
(562, 'ID Card Report', 'idcardreport', 'yes'),
(563, 'Online Exam Report', 'onlineexamreport', 'yes'),
(564, 'Online Exam Question Report', 'onlineexamquestionreport', 'yes'),
(565, 'Certificate Report', 'certificatereport', 'yes'),
(566, 'Student Group', 'studentgroup', 'yes'),
(567, 'Student Group Add', 'studentgroup_add', 'yes'),
(568, 'Student Group Edit', 'studentgroup_edit', 'yes'),
(569, 'Student Group Delete', 'studentgroup_delete', 'yes'),
(570, 'Certificate Template', 'certificate_template', 'yes'),
(571, 'Certificate Template Add', 'certificate_template_add', 'yes'),
(572, 'Certificate Template Edit', 'certificate_template_edit', 'yes'),
(573, 'Certificate Template Delete', 'certificate_template_delete', 'yes'),
(574, 'Certificate Template View', 'certificate_template_view', 'yes'),
(575, 'System Admin', 'systemadmin', 'yes'),
(576, 'System Admin Add', 'systemadmin_add', 'yes'),
(577, 'System Admin Edit', 'systemadmin_edit', 'yes'),
(578, 'System Admin Delete', 'systemadmin_delete', 'yes'),
(579, 'System Admin View', 'systemadmin_view', 'yes'),
(580, 'Reset Password', 'resetpassword', 'yes'),
(581, 'Backup', 'backup', 'yes'),
(582, 'Permission', 'permission', 'yes'),
(583, 'Update', 'update', 'yes'),
(584, 'General Settings', 'setting', 'yes'),
(585, 'Payment Settings', 'paymentsettings', 'yes'),
(586, 'Email Settings', 'emailsetting', 'yes'),
(587, 'Online Exam Question Answer Report', 'onlineexamquestionanswerreport', 'yes'),
(588, 'Addons', 'addons', 'yes'),
(589, 'Question Import', 'bulkimport', 'yes'),
(590, 'Online Exam Payment Report', 'onlineexampaymentreport', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `permission_relationships`
--

CREATE TABLE `permission_relationships` (
  `permission_id` int(11) NOT NULL,
  `usertype_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `permission_relationships`
--

INSERT INTO `permission_relationships` (`permission_id`, `usertype_id`) VALUES
(501, 1),
(502, 1),
(503, 1),
(504, 1),
(505, 1),
(506, 1),
(507, 1),
(508, 1),
(509, 1),
(510, 1),
(511, 1),
(512, 1),
(513, 1),
(514, 1),
(515, 1),
(516, 1),
(517, 1),
(518, 1),
(519, 1),
(520, 1),
(521, 1),
(522, 1),
(523, 1),
(524, 1),
(525, 1),
(526, 1),
(527, 1),
(528, 1),
(529, 1),
(530, 1),
(531, 1),
(532, 1),
(533, 1),
(534, 1),
(535, 1),
(536, 1),
(537, 1),
(538, 1),
(539, 1),
(540, 1),
(541, 1),
(542, 1),
(543, 1),
(544, 1),
(545, 1),
(546, 1),
(547, 1),
(548, 1),
(549, 1),
(550, 1),
(551, 1),
(552, 1),
(553, 1),
(554, 1),
(555, 1),
(556, 1),
(557, 1),
(558, 1),
(559, 1),
(560, 1),
(561, 1),
(562, 1),
(563, 1),
(564, 1),
(565, 1),
(566, 1),
(567, 1),
(568, 1),
(569, 1),
(570, 1),
(571, 1),
(572, 1),
(573, 1),
(574, 1),
(575, 1),
(576, 1),
(577, 1),
(578, 1),
(579, 1),
(580, 1),
(581, 1),
(582, 1),
(583, 1),
(584, 1),
(585, 1),
(586, 1),
(587, 1),
(588, 1),
(589, 1),
(590, 1),
(501, 2),
(502, 2),
(506, 2),
(507, 2),
(511, 2),
(512, 2),
(516, 2),
(525, 2),
(529, 2),
(530, 2),
(531, 2),
(532, 2),
(534, 2),
(535, 2),
(536, 2),
(538, 2),
(539, 2),
(540, 2),
(542, 2),
(543, 2),
(544, 2),
(545, 2),
(547, 2),
(548, 2),
(549, 2),
(551, 2),
(552, 2),
(553, 2),
(554, 2),
(556, 2),
(557, 2),
(558, 2),
(559, 2),
(561, 2),
(562, 2),
(563, 2),
(564, 2),
(565, 2),
(587, 2),
(501, 3),
(502, 3),
(512, 3),
(516, 3),
(525, 3),
(529, 3),
(530, 3),
(534, 3),
(543, 3),
(552, 3),
(556, 3),
(557, 3),
(561, 3),
(501, 4),
(502, 4),
(506, 4),
(512, 4),
(516, 4),
(525, 4),
(529, 4),
(530, 4),
(534, 4),
(543, 4),
(552, 4),
(556, 4),
(557, 4),
(561, 4);

-- --------------------------------------------------------

--
-- Table structure for table `question_answer`
--

CREATE TABLE `question_answer` (
  `answerID` int(11) NOT NULL,
  `questionID` int(11) NOT NULL,
  `optionID` int(11) DEFAULT NULL,
  `typeNumber` int(11) NOT NULL,
  `text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `question_bank`
--

CREATE TABLE `question_bank` (
  `questionBankID` int(11) NOT NULL,
  `question` text NOT NULL,
  `explanation` text DEFAULT NULL,
  `levelID` int(11) DEFAULT NULL,
  `groupID` int(11) DEFAULT NULL,
  `totalQuestion` int(11) DEFAULT 0,
  `totalOption` int(11) DEFAULT NULL,
  `typeNumber` int(11) DEFAULT NULL,
  `parentID` int(11) DEFAULT 0,
  `time` int(11) DEFAULT 0,
  `mark` int(11) DEFAULT 0,
  `hints` text DEFAULT NULL,
  `upload` varchar(512) DEFAULT NULL,
  `subjectID` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `question_group`
--

CREATE TABLE `question_group` (
  `questionGroupID` int(11) NOT NULL,
  `title` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `question_group`
--

INSERT INTO `question_group` (`questionGroupID`, `title`) VALUES
(1, 'Reasoning'),
(2, 'Computer Knowledge'),
(3, 'General'),
(4, 'Math'),
(5, 'GRE');

-- --------------------------------------------------------

--
-- Table structure for table `question_level`
--

CREATE TABLE `question_level` (
  `questionLevelID` int(11) NOT NULL,
  `name` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `question_level`
--

INSERT INTO `question_level` (`questionLevelID`, `name`) VALUES
(1, 'Easy'),
(2, 'Medium'),
(3, 'Hard');

-- --------------------------------------------------------

--
-- Table structure for table `question_option`
--

CREATE TABLE `question_option` (
  `optionID` int(11) NOT NULL,
  `questionID` int(11) NOT NULL,
  `name` varchar(512) NOT NULL,
  `img` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `question_type`
--

CREATE TABLE `question_type` (
  `questionTypeID` int(11) NOT NULL,
  `typeNumber` int(11) NOT NULL,
  `name` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `question_type`
--

INSERT INTO `question_type` (`questionTypeID`, `typeNumber`, `name`) VALUES
(1, 1, 'Single Answer'),
(2, 2, 'Multi Answer'),
(3, 3, 'Fill In The Blanks');

-- --------------------------------------------------------

--
-- Table structure for table `reset`
--

CREATE TABLE `reset` (
  `resetID` int(11) UNSIGNED NOT NULL,
  `keyID` varchar(128) NOT NULL,
  `email` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schoolyear`
--

CREATE TABLE `schoolyear` (
  `schoolyearID` int(11) NOT NULL,
  `schooltype` varchar(40) DEFAULT NULL,
  `schoolyear` varchar(128) NOT NULL,
  `schoolyeartitle` varchar(128) DEFAULT NULL,
  `semestercode` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(100) NOT NULL,
  `create_usertype` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `schoolyear`
--

INSERT INTO `schoolyear` (`schoolyearID`, `schooltype`, `schoolyear`, `schoolyeartitle`, `semestercode`, `create_date`, `modify_date`, `create_userID`, `create_username`, `create_usertype`) VALUES
(1, 'classbase', '2017-2018', '', 0, '2017-01-01 06:21:11', '2017-01-01 08:22:20', 1, 'admin', 'Admin'),
(2, 'semesterbase', '2017-2018', 'Spring', 11, '2017-01-01 08:19:17', '2017-01-06 08:23:15', 1, 'admin', 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `sectionID` int(11) UNSIGNED NOT NULL,
  `section` varchar(60) NOT NULL,
  `category` varchar(128) NOT NULL,
  `capacity` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `fieldoption` varchar(100) NOT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`fieldoption`, `value`) VALUES
('address', ''),
('auto_update_notification', '1'),
('backend_theme', 'default'),
('captcha_status', '1'),
('currency_code', ''),
('currency_symbol', ''),
('email', 'admin@admin.com'),
('fontend_theme', 'default'),
('fontorbackend', '0'),
('footer', 'Copyright &copy; ITEST'),
('frontendorbackend', '1'),
('frontend_theme', 'default'),
('google_analytics', ''),
('language', 'english'),
('language_status', '0'),
('note', '1'),
('phone', '34748458'),
('photo', 'site.png'),
('profile_edit', '1'),
('purchase_code', 'bdf3d254-6863-4f35-9133-3f0b86361d9f'),
('purchase_username', 'dinc5150'),
('recaptcha_secret_key', ''),
('recaptcha_site_key', ''),
('school_type', 'classbase'),
('school_year', '1'),
('sname', 'ITEST'),
('time_zone', 'US/Hawaii'),
('updateversion', '4.1');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `studentID` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `dob` date DEFAULT NULL,
  `sex` varchar(10) NOT NULL,
  `religion` varchar(25) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `phone` tinytext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `classesID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `roll` int(11) NOT NULL,
  `bloodgroup` varchar(5) DEFAULT NULL,
  `country` varchar(128) DEFAULT NULL,
  `registerNO` varchar(128) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `library` int(11) NOT NULL,
  `hostel` int(11) NOT NULL,
  `transport` int(11) NOT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `parentID` int(11) DEFAULT NULL,
  `createschoolyearID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(128) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(40) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentextend`
--

CREATE TABLE `studentextend` (
  `studentextendID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `studentgroupID` int(11) NOT NULL,
  `optionalsubjectID` int(11) NOT NULL,
  `extracurricularactivities` text NOT NULL,
  `remarks` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentgroup`
--

CREATE TABLE `studentgroup` (
  `studentgroupID` int(11) NOT NULL,
  `group` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `studentgroup`
--

INSERT INTO `studentgroup` (`studentgroupID`, `group`) VALUES
(1, 'Science'),
(2, 'Arts'),
(3, 'Commerce');

-- --------------------------------------------------------

--
-- Table structure for table `studentrelation`
--

CREATE TABLE `studentrelation` (
  `studentrelationID` int(11) NOT NULL,
  `srstudentID` int(11) DEFAULT NULL,
  `srname` varchar(40) NOT NULL,
  `srclassesID` int(11) DEFAULT NULL,
  `srclasses` varchar(40) DEFAULT NULL,
  `srroll` int(11) DEFAULT NULL,
  `srregisterNO` varchar(128) DEFAULT NULL,
  `srsectionID` int(11) DEFAULT NULL,
  `srsection` varchar(40) DEFAULT NULL,
  `srstudentgroupID` int(11) NOT NULL,
  `sroptionalsubjectID` int(11) NOT NULL,
  `srschoolyearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `subjectID` int(11) UNSIGNED NOT NULL,
  `classesID` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `type` int(100) NOT NULL,
  `passmark` int(11) NOT NULL,
  `finalmark` int(11) NOT NULL,
  `subject` varchar(60) NOT NULL,
  `subject_author` varchar(100) DEFAULT NULL,
  `subject_code` tinytext NOT NULL,
  `teacher_name` varchar(60) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `systemadmin`
--

CREATE TABLE `systemadmin` (
  `systemadminID` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) NOT NULL,
  `religion` varchar(25) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `phone` tinytext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `jod` date NOT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(128) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(20) NOT NULL,
  `active` int(11) NOT NULL,
  `systemadminextra1` varchar(128) DEFAULT NULL,
  `systemadminextra2` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `systemadmin`
--

INSERT INTO `systemadmin` (`systemadminID`, `name`, `dob`, `sex`, `religion`, `email`, `phone`, `address`, `jod`, `photo`, `username`, `password`, `usertypeID`, `create_date`, `modify_date`, `create_userID`, `create_username`, `create_usertype`, `active`, `systemadminextra1`, `systemadminextra2`) VALUES
(1, 'admin', '2024-01-25', 'Male', 'Unknown', 'admin@admin.com', '', '', '2024-01-25', 'defualt.png', 'admin', 'df2ca0c4122cc6008c86c780222a7c8d45e8bcfc20b3158d1043bee204bf102d480e2c7d38690f0e3c2aec2b8912cc548e36e001a36dfa95e5c6cd610550ef20', 1, '2024-01-25 06:06:52', '2024-01-25 06:06:52', 0, 'admin', 'Admin', 1, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacherID` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `designation` varchar(128) NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) NOT NULL,
  `religion` varchar(25) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `phone` tinytext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `jod` date NOT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(128) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(20) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE `themes` (
  `themesID` int(11) NOT NULL,
  `sortID` int(11) NOT NULL DEFAULT 1,
  `themename` varchar(128) NOT NULL,
  `backend` int(11) NOT NULL DEFAULT 1,
  `frontend` int(11) NOT NULL DEFAULT 1,
  `topcolor` text NOT NULL,
  `leftcolor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `themes`
--

INSERT INTO `themes` (`themesID`, `sortID`, `themename`, `backend`, `frontend`, `topcolor`, `leftcolor`) VALUES
(1, 1, 'Default', 1, 1, '#FFFFFF', '#2d353c'),
(2, 0, 'Blue', 0, 1, '#3c8dbc', '#2d353c'),
(3, 3, 'Black', 1, 1, '#fefefe', '#222222'),
(4, 4, 'Purple', 1, 1, '#605ca8', '#2d353c'),
(5, 5, 'Green', 1, 1, '#00a65a', '#2d353c'),
(6, 6, 'Red', 1, 1, '#dd4b39', '#2d353c'),
(7, 0, 'Yellow', 0, 1, '#f39c12', '#2d353c'),
(8, 7, 'Blue Light', 1, 1, '#3c8dbc', '#f9fafc'),
(9, 8, 'Black Light', 1, 1, '#fefefe', '#f9fafc'),
(10, 9, 'Purple Light', 1, 1, '#605ca8', '#f9fafc'),
(11, 10, 'Green Light', 1, 1, '#00a65a', '#f9fafc'),
(12, 11, 'Red Light', 1, 1, '#dd4b39', '#f9fafc'),
(13, 12, 'Yellow Light', 1, 1, '#f39c12', '#f9fafc'),
(14, 2, 'White Blue', 1, 1, '#ffffff', '#132035');

-- --------------------------------------------------------

--
-- Table structure for table `update`
--

CREATE TABLE `update` (
  `updateID` int(11) NOT NULL,
  `version` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `log` longtext NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `update`
--

INSERT INTO `update` (`updateID`, `version`, `date`, `userID`, `usertypeID`, `log`, `status`) VALUES
(1, '4.1', '2024-01-25 18:06:52', 1, 1, '<h4>1. initial install</h4>', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) NOT NULL,
  `religion` varchar(25) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `phone` tinytext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `jod` date NOT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(128) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(20) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usertype`
--

CREATE TABLE `usertype` (
  `usertypeID` int(11) UNSIGNED NOT NULL,
  `usertype` varchar(60) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(40) NOT NULL,
  `create_usertype` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `usertype`
--

INSERT INTO `usertype` (`usertypeID`, `usertype`, `create_date`, `modify_date`, `create_userID`, `create_username`, `create_usertype`) VALUES
(1, 'Admin', '2016-06-24 07:12:49', '2016-06-24 07:12:49', 1, 'admin', 'Super Admin'),
(2, 'Teacher', '2016-06-24 07:13:13', '2016-06-24 07:13:13', 1, 'admin', 'Super Admin'),
(3, 'Student', '2016-06-24 07:13:27', '2016-06-24 07:13:27', 1, 'admin', 'Super Admin'),
(4, 'Parents', '2016-06-24 07:13:42', '2016-10-25 01:12:52', 1, 'admin', 'Super Admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD PRIMARY KEY (`addonsID`);

--
-- Indexes for table `alert`
--
ALTER TABLE `alert`
  ADD PRIMARY KEY (`alertID`);

--
-- Indexes for table `certificate_template`
--
ALTER TABLE `certificate_template`
  ADD PRIMARY KEY (`certificate_templateID`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`classesID`);

--
-- Indexes for table `conversation_message_info`
--
ALTER TABLE `conversation_message_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversation_msg`
--
ALTER TABLE `conversation_msg`
  ADD PRIMARY KEY (`msg_id`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`documentID`);

--
-- Indexes for table `emailsetting`
--
ALTER TABLE `emailsetting`
  ADD PRIMARY KEY (`fieldoption`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`eventID`);

--
-- Indexes for table `eventcounter`
--
ALTER TABLE `eventcounter`
  ADD PRIMARY KEY (`eventcounterID`);

--
-- Indexes for table `instruction`
--
ALTER TABLE `instruction`
  ADD PRIMARY KEY (`instructionID`);

--
-- Indexes for table `itest_sessions`
--
ALTER TABLE `itest_sessions`
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `loginlog`
--
ALTER TABLE `loginlog`
  ADD PRIMARY KEY (`loginlogID`);

--
-- Indexes for table `mailandsmstemplatetag`
--
ALTER TABLE `mailandsmstemplatetag`
  ADD PRIMARY KEY (`mailandsmstemplatetagID`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menuID`);

--
-- Indexes for table `notice`
--
ALTER TABLE `notice`
  ADD PRIMARY KEY (`noticeID`);

--
-- Indexes for table `online_exam`
--
ALTER TABLE `online_exam`
  ADD PRIMARY KEY (`onlineExamID`);

--
-- Indexes for table `online_exam_payment`
--
ALTER TABLE `online_exam_payment`
  ADD PRIMARY KEY (`online_exam_paymentID`);

--
-- Indexes for table `online_exam_question`
--
ALTER TABLE `online_exam_question`
  ADD PRIMARY KEY (`onlineExamQuestionID`);

--
-- Indexes for table `online_exam_type`
--
ALTER TABLE `online_exam_type`
  ADD PRIMARY KEY (`onlineExamTypeID`);

--
-- Indexes for table `online_exam_user_answer`
--
ALTER TABLE `online_exam_user_answer`
  ADD PRIMARY KEY (`onlineExamUserAnswerID`);

--
-- Indexes for table `online_exam_user_answer_option`
--
ALTER TABLE `online_exam_user_answer_option`
  ADD PRIMARY KEY (`onlineExamUserAnswerOptionID`);

--
-- Indexes for table `online_exam_user_status`
--
ALTER TABLE `online_exam_user_status`
  ADD PRIMARY KEY (`onlineExamUserStatus`);

--
-- Indexes for table `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`parentsID`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_gateway_option`
--
ALTER TABLE `payment_gateway_option`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permissionID`);

--
-- Indexes for table `question_answer`
--
ALTER TABLE `question_answer`
  ADD PRIMARY KEY (`answerID`);

--
-- Indexes for table `question_bank`
--
ALTER TABLE `question_bank`
  ADD PRIMARY KEY (`questionBankID`);

--
-- Indexes for table `question_group`
--
ALTER TABLE `question_group`
  ADD PRIMARY KEY (`questionGroupID`);

--
-- Indexes for table `question_level`
--
ALTER TABLE `question_level`
  ADD PRIMARY KEY (`questionLevelID`);

--
-- Indexes for table `question_option`
--
ALTER TABLE `question_option`
  ADD PRIMARY KEY (`optionID`);

--
-- Indexes for table `question_type`
--
ALTER TABLE `question_type`
  ADD PRIMARY KEY (`questionTypeID`);

--
-- Indexes for table `reset`
--
ALTER TABLE `reset`
  ADD PRIMARY KEY (`resetID`);

--
-- Indexes for table `schoolyear`
--
ALTER TABLE `schoolyear`
  ADD PRIMARY KEY (`schoolyearID`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`sectionID`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`fieldoption`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`studentID`);

--
-- Indexes for table `studentextend`
--
ALTER TABLE `studentextend`
  ADD PRIMARY KEY (`studentextendID`);

--
-- Indexes for table `studentgroup`
--
ALTER TABLE `studentgroup`
  ADD PRIMARY KEY (`studentgroupID`);

--
-- Indexes for table `studentrelation`
--
ALTER TABLE `studentrelation`
  ADD PRIMARY KEY (`studentrelationID`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`subjectID`);

--
-- Indexes for table `systemadmin`
--
ALTER TABLE `systemadmin`
  ADD PRIMARY KEY (`systemadminID`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacherID`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`themesID`);

--
-- Indexes for table `update`
--
ALTER TABLE `update`
  ADD PRIMARY KEY (`updateID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`);

--
-- Indexes for table `usertype`
--
ALTER TABLE `usertype`
  ADD PRIMARY KEY (`usertypeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `addonsID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alert`
--
ALTER TABLE `alert`
  MODIFY `alertID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificate_template`
--
ALTER TABLE `certificate_template`
  MODIFY `certificate_templateID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `classesID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversation_message_info`
--
ALTER TABLE `conversation_message_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversation_msg`
--
ALTER TABLE `conversation_msg`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `documentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `eventID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eventcounter`
--
ALTER TABLE `eventcounter`
  MODIFY `eventcounterID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `instruction`
--
ALTER TABLE `instruction`
  MODIFY `instructionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loginlog`
--
ALTER TABLE `loginlog`
  MODIFY `loginlogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mailandsmstemplatetag`
--
ALTER TABLE `mailandsmstemplatetag`
  MODIFY `mailandsmstemplatetagID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `notice`
--
ALTER TABLE `notice`
  MODIFY `noticeID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam`
--
ALTER TABLE `online_exam`
  MODIFY `onlineExamID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_payment`
--
ALTER TABLE `online_exam_payment`
  MODIFY `online_exam_paymentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_question`
--
ALTER TABLE `online_exam_question`
  MODIFY `onlineExamQuestionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_type`
--
ALTER TABLE `online_exam_type`
  MODIFY `onlineExamTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `online_exam_user_answer`
--
ALTER TABLE `online_exam_user_answer`
  MODIFY `onlineExamUserAnswerID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_user_answer_option`
--
ALTER TABLE `online_exam_user_answer_option`
  MODIFY `onlineExamUserAnswerOptionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_user_status`
--
ALTER TABLE `online_exam_user_status`
  MODIFY `onlineExamUserStatus` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parents`
--
ALTER TABLE `parents`
  MODIFY `parentsID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment_gateway_option`
--
ALTER TABLE `payment_gateway_option`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permissionID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=591;

--
-- AUTO_INCREMENT for table `question_answer`
--
ALTER TABLE `question_answer`
  MODIFY `answerID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question_bank`
--
ALTER TABLE `question_bank`
  MODIFY `questionBankID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question_group`
--
ALTER TABLE `question_group`
  MODIFY `questionGroupID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `question_level`
--
ALTER TABLE `question_level`
  MODIFY `questionLevelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `question_option`
--
ALTER TABLE `question_option`
  MODIFY `optionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question_type`
--
ALTER TABLE `question_type`
  MODIFY `questionTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reset`
--
ALTER TABLE `reset`
  MODIFY `resetID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schoolyear`
--
ALTER TABLE `schoolyear`
  MODIFY `schoolyearID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `sectionID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `studentID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentextend`
--
ALTER TABLE `studentextend`
  MODIFY `studentextendID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentgroup`
--
ALTER TABLE `studentgroup`
  MODIFY `studentgroupID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `studentrelation`
--
ALTER TABLE `studentrelation`
  MODIFY `studentrelationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `subjectID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `systemadmin`
--
ALTER TABLE `systemadmin`
  MODIFY `systemadminID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacherID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `themes`
--
ALTER TABLE `themes`
  MODIFY `themesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `update`
--
ALTER TABLE `update`
  MODIFY `updateID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usertype`
--
ALTER TABLE `usertype`
  MODIFY `usertypeID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
