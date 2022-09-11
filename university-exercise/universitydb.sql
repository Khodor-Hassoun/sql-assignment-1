-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 11, 2022 at 09:30 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `universitydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `crn` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`crn`, `name`, `start_time`, `end_time`, `room_id`, `dept_id`) VALUES
(1, 'CSC275', '2016-09-01', '2017-09-01', 1, 1),
(2, 'data-science', '2018-09-01', '2019-09-01', 2, 1),
(3, 'jave', '2020-09-01', '2021-09-01', 3, 2),
(4, 'pyrhon', '2022-09-01', '2023-09-01', 4, 2),
(5, 'No COURSE', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `office` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `name`, `office`) VALUES
(1, 'BIF', 'office-1'),
(2, 'CS', 'office-2');

-- --------------------------------------------------------

--
-- Table structure for table `enrolled`
--

CREATE TABLE `enrolled` (
  `student_id` int(11) NOT NULL,
  `course_number` int(11) NOT NULL,
  `credit_status` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `enrolled`
--

INSERT INTO `enrolled` (`student_id`, `course_number`, `credit_status`) VALUES
(1, 1, '5cr'),
(2, 2, '10cr'),
(3, 1, '5cr'),
(4, 4, '10cr'),
(5, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `majors_in`
--

CREATE TABLE `majors_in` (
  `student_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `majors_in`
--

INSERT INTO `majors_in` (`student_id`, `dept_id`) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `name`, `capacity`) VALUES
(1, 'room-1', 100),
(2, 'room-2', 95),
(3, 'room-3', 105),
(4, 'room-4', 50);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `name`) VALUES
(1, 'kale'),
(2, 'khodor'),
(3, 'nour'),
(4, 'mohammad'),
(5, 'BILLY');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`crn`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enrolled`
--
ALTER TABLE `enrolled`
  ADD PRIMARY KEY (`student_id`,`course_number`),
  ADD KEY `course_number` (`course_number`);

--
-- Indexes for table `majors_in`
--
ALTER TABLE `majors_in`
  ADD PRIMARY KEY (`student_id`,`dept_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `crn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `enrolled`
--
ALTER TABLE `enrolled`
  ADD CONSTRAINT `enrolled_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `enrolled_ibfk_2` FOREIGN KEY (`course_number`) REFERENCES `course` (`crn`);

--
-- Constraints for table `majors_in`
--
ALTER TABLE `majors_in`
  ADD CONSTRAINT `majors_in_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `majors_in_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
