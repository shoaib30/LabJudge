-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 24, 2016 at 04:59 PM
-- Server version: 5.5.47-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `lab_judge`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `user_name` varchar(10) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `name`, `user_name`, `password`) VALUES
(1, 'admin', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `lab`
--

CREATE TABLE IF NOT EXISTS `lab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_name` varchar(45) DEFAULT NULL,
  `lab_code` varchar(10) DEFAULT NULL,
  `duration` int(10) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `teacher_user_name` varchar(50) NOT NULL,
  `semester` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `lab_name_UNIQUE` (`lab_name`),
  UNIQUE KEY `lab_code_UNIQUE` (`lab_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `lab_questions`
--

CREATE TABLE IF NOT EXISTS `lab_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_code` varchar(10) NOT NULL,
  `question_num` int(11) NOT NULL,
  `question_content` text NOT NULL,
  `solution_path` text NOT NULL,
  `testcase_1` text NOT NULL,
  `testcase_2` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lab_code` (`lab_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `lab_student`
--

CREATE TABLE IF NOT EXISTS `lab_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_code` varchar(10) NOT NULL,
  `student_list` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `lab_code_idx` (`lab_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(100) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`,`user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `session_id`, `user_name`, `time`) VALUES
(8, 's3g08imgotqmrrur0qq9ou4laj', 'admin', '2016-04-24 09:31:53'),
(9, 'mrbti8t153tadsof8rscq89gm8', 'admin', '2016-04-24 09:33:58'),
(15, 'cs8l2j9crn8ijg6oegs2stss1m', 'THIS001', '2016-04-24 10:04:22');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE IF NOT EXISTS `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `user_name`, `name`, `password`) VALUES
(2, 'THIS001', 'Qwerty', '123');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lab_questions`
--
ALTER TABLE `lab_questions`
  ADD CONSTRAINT `lab_questions_ibfk_1` FOREIGN KEY (`lab_code`) REFERENCES `lab` (`lab_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lab_student`
--
ALTER TABLE `lab_student`
  ADD CONSTRAINT `lab_code` FOREIGN KEY (`lab_code`) REFERENCES `lab` (`lab_code`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
