-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 30, 2016 at 05:06 PM
-- Server version: 5.5.46-0ubuntu0.14.04.2
-- PHP Version: 5.5.9-1ubuntu4.16

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `lab`
--

INSERT INTO `lab` (`id`, `lab_name`, `lab_code`, `duration`, `status`, `teacher_user_name`, `semester`) VALUES
(1, 'Operating Systems Lab', 'IS512L', 11100, 1, 'THIS001', 5),
(7, 'Data Structures', 'IS312', 10800, 0, 'THIS001', 3),
(10, 'Trala', 'IS311L', 10800, 0, 'THIS001', 3);

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
  KEY `lab_code` (`lab_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `lab_questions`
--

INSERT INTO `lab_questions` (`id`, `lab_code`, `question_num`, `question_content`, `solution_path`, `testcase_1`, `testcase_2`) VALUES
(6, 'IS312', 1, 'hello1', 'code1', 'case1', 'CASE2'),
(7, 'IS312', 2, 'hello2', 'codde2', 'test2', 'test3'),
(10, 'IS311L', 1, 'esf', 'vsvs', 'sdfv', 'sdv');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `lab_student`
--

INSERT INTO `lab_student` (`id`, `lab_code`, `student_list`) VALUES
(5, 'IS312', '1MS13IS001,1MS13IS002,1MS13IS003,1MS13IS004,1MS13IS005,1MS13IS006,1MS13IS007,1MS13IS008,1MS13IS009,1MS13IS010,1MS13IS011,1MS13IS012,1MS13IS013,1MS13IS014,1MS13IS015,1MS13IS016,1MS13IS017,1MS13IS018,1MS13IS019,1MS13IS020,1MS13IS021,1MS13IS022,1MS13IS023,1MS13IS024,1MS13IS025,1MS13IS026,1MS13IS027,1MS13IS028,1MS13IS029,1MS13IS030,1MS13IS031,1MS13IS032,1MS13IS033,1MS13IS034,1MS13IS035,1MS13IS036,1MS13IS037,1MS13IS038,1MS13IS039,1MS13IS040,1MS13IS041,1MS13IS042,1MS13IS043,1MS13IS044,1MS13IS045,1MS13IS046,1MS13IS047,1MS13IS048,1MS13IS049,1MS13IS050,1MS13IS051,1MS13IS052,1MS13IS053,1MS13IS054,1MS13IS055,1MS13IS056,1MS13IS057,1MS13IS058,1MS13IS059,1MS13IS060,1MS13IS061,1MS13IS062,1MS13IS063,1MS13IS064,1MS13IS065,1MS13IS066,1MS13IS067,1MS13IS068,1MS13IS069,1MS13IS070,1MS13IS071,1MS13IS072,1MS13IS073,1MS13IS074,1MS13IS075,1MS13IS076,1MS13IS077,1MS13IS078,1MS13IS079,1MS13IS080,1MS13IS081,1MS13IS082,1MS13IS083,1MS13IS084,1MS13IS085,1MS13IS086,1MS13IS087,1MS13IS088,1MS13IS089,1MS13IS090,1MS13IS091,1MS13IS092,1MS13IS093,1MS13IS094,1MS13IS095,1MS13IS096,1MS13IS097,1MS13IS098,1MS13IS099,1MS13IS100,1MS13IS101,1MS12IS002,1MS12IS003,'),
(8, 'IS311L', '1MS13IS001,1MS13IS002,1MS13IS003,1MS13IS004,1MS13IS005,1MS13IS006,1MS13IS007,1MS13IS008,1MS13IS009,1MS13IS010,1MS13IS011,1MS13IS012,1MS13IS013,1MS13IS014,1MS13IS015,1MS13IS016,1MS13IS017,1MS13IS018,1MS13IS019,1MS13IS020,1MS13IS021,1MS13IS022,1MS13IS023,1MS13IS024,1MS13IS025,1MS13IS026,1MS13IS027,1MS13IS028,1MS13IS029,1MS13IS030,1MS13IS031,1MS13IS032,1MS13IS033,1MS13IS034,1MS13IS035,1MS13IS036,1MS13IS037,1MS13IS038,1MS13IS039,1MS13IS040,1MS13IS041,1MS13IS042,1MS13IS043,1MS13IS044,1MS13IS045,1MS13IS046,1MS13IS047,1MS13IS048,1MS13IS049,1MS13IS050,1MS13IS051,1MS13IS052,1MS13IS053,1MS13IS054,1MS13IS055,1MS13IS056,');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `session_id`, `user_name`, `time`) VALUES
(8, 's3g08imgotqmrrur0qq9ou4laj', 'admin', '2016-04-24 09:31:53'),
(9, 'mrbti8t153tadsof8rscq89gm8', 'admin', '2016-04-24 09:33:58'),
(24, '9tf1v9oc284qt06lv5tdiekbc0', 'admin', '2016-04-24 15:51:39'),
(37, 'k739o00ppb83dcc0i6c3fqhuv1', 'THIS001', '2016-04-25 09:53:41'),
(39, 'rf7555icrpfgkp5rf41bm78ml', 'THIS001', '2016-04-30 05:15:02'),
(43, 'bpnu6k1sejuaa85921um7oqb9d', 'THIS001', '2016-04-30 10:44:27');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `user_name`, `name`, `password`) VALUES
(2, 'THIS001', 'Qwerty', '123'),
(3, 'THCS001', 'Asd', '123');

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
