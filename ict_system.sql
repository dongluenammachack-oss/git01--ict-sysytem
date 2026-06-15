-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2026 at 06:59 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ict_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `account_type` varchar(100) DEFAULT 'Standard',
  `account_status` varchar(50) DEFAULT 'Active',
  `primary_email` varchar(255) NOT NULL,
  `second_email` varchar(255) DEFAULT NULL,
  `third_email` varchar(255) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `team` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `halo_device_number` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `card_records`
--

CREATE TABLE `card_records` (
  `id` int(11) NOT NULL,
  `ins_number` varchar(100) DEFAULT NULL COMMENT 'INS Number',
  `username` varchar(150) DEFAULT NULL COMMENT 'Username / Full Name',
  `department` varchar(100) DEFAULT NULL COMMENT 'Department',
  `team` varchar(100) DEFAULT NULL COMMENT 'Team',
  `card_number` varchar(150) DEFAULT NULL COMMENT 'Card Number',
  `price` int(11) DEFAULT 0 COMMENT 'Price in LAK (ກີບ)',
  `date_issue` date DEFAULT NULL COMMENT 'Date Issue',
  `remark` text DEFAULT NULL COMMENT 'Remark',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Card issuance records for staff';

-- --------------------------------------------------------

--
-- Table structure for table `desktops`
--

CREATE TABLE `desktops` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'Desktop',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `device_mistakes`
--

CREATE TABLE `device_mistakes` (
  `id` int(11) NOT NULL,
  `serial_number` varchar(150) DEFAULT NULL COMMENT 'Serial Number',
  `halo_id` varchar(100) DEFAULT NULL COMMENT 'Halo ID',
  `ins_number` varchar(100) DEFAULT NULL COMMENT 'INS Number',
  `username` varchar(150) DEFAULT NULL COMMENT 'Username',
  `department` varchar(100) DEFAULT NULL COMMENT 'Department',
  `team` varchar(100) DEFAULT NULL COMMENT 'Team',
  `date_turn` date DEFAULT NULL COMMENT 'Date Turn',
  `problem_case` varchar(255) DEFAULT NULL COMMENT 'Problem Case',
  `remark` text DEFAULT NULL COMMENT 'Remark',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Mistake records for ICT devices';

-- --------------------------------------------------------

--
-- Table structure for table `device_transfers`
--

CREATE TABLE `device_transfers` (
  `id` int(11) NOT NULL,
  `halo_id` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `source_table` varchar(100) DEFAULT NULL,
  `from_username` varchar(150) DEFAULT NULL,
  `from_department` varchar(100) DEFAULT NULL,
  `from_team` varchar(100) DEFAULT NULL,
  `from_ins_number` varchar(100) DEFAULT NULL,
  `from_location` varchar(150) DEFAULT NULL,
  `to_username` varchar(150) DEFAULT NULL,
  `to_department` varchar(100) DEFAULT NULL,
  `to_team` varchar(100) DEFAULT NULL,
  `to_ins_number` varchar(100) DEFAULT NULL,
  `to_location` varchar(150) DEFAULT NULL,
  `transfer_date` date DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `device_transfers`
--

INSERT INTO `device_transfers` (`id`, `halo_id`, `serial_number`, `device_type`, `brand`, `model`, `source_table`, `from_username`, `from_department`, `from_team`, `from_ins_number`, `from_location`, `to_username`, `to_department`, `to_team`, `to_ins_number`, `to_location`, `transfer_date`, `remark`, `created_at`) VALUES
(1, 'TAB-074', '333333333333333', 'Tablet', 'Samsung', 'Dell 123456', 'tablets', 'GIS', 'GIS', 'ICT', 'INS-1540', 'Xepon', 'Dong', 'GIS', 'IT', 'INS-1540', 'xepon', '2026-03-21', 'transfer from gis', '2026-03-21 13:16:05');

-- --------------------------------------------------------

--
-- Table structure for table `dgps`
--

CREATE TABLE `dgps` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'DGPS',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `username`, `ins_number`, `department`, `team`, `location`, `phone`, `created_at`) VALUES
(714, 'Manyvan CHANTILANONG', 'INS-00434', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(715, 'Lery', 'INS-00548', 'Ops', 'CL D13', 'Sepon', NULL, '2026-04-07 05:32:25'),
(716, 'Pea SINGTHONG', 'INS-00136', 'Ops', 'CL D16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(717, 'GIS', 'INS-9096T', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(718, 'Boualoy DORKSONKHAM', 'INS-00915', 'Ops', 'CL D05', 'Sepon', NULL, '2026-04-07 05:32:25'),
(719, 'Fongsamouth  DOUANGMALA', 'INS-00592', 'Ops', 'CL C24', 'Sepon', NULL, '2026-04-07 05:32:25'),
(720, 'Khamphet THEBYODPANY', 'INS-00866', 'Ops', 'MC B02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(721, 'Khampao SANSAVANG', 'INS-01017', 'Ops', 'CL A23', 'Sepon', NULL, '2026-04-07 05:32:25'),
(722, 'Nouamvilay PHIMMALAD', 'INS-01322', 'Ops', 'CL A23', 'Sepon', NULL, '2026-04-07 05:32:25'),
(723, 'Souk PHIMMASENG', 'INS-01151', 'Ops', 'CL D10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(724, 'Khamdeng SICHANTHA', 'INS-00241', 'Ops', 'CL C17', 'Sepon', NULL, '2026-04-07 05:32:25'),
(725, 'Damdee KEOCHALERN', 'INS-00231', 'Ops', 'SV A3', 'Sepon', NULL, '2026-04-07 05:32:25'),
(726, 'Phuvong EMCHAN', 'INS-00865', 'Ops', 'SV A2', 'Sepon', NULL, '2026-04-07 05:32:25'),
(727, 'Bakham SICHANTHA', 'INS-00290', 'Ops', 'CL B02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(728, 'Somboun CHOUMMANY', 'INS-00286', 'Ops', 'MC B1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(729, 'Malaythong THAVONG', 'INS-00553', 'Ops', 'CL A07', 'Sepon', NULL, '2026-04-07 05:32:25'),
(730, 'Keooudone  BOUTYASAN', 'INS-00775', 'Ops', 'CL A05', 'Sepon', NULL, '2026-04-07 05:32:25'),
(731, 'Sonsak SAYNALY', 'INS-00614', 'Ops', 'CL CL A12', 'Sepon', NULL, '2026-04-07 05:32:25'),
(732, 'Khaikham BOUDSADY', 'INS-00114', 'Ops', 'CL A11', 'Sepon', NULL, '2026-04-07 05:32:25'),
(733, 'Chantavong  SAISOMBOUT', 'INS-00788', 'Ops', 'CL A21', 'Sepon', NULL, '2026-04-07 05:32:25'),
(734, 'Kounglay VEDMANY', 'INS-00251', 'Ops', 'CL A09', 'Sepon', NULL, '2026-04-07 05:32:25'),
(735, 'Phim KEOKHOUNPHET', 'INS-01332', 'Ops', 'CL A22', 'Sepon', NULL, '2026-04-07 05:32:25'),
(736, 'Toulanee SENSOULIYA', 'INS-00018', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(737, 'Konkeo', 'INS-00676', 'Ops', 'CL A16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(738, 'Darling', 'INS-00682', 'Ops', 'CL A03', 'Sepon', NULL, '2026-04-07 05:32:25'),
(739, 'Bounchome NIPHACHAN', 'INS-00133', 'Ops', 'CL A01', 'Sepon', NULL, '2026-04-07 05:32:25'),
(740, 'Khamsai  SEESOUPHAN', 'INS-00597', 'Ops', 'CL B08', 'Sepon', NULL, '2026-04-07 05:32:25'),
(741, 'Kedsana PHETKONGMA', 'INS-01816', 'Ops', 'EOD2 A', 'Sepon', NULL, '2026-04-07 05:32:25'),
(742, 'Seesouda  BOUTTAKHAN', 'INS-00776', 'Ops', 'EOD 5 A', 'Sepon', NULL, '2026-04-07 05:32:25'),
(743, 'Tiengthong SISAVAN', 'INS-00182', 'Ops', 'EOD6', 'Sepon', NULL, '2026-04-07 05:32:25'),
(744, 'Chandee', 'INS-00526', 'Ops', 'CL A8', 'Sepon', NULL, '2026-04-07 05:32:25'),
(745, 'Kiengkham KHINTHAVONG', 'INS-00021', 'Ops', 'CL A09', 'Sepon', NULL, '2026-04-07 05:32:25'),
(746, 'Vonema CHANTHATHILATH', 'INS-00825', 'Ops', 'CL A11', 'Sepon', NULL, '2026-04-07 05:32:25'),
(747, 'Pinnapha SINPHADA', 'INS-00418', 'Ops', 'EOD5', 'Sepon', NULL, '2026-04-07 05:32:25'),
(748, 'Phalom KEOBOUNSAN', 'INS-01329', 'Ops', 'CL C02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(749, 'Chanpasouk PHATHITHAK', 'INS-00349', 'Ops', 'CL A02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(750, 'Bounthavy KHAMSINOLA', 'INS-01298', 'Ops', 'SV A4', 'Sepon', NULL, '2026-04-07 05:32:25'),
(751, 'Toy XAYYABOUTH', 'INS-00619', 'Ops', 'CL C22', 'Sepon', NULL, '2026-04-07 05:32:25'),
(752, 'Sounee NORSAOVANG', 'INS-00464', 'Ops', 'CL A15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(753, 'Bounthavy KONEMANY', 'INS-00347', 'Ops', 'EOD3', 'Sepon', NULL, '2026-04-07 05:32:25'),
(754, 'Poukky SEEPHENG', 'INS-00556', 'Ops', 'CL A13', 'Sepon', NULL, '2026-04-07 05:32:25'),
(755, 'Somvang VONGMANY', 'INS-00540', 'Ops', 'CL A10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(756, 'Phetsamone SEESAKEDKHAMMOUAN', 'INS-00537', 'Ops', 'CL A04', 'Sepon', NULL, '2026-04-07 05:32:25'),
(757, 'Ar SIXANON', 'INS-00343', 'Ops', 'CL B12', 'Sepon', NULL, '2026-04-07 05:32:25'),
(758, 'Ounchai  PHONSANGA', 'INS-00633', 'Ops', 'CL B06', 'Sepon', NULL, '2026-04-07 05:32:25'),
(759, 'Bouahong', 'INS-00546', 'Ops', 'CL B11', 'Sepon', NULL, '2026-04-07 05:32:25'),
(760, 'Darling KHENNAVONG', 'INS-00552', 'Ops', 'CL C25', 'Sepon', NULL, '2026-04-07 05:32:25'),
(761, 'Saisomphone ANOUPHIN', 'INS-01424', 'Ops', 'CL C07', 'Sepon', NULL, '2026-04-07 05:32:25'),
(762, 'Chit VORLASOUN', 'INS-01191', 'Ops', 'CL C05', 'Sepon', NULL, '2026-04-07 05:32:25'),
(763, 'Chaiphet THEBPHAVONG', 'INS-01300', 'Ops', 'CL A25', 'Sepon', NULL, '2026-04-07 05:32:25'),
(764, 'Sone  PHOMMACHAK', 'INS-00617', 'Ops', 'CL C01', 'Sepon', NULL, '2026-04-07 05:32:25'),
(765, 'Somemay KHAMSAI', 'INS-00220', 'Ops', 'CL C22', 'Sepon', NULL, '2026-04-07 05:32:25'),
(766, 'Khamsavang THOUMMANY', 'INS-00419', 'Ops', 'CL B03', 'Sepon', NULL, '2026-04-07 05:32:25'),
(767, 'Sack XAYYASANE', 'INS-00187', 'Ops', 'CL C11', 'Sepon', NULL, '2026-04-07 05:32:25'),
(768, 'Khitsamai', 'INS-00937', 'Ops', 'CL B20', 'Sepon', NULL, '2026-04-07 05:32:25'),
(769, 'Keota PHENGTHONG', 'INS-00316', 'Ops', 'CL A20', 'Sepon', NULL, '2026-04-07 05:32:25'),
(770, 'Toyota VANHTHALY', 'INS-00084', 'Ops', 'CL C08', 'Sepon', NULL, '2026-04-07 05:32:25'),
(771, 'Bouakham', 'INS-00836', 'Ops', 'CL A02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(772, 'Khamsamai THOUVONGSA', 'INS-00139', 'Ops', 'CL D15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(773, 'Phetsamai SIBOUNHEUANG', 'INS-01261', 'Ops', 'CL A19', 'Sepon', NULL, '2026-04-07 05:32:25'),
(774, 'Adsaphone', 'INS-00582', 'Ops', 'CL C06', 'Sepon', NULL, '2026-04-07 05:32:25'),
(775, 'Chakkavarn VILAYVIENG', 'INS-00030', 'Ops', 'CL C04', 'Sepon', NULL, '2026-04-07 05:32:25'),
(776, 'Mouk SOUKSAVAN', 'INS-00428', 'Ops', 'CL C23', 'Sepon', NULL, '2026-04-07 05:32:25'),
(777, 'Khamfai VILAISAK', 'INS-01114', 'Ops', 'CL C20', 'Sepon', NULL, '2026-04-07 05:32:25'),
(778, 'Somboun', 'INS-00688', 'Ops', 'CL C12', 'Sepon', NULL, '2026-04-07 05:32:25'),
(779, 'Ladsamee PHOMMALIN', 'INS-00234', 'Ops', 'CL C09', 'Sepon', NULL, '2026-04-07 05:32:25'),
(780, 'Tahouy  PHONESOMSAY', 'INS-00221', 'Ops', 'CL B08', 'Sepon', NULL, '2026-04-07 05:32:25'),
(781, 'Manyphone KOMMALAY', 'INS-01006', 'Ops', 'CL B05', 'Sepon', NULL, '2026-04-07 05:32:25'),
(782, 'Dery', 'INS-00601', 'Ops', 'CL C10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(783, 'Phikoudone SEESIENGMATH', 'INS-00595', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(784, 'Keooudone', 'INS-00668', 'Ops', 'CL B15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(785, 'Khouanta PHONESAMAI', 'INS-00519', 'Ops', 'CL B16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(786, 'Vandara KHAMAE', 'INS-00223', 'Ops', 'CL C21', 'Sepon', NULL, '2026-04-07 05:32:25'),
(787, 'Monekham', 'INS-00470', 'Ops', 'CL C17', 'Sepon', NULL, '2026-04-07 05:32:25'),
(788, 'Dasavan', 'INS-00672', 'Ops', 'CL C18', 'Sepon', NULL, '2026-04-07 05:32:25'),
(789, 'Vangchai  NAMPANYA', 'INS-00674', 'Ops', 'CL C19', 'Sepon', NULL, '2026-04-07 05:32:25'),
(790, 'Toumphone', 'INS-00594', 'Ops', 'CL B14', 'Sepon', NULL, '2026-04-07 05:32:25'),
(791, 'Noula PHONGPHANA', 'INS-00531', 'Ops', 'CL B10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(792, 'Khonesavan VILAYVONG', 'INS-00420', 'Ops', 'CL C15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(793, 'Somephet SYMEUANG', 'INS-00141', 'Ops', 'CL C16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(794, 'Buakham PHOMMADTA', 'INS-00159', 'Ops', 'CL C13', 'Sepon', NULL, '2026-04-07 05:32:25'),
(795, 'Somkhit PHOMLOUANGVISA', 'INS-00411', 'Ops', 'CL C14', 'Sepon', NULL, '2026-04-07 05:32:25'),
(796, 'Nouansee BOUNMISAY', 'INS-00456', 'Ops', 'CL B07', 'Sepon', NULL, '2026-04-07 05:32:25'),
(797, 'Noud  BOUNYONGMA', 'INS-00304', 'Ops', 'CL B17', 'Sepon', NULL, '2026-04-07 05:32:25'),
(798, 'Seng VERNKHAM', 'INS-00135', 'Ops', 'CL B18', 'Sepon', NULL, '2026-04-07 05:32:25'),
(799, 'Alingkham  LOUANGLADKEOKHOUNMEUANG', 'INS-00659', 'Ops', 'CL C19', 'Sepon', NULL, '2026-04-07 05:32:25'),
(800, 'Thongdam SINGSAVATH', 'INS-00462', 'Ops', 'CL B13', 'Sepon', NULL, '2026-04-07 05:32:25'),
(801, 'Manyngern', 'INS-00332', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(802, 'Soukphama THEBSOMBAT', 'INS-00441', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(803, 'Viengsavanh PHIMMASONE', 'INS-00149', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(804, 'Adna DOUANGBOUDDY', 'INS-00431', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(805, 'Bolibouan  SALIHA', 'INS-01023', 'Ops', 'HQ1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(806, 'Khedsavan KHENNAVONG', 'INS-01196', 'Ops', 'HQ1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(807, 'Kongsanith SOUASIVILAY', 'INS-00450', 'Medical', 'HQ1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(808, 'Khonsavanh XAYYASITH', 'INS-00078', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(809, 'Sivay KEDSAVANH', 'INS-00032', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(810, 'Hein Bekker', 'INS-09001', 'Ops', 'Ops', 'Sepon', NULL, '2026-04-07 05:32:25'),
(811, 'Phoimany SENGATHIT', 'INS-00843', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(812, 'Vannida KONGSADETH', 'INS-01062', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(813, 'Chansamone', 'INS-00728', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(814, 'Yonesa SINGTHONGTHAI', 'INS-00121', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(815, 'Manyvan VONGNADY', 'INS-00414', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(816, 'Daovandone KHOUTPHAITHOUN', 'INS-00046', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(817, 'Kaisamone VONGSAKSI', 'INS-01192', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(818, 'Bounyor SEKAVONE', 'INS-00222', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(819, 'Somphone  SAYYAVONG', 'INS-00593', 'Ops', 'AC 01', 'Sepon', NULL, '2026-04-07 05:32:25'),
(820, 'Khamsamai', 'INS-00890', 'Ops', 'AC 02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(821, 'Minthada THEBVONGSA', 'INS-00480', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(822, 'Phouvanh KETHTHASONE', 'INS-00041', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(823, 'Phantha KIKHOUNKHAM', 'INS-00025', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(824, 'Bounnoi PHOMMAVONG', 'INS-00022', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(825, 'Souliya OUANTHOUMPHONE', 'INS-00146', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(826, 'Malaythong KHODSISA', 'INS-00439', 'Ops', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(827, 'Phet KHENTHILA', 'INS-00280', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(828, 'Inthouon KONGSAYSY', 'INS-01268', 'HR', 'HR', 'Sepon', NULL, '2026-04-07 05:32:25'),
(829, 'Sisomphan PHIMTHISAN', 'INS-00810', 'Electrician', 'Electrician', 'Sepon', NULL, '2026-04-07 05:32:25'),
(830, 'Chanlone UONGBOUNCHAN', 'INS-02011', 'Translator', 'Interpreter', 'Sepon', NULL, '2026-04-07 05:32:25'),
(831, 'Ackala SINOUVONG', 'INS-00375', 'Translator', 'Interpreter', 'Sepon', NULL, '2026-04-07 05:32:25'),
(832, 'Phettanousone KOMMATHILATH', 'INS-00878', 'FN', 'Finance', 'Sepon', NULL, '2026-04-07 05:32:25'),
(833, 'Punya  PHOMMIXAY', 'INS-00720', 'Logistic', 'Logistic', 'Sepon', NULL, '2026-04-07 05:32:25'),
(834, 'Lattana INTHAVONGSA', 'INS-01850', 'Translator', 'Interpreter', 'Sepon', NULL, '2026-04-07 05:32:25'),
(835, 'Kayamphone SOUMPHONPHAKDY', 'INS-01863', 'translator', 'Interpreter', 'Sepon', NULL, '2026-04-07 05:32:25'),
(836, 'Keovongkot PHISITHXAY', 'INS-01287', 'Logistic', 'Logistic', 'Sepon', NULL, '2026-04-07 05:32:25'),
(837, 'Sathaphone KHENVANPHENG', 'INS-01851', 'translator', 'Interpreter', 'Sepon', NULL, '2026-04-07 05:32:25'),
(838, 'Touk PHOVANNAVONG', 'INS-00626', 'Procurment', 'VTE', 'Sepon', NULL, '2026-04-07 05:32:25'),
(839, 'Nikhone  SOMMYXAY', 'INS-00739', 'HR', 'HR', 'Sepon', NULL, '2026-04-07 05:32:25'),
(840, 'Khanmali KEOSIPASERT', 'INS-00358', 'Admin', 'Facilities1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(841, 'Namfonh VORASANE', 'INS-01902', 'Translator', 'Interpreter', 'Sepon', NULL, '2026-04-07 05:32:25'),
(842, 'Phutthasit SENPASERD', 'INS-00167', 'OPS', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(843, 'Keo CHANTHAVONE', 'INS-01094', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(844, 'Lee KOULOR', 'INS-02014', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(845, 'Khonesavan MALAYKHAM', 'INS-00508', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(846, 'Somthan SYMEEXAY', 'INS-02012', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(847, 'Keosomehak  SENVISAYSOUK', 'INS-00359', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(848, 'Hongsa LOUANGBOUTDY', 'INS-00505', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(849, 'Sengvang NAOLOR', 'INS-02013', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(850, 'Sain', 'INS-09173', 'OPS', 'Expat', 'Sepon', NULL, '2026-04-07 05:32:25'),
(851, 'Lay KETHSAVAN', 'INS-00395', 'Ops', 'EORE 1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(852, 'Soukdavan DOUANGSOPHA', 'INS-01279', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(853, 'Sykhoun  KONGTHILATH', 'INS-00639', 'OPS', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(854, 'Viphakone VILATHAM', 'INS-01670', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(855, 'Viengvilay VONGKHAMMOUTY', 'INS-00408', 'Admin', 'VTE', 'Vientiane', NULL, '2026-04-07 05:32:25'),
(856, 'Nilandone PHOMLOUANGSY', 'INS-00062', 'Finance', 'Finance', 'Sepon', NULL, '2026-04-07 05:32:25'),
(857, 'Phiphavanh XAYAVONG', 'INS-01519', 'EORE', 'EORE', 'Sepon', NULL, '2026-04-07 05:32:25'),
(858, 'Souligno INTHAVONG', 'INS-01866', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(859, 'fleet', 'INS-9103', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(860, 'Douangchay  SOUTHAMMAVONG', 'INS-00732', 'Liaison', 'Liaison1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(861, 'Phoulathsamy PHOMMALATH', 'INS-00478', 'Finance', 'Finance', 'Sepon', NULL, '2026-04-07 05:32:25'),
(862, 'Fleet', 'INS-9103T', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(863, 'Lathdaphone CHANTHAPASEUTH', 'INS-00443', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(864, 'Chanthala SAYYAVONGSA', 'INS-00161', 'Logistic', 'Logistic', 'Sepon', NULL, '2026-04-07 05:32:25'),
(865, 'Tom THOOYYAVONG', 'INS-00298', 'HR', 'HR', 'Sepon', NULL, '2026-04-07 05:32:25'),
(866, 'Noknoy PHOMLOUANGVISA', 'INS-00451', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(867, 'Khammany BOUNTEUM', 'INS-01361', 'liaison', 'Liaison2', 'Sepon', NULL, '2026-04-07 05:32:25'),
(868, 'Oth PHIMMASY', 'INS-00250', 'liaison', 'Liaison1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(869, 'Kaoxing SINGTHAVONG', 'INS-00200', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(870, 'Arty BOLIBOUN', 'INS-01369', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(871, 'Vongdeuane KHOUNPHOM', 'INS-00448', 'Logistic', 'Logistic', 'Sepon', NULL, '2026-04-07 05:32:25'),
(872, 'Facilities', 'INS-9099', 'Facilities', 'Facilities', 'Sepon', NULL, '2026-04-07 05:32:25'),
(873, 'Touktic VORLASAN', 'INS-00071', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(874, 'Khammy KHAMVANVONGSA', 'INS-00405', 'Electrician', 'Electrician', 'Sepon', NULL, '2026-04-07 05:32:25'),
(875, 'Sinchai VORLACHARK', 'INS-01288', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(876, 'Yeechang CHONGXENG', 'INS-01976', 'HR', 'HR', 'Sepon', NULL, '2026-04-07 05:32:25'),
(877, 'Anongsack LUENAMACHACK', 'INS-01540', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(878, 'Anousa  PHOMPHITHAK', 'INS-00734', 'Ops', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(879, 'Kattherin', 'INS-9167', 'Liaison', 'Expat', 'Sepon', NULL, '2026-04-07 05:32:25'),
(880, 'Khaiphone NIAMVIMAN', 'INS-00507', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(881, 'Akim', 'INS-09174', 'Ops', 'Ops', 'Sepon', NULL, '2026-04-07 05:32:25'),
(882, 'Bounthan PHENGMANYVONG', 'INS-00007', 'Fleet', 'Fleet', 'Sepon', NULL, '2026-04-07 05:32:25'),
(883, 'Khamphone  THONEMA', 'INS-00733', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(884, 'Hanna', 'INS-09157', 'OPS', 'expat', 'Sepon', NULL, '2026-04-07 05:32:25'),
(885, 'Andrew', 'INS-09093', 'Fleet', 'expat', 'Sepon', NULL, '2026-04-07 05:32:25'),
(886, 'Vilannoud MOLOUNTHACHACK', 'INS-00404', 'Finance', 'VTE', 'Vientiane', NULL, '2026-04-07 05:32:25'),
(887, 'Somxay SENPHONE', 'INS-00281', 'Logistic', 'Logistic', 'Sepon', NULL, '2026-04-07 05:32:25'),
(888, 'Sitdavan CHANTHASOMPHOU', 'INS-00846', 'Ops', 'EORE 3', 'Sepon', NULL, '2026-04-07 05:32:25'),
(889, 'Vilakhone THEPSOULINTHONE', 'INS-00265', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(890, 'Someta', 'INS-00351', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(891, 'Anousith  VINKHOUNSAVATH', 'INS-00596', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(892, 'Vongphan  XAYPHAVIENG', 'INS-00354', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(893, 'Laiphone KHAMDEEPASERD', 'INS-00197', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(894, 'Amphaiphone LITTHIKOUMMAN', 'INS-00463', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(895, 'Syoudone  XAYYASIT', 'INS-00721', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(896, 'Namfon', 'INS-00511', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(897, 'Lumngern', 'INS-00352', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(898, 'Honda TANKHAMPHONG', 'INS-00791', 'Ops', 'S1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(899, 'Somebuth PHENGSIYA', 'INS-00264', 'Ops', 'EOD 4', 'Sepon', NULL, '2026-04-07 05:32:25'),
(900, 'Lamphone CHAMPATHONG', 'INS-00313', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(901, 'Logistic', 'INS-9107T', 'Logistic', 'Logistic', 'Sepon', NULL, '2026-04-07 05:32:25'),
(902, 'Ketkesa PANGTHANA', 'INS-00972', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(903, 'Siphong PHOUNSOD', 'INS-00093', 'Facility', 'Facilities1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(904, 'Phout', 'INS-01015', 'Ops', 'CL D15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(905, 'Touly  KHAMPHIEW', 'INS-00301', 'Ops', 'AC', 'Sepon', NULL, '2026-04-07 05:32:25'),
(906, 'Malavan VONGHACHAK', 'INS-00509', 'OPS', 'O1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(907, 'M Kalathone MALABATH', 'INS-00160', 'Ops', 'EOD 1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(908, 'Kheunma', 'INS-00749', 'Ops', 'CL B19', 'Sepon', NULL, '2026-04-07 05:32:25'),
(909, 'Finance', 'INS-9098T', 'Finance', 'Finance', 'Sepon', NULL, '2026-04-07 05:32:25'),
(910, 'David', 'INS-09176', 'Expat', 'OPS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(911, 'Soukan TANVONGPHAN', 'INS-01341', 'Ops', 'CL A10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(912, 'Souphachan', 'INS-00551', 'Ops', 'MC B1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(913, 'Oil', 'INS-00586', 'Ops', 'CL B08', 'Sepon', NULL, '2026-04-07 05:32:25'),
(914, 'Training', 'INS-9100T', 'OPS', 'Training', 'Sepon', NULL, '2026-04-07 05:32:25'),
(915, 'Saiysavanh KHONGTHILATH', 'INS-01353', 'Finance', 'Finance', 'Sepon', NULL, '2026-04-07 05:32:25'),
(916, 'Natmany INTHISONE', 'INS-00417', 'Ops', 'MC B2', 'Sepon', NULL, '2026-04-07 05:32:25'),
(917, 'Ei VONGKANTHAO', 'INS-01179', 'Ops', 'CL C02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(918, 'Kaenta', 'INS-00600', 'Ops', 'CL C03', 'Sepon', NULL, '2026-04-07 05:32:25'),
(919, 'Chansamai PHIMKHAITHONG', 'INS-00997', 'Ops', 'CL A09', 'Sepon', NULL, '2026-04-07 05:32:25'),
(920, 'Phousavan KEOBOUAPHAN', 'INS-01012', 'Ops', 'CL B26', 'Sepon', NULL, '2026-04-07 05:32:25'),
(921, 'Loy  TOUNMANISONE', 'INS-00680', 'Ops', 'CL C21', 'Sepon', NULL, '2026-04-07 05:32:25'),
(922, 'Bounkerd KEOLOUANGLATH', 'INS-00226', 'Ops', 'CL B19', 'Sepon', NULL, '2026-04-07 05:32:25'),
(923, 'HR', 'INS-9097T', 'HR', 'HR', 'Sepon', NULL, '2026-04-07 05:32:25'),
(924, 'Kongpheng', 'INS-00689', 'Ops', 'CL D03', 'Sepon', NULL, '2026-04-07 05:32:25'),
(925, 'Lakhonesy', 'INS-01311', 'Ops', 'D07', 'Sepon', NULL, '2026-04-07 05:32:25'),
(926, 'Aon SAIYASIN', 'INS-01293', 'Ops', 'D08', 'Sepon', NULL, '2026-04-07 05:32:25'),
(927, 'Ladsavong  SAYSOMPHENG', 'INS-00631', 'Ops', 'CL B16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(928, 'Phimpha THEPHAVONG', 'INS-00177', 'Ops', 'MC B1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(929, 'Makki VATTANA', 'INS-01317', 'Ops', 'CL A06', 'Sepon', NULL, '2026-04-07 05:32:25'),
(930, 'Leokham PHOUKEO', 'INS-00993', 'Ops', 'CL B18', 'Sepon', NULL, '2026-04-07 05:32:25'),
(931, 'Sing SAMEUANGBOR', 'INS-01164', 'Ops', 'CL A13', 'Sepon', NULL, '2026-04-07 05:32:25'),
(932, 'Thongmai SOUKDALA', 'INS-01344', 'Ops', 'CL B04', 'Sepon', NULL, '2026-04-07 05:32:25'),
(933, 'Airnoy PHOMLOUANGSY', 'INS-01541', 'Ops', 'CL C20', 'Sepon', NULL, '2026-04-07 05:32:25'),
(934, 'Chanthy VILAISAK', 'INS-01553', 'Ops', 'CL B21', 'Sepon', NULL, '2026-04-07 05:32:25'),
(935, 'Toung YODCHONGKHAM', 'INS-01346', 'Ops', 'CL B15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(936, 'Khamhou KHONGKHANTHACHAK', 'INS-01625', 'Ops', 'CL A11', 'Sepon', NULL, '2026-04-07 05:32:25'),
(937, 'Somphong FONGSALATH', 'INS-01806', 'Ops', 'CL A23', 'Sepon', NULL, '2026-04-07 05:32:25'),
(938, 'Thevy LATTANA', 'INS-01656', 'Ops', 'CL A10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(939, 'Timkham KEOCHAIDEE', 'INS-01963', 'Ops', 'CL C14', 'Sepon', NULL, '2026-04-07 05:32:25'),
(940, 'Van SOUDAVAN', 'INS-01587', 'Ops', 'C08', 'Sepon', NULL, '2026-04-07 05:32:25'),
(941, 'Noy KONPASA', 'INS-01936', 'Ops', 'CL A18', 'Sepon', NULL, '2026-04-07 05:32:25'),
(942, 'Keomanivone BOUNPHAHAKSA', 'INS-01620', 'Ops', 'CL A18', 'Sepon', NULL, '2026-04-07 05:32:25'),
(943, 'Phitsadee SOMNAK', 'INS-01643', 'Ops', 'CL A20', 'Sepon', NULL, '2026-04-07 05:32:25'),
(944, 'Chanthanome SOUVANNAVONG', 'INS-00921', 'Ops', 'CL D15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(945, 'Phonethib', 'INS-01645', 'Ops', 'CL C14', 'Sepon', NULL, '2026-04-07 05:32:25'),
(946, 'Houang', 'INS-01765', 'Ops', 'CL B19', 'Sepon', NULL, '2026-04-07 05:32:25'),
(947, 'Dalavan  NORVANG', 'INS-00588', 'Ops', 'CL C12', 'Sepon', NULL, '2026-04-07 05:32:25'),
(948, 'Wut Hmon', 'INS-9199', 'Finance', 'FN manaer', 'Sepon', NULL, '2026-04-07 05:32:25'),
(949, 'Manta TONGMALATH', 'INS-00623', 'Ops', 'CL C14', 'Sepon', NULL, '2026-04-07 05:32:25'),
(950, 'Seephone', 'INS-00340', 'Ops', 'D06', 'Sepon', NULL, '2026-04-07 05:32:25'),
(951, 'Nouhak PHIMBOUASONE', 'INS-01323', 'Ops', 'EORE 3', 'Sepon', NULL, '2026-04-07 05:32:25'),
(952, 'Latsamee', 'INS-00834', 'Ops', 'CL C06', 'Sepon', NULL, '2026-04-07 05:32:25'),
(953, 'Padthana  KHOUNKHAM', 'INS-00705', 'Ops', 'CL A02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(954, 'Liphone VONGVILAILAT', 'INS-01315', 'Ops', 'CL C04', 'Sepon', NULL, '2026-04-07 05:32:25'),
(955, 'Saipaserthsith Insixiengmai', 'INS-02061', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(956, 'Matthew', 'INS-9200', 'Expat', 'expat', 'Sepon', NULL, '2026-04-07 05:32:25'),
(957, 'Phoutmany  INSYXIENGMAY', 'INS-00501', 'Vientiane', 'VTE', 'Vientiane', NULL, '2026-04-07 05:32:25'),
(958, 'Kanya', 'INS-02055', 'Translator', 'Treanslator', 'Sepon', NULL, '2026-04-07 05:32:25'),
(959, 'khamlar.xayyakoumman', 'INS-002053', 'Translator', 'Translator', 'Sepon', NULL, '2026-04-07 05:32:25'),
(960, 'Linna Sikhongthon', 'INS-02062', 'Translator', 'Translator', 'Sepon', NULL, '2026-04-07 05:32:25'),
(961, 'Tina Chanthalome', 'INS-02064', 'Translator', 'Translator', 'Sepon', NULL, '2026-04-07 05:32:25'),
(962, 'Vanida Nanthasan', 'INS-02063', 'Translator', 'Translator', 'Sepon', NULL, '2026-04-07 05:32:25'),
(963, 'Tina', 'INS-3064', 'Translator', 'Field Researsher', 'Sepon', NULL, '2026-04-07 05:32:25'),
(964, 'Tha', 'INS-01294', 'Ops', 'CL A07', 'Sepon', NULL, '2026-04-07 05:32:25'),
(965, 'Traning', 'INS-9100', 'OPS', 'Traning', 'Sepon', NULL, '2026-04-07 05:32:25'),
(966, 'Thay Chanthavong', 'INS-002065', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(967, 'Thay Chanthavong', 'INS-02065', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(968, 'Kongkeo YODTHALEUSAI', 'INS-01124', 'Ops', 'CL A20', 'Sepon', NULL, '2026-04-07 05:32:25'),
(969, 'Akim', 'INS-9174', 'Expat', 'expat', 'Sepon', NULL, '2026-04-07 05:32:25'),
(970, 'Kaina SOUMIXAY', 'INS-01926', 'Ops', 'CL C19', 'Sepon', NULL, '2026-04-07 05:32:25'),
(971, 'Homema', 'INS-01052', 'Ops', 'CL B05', 'Sepon', NULL, '2026-04-07 05:32:25'),
(972, 'Vanh', 'INS-00786', 'Ops', 'CL B16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(973, 'Phoun SILAKHONE', 'INS-01709', 'Ops', 'CL B03', 'Sepon', NULL, '2026-04-07 05:32:25'),
(974, 'Somphone', 'INS-00662', 'Ops', 'MC B2', 'Sepon', NULL, '2026-04-07 05:32:25'),
(975, 'Lunya MITKONGKY', 'INS-01630', 'Ops', 'CL B05', 'Sepon', NULL, '2026-04-07 05:32:25'),
(976, 'Boualin Vongdata', 'INS-02073', 'Medical', 'Medical', 'Sepon', NULL, '2026-04-07 05:32:25'),
(977, 'Daniel Kuchalski', 'INS-9201', 'Fleet', 'Fleet Manager', 'Sepon', NULL, '2026-04-07 05:32:25'),
(978, 'Singthong SAINAMSOK', 'INS-01504', 'Ops', 'CL A24', 'Sepon', NULL, '2026-04-07 05:32:25'),
(979, 'Ta', 'INS-00648', 'Ops', 'CL B02', 'Sepon', NULL, '2026-04-07 05:32:25'),
(980, 'Sali', 'INS-01425', 'Ops', 'EOD 6', 'Sepon', NULL, '2026-04-07 05:32:25'),
(981, 'Bounchan', 'INS-01872', 'Ops', 'CL A22', 'Sepon', NULL, '2026-04-07 05:32:25'),
(982, 'Fasai THOCHAN', 'INS-01459', 'Ops', 'CL D10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(983, 'Phiwphone', 'INS-00514', 'Ops', 'EOD 06', 'Sepon', NULL, '2026-04-07 05:32:25'),
(984, 'Airnoy', 'INS-01187', 'Ops', 'CL B16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(985, 'Panee KONGPHENGMA', 'INS-01642', 'Ops', 'CL B21', 'Sepon', NULL, '2026-04-07 05:32:25'),
(986, 'Phoukham SIVILAY', 'INS-01571', 'Ops', 'CL A16', 'Sepon', NULL, '2026-04-07 05:32:25'),
(987, 'Athai', 'INS-01100', 'Ops', 'CL A15', 'Sepon', NULL, '2026-04-07 05:32:25'),
(988, 'Dee', 'INS-00761', 'Ops', 'MC B2', 'Sepon', NULL, '2026-04-07 05:32:25'),
(989, 'Koukki XAYYALATH', 'INS-01689', 'Ops', 'CL C07', 'Sepon', NULL, '2026-04-07 05:32:25'),
(990, 'Kahaeng MANIVAN', 'INS-01305', 'Ops', 'CL B13', 'Sepon', NULL, '2026-04-07 05:32:25'),
(991, 'Xay', 'INS-00699', 'Ops', 'MC B1', 'Sepon', NULL, '2026-04-07 05:32:25'),
(992, 'Bounpheng', 'INS-00620', 'Ops', 'EOD 2', 'Sepon', NULL, '2026-04-07 05:32:25'),
(993, 'Noynikon SEESOULATH', 'INS-01640', 'Ops', 'CL C01', 'Sepon', NULL, '2026-04-07 05:32:25'),
(994, 'Phengta SAIYACHAK', 'INS-01421', 'Ops', 'CL D01', 'Sepon', NULL, '2026-04-07 05:32:25'),
(995, 'Phaivan MAHAVONG', 'INS-01793', 'Ops', 'CL A03', 'Sepon', NULL, '2026-04-07 05:32:25'),
(996, 'Yathom KHAMLAHOR', 'INS-01590', 'Ops', 'CL B04', 'Sepon', NULL, '2026-04-07 05:32:25'),
(997, 'Anoud POUMPRAI', 'INS-01442', 'Ops', 'CL C24', 'Sepon', NULL, '2026-04-07 05:32:25'),
(998, 'Than', 'INS-01899', 'Ops', 'CL A08', 'Sepon', NULL, '2026-04-07 05:32:25'),
(999, 'Mounit INTHAVONG', 'INS-01413', 'Ops', 'CL B18', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1000, 'Phai', 'INS-01937', 'Ops', 'CL A09', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1001, 'Thit KHEN', 'INS-01581', 'Ops', 'CL B10', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1002, 'Di KHOUNVISED', 'INS-01457', 'Ops', 'CL D04', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1003, 'Saiysamone AESOMEPHOU', 'INS-01948', 'Ops', 'CL D03', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1004, 'Phisitsay CHITSOUTTAVONG', 'INS-01013', 'Ops', 'CL D06', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1005, 'Angus Dickson', 'INS-9202', 'Expat', 'Expat', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1006, 'Khouayue  KATEEYUE', 'INS-02078', 'GIS', 'GIS', 'Sepon', NULL, '2026-04-07 05:32:25'),
(1007, 'Heuangsalak PHIMMACHAK', 'INS-01910', 'HR', 'HR', 'Sepon', '', '2026-04-07 05:32:25');

-- --------------------------------------------------------

--
-- Table structure for table `equipment_issue`
--

CREATE TABLE `equipment_issue` (
  `id` int(11) NOT NULL,
  `ins_number` varchar(100) DEFAULT '',
  `username` varchar(255) DEFAULT '',
  `department` varchar(100) DEFAULT '',
  `e_id` varchar(100) DEFAULT '',
  `eng_name` varchar(255) DEFAULT '',
  `lao_name` varchar(255) DEFAULT '',
  `e_new` int(11) DEFAULT 0,
  `old_stock` int(11) DEFAULT 0,
  `all_stock` int(11) DEFAULT 0,
  `type` varchar(100) DEFAULT '',
  `issue_date` date DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipment_issues`
--

CREATE TABLE `equipment_issues` (
  `id` int(11) NOT NULL,
  `ins_number` varchar(100) DEFAULT '',
  `username` varchar(150) DEFAULT '',
  `department` varchar(100) DEFAULT '',
  `e_id` varchar(100) DEFAULT '',
  `eng_name` varchar(255) DEFAULT '',
  `lao_name` varchar(255) DEFAULT '',
  `e_new` int(11) DEFAULT 0,
  `old_stock` int(11) DEFAULT 0,
  `all_stock` int(11) DEFAULT 0,
  `type` varchar(100) DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `team` varchar(100) DEFAULT '',
  `quantity` int(11) DEFAULT 0,
  `in_stock` int(11) DEFAULT 0,
  `date_out` date DEFAULT NULL,
  `e_old_stock` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipment_stock`
--

CREATE TABLE `equipment_stock` (
  `id` int(11) NOT NULL,
  `e_id` varchar(100) DEFAULT '',
  `eng_name` varchar(255) DEFAULT '',
  `lao_name` varchar(255) DEFAULT '',
  `e_new` int(11) DEFAULT 0,
  `old_stock` int(11) DEFAULT 0,
  `all_stock` int(11) DEFAULT 0,
  `type` varchar(100) DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_in` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipment_stock`
--

INSERT INTO `equipment_stock` (`id`, `e_id`, `eng_name`, `lao_name`, `e_new`, `old_stock`, `all_stock`, `type`, `created_at`, `date_in`) VALUES
(5, 'E001', 'Mouse wireless', 'ເມົ້າ ໄວເລັດ', 2, 0, 2, 'unit', '2026-05-01 07:00:42', '2026-04-06');

-- --------------------------------------------------------

--
-- Table structure for table `google_accounts`
--

CREATE TABLE `google_accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `account_type` varchar(100) DEFAULT 'Standard',
  `account_status` varchar(50) DEFAULT 'Active',
  `primary_email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `second_email` varchar(255) DEFAULT NULL,
  `third_email` varchar(255) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `team` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `halo_device_number` varchar(100) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `google_accounts`
--

INSERT INTO `google_accounts` (`id`, `full_name`, `account_type`, `account_status`, `primary_email`, `password`, `second_email`, `third_email`, `department`, `team`, `ins_number`, `halo_device_number`, `remark`, `phone`, `created_at`) VALUES
(5, 'GIS', 'Google account', 'actived', 'halolaos.245@gmail.com', 'Halo1353', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(6, 'GIS', 'Google account', 'actived', 'halolaos244@gmail.com', 'Ka1353ry', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(7, 'ICT', 'Google account', 'actived', 'halo.laos.ts.k@gmail.com', 'qZW4v8gv', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(8, 'ICT', 'Google account', 'actived', 'halolaos.11@gmail.com', 'GIS@123%11', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093124478', '2026-04-07 07:59:15'),
(9, 'ICT', 'Google account', 'actived', 'halolaos.101@gmail.com', '8JZLdv3s', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096420972', '2026-04-07 07:59:15'),
(10, 'ICT', 'Google account', 'actived', 'halolaos.10@gmail.com', 'GIS@123%10', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093124478', '2026-04-07 07:59:15'),
(11, 'ICT', 'Google account', 'actived', 'halolaos.105@gmail.com', 'vEKkTPly', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(12, 'ICT', 'Google account', 'actived', 'halolaos.106@gmail.com', 'G59MN7oS', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2099741524', '2026-04-07 07:59:15'),
(13, 'ICT', 'Google account', 'actived', 'halo.laos.ts.c@gmail.com', 'h7G4V19n', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(14, 'ICT', 'Google account', 'actived', 'halolaos.110@gmail.com', 'hoE8z9w7', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096420972', '2026-04-07 07:59:15'),
(15, 'ICT', 'Google account', 'actived', 'halolaos.112@gmail.com', '0cwt2YxW', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(16, 'ICT', 'Google account', 'actived', 'halolaos.114@gmail.com', 'XqXUZjYR', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(17, 'ICT', 'Google account', 'actived', 'halolaos.115@gmail.com', '6y6ubkN8', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2097432046', '2026-04-07 07:59:15'),
(18, 'ICT', 'Google account', 'actived', 'halolaos.117@gmail.com', 'x4iIv3yJ', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(19, 'ICT', 'Google account', 'actived', 'halolaos.118@gmail.com', 'kZNR5YPs', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(20, 'ICT', 'Google account', 'actived', 'halolaos.120@gmail.com', 'AMejz6fR', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(21, 'ICT', 'Google account', 'actived', 'halolaos.121@gmail.com', 'xeJGv8VT', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2099571974', '2026-04-07 07:59:15'),
(22, 'ICT', 'Google account', 'actived', 'halolaos.122@gmail.com', 'lJK6e6SM', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(23, 'ICT', 'Google account', 'actived', 'halolaos.08@gmail.com', 'GIS@123%08', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096023105', '2026-04-07 07:59:15'),
(24, 'ICT', 'Google account', 'actived', 'halolaos.123@gmail.com', 'LNTrupXT', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(25, 'ICT', 'Google account', 'actived', 'halolaos.125@gmail.com', 'oRZEY6VG', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(26, 'ICT', 'Google account', 'actived', 'halolaos.126@gmail.com', 'V31zckER', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(27, 'ICT', 'Google account', 'actived', 'halolaos.128@gmail.com', 'tvm3tVG5', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(28, 'ICT', 'Google account', 'actived', 'halolaos.129@gmail.com', 'zjF7wcLk', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(29, 'ICT', 'Google account', 'actived', 'halolaos.130@gmail.com', 'K9xRI53C', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093141457', '2026-04-07 07:59:15'),
(30, 'ICT', 'Google account', 'actived', 'halolaos.131@gmail.com', '5TGkoXzB', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(31, 'ICT', 'Google account', 'actived', 'halolaos.132@gmail.com', 'b20qup5E', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(32, 'ICT', 'Google account', 'actived', 'halolaos.133@gmail.com', 'u9pPE0Hu', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(33, 'ICT', 'Google account', 'actived', 'halolaos.135@gmail.com', 'NYMzgvlg', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(34, 'ICT', 'Google account', 'actived', 'halolaos.07@gmail.com', 'GIS@123%07', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092735428', '2026-04-07 07:59:15'),
(35, 'ICT', 'Google account', 'actived', 'halolaos.136@gmail.com', 'DQbF2p9Z', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(36, 'ICT', 'Google account', 'actived', 'halolaos.137@gmail.com', 'gU514Q4A', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(37, 'ICT', 'Google account', 'actived', 'halolaos.138@gmail.com', 'n7lEYKbG', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(38, 'ICT', 'Google account', 'actived', 'halolaos.139@gmail.com', 'Vhkk3jTM', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(39, 'ICT', 'Google account', 'actived', 'halolaos.140@gmail.com', 'q8fbF0i6', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(40, 'ICT', 'Google account', 'actived', 'halolaos.146@gmail.com', 'xdWXM8zn', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093735712', '2026-04-07 07:59:15'),
(41, 'ICT', 'Google account', 'actived', 'halolaos.147@gmail.com', 'WckEkVVA', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093287662', '2026-04-07 07:59:15'),
(42, 'ICT', 'Google account', 'actived', 'halo.laos.ts.g@gmail.com', 'kHqW33bd', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(43, 'ICT', 'Google account', 'actived', 'halolaos.149@gmail.com', 'sewiPn9o', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(44, 'ICT', 'Google account', 'actived', 'halolaos.150@gmail.com', 'BzEzCWLT', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093807510', '2026-04-07 07:59:15'),
(45, 'ICT', 'Google account', 'actived', 'halolaos.151@gmail.com', '40HuG5iU', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098134753', '2026-04-07 07:59:15'),
(46, 'ICT', 'Google account', 'actived', 'halolaos.152@gmail.com', 'qfBkr8Qw', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092355800', '2026-04-07 07:59:15'),
(47, 'ICT', 'Google account', 'actived', 'halolaos.153@gmail.com', '6a5YexKs', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(48, 'ICT', 'Google account', 'actived', 'halolaos.154@gmail.com', '2ysLIGqT', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2094320607', '2026-04-07 07:59:15'),
(49, 'ICT', 'Google account', 'actived', 'halolaos.155@gmail.com', 'O3sZvZfa', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2095806481', '2026-04-07 07:59:15'),
(50, 'ICT', 'Google account', 'actived', 'halolaos.156@gmail.com', '1NrBQxjO', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(51, 'ICT', 'Google account', 'actived', 'halolaos.157@gmail.com', 'b6HSWyrF', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(52, 'ICT', 'Google account', 'actived', 'halolaos.158@gmail.com', 'qbDZpPg6', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(53, 'ICT', 'Google account', 'actived', 'halolaos.159@gmail.com', 'GJPhuGC7', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(54, 'ICT', 'Google account', 'actived', 'halolaos.160@gmail.com', 'YP0Vh6Ey', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(55, 'ICT', 'Google account', 'actived', 'halolaos.161@gmail.com', 'X5OFXlRn', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(56, 'ICT', 'Google account', 'actived', 'halolaos.162@gmail.com', 'U7CKCFEl', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(57, 'ICT', 'Google account', 'actived', 'halolaos.163@gmail.com', 'ehsJnvYB', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(58, 'ICT', 'Google account', 'actived', 'halolaos.165@gmail.com', 'ecIJAIp7', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(59, 'ICT', 'Google account', 'actived', 'halolaos.166@gmail.com', 'QJDfYit9', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(60, 'ICT', 'Google account', 'actived', 'halolaos.167@gmail.com', 'Q9i1zuzX', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(61, 'ICT', 'Google account', 'actived', 'halolaos.04@gmail.com', 'GIS@123%04', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093542106', '2026-04-07 07:59:15'),
(62, 'ICT', 'Google account', 'actived', 'halolaos.168@gmail.com', 'sOwID8J4', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(63, 'ICT', 'Google account', 'actived', 'halolaos.169@gmail.com', 'woXqdyPD', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(64, 'ICT', 'Google account', 'actived', 'halolaos.170@gmail.com', '5bALoYDW', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2091025919', '2026-04-07 07:59:15'),
(65, 'ICT', 'Google account', 'actived', 'halolaos.09@gmail.com', 'GIS@123%09', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096023105', '2026-04-07 07:59:15'),
(66, 'ICT', 'Google account', 'actived', 'halolaos.173@gmail.com', 'LJ28gCSC', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2097524350', '2026-04-07 07:59:15'),
(67, 'ICT', 'Google account', 'actived', 'halolaos.174@gmail.com', 'XB5LZgX3', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093233247', '2026-04-07 07:59:15'),
(68, 'ICT', 'Google account', 'actived', 'halolaos.175@gmail.com', 'FwMPZRkW', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2095126019', '2026-04-07 07:59:15'),
(69, 'ICT', 'Google account', 'actived', 'halolaos.176@gmail.com', 'H2GKVOAD', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(70, 'ICT', 'Google account', 'actived', 'halolaos.177@gmail.com', 'FfJukLv0', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(71, 'ICT', 'Google account', 'actived', 'halolaos.178@gmail.com', '7T4Wvzdo', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(72, 'ICT', 'Google account', 'actived', 'halolaos.180@gmail.com', 'bR73TPSF', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(73, 'ICT', 'Google account', 'actived', 'halolaos.181@gmail.com', 'XXaKqn0Q', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(74, 'ICT', 'Google account', 'actived', 'halolaos.183@gmail.com', 'Bra3VnPS', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(75, 'ICT', 'Google account', 'actived', 'halolaos.184@gmail.com', 'VjzOYZ9P', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098103564', '2026-04-07 07:59:15'),
(76, 'ICT', 'Google account', 'actived', 'halolaos.185@gmail.com', 'COQYFaLF', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(77, 'ICT', 'Google account', 'actived', 'halolaos.187@gmail.com', '6sUiV8K9', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(78, 'ICT', 'Google account', 'actived', 'halolaos.188@gmail.com', '2jZYEUGc', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(79, 'ICT', 'Google account', 'actived', 'halolaos.189@gmail.com', 'nFI4tyDw', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(80, 'ICT', 'Google account', 'actived', 'halolaos.190@gmail.com', 'biGWc1Gd', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(81, 'ICT', 'Google account', 'actived', 'halolaos.191@gmail.com', 'nl8c2Akn', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(82, 'ICT', 'Google account', 'actived', 'halolaos.192@gmail.com', 'BQ9kBEaF', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(83, 'ICT', 'Google account', 'actived', 'halolaos.193@gmail.com', '1N6XtQrj', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(84, 'ICT', 'Google account', 'actived', 'halolaos.196@gmail.com', 'haNR0yqq', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(85, 'ICT', 'Google account', 'actived', 'halolaos.197@gmail.com', 'X4HmzkuU', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(86, 'ICT', 'Google account', 'actived', 'halolaos.198@gmail.com', 'jfZa9prA', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(87, 'ICT', 'Google account', 'actived', 'halolaos.199@gmail.com', 'kDrzF2m4', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(88, 'ICT', 'Google account', 'actived', 'halolaos.200@gmail.com', 'amy43rv9', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096757442', '2026-04-07 07:59:15'),
(89, 'ICT', 'Google account', 'actived', 'halolaos.201@gmail.com', 'ZR5EKbLy', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(90, 'ICT', 'Google account', 'actived', 'halolaos.02@gmail.com', 'GIS@123%02', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(91, 'ICT', 'Google account', 'actived', 'halolaos.202@gmail.com', 'x07j70oV', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(92, 'ICT', 'Google account', 'actived', 'halolaos.203@gmail.com', 'uZzUCW6V', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(93, 'ICT', 'Google account', 'actived', 'halolaos.204@gmail.com', 'BN3iAYuQ', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(94, 'ICT', 'Google account', 'actived', 'halolaos.205@gmail.com', '0oKYMwSy', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2099881320', '2026-04-07 07:59:15'),
(95, 'ICT', 'Google account', 'actived', 'halolaos.206@gmail.com', 'DXM9rZ1N', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(96, 'ICT', 'Google account', 'actived', 'halolaos.01@gmail.com', 'GIS@123%', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(97, 'ICT', 'Google account', 'actived', 'halolaos.06@gmail.com', 'GIS@123%06', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092735428', '2026-04-07 07:59:15'),
(98, 'ICT', 'Google account', 'actived', 'halolaos.208@gmail.com', 'c2kPSD7I', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(99, 'ICT', 'Google account', 'actived', 'halolaos.209@gmail.com', 'uoSqOZva', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(100, 'ICT', 'Google account', 'actived', 'halolaos.210@gmail.com', 'bTqswdTD', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(101, 'ICT', 'Google account', 'actived', 'halolaos.211@gmail.com', 'G2NqKepg', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(102, 'ICT', 'Google account', 'actived', 'halolaos.212@gmail.com', '2US8PtM2', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(103, 'ICT', 'Google account', 'actived', 'halolaos.213@gmail.com', 'wN5oyrTJ', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(104, 'ICT', 'Google account', 'actived', 'halolaos.214@gmail.com', '3oMxVlKs', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(105, 'ICT', 'Google account', 'actived', 'halolaos.215@gmail.com', '7pAZ6Pq2', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(106, 'ICT', 'Google account', 'actived', 'halolaos.216@gmail.com', 'gFDvdwtG', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(107, 'ICT', 'Google account', 'actived', 'halo.laos.ts.e@gmail.com', 'LvFiY6Wg', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(108, 'ICT', 'Google account', 'actived', 'halolaos.218@gmail.com', 'cmvYAxxV', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(109, 'ICT', 'Google account', 'actived', 'halolaos.219@gmail.com', 'KQ8zEi8v', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093164767', '2026-04-07 07:59:15'),
(110, 'ICT', 'Google account', 'actived', 'halolaos.220@gmail.com', 'gYk8zsrU', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(111, 'ICT', 'Google account', 'actived', 'halolaos.221@gmail.com', '2wHHwy2U', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096767714', '2026-04-07 07:59:15'),
(112, 'ICT', 'Google account', 'actived', 'halolaos.223@gmail.com', 'wCR3eUWl', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092652135', '2026-04-07 07:59:15'),
(113, 'ICT', 'Google account', 'actived', 'halolaos.224@gmail.com', '3UadjQMo', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098458990', '2026-04-07 07:59:15'),
(114, 'ICT', 'Google account', 'actived', 'halolaos.0225@gmail.com', '31puPl9M', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092053480', '2026-04-07 07:59:15'),
(115, 'ICT', 'Google account', 'actived', 'halolaos.226@gmail.com', 'vFTPam9l', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092728047', '2026-04-07 07:59:15'),
(116, 'ICT', 'Google account', 'actived', 'halolaos.227@gmail.com', 'uGkGwTRv', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092830273', '2026-04-07 07:59:15'),
(117, 'ICT', 'Google account', 'actived', 'halolaos.228@gmail.com', 'JArRa9c9', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093052415', '2026-04-07 07:59:15'),
(118, 'ICT', 'Google account', 'actived', 'halolaos.230@gmail.com', 'MhIcqwIL', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(119, 'ICT', 'Google account', 'actived', 'halolaos.233@gmail.com', '0AaJjNgr', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(120, 'ICT', 'Google account', 'actived', 'halolaos.234@gmail.com', 'z6EK0TgQ', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2091784896', '2026-04-07 07:59:15'),
(121, 'ICT', 'Google account', 'actived', 'halolaos.236@gmail.com', 'CykZdqJY', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096032619', '2026-04-07 07:59:15'),
(122, 'ICT', 'Google account', 'actived', 'halolaos.237@gmail.com', 'miZtO3Vi', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098361434', '2026-04-07 07:59:15'),
(123, 'ICT', 'Google account', 'actived', 'halolaos.238@gmail.com', 'OsTW6X80', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2091346360', '2026-04-07 07:59:15'),
(124, 'ICT', 'Google account', 'actived', 'halolaos.239@gmail.com', 'Xye1uSaY', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098715077', '2026-04-07 07:59:15'),
(125, 'ICT', 'Google account', 'actived', 'halolaos.240@gmail.com', 'o5en7UyF', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2091741885', '2026-04-07 07:59:15'),
(126, 'ICT', 'Google account', 'actived', 'halolaos.241@gmail.com', 'nz99EGiV', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093734522', '2026-04-07 07:59:15'),
(127, 'ICT', 'Google account', 'actived', 'halolaos.242@gmail.com', 'YP0Vh6Ey', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093185335', '2026-04-07 07:59:15'),
(128, 'ICT', 'Google account', 'actived', 'halo.laos.ts.n@gmail.com', 'sT75AwuL', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(129, 'ICT', 'Google account', 'actived', 'halolaos.247@gmail.com', 'Z95WEtJL', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(130, 'ICT', 'Google account', 'actived', 'halolaos.248@gmail.com', 'Z84wetjl', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(131, 'ICT', 'Google account', 'actived', 'halolaos.249@gmail.com', 'oGpJFRX4', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(132, 'ICT', 'Google account', 'actived', 'halo.laos.sv.4@gmail.com', 'halolaossv4', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(133, 'ICT', 'Google account', 'actived', 'halo.laos.ts.m@gmail.com', 'dqPbEr4u', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(134, 'ICT', 'Google account', 'actived', 'halolaos.252@gmail.com', 'Gs74RL7B', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(135, 'ICT', 'Google account', 'actived', 'halolaos.253@gmail.com', 'Gs94RL9B', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(136, 'ICT', 'Google account', 'actived', 'halolaos.254@gmail.com', 'Gs84RL8B', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(137, 'ICT', 'Google account', 'actived', 'halolaos.255@gmail.com', 'YPqllH29', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(138, 'ICT', 'Google account', 'actived', 'halo.laos.ts.d@gmail.com', 'PbmcQT8R', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(139, 'ICT', 'Google account', 'actived', 'halolaos.257@gmail.com', 'ST75AwuL', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(140, 'ICT', 'Google account', 'actived', 'halolaos.258@gmail.com', 'ST258AwuA', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(141, 'ICT', 'Google account', 'actived', 'halolaos.259@gmail.com', 'ST75Awu%', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(142, 'ICT', 'Google account', 'actived', 'halolaos.78@gmail.com', 'r9qGidXz', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2091841803', '2026-04-07 07:59:15'),
(143, 'ICT', 'Google account', 'actived', 'halolaos.03@gmail.com', 'GIS@123%03', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093542106', '2026-04-07 07:59:15'),
(144, 'ICT', 'Google account', 'actived', 'halolaos.80@gmail.com', 'uf56y49s', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2097193834', '2026-04-07 07:59:15'),
(145, 'ICT', 'Google account', 'actived', 'halolaos.080@gmail.com', 'KH5d0qXj', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2097193834', '2026-04-07 07:59:15'),
(146, 'ICT', 'Google account', 'actived', 'halolaos.081@gmail.com', 'sFCAiPKc', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2095404901', '2026-04-07 07:59:15'),
(147, 'ICT', 'Google account', 'actived', 'halolaos.083@gmail.com', 'ngtMfRRv', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098849306', '2026-04-07 07:59:15'),
(148, 'ICT', 'Google account', 'actived', 'halolaos.090@gmail.com', 'TRLZv5kt', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2094230448', '2026-04-07 07:59:15'),
(149, 'ICT', 'Google account', 'actived', 'halolaos.092@gmail.com', '3ib0Hgvj', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098849670', '2026-04-07 07:59:15'),
(150, 'ICT', 'Google account', 'actived', 'halolaos.094@gmail.com', 'Z2xFBXvc', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2098752371', '2026-04-07 07:59:15'),
(151, 'ICT', 'Google account', 'actived', 'halolaos.095@gmail.com', 'Ia7PGOai', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093721481', '2026-04-07 07:59:15'),
(152, 'ICT', 'Google account', 'actived', 'halolaos.96@gmail.com', 'eP5DGG4J', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2095645564', '2026-04-07 07:59:15'),
(153, 'ICT', 'Google account', 'actived', 'halolaos.096@gmail.com', 'ucB3B0et', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(154, 'ICT', 'Google account', 'actived', 'halolaos.99@gmail.com', 'kZaXZ2Cc', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(155, 'ICT', 'Google account', 'actived', 'halolaos.010@gmail.com', 'Z84wetj10', '', '', 'Finance', '', '', '', NULL, '', '2026-04-07 07:59:15'),
(156, 'ICT', 'Google account', 'actived', 'halo.laos.ts.f@gmail.com', 'ZAdJ9hAn', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(157, 'ICT', 'Google account', 'actived', 'halolaosda212@gmail.com', 'Da&2_5542', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092388083', '2026-04-07 07:59:15'),
(158, 'ICT', 'Google account', 'actived', 'halolaos.075@gmail.com', 'ST75Awul', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(159, 'ICT', 'Google account', 'actived', 'halolaos.260@gmail.com', '3oMxViKs', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(160, 'ICT', 'Google account', 'actived', 'halolaos256@gmail.com', 'PbmcQT8R', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(161, 'ICT', 'Google account', 'actived', 'halolaostab261@gmail.com', 'Ri8HGl7Q', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(162, 'ICT', 'Google account', 'actived', 'halolaos262@gmail.com', 'eW15kQI7', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(163, 'ICT', 'Google account', 'actived', 'halolaos263@gmail.com', 'GJ1oRzWv', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(164, 'ICT', 'Google account', 'actived', 'halolaos264@gmail.com', 'lN2RIt44', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(165, 'ICT', 'Google account', 'actived', 'halolaos265@gmail.com', 'CWOYJ6Ah', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(166, 'ICT', 'Google account', 'actived', 'halolaos273@gmail.com', 'ypBg7JtK', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(167, 'ICT', 'Google account', 'actived', 'halolaos266@gmail.com', 'FkFmMoAl', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(168, 'ICT', 'Google account', 'actived', 'halolaos272@gmail.com', '7ATAXpU7', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(169, 'ICT', 'Google account', 'actived', 'halolaos267@gmail.com', 'RYeeoZgM', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(170, 'ICT', 'Google account', 'actived', 'halolaos268@gmail.com', 'RwPmkawe', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(171, 'ICT', 'Google account', 'actived', 'halolaos275@gmail.com', '2T5h3nrU', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(172, 'ICT', 'Google account', 'actived', 'halolaos269@gmail.com', 'nK8QIjLH', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(173, 'ICT', 'Google account', 'actived', 'halolaos270@gmail.com', 'fL7EYP2G', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(174, 'ICT', 'Google account', 'actived', 'halolaos.074@gmail.com', 'ST75AwuL', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(175, 'ICT', 'Google account', 'actived', 'halolaos274@gmail.com', 'JgA3e3IY', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(176, 'ICT', 'Google account', 'actived', 'halolaos279@gmail.com', 'JgA3e3IK', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(177, 'ICT', 'Google account', 'actived', 'halolaos278@gmail.com', 'Jga3e3Ik', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(178, 'ICT', 'Google account', 'actived', 'halolaos289@gmail.com', 'JQA3e3Ik', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(179, 'ICT', 'Google account', 'actived', 'halolaos290@gmail.com', 'JqA3e3LK', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096483798', '2026-04-07 07:59:15'),
(180, 'ICT', 'Google account', 'actived', 'halolaos281@gmail.com', 'JQa3e3Lk', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(181, 'ICT', 'Google account', 'actived', 'halolaos277@gmail.com', 'JQa3e3Lk', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(182, 'ICT', 'Google account', 'actived', 'halotlp016@gmail.com', 'JQa3e3TLP', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(183, 'ICT', 'Google account', 'actived', 'halolaos.017@gmail.com', 'JQa3e3Tlp', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(184, 'ICT', 'Google account', 'actived', 'halolaos.288@gmail.com', 'JArRa9c9', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(185, 'ICT', 'Google account', 'actived', 'halolaos.287@gmail.com', 'JQa3e3TlQ', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(186, 'ICT', 'Google account', 'actived', 'halolaos.286@gmail.com', 'JQa3e3TlA', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(187, 'ICT', 'Google account', 'actived', 'halolaos.285@gmail.com', 'JQa3e3tia', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(188, 'ICT', 'Google account', 'actived', 'halolaos.293@gmail.com', 'JQa3e3tiK', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(189, 'ICT', 'Google account', 'actived', 'halolaos.292@gmail.com', 'JQa3e3t86', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(190, 'ICT', 'Google account', 'actived', 'halolaos.291@gmail.com', 'JQa3e3t03', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(191, 'ICT', 'Google account', 'actived', 'halolaos.0266@gmail.com', 'JQa3e3t04', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(192, 'ICT', 'Google account', 'actived', 'halolaos.284@gmail.com', 'JQa3e3t05', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(193, 'ICT', 'Google account', 'actived', 'halolaos.282@gmail.com', 'JQa3e3t06', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(194, 'ICT', 'Google account', 'actived', 'halolaos.379@gmail.com', 'JQa3at379', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(195, 'ICT', 'Google account', 'actived', 'halolaos271@gmail.com', 'M5JbiFZA', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(196, 'ICT', 'Google account', 'actived', 'halo.laos.gis.a@gmail.com', 'GIS_ICT!2024', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:15'),
(197, 'ICT', 'Google account', 'actived', 'halolaosda27@gmail.com', 'Da&2_8935', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '309714588', '2026-04-07 07:59:15'),
(198, 'ICT', 'Google account', 'actived', 'halolaosda28@gmail.com', 'Da&2_1663', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '309714588', '2026-04-07 07:59:15'),
(199, 'ICT', 'Google account', 'actived', 'halolaosda29@gmail.com', 'Da&2_5994', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093124478', '2026-04-07 07:59:15'),
(200, 'ICT', 'Google account', 'actived', 'halolaosda210@gmail.com', 'Da&2_4623', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093233247', '2026-04-07 07:59:15'),
(201, 'ICT', 'Google account', 'actived', 'halolaosda211@gmail.com', 'Da&2_2996', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093233247', '2026-04-07 07:59:15'),
(202, 'ICT', 'Google account', 'actived', 'halolaosda213@gmail.com', 'Da&2_5778', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093672978', '2026-04-07 07:59:16'),
(203, 'ICT', 'Google account', 'actived', 'halolaosda214@gmail.com', 'Da&2_7829', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2097668541', '2026-04-07 07:59:16'),
(204, 'ICT', 'Google account', 'actived', 'halolaosda215@gmail.com', 'Da&2_8100', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2096023105', '2026-04-07 07:59:16'),
(205, 'ICT', 'Google account', 'actived', 'halolaos.031@gmail.com', 'TAP_031@2026', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(206, 'ICT', 'Google account', 'actived', 'halolaos.375@gmail.com', 'QJa3e3t07', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(207, 'ICT', 'Google account', 'actived', 'halolaos.340@gmail.com', 'Jq33tb1151', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(208, 'ICT', 'Google account', 'actived', 'halolaos.341@gmail.com', 'JQa33tbJ', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(209, 'ICT', 'Google account', 'actived', 'halolaos.337@gmail.com', 'JQa33tbk', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(210, 'ICT', 'Google account', 'actived', 'halolaos.306@gmail.com', 'JQa33tbH', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(211, 'ICT', 'Google account', 'actived', 'halolaostab324@gmail.com', 'Hlolaos25', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(212, 'ICT', 'Google account', 'actived', 'halolaos.311@gmail.com', 'Kka3e3t11', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(213, 'ICT', 'Google account', 'actived', 'halolaostab225@gmail.com', 'Halo@225', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(214, 'ICT', 'Google account', 'actived', 'halolaosda21@gmail.com', 'Da&2_1424', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2093542106', '2026-04-07 07:59:16'),
(215, 'ICT', 'Google account', 'actived', 'halolaosda22@gmail.com', 'Da&2_5651', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '309494877', '2026-04-07 07:59:16'),
(216, 'ICT', 'Google account', 'actived', 'halolaosda23@gmail.com', 'Da&2_4562', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092735428', '2026-04-07 07:59:16'),
(217, 'ICT', 'Google account', 'actived', 'halolaosda24@gmail.com', 'Da&2_3511', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '304970127', '2026-04-07 07:59:16'),
(218, 'ICT', 'Google account', 'actived', 'halolaosda25@gmail.com', 'Da&2_5585', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '309494877', '2026-04-07 07:59:16'),
(219, 'ICT', 'Google account', 'actived', 'halolaosda26@gmail.com', 'Da&2_8574', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '304970127', '2026-04-07 07:59:16'),
(220, 'Medical', 'Google account', 'actived', 'gislaos10@gmail.com', 'Halo@2025', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '2092824265', '2026-04-07 07:59:16'),
(221, 'Monekham', 'Google account', 'actived', 'halolaos362@gmail.com', 'JQa33tbJ', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(222, 'Tab38', 'Google account', 'actived', 'halolaos261@gmail.com', 'Da2_tb38', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(223, 'ICT', 'Google account', 'actived', 'halo.laos.ts.b@gmail.com', 'In0jdrTP', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(224, 'ICT', 'Google account', 'actived', 'halo.laos.mre1@gmail.com', 'halolaosmre1', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(225, 'ICT', 'Google account', 'actived', 'halo.laos.ts.t@gmail.com', 'halolaost', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(226, 'ICT', 'Google account', 'actived', 'halo.laos.sv.1@gmail.com', 'halolaossv1', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(227, 'ICT', 'Google account', 'actived', 'halo.laos.sv.2@gmail.com', 'halolaossv2', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16'),
(228, 'ICT', 'Google account', 'actived', 'halo.laos.ts.a@gmail.com', '4R7GE3pv', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, '', '2026-04-07 07:59:16');

-- --------------------------------------------------------

--
-- Table structure for table `ict_devices`
--

CREATE TABLE `ict_devices` (
  `id` int(11) NOT NULL,
  `device_type` varchar(100) DEFAULT NULL,
  `halo_id` varchar(50) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(100) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(255) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(100) DEFAULT NULL,
  `gmail_address` varchar(255) DEFAULT NULL,
  `gmail_pass` varchar(100) DEFAULT NULL,
  `dgps_mail` varchar(255) DEFAULT NULL,
  `dgps_pass` varchar(100) DEFAULT NULL,
  `bitlocker_pass` varchar(100) DEFAULT NULL,
  `bitlocker_id` varchar(150) DEFAULT NULL,
  `bitlocker_key` text DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ict_devices`
--

INSERT INTO `ict_devices` (`id`, `device_type`, `halo_id`, `brand`, `model`, `serial_number`, `date_in`, `date_out`, `username`, `department`, `team`, `location_local`, `ins_number`, `status`, `sv123_user`, `sv123_pass`, `gmail_address`, `gmail_pass`, `dgps_mail`, `dgps_pass`, `bitlocker_pass`, `bitlocker_id`, `bitlocker_key`, `remark`, `created_at`) VALUES
(13, 'Phone', 'TLP-001', 'Samsung', 'S0001', '11', '2026-03-20', NULL, 'GIS', 'Finance', 'ICT', 'Xepon', 'INS-1540', 'Active', '', '', '', '', '', '', '', '', '', 'new', '2026-03-20 13:54:40');

-- --------------------------------------------------------

--
-- Table structure for table `internet_records`
--

CREATE TABLE `internet_records` (
  `id` int(11) NOT NULL,
  `internet_local` varchar(255) DEFAULT '',
  `internet_type` varchar(100) DEFAULT '',
  `package` varchar(255) DEFAULT '',
  `price` decimal(12,2) DEFAULT 0.00,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `document_local` varchar(255) DEFAULT '',
  `document_link` varchar(500) DEFAULT '',
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `internet_records`
--

INSERT INTO `internet_records` (`id`, `internet_local`, `internet_type`, `package`, `price`, `start_date`, `end_date`, `document_local`, `document_link`, `remark`, `created_at`) VALUES
(2, 'Xepon', 'Other', '250M', 186000000.00, '2026-04-03', '2026-07-31', '41fl2100052.pdf', 'uploads/internet/1775175301_41fl2100052.pdf', '', '2026-04-03 00:30:40');

-- --------------------------------------------------------

--
-- Table structure for table `laptops`
--

CREATE TABLE `laptops` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'Laptop',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `laptops`
--

INSERT INTO `laptops` (`id`, `device_type`, `halo_id`, `brand`, `model`, `serial_number`, `date_in`, `date_out`, `month_used`, `year_used`, `username`, `department`, `team`, `location_local`, `ins_number`, `status`, `sv123_user`, `sv123_pass`, `gmail_address`, `gmail_pass`, `dgps_mail`, `dgps_pass`, `bitlocker_pass`, `bitlocker_id`, `bitlocker_key`, `remark`, `created_at`) VALUES
(317, 'Laptop', 'LPT-004\n\nLPT-064', 'SAMSUNG', 'NP470R5E', 'JE8J911D700842R', '2013-10-15', '2024-08-14', 10, 10, '', '', '', '', '', 'Write-off', '', '', '', '', '', '', '', '', '', '', '0000-00-00 00:00:00'),
(318, 'Laptop', 'LPT-004', 'HP', 'Pavilion G4W20PA#AKL', '5CD41109L1', '2014-05-03', '2024-08-14', 3, 10, '', 'Translator', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', 'LPT12345', '06D08F8D-7090-4B87-9923-CD37B0060CDB', '206921-234003-713834-642653-697862-653466-236797-604043', '', '0000-00-00 00:00:00'),
(319, 'Laptop', 'LPT-005', 'Lenovo', '80JT', 'R90FWD15', '2015-09-14', '2024-08-14', 11, 8, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', '', '', '', 'ເຄື່ອງຊ້າໃຊ້ງານບໍ່ໄດ້', '0000-00-00 00:00:00'),
(320, 'Laptop', 'LPT-006', 'Lenovo', '80JT', 'R90FWD43', '2015-09-14', '2024-08-14', 11, 8, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', '', '', '', '', '0000-00-00 00:00:00'),
(321, 'Laptop', 'LPT-007', 'Lenovo', '80RK', 'PF0LDXG2', '2016-10-03', '2024-08-14', 10, 7, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', 'ops12345', '', '', 'ເຄື່ອງຊ່າ', '0000-00-00 00:00:00'),
(322, 'Laptop', 'LPT-007i', 'Lenovo', 'G40-70 20369 ', 'YB06769526', '2015-11-20', '2024-08-14', 9, 8, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', '', '', '', '', '0000-00-00 00:00:00'),
(323, 'Laptop', 'LPT-008', 'Lenovo', '80RK', 'PF0LDRLE', '2016-10-03', '2024-08-14', 10, 7, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', 'ops111', '', '', '', '0000-00-00 00:00:00'),
(324, 'Laptop', 'LPT-009', 'Lenovo', '80RK', 'PF0LDRNB', '2016-10-03', '2025-03-15', 5, 8, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', '', '', '', '', '', '', 'LPT009', '737228D3-578E-4422-BDA3-4BBD7E0D796A', '242330-017556-228052-694760-021659-696542-008932-506726', 'ເຄືອງຊ້າຫຼາຍຕ້ອງການປຽນໃຫມ່,ປຽນຫັກດິດເປັນ SSD', '0000-00-00 00:00:00'),
(325, 'Laptop', 'LPT-010', 'Lenovo', '80RK', 'PF0LDW0B', '2016-10-03', '2024-08-14', 10, 7, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', 'lpt010', '9BA2A0C8-3F0D-4C94-91F6-0FC9846320A4', '076307-716122-235378-616594-445423-430672-375122-046167', 'ເຄື່ອງຊ້າໃຊ້ງານບໍ່ໄດ້', '0000-00-00 00:00:00'),
(326, 'Laptop', 'LPT-011', 'Lenovo', '80RK', 'PF0LDW3V', '2016-10-03', '2024-08-14', 10, 7, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', 'ops12345', '767CAC7D-D559-4DD0-8B8F-492EB51CF407', '527263-188375-130097-541596-616979-119251-229944-424963', 'using Chrome OS', '0000-00-00 00:00:00'),
(327, 'Laptop', 'LPT-012', 'Lenovo', 'Ideapad 110-14ISK', 'MP19ALK9', '2017-08-16', '0000-00-00', 8, 8, '', '', '', 'Sepon ', '', 'Write-off', '', '', '', '', '', '', 'lpt012', '7A02E415-B42E-4E0F-978D-C2053BAC2509', '313863-288926-486574-519376-166463-655644-628694-307428', 'transfer to Ai Lakonekham\'s team on 01-7-23', '0000-00-00 00:00:00'),
(328, 'Laptop', 'LPT-013', 'HP', 'HP EliteBook 840 G3', '5CG7322W99', '2017-10-05', '0000-00-00', 6, 8, 'Vanida Nanthasan', 'Translator', 'Translator', 'Sepon ', '', 'Working', '', '', '', '', '', '', 'lpt-013', '0D8352FE-CCEE-4518-908D-6B5A1F90C7F2', '192313-460504-394207-409750-092367-445984-288233-428846', 'ປຽນຫັດດິດໃໝ່ ແລະ ແບັກເຕຣີ\n22.01.2024, Write-off on 17/3/25', '0000-00-00 00:00:00'),
(329, 'Laptop', 'LPT-015', 'HP', 'HP EliteBook 840 G3', '5CG7322VP1', '2017-10-05', '0000-00-00', 6, 8, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', '', '', '', '', '', '', 'lpt-015', '25F02184-E677-4050-818A-D8B0169CEAF9', '009801-037532-327228-151250-254694-458007-641652-076285435997', '', '0000-00-00 00:00:00'),
(330, 'Laptop', 'LPT-016', 'HP', 'HP EliteBook 840 G3', '5CG7322VNV', '2017-10-05', '0000-00-00', 6, 8, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', 'laos_fleet1', '', '', '', '', '', 'lpt016', '46BA83DF-DA44-4340-9114-BE6D8D636547', '143143-513623-572572-059587-237281-354750-177419-608740', '108405-163449-260095-449658-612788-144826-598862-220154', '0000-00-00 00:00:00'),
(331, 'Laptop', 'LPT-017', 'Acer', 'Acer Aspire T005', 'NXGT1ST005805058813400', '2018-06-10', '0000-00-00', 10, 7, 'Lay KETHSAVAN', 'Ops', 'EORE 1', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt017', '963B45FC-0742-4070-AB5B-8376480E5F60', '085228-497662-558657-692967-199595-298562-571043-548163', '', '0000-00-00 00:00:00'),
(332, 'Laptop', 'LPT-018', 'Acer', 'Acer Aspire T005', 'NXGT1ST005805062523400', '2018-06-10', '0000-00-00', 10, 7, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', 'laos_operationcoordinator1', '', '', '', '', '', 'ops12345', '1DB5FBFB-B978-48BF-8BDD-5CC17A394176', '278696-109857-046893-456610-638110-221782-522841-699853', 'ປຽນ SSD ໃຫມ່', '0000-00-00 00:00:00'),
(333, 'Laptop', 'LPT-019', 'Acer', 'Acer Aspire T005', 'NXGT1ST005800505EAF3400', '2018-06-10', '0000-00-00', 10, 7, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', '', '', '', '', '', '', 'LPT019', '30D6405A-9288-40CA-AA0B-F931E16DE185', '507485-448800-392491-412951-179212-302115-113190-470701', 'ປຽນ SSD ໃສ່', '0000-00-00 00:00:00'),
(334, 'Laptop', 'LPT-020', 'HP', 'HP EliteBook 840 G5', '5CG8303WLJ', '2018-08-17', '2023-08-03', 1900, 5, 'Viphakone VILATHAM', 'Medical', 'Medical', 'Sepon', '', 'Working', 'laos_medical3', '', '', '', '', '', 'lpt020', '31B9D39B-95B2-41B9-B746-590A0FF2E2CE', '187792-152262-084546-570020-492459-181346-655479-023276', '', '0000-00-00 00:00:00'),
(335, 'Laptop', 'LPT-021', 'HP', 'HP EliteBook 840 G5', '5CG8303WM5', '2018-08-17', '0000-00-00', 8, 7, 'Phantha KIKHOUNKHAM', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor20', '', '', '', '', '', 'ops12345', 'C2462669-44B5-4BC3-A854-B1D1F7304AD6', '267608-255453-108636-543422-368445-099594-402369-220077', '', '0000-00-00 00:00:00'),
(336, 'Laptop', 'LPT-025', 'HP', 'HP EliteBook 840 G5', '5CG9190T7P', '2019-05-24', '0000-00-00', 11, 6, 'Amphaiphone LITTHIKOUMMAN', 'Ops', 'S1', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt025', 'E3FFAA4F-263D-4057-B05A-998B272831FE', '199661-179025-592493-329153-002860-437602-079629-258170', '', '0000-00-00 00:00:00'),
(337, 'Laptop', 'LPT-026', 'HP', 'HP EliteBook 840 G3', '5CG72650N3', '2019-09-19', '0000-00-00', 7, 6, 'Viengvilay VONGKHAMMOUTY', 'Admin', 'VTE', 'Vientiane', '', 'Working', '', '', '', '', '', '', '', '', '', '', '0000-00-00 00:00:00'),
(338, 'Laptop', 'LPT-027', 'HP', 'HP EliteBook 850 G5', '5CG9261KKQ', '2019-11-04', '2023-01-15', 2, 3, 'Thay', 'Medical', 'Medical', 'Sepon', '', 'Working', '', '', '', '', '', '', 'LPT027', '8DDC723D-F0B6-4F76-BD82-80447C27E233', '436755-684332-414964-143847-083490-388003-689788-069135', '', '0000-00-00 00:00:00'),
(339, 'Laptop', 'LPT-028', 'HP', 'HP EliteBook 840 G5', '5CG847842M', '2019-11-04', '0000-00-00', 5, 6, 'Khamphone  THONEMA', 'GIS', 'GIS', 'Sepon', '', 'Working', 'laos_gis5', '', '', '', '', '', 'ict123', '4F2FB1CC-4E6F-4CB6-B226-EBA235FEFFA3', '043131-717508-253704-680471-611105-007711-436172-423060', '', '0000-00-00 00:00:00'),
(340, 'Laptop', 'LPT-029', 'HP', 'HP EliteBook 840 G5', '5CG847841T', '2019-11-04', '0000-00-00', 5, 6, 'Keidtisak VORASOUKKHA', 'Logistic', 'Logistic', 'Sepon', '', 'Working', 'laos_logistic6', '', '', '', '', '', 'gis12345', 'EC9139D2-3C14-44A6-B261-D1561C110E6C', '027049-012947-154462-110660-269951-354959-639870-126500', '', '0000-00-00 00:00:00'),
(341, 'Laptop', 'LPT-030', 'HP', 'HP EliteBook 840 G5', '5CG92760w1', '2019-11-04', '0000-00-00', 5, 6, 'Khammy KHAMVANVONGSA', 'Electric', 'Electrician', 'Sepon', '', 'Working', 'laos_electrician1', '', '', '', '', '', 'lpt030', '318112DE-54FF-45BD-A013-B982BE5F3DD9', '560626-394867-624756-398552-496342-080751-168476-482625', 'change mainboard 22-1-2025', '0000-00-00 00:00:00'),
(342, 'Laptop', 'LPT-031', 'HP', 'HP EliteBook 840 G5', '5CG847843Q', '2019-11-04', '0000-00-00', 5, 6, 'Sykhoun  KONGTHILATH', 'OPS', 'O1', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt031', '', '', '', '0000-00-00 00:00:00'),
(343, 'Laptop', 'LPT-032', 'HP', 'HP EliteBook 840 G5', '5CG8478B2K', '2019-11-04', '0000-00-00', 5, 6, 'Phiphavanh XAYAVONG', 'CORE', 'EORE', 'Sepon', '', 'Working', 'laos_eore1', '', '', '', '', '', 'LPT032', 'A93496FD-7E62-4EBB-924F-4F34F7454B0F', '637560-289223-529672-355212-269390-067287-359007-642972', 'Transfer from Mr. Phonepasith on 11-9-2023', '0000-00-00 00:00:00'),
(344, 'Laptop', 'LPT-085', 'Lenovo', 'IdeaPad Slim 5 16IMH9 (83DC0098TA)', 'MP2YS2DR', '2025-08-19', '0000-00-00', 8, 1900, 'Wut Hmon', 'Finance', 'FN manaer', 'Sepon', '', 'Working', '', '', '', '', '', '', 'LPT085', '8D76AD6D-7EF1-4608-B6E7-B445CC0BBDB6', '247907-487718-621104-386210-196317-509421-381326-191235', '', '0000-00-00 00:00:00'),
(345, 'Laptop', 'LPT-084', 'Lenovo', 'IdeaPad Slim 5 16AKP10', 'YX0FDNSQ', '2025-08-19', '0000-00-00', 8, 1900, 'Khouayue  KATEEYUE', 'GIS', 'GIS', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt-084', '911EBB93-D6D6-4C7A-B68E-C1830DD3A785', '121176-639419-075130-178717-649792-019635-286220-567182', '', '0000-00-00 00:00:00'),
(346, 'Laptop', 'LPT-086', 'HP', 'HP Pavilion Aero 13-bg0056AU', 'CND4372PW9', '2025-08-20', '0000-00-00', 8, 1900, 'Phet KHENTHILA', 'Fleet', 'Fleet', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt086', '6F9C3E87-3FC0-4104-8FC0-8AEE590C2A89', '294393-709445-112464-143748-165616-124894-012353-070873', '', '0000-00-00 00:00:00'),
(347, 'Laptop', 'LPT-087', 'HP', 'HP Pavilion Aero 13-bg0056AU', 'CND4372PW6', '2025-08-20', '0000-00-00', 8, 1900, 'Punya  PHOMMIXAY', 'Logistic', 'Logistic', 'Sepon', '', 'Working', 'laos_logistic5', '', '', '', '', '', 'LPT087', '9DE64DB7-F2FC-4B52-84C3-623FD5D3E7CB', '035354-112046-348865-668503-635448-102047-248193-310178', '', '0000-00-00 00:00:00'),
(348, 'Laptop', 'LPT-090', 'LENOVO', 'IdeaPad Slim5 14IMH9', 'MP2Z04L8', '2025-09-03', '0000-00-00', 7, 1900, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', 'laos_translator3', '', '', '', '', '', 'LPT090', '5543F4D3-2FA5-40FB-9DA1-C054F2BAB42F', '185394-096327-171567-578721-123464-346544-240119-492217', '', '0000-00-00 00:00:00'),
(349, 'Laptop', 'LPT-091', 'LENOVO', 'IdeaPad Slim5 16IMH9', 'MP2YS4NC', '2025-09-03', '0000-00-00', 7, 1900, 'Nilandone PHOMLOUANGSY', 'Finance', 'Finance', 'Sepon', '', 'Working', 'laos_finance1', '', '', '', '', '', 'lpt-091', 'FCF84602-05F9-4851-BF45-E41AFD90A326', '497849-668305-172601-536283-284229-360217-551958-220627', '', '0000-00-00 00:00:00'),
(350, 'Laptop', 'LPT-093', 'LENOVO', 'IdeaPad Slim5 14IMH9', 'MP2YZJ6T', '2025-09-03', '0000-00-00', 7, 1900, 'khamlar.xayyakoumman', 'Translator', 'Translator', 'Sepon', '', 'Working', 'laos_translator2', '', '', '', '', '', 'LPT093', '56D46288-2E4F-452A-BE4E-F42606B45B0D', '429407-662277-700172-022671-116127-178420-539363-568876', '', '0000-00-00 00:00:00'),
(351, 'Laptop', 'LPT-095', 'LENOVO', 'IdeaPad Slim5 14IMH9', 'MP2YZJ42', '2025-09-03', '0000-00-00', 7, 1900, 'Phoutmany  INSYXIENGMAY', 'Vientiane', 'VTE', 'Vientiane', '', 'Working', '', '', '', '', '', '', 'LPT095', '10F45E10-C9D8-4A62-8994-4831BBE91DCF', '312059-257829-673871-096470-370887-689557-202862-467918', '', '0000-00-00 00:00:00'),
(352, 'Laptop', 'LPT-096', 'LENOVO', 'IdeaPad Slim5 14IMH9', 'MP2YZFSN', '2025-09-03', '0000-00-00', 7, 1900, 'Chanlone UONGBOUNCHAN', 'Translator', 'Translator', 'Sepon', '', 'Working', 'laos_translator3', '', '', '', '', '', 'lpt-096', 'CA7A5484-DA9E-48A2-A6A5-79266F190823', '368049-401566-708213-102608-216612-421740-188573-394438', '', '0000-00-00 00:00:00'),
(353, 'Laptop', 'LPT-088', 'ASUS', 'M1607K', 'T5N0KD007804215', '2025-09-03', '0000-00-00', 7, 1900, 'Phutthasit SENPASERD', 'OPS', 'O1', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt-088', '2532534C-A07B-4A68-921E-0923E1988E16', '530519-206701-260436-628045-187440-316206-307417-416900', '', '0000-00-00 00:00:00'),
(354, 'Laptop', 'LPT-089', 'ASUS', 'M1607K', 'T5N0KD00D220208', '2025-09-03', '0000-00-00', 7, 1900, 'Sathaphone KHENVANPHENG', 'Translator', 'Translator', 'Sepon', '', 'Working', '', '', '', '', '', '', 'LPT089', '496FC918-2642-48B3-85BC-AEABFF240209', '286297-330803-617573-633831-688578-371932-367147-152405', '', '0000-00-00 00:00:00'),
(355, 'Laptop', 'LPT-092', 'Lenovo', 'IdeaPad Slim 16MH9', 'MP2YT0HC', '2025-09-03', '0000-00-00', 7, 1900, 'Daniel Kuchalski', 'Fleet', 'Fleet Manager', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt092', '21D175A0-004D-4D48-B257-EBBD3300F97B', '199221-676544-053449-490666-498366-112596-458656-539726', '', '0000-00-00 00:00:00'),
(356, 'Laptop', 'LPT-097', 'MSI', 'B2VMG-091TH', '9S715A352091ZS8000007', '2025-09-06', '0000-00-00', 7, 1900, 'Kaoxing SINGTHAVONG', 'GIS', 'GIS', 'Sepon', '', 'Working', '', '', '', '', '', '', '', 'E11FA3B8-2B1D-4DED-81E4-62DC84F7D965', 'E11FA3B8-2B1D-4DED-81E4-62DC84F7D965', '', '0000-00-00 00:00:00'),
(357, 'Laptop', 'LPT-094', 'LENOVO', 'IdeaPad Slim5 14IMH9', 'MP2YZJ4T', '2025-09-09', '0000-00-00', 7, 1900, 'Namfonh VORASANE', 'Translator', 'Translator', 'Sepon', '', 'Working', 'laos_translator1', '', '', '', '', '', 'LPT094', '17E4F82D-D936-48A7-A561-AA5ED2477A17', '515339-211046-237809-416273-571384-690745-647922-430540', '', '0000-00-00 00:00:00'),
(358, 'Laptop', 'LPT-098', 'Lenovo', 'IdeaPad Slim 5 16IAH10 (83ND000QTA)', 'YX0FG6ZF', '2025-12-25', '0000-00-00', 4, 1900, 'David Haddock', 'Expat', 'Expat', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt098', 'A768A038-7576-4995-BAF1-C6B5BF18B324', '490578-550847-438438-314435-707267-112992-533434-348623', '', '0000-00-00 00:00:00'),
(359, 'Laptop', 'LPT-099', 'DELL', 'HP EliteBook 840 G8', '5CG2086F3B', '2025-12-20', '0000-00-00', 4, 1900, 'Sisomphan PHIMTHISAN', 'Electric', 'Electrician', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt099', '4FE6CF4C-7207-4A6D-B1C1-A25659EFBDF1', '395373-447260-705419-064713-230252-313577-634392-587235', '', '0000-00-00 00:00:00'),
(360, 'Laptop', 'LPT-100', 'Lenovo', 'IdeaPad Slim 5 14IMH9', 'MP2Z0H7G', '2026-01-22', '0000-00-00', 3, 1900, 'Linna Sikhongthon', 'Translator', 'interpreter', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt-100', 'F7CE9177-BF02-4071-BD6A-65AD659CE1A5', '111782-014828-196812-700062-102608-229911-435094-329494', '', '0000-00-00 00:00:00'),
(361, 'Laptop', 'LPT-101', 'Lenovo', 'IdeaPad Slim 5 14IMH9', 'PM2Z04K4', '2026-01-22', '0000-00-00', 3, 1900, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', '', '', '', '', '', '', 'lpt101', 'FA3CD81F-8DCF-4E75-9D0B-BFE07542A638', '251361-703296-557931-304854-173283-430881-500313-162404', '', '0000-00-00 00:00:00'),
(362, 'Laptop', 'LPT-102', 'Lenavo', 'IdeaPad Slim 5 16IMH9 83DC0098TA', 'MP2YSVVX', '2026-01-25', '0000-00-00', 3, 1900, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', '', '', '', '', '', '', '', '', '', '', '0000-00-00 00:00:00'),
(363, 'Laptop', 'LPT-033', 'HP', 'HP EliteBook 840 G5', '5CG8478437', '2019-11-04', '0000-00-00', 5, 6, 'Keovongkot PHISITHXAY', 'Logistic', 'Logistic', 'Sepon', '', 'Working', 'laos_logistic4', '', '', '', '', '', 'log12345', '16487C5E-BF0A-420C-8149-D1DEEFBA2D14', '021219-190267-466499-098439-365046-614867-291302-678326', '', '0000-00-00 00:00:00'),
(364, 'Laptop', 'LPT-034', 'HP', 'HP EliteBook 840 G5', '5CG847844S', '2019-11-04', '0000-00-00', 5, 6, 'Phouvanh KETHTHASONE', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor13', '', '', '', '', '', 'ops12345', 'D0300093-6FC1-47AB-9F41-816CF758E698', '  121638-280775-003366-714021-633534-341066-545567-280775', '', '0000-00-00 00:00:00'),
(365, 'Laptop', 'LPT-035', 'HP', 'HP EliteBook 840 G5', '5CG8478424', '2019-11-04', '0000-00-00', 5, 6, 'Boualin Vongdata', 'Medical', 'Medical', 'Sepon', '', 'Working', 'laos_medical2', '', '', '', '', '', '', 'BFD658BA-E897-4BDD-A91B-2F6BA973CD86', '068849-168531-272690-442497-229372-055561-146630-004004', 'Transfrer from', '0000-00-00 00:00:00'),
(366, 'Laptop', 'LPT-036', 'HP', 'HP EliteBook 840 G5', '5CG8478451', '2019-11-04', '0000-00-00', 5, 6, 'Nouhak PHIMBOUASONE', 'CORE', 'EORE 3', 'Sepon', '', 'Working', '', '', '', '', '', '', 'c12345', '93BDF48A-39EF-4F68-BDA3-6E0A87E287A9', '316965-388828-510334-486981-058124-655402-573639-076923', 'core@halolaos.org', '0000-00-00 00:00:00'),
(367, 'Laptop', 'LPT-037', 'HP', 'HP EliteBook 840 G5', '5CG847843N', '2019-11-04', '2025-03-17', 4, 5, 'Minthada THEBVONGSA', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor23', '', '', '', '', '', '1998-11-24', '  C388E62E-6536-4D6F-BCD4-42BF19B08920', ' 169774-579260-283217-597278-086240-428197-250448-670010', 'FROM Minthada, He lost charger\nborrow chager number 53', '0000-00-00 00:00:00'),
(368, 'Laptop', 'LPT-040', 'HP', 'HP EliteBook 840 G6', '5CG0421S1J', '0000-00-00', '0000-00-00', 0, 0, '	Andrew', 'Fleet', 'expat', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lovac19', 'E3AE006B-EAB5-4B21-B66C-C87A8C426E6C', '179080-669570-349657-517770-399113-230120-694606-717882', '', '0000-00-00 00:00:00'),
(369, 'Laptop', 'LPT-041', 'HP', 'HP EliteBook 840 G7', '54G1303PM7', '0000-00-00', '0000-00-00', 0, 0, 'Kayamphone SOUMPHONPHAKDY', 'Liaison', 'Liaison', 'Sepon', '', 'Working', 'laos_liaison1', '', '', '', '', '', 'LPT041', 'DD7799E8-219B-49F8-A9A2-1F611DD92402', '335533-132231-389279-615197-692021-625526-398992-469183', '', '0000-00-00 00:00:00'),
(370, 'Laptop', 'LPT-042', 'HP', 'HP EliteBook 840 G7', '5CG1303PM2', '0000-00-00', '0000-00-00', 0, 0, 'Phoulathsamy PHOMMALATH', 'Finance', 'Finance', 'Sepon', '', 'Working', 'laos_finance1', '', '', '', '', '', 'lpt042', 'FA8442F1-CCA0-406F-84DA-0CF44FF6BA49', '357852-684640-153428-632819-087285-481899-173690-608982', '', '0000-00-00 00:00:00'),
(371, 'Laptop', 'LPT-043', 'HP', 'HP EliteBook 840 G7', '5CG1303PM6', '2025-03-10', '0000-00-00', 1, 1, 'Bounnoi PHOMMAVONG', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor25', '', '', '', '', '', 'LPT043', 'EC1048B7-C66B-483A-B9F6-10408FB0D261', '614669-021285-225819-008800-228305-218911-575036-587873', '', '0000-00-00 00:00:00'),
(372, 'Laptop', 'LPT-044', 'HP', 'HP EliteBook 840 G7', '5CG1303PLK', '0000-00-00', '2025-03-21', 0, 0, 'Toulanee SENSOULIYA', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor1', '', '', '', '', '', 'LPT044', '871605DD-7615-40CB-8277-9D80C896616D', '332233-137797-356191-317504-362296-143253-030052-222057', '', '0000-00-00 00:00:00'),
(373, 'Laptop', 'LPT-045', 'HP', 'HP EliteBook 840 G7', '5CG1303PLT', '0000-00-00', '0000-00-00', 0, 0, 'Sivay KEDSAVANH', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor35', '', '', '', '', '', 'lpt045', '9360B06B-E285-4A12-8383-70A6E4EA32D1', '160908-566588-576092-258973-254276-549857-080982-690822', '', '0000-00-00 00:00:00'),
(374, 'Laptop', 'LPT-046', 'HP', 'HP EliteBook 840 G7', '5CG1303PM4', '0000-00-00', '0000-00-00', 0, 0, 'Lathdaphone CHANTHAPASEUTH', 'Medical', 'Medical', 'Sepon', '', 'Working', 'laos_medical1', '', '', '', '', '', 'LPT046', '192C3D8E-8C03-4378-BF06-705168268D7B', '538010-008195-513788-582626-524337-189035-518001-057750', '', '0000-00-00 00:00:00'),
(375, 'Laptop', 'LPT-047', 'HP', 'HP EliteBook 840 G7', '5CG1303PLP', '0000-00-00', '0000-00-00', 0, 0, 'Chanthala SAYYAVONGSA', 'Logistic', 'Logistic', 'Sepon', '', 'Working', 'laos_logistic3', '', '', '', '', '', 'LPT047', '2F3A6C42-FD00-4B99-B07B-0D785B19DDC7', '471757-660946-289696-419210-453046-130559-411994-388256', '', '0000-00-00 00:00:00'),
(376, 'Laptop', 'LPT-048', 'HP', 'HP EliteBook 840 G7', '5CG1303PLZ', '0000-00-00', '0000-00-00', 0, 0, 'Lattana INTHAVONGSA', 'HR', 'HR', 'Sepon', '', 'Working', 'laos_translator2', '', '', '', '', '', 'lpt048', '5AA29381-BECB-4D04-894F-6189E37AE9F0', '003333-652927-623381-013508-266035-109153-244222-334367', '', '0000-00-00 00:00:00'),
(377, 'Laptop', 'LPT-049', 'HP', 'HP EliteBook 840 G7', '5CG1303PMD', '0000-00-00', '0000-00-00', 0, 0, 'Noknoy PHOMLOUANGVISA', 'Fleet', 'Fleet', 'Sepon', '', 'Working', 'laos_fleet1', '', '', '', '', '', 'LPT12345', '0D258FF4-FD31-4EC5-BC44-FD3F6944A96F', '447458-349415-538846-564487-279235-707652-548581-272558', '', '0000-00-00 00:00:00'),
(378, 'Laptop', 'LPT-050', 'HP', 'HP EliteBook 840 G7', '5CG1303PLH', '0000-00-00', '0000-00-00', 0, 0, 'Khammany BOUNTEUM', 'liaison', 'Liaison2', 'Sepon', '', 'Working', 'laos_liaison1', '', '', '', '', '', 'LPT050', '48B6953B-BCB2-48BC-B86E-CB8D352DE85F', '618310-561363-155606-692615-541299-528143-130581-255024', '', '0000-00-00 00:00:00'),
(379, 'Laptop', 'LPT-051', 'HP', 'HP EliteBook 840 G7', '5CG1303PM3', '0000-00-00', '0000-00-00', 0, 0, 'Oth PHIMMASY', 'liaison', 'Liaison1', 'Sepon', '', 'Working', 'laos_liaison1', '', '', '', '', '', 'LPT051', '54399B9C-BB99-4326-9C2B-D61B5186532E', '030525-198396-506077-262460-102608-193842-461186-491634', '', '0000-00-00 00:00:00'),
(380, 'Laptop', 'LPT-052', 'Lenovo', 'Think Pad P17 Gen 2', 'PF-34M51J', '0000-00-00', '0000-00-00', 0, 0, 'Arty BOLIBOUN', 'HR', 'HR', 'Sepon', '', 'Working', '', '', '', '', '', '', 'LPT052', '95542505-FF51-4F46-9E91-E90C42BFD3BE', '547063-575641-484704-213345-157718-405581-224103-024497', '', '0000-00-00 00:00:00'),
(381, 'Laptop', 'LPT-053', 'HP', 'HP EliteBook 840 G3', '5CG8182G2P', '0000-00-00', '2022-07-11', 0, 0, 'Adna DOUANGBOUDDY', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor19', '', '', '', '', '', 'lpt053', '4C722428-9B95-4DA2-941C-E0493C404401', '618838-629541-297902-377817-653873-073568-632874-455609', '11/07/2022\nUpdate: Return on 11-9-23, The device Keyboard not good with battery not save', '0000-00-00 00:00:00'),
(382, 'Laptop', 'LPT-055', 'HP', 'HP EliteBook 840 G8', '5CG2086DYS', '2022-07-07', '0000-00-00', 9, 3, 'Vongdeuane KHOUNPHOM', 'Logistic', 'Logistic', 'Sepon', '', 'Working', 'laos_logistic1', '', '', '', '', '', 'LPT055', 'EC5E62A0-4B6D-4F61-8B86-00E9863D08A0', '202928-431420-136631-317317-074459-719543-344322-493845', '', '0000-00-00 00:00:00'),
(383, 'Laptop', 'LPT-054', 'HP', 'HP EliteBook 840 G8', '5CG2086F2P', '2022-07-07', '0000-00-00', 9, 3, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', '', '', '', '', '', '', 'lpt054', '64711158-E725-43DD-A929-0B2A75279F1C', '008030-408386-606848-685949-592746-607640-714934-094435', 'My Second Login:\nICT123', '0000-00-00 00:00:00'),
(384, 'Laptop', 'LPT-057', 'HP', 'HP EliteBook 840 G8', '5CG2086DYX', '2022-08-02', '0000-00-00', 8, 3, 'Touktic VORLASAN', 'Fleet', 'Fleet', 'Sepon', '', 'Working', 'laos_fleet3', '', '', '', '', '', 'LPT057', '5B156C08-56F9-4EC9-9F36-4B5B104E33C8', '221210-363748-030360-092807-358677-379456-484605-550143', '', '0000-00-00 00:00:00'),
(385, 'Laptop', 'LPT-056', 'HP', 'HP EliteBook 840 G8', '5CG2086F3F', '2022-08-02', '0000-00-00', 8, 3, 'Bounyor SEKAVONE', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor10', '', '', '', '', '', 'lpt056', 'BA338394-ED10-41F2-BDCF-F1C51DD8D7B0', '650551-475816-323290-223157-570559-548966-375408-431134', '', '0000-00-00 00:00:00'),
(386, 'Laptop', 'LPT-059', 'HP', 'HP EliteBook 840 G5', '5CG92760W5', NULL, NULL, 0, 0, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Broken', '', '', '', '', '', '', 'LPT058', '9FB05B3A-DFD2-492C-AF66-77FF1923554C', '081312-648912-458557-106799-700546-356587-018172-527813', 'ຄອມເກົ່າຂອງລຸງຄຳມີ', '0000-00-00 00:00:00'),
(387, 'Laptop', 'LPT-058', 'HP', 'HP EliteBook 840 G5', '5CG8346G1N', '2022-08-03', '2022-08-10', 1900, 1900, 'Souliya OUANTHOUMPHONE', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor29', '', '', '', '', '', 'LPT058', '1FCC5827-DFF7-4A90-9E77-41E4CC67D20A', '319913-188804-109527-174999-384417-481844-564443-423203', '', '0000-00-00 00:00:00'),
(388, 'Laptop', 'LPT-060', 'HP', 'HP EliteBook 850 G8', '5CG2086DZ6', '2022-10-01', '0000-00-00', 6, 3, 'Sinchai VORLACHARK', 'Fleet', 'Fleet', 'Sepon', '', 'Working', 'laos_fleet2', '', '', '', '', '', 'LPT060', 'DB849CA0-5BC8-4CE3-94BB-49FE64E2EDDC', '266783-203104-326942-624503-034199-089584-186329-195085', '', '0000-00-00 00:00:00'),
(389, 'Laptop', 'LPT-061', 'HP', 'HP EliteBook 840 G8', '5CG2086F2J', '2022-10-02', '0000-00-00', 6, 3, 'Hanna', 'Expat', 'expat', 'Sepon', '', 'Working', '', '', '', '', '', '', '', '356D87FA-0DF3-4DD5-8781-962A4664869E', '714901-624602-453409-492855-227128-561330-002992-124850', '', '0000-00-00 00:00:00'),
(390, 'Laptop', 'LPT-062', 'Dell', 'Dell', 'FV9L1B3', '2022-11-06', '0000-00-00', 5, 3, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', 'laos_hr2', '', '', '', '', '', 'lpt062', 'C79B2485-42B1-47C1-A41A-0DB5F823E562', '159753-293854-565158-426910-024794-436392-352605-674641', 'update 04/08/2024', '0000-00-00 00:00:00'),
(391, 'Laptop', 'LPT-063', 'HP', 'HP EliteBook 840 G8', '5CG2086F2T', '2023-01-13', '2023-02-18', 1, 1900, 'Malaythong KHODSISA', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor9', '', '', '', '', '', 'LPT063', '8588BFE9-F26D-44F3-B21C-F8ABA2A4C12E', 'Key:\n306900-340351-402754-457457-253880-096569-488972-574772', 'FROM MALAYTHONG', '0000-00-00 00:00:00'),
(392, 'Laptop', 'LPT-064', 'HP', 'HP EliteBook 840 G8', '5CG2086DXZ', '2023-01-13', '0000-00-00', 3, 3, 'Anongsack LUENAMACHACK', 'GIS', 'GIS', 'Sepon', '', 'Working', 'laos_gis5', '', '', '', '', '', 'lpt064', '514B5977-731B-4AF0-A8F0-642607ACB788', '706508-174757-389378-409497-149919-290433-512941-184558', '', '0000-00-00 00:00:00'),
(393, 'Laptop', 'LPT-065', 'dynabook', 'dynabook', '71119310H', '2023-06-02', '0000-00-00', 10, 2, 'Anousa  PHOMPHITHAK', 'Medical', 'Medical', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt065', '2AFA8125-187E-4F76-9FB0-BC53BD97C0C4', '582439-417659-716507-662101-477697-685157-097053-661793', 'Transfer to Anouxa on 12-12-24', '0000-00-00 00:00:00'),
(394, 'Laptop', 'LPT-066', 'HP', 'HP EliteBook 840 G9', '5CG3214BRZ', '2023-08-15', '2023-08-15', 1900, 1900, 'Expat', 'Expat', '', 'Sepon', '', 'Working', '', '', '', '', '', '', '', '7FBF9A0D-1707-4A97-89D0-5E30121E24F4', '008261-041294-525745-692384-041184-462055-487828-306768', '', '0000-00-00 00:00:00'),
(395, 'Laptop', 'LPT-067', 'HP', 'HP EliteBook 850 G9', '5CG3214BTJ', '2023-12-25', '2024-02-02', 2, 1900, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Lose', '', '', '', '', '', '', 'lpt067', 'D97BFF49-9AE1-4BE7-8420-A97D562156F5', '203819-719488-163064-572341-224653-171930-399575-546931', '', '0000-00-00 00:00:00'),
(396, 'Laptop', 'LPT-069', 'HP-OMEU', '9Y8H5PA#AKL', 'CND4050HJN', '2024-05-19', '0000-00-00', 11, 1, 'Khaiphone NIAMVIMAN', 'GIS', 'GIS', 'Sepon', '', 'Working', 'laosadmin', '', '', '', '', '', 'gis1234', 'FAB4173D-512C-48DA-97A2-086CCF7198C7', '307109-705122-512567-711590-413105-091047-365607-527373', '', '0000-00-00 00:00:00'),
(397, 'Laptop', 'LPT-070', 'HP-OMEU', '9Y8H5PA#AKL', 'CND4050HJJ', '2024-05-19', '0000-00-00', 11, 1, 'GIS', 'GIS', 'GIS', 'Sepon', '', 'Spare', '', '', '', '', '', '', 'lpt-070', '9C61A56E-55CD-48F5-B757-7F8E9AFF7CFE', '213411-414931-636735-464431-508651-700370-484440-247126', '', '0000-00-00 00:00:00'),
(398, 'Laptop', 'LPT-071', 'HP', 'HP EliteBook 840 14 inch G10', '5CG41117HG', '2024-08-14', '0000-00-00', 8, 1, 'Hein Bekker', 'Expat', 'Ops', 'Sepon', '', 'Working', 'laos_ops1', '', '', '', '', '', 'lpt071', '154B3B89A-632F-4162-A4C1-545088A470CC', '667370-019184-314908-504515-437041-254749-272283-429506', '', '0000-00-00 00:00:00'),
(399, 'Laptop', 'LPT-072', 'HP', 'HP EliteBook 840 G10', '5CG41117GX', '2024-08-14', '2024-08-21', 1900, 1900, 'Khonsavanh XAYYASITH', 'Ops', 'O1', 'Sepon', '', 'Working', 'laos_supervisor2', '', '', '', '', '', 'lpt072', '0D6D6BCF-F984-46D4-9793-98542F2BA745', '031273-516901-116182-121979-611688-132077-541002-542003', '', '0000-00-00 00:00:00'),
(400, 'Laptop', 'LPT-073', 'HP', 'HP EliteBook 840 14 inch G10', '5CG41117HH', '2024-10-13', '0000-00-00', 6, 1, 'Phettanousone KOMMATHILATH', 'Finance', 'Finance', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt073', '74DCE5D6-86C3-4081-83C9-83B65622B490', '374748-172216-290367-490468-243474-405449-209231-138842', '', '0000-00-00 00:00:00'),
(401, 'Laptop', 'LPT-074', 'HP', 'HP EliteBook 840 14 inch G10', '5CG41117GR', '2024-10-13', '0000-00-00', 6, 1, 'Akim', 'Expat', 'Ops', 'Sepon', '', 'Working', 'laos_ops1', '', '', '', '', '', '2174-04-14', '1D7C280E-A77D-418D-89F5-62BE758F5882', '474144-519662-019558-525228-108130-220176-119218-108185', '', '0000-00-00 00:00:00'),
(402, 'Laptop', 'FROM HQ', 'HP', 'HP EliteBook 840 G9', '5CG321BTR', '2025-02-12', '2025-02-12', 1900, 1900, 'Zan', 'Expat', 'ops', 'Sepon', '', 'Working', 'laos_ops1', '', '', '', '', '', 'Five-Honor-Chap0', '', '', 'ເຄື່ອງສົ່ງມາຈາກຫ້ອງການໃຫຍ່ ແຕ່ສົ່ງຜິດມາລາວ ເລີຍເອົາ ຊານ ໃຊ້ເລີຍເພາະຄອມລາວຊ້າ ແລະ ຢາກເພແລ້ວ', '0000-00-00 00:00:00'),
(403, 'Laptop', 'LPT-078', 'Lenovo', 'Ideapad SIM5 16iMH9', 'MP2NNV7C', '2025-02-14', '2025-03-17', 1, 1900, 'Bounthan PHENGMANYVONG', 'Fleet', 'Fleet', 'Sepon', '', 'Working', 'laos_fleet2', '', '', '', '', '', 'lpt078', '09DEE676-C4F2-41CE-A7BD-0FA699014B51', '267696-589589-409772-486156-228921-599500-083248-066781', 'Lenovo Pag 1 unit', '0000-00-00 00:00:00'),
(404, 'Laptop', 'LPT-077', 'Lenovo', 'Ideapad SIM5 16iMH9', 'MP2J12Q8', '2025-02-14', '0000-00-00', 2, 1, 'Daovandone KHOUTPHAITHOUN', 'Ops', 'O1', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt077', 'EA93C28B-B9E8-4105-9E8B-0CB49640DDB7', '536437-330297-560912-145266-068640-378466-109747-211552', '', '0000-00-00 00:00:00'),
(405, 'Laptop', 'LPT-076', 'Lenovo', 'Ideapad SIM5 16iMH9', 'MP2NTKGJ', '2025-02-14', '0000-00-00', 2, 1, 'Soukdavan DOUANGSOPHA', 'Fleet', 'Fleet', 'Sepon', '', 'Working', 'laos_fleet1', '', '', '', '', '', 'lpt076', 'AA0E5293-54AF-453B-8D53-63B6DC7A468D', '433499-323873-285879-270655-589633-256630-012782-234432', '', '0000-00-00 00:00:00'),
(406, 'Laptop', 'LPT-075', 'Lenovo', 'Ideapad SIM5 16iMH9', 'MP2J12Q6', '2025-02-14', '0000-00-00', 2, 1, 'Viengvilay VONGKHAMMOUTY', 'ADMIN', 'VTE', 'Vientiane', '', 'Working', 'laos_tablet60', '', '', '', '', '', 'lpt075', 'BD0C30AF-DC9E-4FD8-9FC8-C14A67935CC7', '527219-572814-487575-332541-353089-478753-423016-566973', '', '0000-00-00 00:00:00'),
(407, 'Laptop', 'LPT-079', 'HP', 'HP EloteBook 840 G9', 'SCG3214BS2', '2025-03-23', '0000-00-00', 1, 1, 'Saiysavanh KHONGTHILATH', 'Finance', 'Finance', 'Sepon', '', 'Working', 'laos_finance1', '', '', '', '', '', 'lpt079', '', '392139-494021-462275-227601-003531-145541-069190-325259', '', '0000-00-00 00:00:00'),
(408, 'Laptop', 'LPT-080', 'HP', 'HP EliteBook 840 G7', '5CGO517MHL', '2025-07-21', '0000-00-00', 9, 1900, 'Laiphone KHAMDEEPASERD', 'Ops', 'S1', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt080', '2393A1F2-94EE-42A6-A57D-C94B77C05067', '052547-313621-421080-398420-210353-107745-041690-087098', 'Computer  Amary', '0000-00-00 00:00:00'),
(409, 'Laptop', 'LPT-081', 'ASUS', 'UX3405CA-SILVER971WA', 'T2N0CX014597060', '2025-08-16', '0000-00-00', 8, 1900, 'Cameron', 'Expat', '', 'Sepon', '', 'Working', '', '', '', '', '', '', '', '6636567B-EBE0-47A7-9D6F-AAAA2DE60BB8', '156574-605297-342727-280665-345323-400741-602118-641300', '', '0000-00-00 00:00:00'),
(410, 'Laptop', 'LPT-082', 'DELL', 'P131F', 'ST= 42KQP74', '2025-08-17', '0000-00-00', 8, 1900, 'Douangchay  SOUTHAMMAVONG', 'HR', 'HR', 'Sepon', '', 'Working', '', '', '', '', '', '', 'LPT082', '18EDF6FA-3685-4170-A14D-B12249E482F3', '497915-026125-267333-288200-290235-240020-261151-015455', '', '0000-00-00 00:00:00'),
(411, 'Laptop', 'LPT-083', 'DELL', 'P131F', '2SWQP74', '2025-08-17', '0000-00-00', 8, 1900, 'Khanmali KEOSIPASERT', 'Facility', 'Facilities1', 'Sepon', '', 'Working', '', '', '', '', '', '', 'lpt083', '5EFF14C4-F0CD-4C9A-925F-72F7EA21E718', '447546-563673-022770-150854-175131-482845-142087-588467', '', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `monitors`
--

CREATE TABLE `monitors` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'Monitor',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `office365_accounts`
--

CREATE TABLE `office365_accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `account_type` varchar(100) DEFAULT 'Standard',
  `account_status` varchar(50) DEFAULT 'Active',
  `primary_email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `second_email` varchar(255) DEFAULT NULL,
  `third_email` varchar(255) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `team` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `halo_device_number` varchar(100) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `office365_accounts`
--

INSERT INTO `office365_accounts` (`id`, `full_name`, `account_type`, `account_status`, `primary_email`, `password`, `second_email`, `third_email`, `department`, `team`, `ins_number`, `halo_device_number`, `remark`, `phone`, `created_at`) VALUES
(30, 'Adna Douangbouddy', 'Office 365', 'actived', 'adna.douangbouddy@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(31, 'Anongsack Luenamachack', 'Office 365', 'actived', 'anongsack.luenamachack@halolaos.org', '', 'im@halolaos.org', '', 'GIS', 'ICT', 'INS-01540', 'LPT-064', 'ທົດລອງ', '020 23725030', '2026-04-07 07:41:21'),
(32, 'Anousa PHOMPHITHAK', 'Office 365', 'actived', 'anouxa.phomphiphak@halolaos.org', '', 'im@halolaos.org', '', 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(33, 'Arty BOLIBOUN', 'Office 365', 'actived', 'arty.boliboun@halolaos.org', '', 'im@halolaos.org', '', 'GIS', 'ICT', '', '', NULL, '', '2026-04-07 07:41:21'),
(34, 'Boualin Vongdata', 'Office 365', 'actived', 'boualin.vongdata@halolaos.org', '', 'medical@halolaos.org', '', 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(35, 'Bounnoi PHOMMAVONG', 'Office 365', 'actived', 'bounnoi.phommavong@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(36, 'Bounthan PHENGMANYVONG', 'Office 365', 'actived', 'bounthan.phengmanivong@halolaos.org', '', 'fleel@halolaos.org', '', 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(37, 'Bounyor SEKAVONE', 'Office 365', 'actived', 'bounyor.sekavone@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(38, 'Chanlone Uongbounchan', 'Office 365', 'actived', 'chanlone.uongbounchan@halolaos.org', '', '', '', 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(39, 'Chanthala SAYYAVONGSA', 'Office 365', 'actived', 'chanthala.sayyavongsa@halolaos.org', '', 'logistics@halolaos.org', '', 'Logistics', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(40, 'Daovandone KHOUTPHAITHOUN', 'Office 365', 'actived', 'daovandone.khoutphaithoun@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(41, 'Douangchay SOUTHAMMAVONG', 'Office 365', 'actived', 'duangchai.southammavong@halolaos.org', '', 'liaison@halolaos.org', '', 'HR', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(42, 'Hongsa LOUANGBOUTDY', 'Office 365', 'actived', 'hongsa.louangboutdy@halolaos.org', '', 'im@halolaos.org', '', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(43, 'Kanya Xayyakosy', 'Office 365', 'actived', 'kanya.xayyakosy@halolaos.org', '', '', '', 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(44, 'Kaoxing SINGTHAVONG', 'Office 365', 'actived', 'kaoxing.singthavong@halolaos.org', '', 'im@halolaos.org', '', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(45, 'Kayamphone SOUMPHONPHAKDY', 'Office 365', 'actived', 'kayamphone.soumphonphakdy@halolaos.org', '', '', '', 'Liaison', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(46, 'Keo CHANTHAVONE', 'Office 365', 'actived', 'kaikeo.chanthavone@halolaos.org', '', 'im@halolaos.org', 'sepon@halolaos.org', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(47, 'Keosomehak SENVISAYSOUK', 'Office 365', 'actived', 'keosomhuk.senvisaysouk@halolaos.org', '', 'im@halolaos.org', 'sepon@halolaos.org', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(48, 'Keovongkot Phisithxay', 'Office 365', 'actived', 'keovongkot.phisithxay@halolaos.org', '', 'logistics@halolaos.org', '', 'Logistics', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(49, 'Khaiphone NIAMVIMAN', 'Office 365', 'actived', 'khaiphone.niamvimanh@halolaos.org', '', 'im@halolaos.org', 'sepon@halolaos.org', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(50, 'khamlar Xayyakoumman', 'Office 365', 'actived', 'khamlar.xayyakoumman@halolaos.org', '', '', '', 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(51, 'Khammany BOUNTEUM', 'Office 365', 'actived', 'Khammany.Bounteum@halolaos.org', '', 'liaison@halolaos.org', '', 'Liaison', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(52, 'Khammy KHAMVANVONGSA', 'Office 365', 'actived', 'khammy.sulyvong@halolaos.org', '', '', '', 'Electrician', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(53, 'Khamphone THONEMA', 'Office 365', 'actived', 'khamphone.thonema@halolaos.org', '', 'im@halolaos.org', '', 'GIS', '', '', '', NULL, '', '2026-04-07 07:41:21'),
(54, 'Khanmali KEOSIPASERT', 'Office 365', 'actived', 'Khanmali.keosipasert@halolaos.org', '', 'sepon@halolaos.org', '', 'Admin', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(55, 'Khonesavan MALAYKHAM', 'Office 365', 'actived', 'khonesavan.malaikham@halolaos.org', '', 'im@halolaos.org', '', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(56, 'Khonsavanh XAYYASITH', 'Office 365', 'actived', 'khonsavanh.xayyasith@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(57, 'Khouayue Kateeyue', 'Office 365', 'actived', 'khouayue.kateeyue@halolaos.org', '', 'im@halolaos.org', '', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(58, 'kiettisak vorasoukkha', 'Office 365', 'actived', 'kiettisak.vorasoukkha@halolaos.org', '', '', '', 'Logistic', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(59, 'Lakhonekham LUANGKHAM', 'Office 365', 'actived', 'lakhonekham.luangkham@halolaos.org', '', 'core@halolaos.org', '', 'CORE', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(60, 'Lathdaphone CHANTHAPASEUTH', 'Office 365', 'actived', 'lathdaphone.chanthapaseuth@halolaos.org', '', 'medical@halolaos.org', '', 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(61, 'Lattana Inthavongsa', 'Office 365', 'actived', 'lattana.inthavongsa@halolaos.org', '', '', '', 'HR', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(62, 'Lay KETHSAVAN', 'Office 365', 'actived', 'lay.kethsavan@halolaos.org', '', 'core@halolaos.org', '', 'CORE', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(63, 'Linna Sikhongthon', 'Office 365', 'actived', 'linna.sikhongthon@halolaos.org', '', '', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(64, 'Malaythong KHODSISA', 'Office 365', 'actived', 'malaythong.khodsisa@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(65, 'Minthada THEBVONGSA', 'Office 365', 'actived', 'minthada.thebvongsa@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(66, 'Namfonh Vorasane', 'Office 365', 'actived', 'Namfonh.Vorasane@halolaos.org', '', '', '', 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(67, 'Nilandone PHOMLOUANGSY', 'Office 365', 'actived', 'nilandone.phomlouangsy@halolaos.org', '', 'finance@halolaos.org', 'sepon@halolaos.org', 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(68, 'Noknoy PHOMLOUANGVISA', 'Office 365', 'actived', 'noknoy.phomlouangvisa@halolaos.org', '', 'fleel@halolaos.org', '', 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(69, 'Ops Sub-Unit1', 'Office 365', 'actived', 'ops_sub_unit1@halolaos.org', '', '', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(70, 'Ops Sub-Unit2', 'Office 365', 'actived', 'ops_sub_unit2@halolaos.org', '', '', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(71, 'Oth PHIMMASY', 'Office 365', 'actived', 'oth.somsanya@halolaos.org', '', 'liaison@halolaos.org', '', 'Liaison', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(72, 'Phantha KIKHOUNKHAM', 'Office 365', 'actived', 'phantha.kikhounkham@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(73, 'Phet KHENTHILA', 'Office 365', 'actived', 'phet.khenthila@halolaos.org', '', 'fleel@halolaos.org', '', 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(74, 'Phettanousone Kommathilath', 'Office 365', 'actived', 'phettanousone.kommathilath@halolaos.org', '', 'finance@halolaos.org', '', 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(75, 'Phiphavanh XAYAVONG', 'Office 365', 'actived', 'phiphavanh.xayavong@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(76, 'Phoulathsamy PHOMMALATH', 'Office 365', 'actived', 'phoulathsamy.phommalath@halolaos.org', '', 'finance@halolaos.org', 'sepon@halolaos.org', 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(77, 'Phoutmany INSYXIENGMAY', 'Office 365', 'actived', 'phoutmany.insyxiengmay@halolaos.org', '', 'vientiane@halolaos.org', '', 'Admin', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(78, 'Phouvanh KETHTHASONE', 'Office 365', 'actived', 'phouvanh.keththasone@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(79, 'Phutthasit SENPASERD', 'Office 365', 'actived', 'phutthasit.senpaserd@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(80, 'Punya PHOMMIXAY', 'Office 365', 'actived', 'Panya.phommixay@halolaos.org', '', 'logistics@halolaos.org', 'sepon@halolaos.org', 'Logistics', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(81, 'Saiysavanh KHONGTHILATH', 'Office 365', 'actived', 'saiysavanh.khongthilath@halolaos.org', '', 'finance@halolaos.org', '', 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(82, 'Sakhone PHOMMAVONG', 'Office 365', 'actived', 'sakhone.phommavong@halolaos.org', '', 'sepon@halolaos.org', '', 'Admin', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(83, 'Satthaphone khenvanpheng', 'Office 365', 'actived', 'sathaphone.khenvanpheng@halolaos.org', '', '', '', 'Translator', 'Translator', 'INS-01851', '', NULL, '', '2026-04-07 07:41:21'),
(84, 'sengvang Naolor', 'Office 365', 'actived', 'sengvang.naolor@halolaos.org', '', 'im@halolaos.org', '', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(85, 'Sinchai VORLACHARK', 'Office 365', 'actived', 'sinchai.orlachark@halolaos.org', '', 'fleel@halolaos.org', '', 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(86, 'Sisomphan Phimthisan', 'Office 365', 'actived', 'sisomphan.phimthisan@halolaos.org', '', '', '', 'Electrician', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(87, 'Sivay KEDSAVANH', 'Office 365', 'actived', 'sivay.kedsavanh@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(88, 'Somthan Symeexay', 'Office 365', 'actived', 'somthan.symeexay@halolaos.org', '', 'im@halolaos.org', '', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(89, 'soukdavan douangsopha', 'Office 365', 'actived', 'soukdavan.douangsopha@halolaos.org', '', 'fleel@halolaos.org', '', 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(90, 'Souliya OUANTHOUMPHONE', 'Office 365', 'actived', 'souliya.ouanthoumphone@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(91, 'Sykhoun KONGTHILATH', 'Office 365', 'actived', 'sykhoun.kongthilath@halolaos.org', '', 'ops@halolaos.org', 'sepon@halolaos.org', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(92, 'Thay Chanthavong', 'Office 365', 'actived', 'thay.chanthavong@halolaos.org', '', 'medical@halolaos.org', '', 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(93, 'Touktic VORLASAN', 'Office 365', 'actived', 'touktick.vorlasan@halolaos.org', '', 'fleel@halolaos.org', '', 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(94, 'Toulanee SENSOULIYA', 'Office 365', 'actived', 'toulanee.khoutphadate@halolaos.org', '', 'ops@halolaos.org', '', 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(95, 'Vaya laoya', 'Office 365', 'actived', 'vaya.laoya@halolaos.org', '', 'im@halolaos.org', '', 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(96, 'Viengvilay VONGKHAMMOUTY', 'Office 365', 'actived', 'viengvilay.vongkhammouty@halolaos.org', '', 'vientiane@halolaos.org', '', 'Admin', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(97, 'Viphakone Vilathan', 'Office 365', 'actived', 'viphakone.vilathan@halolaos.org', '', 'medical@halolaos.org', '', 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(98, 'Vongdeuane KHOUNPHOM', 'Office 365', 'actived', 'vongdeuane.khounphom@halolaos.org', '', 'logistics@halolaos.org', '', 'Logistics', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:41:21'),
(99, 'Ops Sub-Unit3', 'Office 365', 'actived', 'ops_sub_unit3@halolaos.org', 'Halo@unit3', '', '', 'Operation', '', '', '', NULL, '', '2026-05-03 00:56:20'),
(100, 'Ops Sub-Unit4', 'Office 365', 'actived', 'ops_sub_unit4@halolaos.org', 'Halo@unit4', '', '', 'Operation', '', '', '', NULL, '', '2026-05-03 00:56:46');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `expires_at` int(11) NOT NULL,
  `used` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `otp`, `expires_at`, `used`, `created_at`) VALUES
(5, 'dongluenammachack@gmail.com', '$2y$10', 1775306816, 0, '2026-04-04 12:36:56');

-- --------------------------------------------------------

--
-- Table structure for table `phones`
--

CREATE TABLE `phones` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'Phone',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `powerbanks`
--

CREATE TABLE `powerbanks` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'PowerBank',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `printers`
--

CREATE TABLE `printers` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'Printer',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey123_accounts`
--

CREATE TABLE `survey123_accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `account_type` varchar(100) DEFAULT 'Survey123',
  `account_status` varchar(50) DEFAULT 'Active',
  `primary_email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `second_email` varchar(255) DEFAULT NULL,
  `third_email` varchar(255) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `team` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `halo_device_number` varchar(100) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `survey123_accounts`
--

INSERT INTO `survey123_accounts` (`id`, `full_name`, `account_type`, `account_status`, `primary_email`, `password`, `second_email`, `third_email`, `department`, `team`, `ins_number`, `halo_device_number`, `remark`, `phone`, `created_at`) VALUES
(13, 'Khamlar', 'Survey 123', 'actived', 'laos_translator5', 'tab_9441', NULL, NULL, 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(14, 'Khammy,Sisomphan', 'Survey 123', 'actived', 'laos_electrician1', 'elec_9181', NULL, NULL, 'Electrician', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(15, 'Phiphavanh.Xayavong', 'Survey 123', 'actived', 'laos_eore1', 'eore_1179', NULL, NULL, 'EORE', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(16, 'Khanmali', 'Survey 123', 'actived', 'laos_facility1', 'facility_6661', NULL, NULL, 'Facility', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(17, 'Sakhone', 'Survey 123', 'actived', 'laos_facility2', 'tab_9440', NULL, NULL, 'Facility', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(18, 'Nilundone', 'Survey 123', 'actived', 'laos_finance1', 'finance_64211', NULL, NULL, 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(19, 'Phetthanousone', 'Survey 123', 'actived', 'laos_finance2', 'tab_9428', NULL, NULL, 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(20, 'Saiysavanh', 'Survey 123', 'actived', 'laos_finance3', 'tab_9429', NULL, NULL, 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(21, 'Phoulathsamy Khommalath', 'Survey 123', 'actived', 'laos_finance4', 'tab_9442', NULL, NULL, 'Finance', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(22, 'Noknoy', 'Survey 123', 'actived', 'laos_fleet1', 'fleet_18211', NULL, NULL, 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(23, 'Bounthan', 'Survey 123', 'actived', 'laos_fleet2', 'fleet_18222', NULL, NULL, 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(24, 'Toutick', 'Survey 123', 'actived', 'laos_fleet3', 'fleet_18233', NULL, NULL, 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(25, 'Sinchai', 'Survey 123', 'actived', 'laos_fleet4', 'tab_9434', NULL, NULL, 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(26, 'Soukdavanh', 'Survey 123', 'actived', 'laos_fleet5', 'tab_9435', NULL, NULL, 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(27, 'Phet', 'Survey 123', 'actived', 'laos_fleet6', 'tab_9436', NULL, NULL, 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(28, 'Daniel Kuchalski', 'Survey 123', 'actived', 'laos_fn_ln', 'tab_48000', NULL, NULL, 'Fleet', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(29, 'kaikeo', 'Survey 123', 'actived', 'laos_gis1', 'gis_4101', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(30, 'Sengvang', 'Survey 123', 'actived', 'laos_gis2', 'gis_4102', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(31, 'Vaya', 'Survey 123', 'actived', 'laos_gis3', 'gis_41033', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(32, 'Somthan', 'Survey 123', 'actived', 'laos_gis4', 'gis_4104', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(33, 'Keosomehak', 'Survey 123', 'actived', 'laos_gis5', 'gis_4105', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(34, 'Hongsa', 'Survey 123', 'actived', 'laos_gis6', 'gis_4106', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(35, 'Dong+Khamphone+Nick', 'Survey 123', 'actived', 'laos_gis7', 'gis_9477', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(36, 'Arty Boliboun', 'Survey 123', 'actived', 'laos_hr1', 'humanres_6421', NULL, NULL, 'HR', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(37, 'Lattana', 'Survey 123', 'actived', 'laos_hr2', 'tab_9415', NULL, NULL, 'HR', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(38, 'duangchai', 'Survey 123', 'actived', 'laos_hr3', 'tab_9416', NULL, NULL, 'HR', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(39, 'Khammany', 'Survey 123', 'actived', 'laos_liaison1', 'liaison_88311', NULL, NULL, 'Liaison', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(40, 'Kayamphone', 'Survey 123', 'actived', 'laos_liaison2', 'tab_9430', NULL, NULL, 'Liaison', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(41, 'Oth', 'Survey 123', 'actived', 'laos_liaison3', 'tab_9431', NULL, NULL, 'Liaison', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(42, 'Vongdouane', 'Survey 123', 'actived', 'laos_logistic1', 'logistic_3691', NULL, NULL, 'Logistic', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(43, 'Chanthala SAYYAVONGSA', 'Survey 123', 'actived', 'laos_logistic2', 'logistic_3692', NULL, NULL, 'Logistic', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(44, 'Keidtisak VORASOUKKHA', 'Survey 123', 'actived', 'laos_logistic3', 'tab_4796', NULL, NULL, 'Logistic', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(45, 'Keovongkot', 'Survey 123', 'actived', 'laos_logistic4', 'tab_4797', NULL, NULL, 'Logistic', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(46, 'Punya', 'Survey 123', 'actived', 'laos_logistic5', 'tab_4798', NULL, NULL, 'Logistic', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(47, 'Latdaphone', 'Survey 123', 'actived', 'laos_medical1', 'medical_7541', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(48, 'Bolibouan SALIHA', 'Survey 123', 'actived', 'laos_medical10', 'tab_9446', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(49, 'Boualin', 'Survey 123', 'actived', 'laos_medical2', 'tab_9423', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(50, 'Vilakhone', 'Survey 123', 'actived', 'laos_medical3', 'tab_9420', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(51, 'Thay', 'Survey 123', 'actived', 'laos_medical4', 'tab_9421', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(52, 'Viphakhone', 'Survey 123', 'actived', 'laos_medical5', 'tab_9422', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(53, 'Anouxa', 'Survey 123', 'actived', 'laos_medical6', 'tab_9433', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(54, 'Kongsanith SOUASIVILAY', 'Survey 123', 'actived', 'laos_medical7', 'tab_9443', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(55, 'Lamphone CHAMPATHONG', 'Survey 123', 'actived', 'laos_medical8', 'tab_9444', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(56, 'Khedsavan KHENNAVONG', 'Survey 123', 'actived', 'laos_medical9', 'tab_9445', NULL, NULL, 'Medical', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(57, 'Phutthasit+Sykhoun', 'Survey 123', 'actived', 'laos_operationcoordinator1', 'ops_4291', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(58, 'Will', 'Survey 123', 'actived', 'laos_ops1', 'ops_77911', NULL, NULL, 'Expat', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(59, 'Matthew', 'Survey 123', 'actived', 'laos_ops2', 'ops_77922', NULL, NULL, 'Expat', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(60, 'Hein', 'Survey 123', 'actived', 'laos_ops3', 'ops_77933', NULL, NULL, 'Expat', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(61, 'David', 'Survey 123', 'actived', 'laos_ops4', 'tab_94199', NULL, NULL, 'Expat', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(62, 'Akim', 'Survey 123', 'actived', 'laos_ops5', 'tab_9424', NULL, NULL, 'Expat', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(63, 'Wut Hmon', 'Survey 123', 'actived', 'laos_ops6', 'tab_9425', NULL, NULL, 'Expat', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(64, 'Toulanee SENSOULIYA', 'Survey 123', 'actived', 'laos_supervisor1', 'tab_4759', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(65, 'Bounyor SEKAVONE', 'Survey 123', 'actived', 'laos_supervisor10', 'tab_4768', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(66, 'Kaisamone VONGSAKSI', 'Survey 123', 'actived', 'laos_supervisor11', 'tab_4769', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(67, 'Viengsavanh', 'Survey 123', 'actived', 'laos_supervisor12', 'tab_4770', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(68, 'Phouvanh KETHTHASONE', 'Survey 123', 'actived', 'laos_supervisor13', 'tab_4771', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(69, 'Konekeo', 'Survey 123', 'actived', 'laos_supervisor14', 'tab_47722', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(70, 'Natmany INTHISONE', 'Survey 123', 'actived', 'laos_supervisor15', 'tab_4773', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(71, 'Laiphone KHAMDEEPASERD', 'Survey 123', 'actived', 'laos_supervisor17', 'tab_4775', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(72, 'Malaythong THAVONG', 'Survey 123', 'actived', 'laos_supervisor18', 'tab_4776', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(73, 'Adna DOUANGBOUDDY', 'Survey 123', 'actived', 'laos_supervisor19', 'tab_4777', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(74, 'Khonsavanh XAYYASITH', 'Survey 123', 'actived', 'laos_supervisor2', 'tab_4760', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(75, 'Phantha KIKHOUNKHAM', 'Survey 123', 'actived', 'laos_supervisor20', 'tab_4778', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(76, 'Khamsamai THOUVONGSA', 'Survey 123', 'actived', 'laos_supervisor21', 'tab_4779', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(77, 'Vongphan XAYPHAVIENG', 'Survey 123', 'actived', 'laos_supervisor22', 'tab_4780', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(78, 'Minthada', 'Survey 123', 'actived', 'laos_supervisor23', 'tab_4781', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(79, 'Bounnoi PHOMMAVONG', 'Survey 123', 'actived', 'laos_supervisor25', 'tab_4783', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(80, 'Namfon', 'Survey 123', 'actived', 'laos_supervisor26', 'tab_4784', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(81, 'Daovandone', 'Survey 123', 'actived', 'laos_supervisor27', 'tab_4785', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(82, 'Souliya', 'Survey 123', 'actived', 'laos_supervisor29', 'tab_4787', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(83, 'Anousith VINKHOUNSAVATH', 'Survey 123', 'actived', 'laos_supervisor3', 'tab_4761', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(84, 'Chanpasouk', 'Survey 123', 'actived', 'laos_supervisor30', 'tab_4788', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(85, 'Pinnapha', 'Survey 123', 'actived', 'laos_supervisor32', 'tab_4790', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(86, 'Chansamone', 'Survey 123', 'actived', 'laos_supervisor34', 'tab_4792', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(87, 'Sivay', 'Survey 123', 'actived', 'laos_supervisor35', 'tab_4793', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(88, 'Honda TANKHAMPHONG', 'Survey 123', 'actived', 'laos_supervisor36', 'tab_4794', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(89, 'Somtha', 'Survey 123', 'actived', 'laos_supervisor37', 'tab_4795', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(90, 'Maneegneng', 'Survey 123', 'actived', 'laos_supervisor38', 'tab_9407', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(91, 'Kalathone', 'Survey 123', 'actived', 'laos_supervisor39', 'tab_9408', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(92, 'Amphaiphone LITTHIKOUMMAN', 'Survey 123', 'actived', 'laos_supervisor4', 'tab_4762', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(93, 'Phoimany SENGATHIT', 'Survey 123', 'actived', 'laos_supervisor40', 'tab_9409', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(94, 'Kheunma', 'Survey 123', 'actived', 'laos_supervisor41', 'tab_9410', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(95, 'Vannida KONGSADETH', 'Survey 123', 'actived', 'laos_supervisor42', 'tab_9411', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(96, 'Phikoudone SEESIENGMATH', 'Survey 123', 'actived', 'laos_supervisor43', 'tab_9412', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(97, 'Manyvan', 'Survey 123', 'actived', 'laos_supervisor44', 'tab_9413', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(98, 'Syoudone XAYYASIT', 'Survey 123', 'actived', 'laos_supervisor5', 'tab_4763', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(99, 'Lumngern', 'Survey 123', 'actived', 'laos_supervisor6', 'tab_4764', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(100, 'Yonesa SINGTHONGTHAI', 'Survey 123', 'actived', 'laos_supervisor7', 'tab_4765', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(101, 'Soukphama THEBSOMBAT', 'Survey 123', 'actived', 'laos_supervisor8', 'tab_4766', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(102, 'Malaythong KHODSISA', 'Survey 123', 'actived', 'laos_supervisor9', 'tab_4767', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(103, 'Kiengkham', 'Survey 123', 'actived', 'laos_tablet1', 'tb_135112', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(104, 'Training', 'Survey 123', 'actived', 'laos_tablet100', 'tb_133014', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(105, 'Training', 'Survey 123', 'actived', 'laos_tablet101', 'tb_132114', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(106, 'Lery', 'Survey 123', 'actived', 'laos_tablet103', 'tb_131314', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(107, 'Phuvong EMCHAN', 'Survey 123', 'actived', 'laos_tablet104', 'tb_130414', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(108, 'Dery', 'Survey 123', 'actived', 'laos_tablet105', 'tb_129514', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(109, 'Bounthavy', 'Survey 123', 'actived', 'laos_tablet11', 'tb_126311', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(110, 'Bouakham', 'Survey 123', 'actived', 'laos_tablet112', 'tb_123214', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(111, 'Fongsamouth DOUANGMALA', 'Survey 123', 'actived', 'laos_tablet113', 'tb_122314', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(112, 'Ar SIXANON', 'Survey 123', 'actived', 'laos_tablet117', 'tb_121714', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(113, 'Somkhit PHOMLOUANGVISA', 'Survey 123', 'actived', 'laos_tablet119', 'tb_120914', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(114, 'Chantavong', 'Survey 123', 'actived', 'laos_tablet12', 'tb_119213', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(115, 'Somphone SAYYAVONG', 'Survey 123', 'actived', 'laos_tablet120', 'tb_118014', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(116, 'Tahouy PHONESOMSAY', 'Survey 123', 'actived', 'laos_tablet124', 'tb_116414', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(117, 'Toy XAYYABOUTH', 'Survey 123', 'actived', 'laos_tablet125', 'tb_115514', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(118, 'Chaiphet THEBPHAVONG', 'Survey 123', 'actived', 'laos_tablet127', 'tb_113714', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(119, 'Nouansee BOUNMISAY', 'Survey 123', 'actived', 'laos_tablet128', 'tb_112814', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(120, 'Somvang', 'Survey 123', 'actived', 'laos_tablet129', 'tb_111914', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(121, 'Khamdeng', 'Survey 123', 'actived', 'laos_tablet130', 'tb_109014', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(122, 'Damdee KEOCHALERN', 'Survey 123', 'actived', 'laos_tablet131', 'tb_108114', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(123, 'Ladsavong', 'Survey 123', 'actived', 'laos_tablet134', 'tb_107414', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(124, 'Chakkavarn VILAYVIENG', 'Survey 123', 'actived', 'laos_tablet136', 'tb_106614', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(125, 'Toyota VANHTHALY', 'Survey 123', 'actived', 'laos_tablet137', 'tb_105714', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(126, 'Sounee NORSAOVANG', 'Survey 123', 'actived', 'laos_tablet138', 'tb_104814', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(127, 'Bouahong', 'Survey 123', 'actived', 'laos_tablet139', 'tb_103914', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(128, 'Manyphone', 'Survey 123', 'actived', 'laos_tablet14', 'tb_102413', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(129, 'Ounchai PHONSANGA', 'Survey 123', 'actived', 'laos_tablet140', 'tb_101014', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(130, 'Chansamai', 'Survey 123', 'actived', 'laos_tablet141', 'tb_100114', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(131, 'Mouk SOUKSAVAN', 'Survey 123', 'actived', 'laos_tablet142', 'tb_99214', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(132, 'Makki', 'Survey 123', 'actived', 'laos_tablet143', 'tb_98313', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(133, 'Poukky SEEPHENG', 'Survey 123', 'actived', 'laos_tablet145', 'tb_96514', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(134, 'Khonesavan', 'Survey 123', 'actived', 'laos_tablet146', 'tb_95614', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(135, 'Nouamvilay PHIMMALAD', 'Survey 123', 'actived', 'laos_tablet147', 'tb_94714', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(136, 'Phetsamai SIBOUNHEUANG', 'Survey 123', 'actived', 'laos_tablet151', 'tb_90114', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(137, 'Souk PHIMMASENG', 'Survey 123', 'actived', 'laos_tablet152', 'tb_89214', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(138, 'Sitdavan', 'Survey 123', 'actived', 'laos_tablet153', 'tb_88314', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(139, 'Lay KETHSAVAN', 'Survey 123', 'actived', 'laos_tablet154', 'tb_87414', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(140, 'Oill', 'Survey 123', 'actived', 'laos_tablet16', 'tb_85613', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(141, 'Chit VORLASOUN', 'Survey 123', 'actived', 'laos_tablet17', 'tb_84713', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(142, 'Vangchai', 'Survey 123', 'actived', 'laos_tablet18', 'tb_83813', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(143, 'Manyvan CHANTILANONG', 'Survey 123', 'actived', 'laos_tablet19', 'tb_82913', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(144, 'Khouanta', 'Survey 123', 'actived', 'laos_tablet2', 'tb_81212', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(145, 'Phout', 'Survey 123', 'actived', 'laos_tablet20', 'tb_80013', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(146, 'Keooudone BOUTYASAN', 'Survey 123', 'actived', 'laos_tablet21', 'tb_79113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(147, 'Dasavanh', 'Survey 123', 'actived', 'laos_tablet22', 'tb_78213', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(148, 'Chandee', 'Survey 123', 'actived', 'laos_tablet23', 'tb_77313', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(149, 'Saisomphone ANOUPHIN', 'Survey 123', 'actived', 'laos_tablet25', 'tb_75513', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(150, 'Khamsai', 'Survey 123', 'actived', 'laos_tablet28', 'tb_72813', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(151, 'Khamsavang THOUMMANY', 'Survey 123', 'actived', 'laos_tablet29', 'tb_71913', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(152, 'Darling', 'Survey 123', 'actived', 'laos_tablet3', 'tb_70312', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(153, 'Khampao', 'Survey 123', 'actived', 'laos_tablet30', 'tb_69031', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(154, 'Aon', 'Survey 123', 'actived', 'laos_tablet31', 'tb_68113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(155, 'Sack XAYYASANE', 'Survey 123', 'actived', 'laos_tablet32', 'tb_67213', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(156, 'Sone PHOMMACHAK', 'Survey 123', 'actived', 'laos_tablet33', 'tb_66313', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(157, 'Noula PHONGPHANA', 'Survey 123', 'actived', 'laos_tablet37', 'tb_63713', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(158, 'Bounkerd', 'Survey 123', 'actived', 'laos_tablet39', 'tb_61913', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(159, 'Keooudone', 'Survey 123', 'actived', 'laos_tablet4', 'tb_60412', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(160, 'Alingkham LOUANGLADKEOKHOUNMEUANG', 'Survey 123', 'actived', 'laos_tablet40', 'tb_59013', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(161, 'Munta', 'Survey 123', 'actived', 'laos_tablet41', 'tb_58113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(162, 'Souphachan', 'Survey 123', 'actived', 'laos_tablet42', 'tb_57213', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(163, 'Buakham PHOMMADTA', 'Survey 123', 'actived', 'laos_tablet43', 'tb_56313', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(164, 'Khaikham BOUDSADY', 'Survey 123', 'actived', 'laos_tablet44', 'tb_55413', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(165, 'Noud BOUNYONGMA', 'Survey 123', 'actived', 'laos_tablet45', 'tab_9295', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(166, 'Ei VONGKANTHAO', 'Survey 123', 'actived', 'laos_tablet46', 'tb_54613', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(167, 'Tha', 'Survey 123', 'actived', 'laos_tablet47', 'tb_53713', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(168, 'Loy Tounmanysone', 'Survey 123', 'actived', 'laos_tablet48', 'tb_52813', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(169, 'Somemay', 'Survey 123', 'actived', 'laos_tablet5', 'tb_51512', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(170, 'Thongdam SINGSAVATH', 'Survey 123', 'actived', 'laos_tablet51', 'tb_50113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(171, 'Sonsak SAYNALY', 'Survey 123', 'actived', 'laos_tablet57', 'tb_48713', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(172, 'Konkeo', 'Survey 123', 'actived', 'laos_tablet59', 'tb_46913', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(173, 'Vonema CHANTHATHILATH', 'Survey 123', 'actived', 'laos_tablet61', 'tb_44113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(174, 'Lakhonesy', 'Survey 123', 'actived', 'laos_tablet63', 'tb_43313', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(175, 'Darling KHENNAVONG', 'Survey 123', 'actived', 'laos_tablet64', 'tb_42413', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(176, 'Somboun', 'Survey 123', 'actived', 'laos_tablet65', 'tb_41513', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(177, 'Monekham', 'Survey 123', 'actived', 'laos_tablet66', 'tb_40613', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(178, 'Somephet SYMEUANG', 'Survey 123', 'actived', 'laos_tablet67', 'tb_39713', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(179, 'Kanta', 'Survey 123', 'actived', 'laos_tablet68', 'tb_38813', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(180, 'Phim', 'Survey 123', 'actived', 'laos_tablet70', 'tb_37013', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(181, 'Pea SINGTHONG', 'Survey 123', 'actived', 'laos_tablet71', 'tb_36113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(182, 'Toumphone', 'Survey 123', 'actived', 'laos_tablet72', 'tb_35213', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(183, 'Khamsamai', 'Survey 123', 'actived', 'laos_tablet75', 'tb_34513', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(184, 'Phetsamone SEESAKEDKHAMMOUAN', 'Survey 123', 'actived', 'laos_tablet8', 'tb_33812', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(185, 'Khamfai VILAISAK', 'Survey 123', 'actived', 'laos_tablet80', 'tb_32013', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(186, 'Phalom KEOBOUNSAN', 'Survey 123', 'actived', 'laos_tablet81', 'tb_31113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(187, 'Ladsamee PHOMMALIN', 'Survey 123', 'actived', 'laos_tablet82', 'tb_30213', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(188, 'Kedsana', 'Survey 123', 'actived', 'laos_tablet84', 'tb_28413', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(189, 'Training', 'Survey 123', 'actived', 'laos_tablet85', 'tb_27513', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(190, 'Training', 'Survey 123', 'actived', 'laos_tablet87', 'tb_25713', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(191, 'Training', 'Survey 123', 'actived', 'laos_tablet88', 'tb_22813', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(192, 'Training', 'Survey 123', 'actived', 'laos_tablet89', 'tb_20913', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(193, 'Adsaphone', 'Survey 123', 'actived', 'laos_tablet9', 'tb_17912', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(194, 'Bounthavy konemany', 'Survey 123', 'actived', 'laos_tablet90', 'tb_16013', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(195, 'Nadmany', 'Survey 123', 'actived', 'laos_tablet91', 'tb_15113', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(196, 'Bounchome', 'Survey 123', 'actived', 'laos_tablet94', 'tb_13413', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(197, 'Training', 'Survey 123', 'actived', 'laos_tablet95', 'tb_12513', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(198, 'Bakham SICHANTHA', 'Survey 123', 'actived', 'laos_tablet96', 'tb_96134', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(199, 'Training', 'Survey 123', 'actived', 'laos_tablet97', 'tb_87134', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(200, 'Training', 'Survey 123', 'actived', 'laos_tablet98', 'tb_68134', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(201, 'Training', 'Survey 123', 'actived', 'laos_tablet99', 'tb_19134', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(202, 'Namfon', 'Survey 123', 'actived', 'laos_translator1', 'tab_4801', NULL, NULL, 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(203, 'Satthaphone', 'Survey 123', 'actived', 'laos_translator2', 'tab_4802', '', '', 'Translator', '', 'INS-01851', '', NULL, '', '2026-04-07 07:18:26'),
(204, 'Chanlone', 'Survey 123', 'actived', 'laos_translator3', 'tab_9418', NULL, NULL, 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(205, 'Kanya', 'Survey 123', 'actived', 'laos_translator4', 'tab_9439', NULL, NULL, 'Translator', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(206, 'Viengvilay', 'Survey 123', 'actived', 'laos_vientiane1', 'tab_9437', NULL, NULL, 'Admin', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(207, 'Phoutmany', 'Survey 123', 'actived', 'laos_vientiane2', 'tab_9438', NULL, NULL, 'Admin', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26'),
(208, 'Kaoxing + Kaiphone', 'Survey 123', 'actived', 'laosadmin', 'admin_213', NULL, NULL, 'GIS', NULL, NULL, NULL, NULL, NULL, '2026-04-07 07:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `system_users`
--

CREATE TABLE `system_users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `totp_secret` varchar(64) DEFAULT '',
  `otp_secret` varchar(32) DEFAULT '',
  `is_verified` tinyint(1) DEFAULT 0,
  `role` varchar(50) DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_users`
--

INSERT INTO `system_users` (`id`, `full_name`, `email`, `password`, `totp_secret`, `otp_secret`, `is_verified`, `role`, `created_at`) VALUES
(6, 'Anongsack', 'anongsack.luenamachack@halolaos.org', '$2y$10$WTfHzX3UReMcqQuq6wzTS.B3D5TdPQhK8vd1DiVc3TNdO3ENbgv0O', '5VV23JFNA2D26UD3KIX6K4RBCQTHNJGU', '', 1, 'user', '2026-04-04 15:12:28'),
(7, 'Dong', 'dongluenammachack@gmail.com', '$2y$10$/XY5Wa2Xi2kVW5MMv/PCFOA2uBUrtmGQ.iwu7AHBb1ndUWWNfMNHW', 'Z7C3Z2XF4T2JXFPK6WPMNQIPZA672557', '', 1, 'user', '2026-04-09 03:34:07');

-- --------------------------------------------------------

--
-- Table structure for table `tablets`
--

CREATE TABLE `tablets` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'Tablet',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trimble_accounts`
--

CREATE TABLE `trimble_accounts` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `account_type` varchar(100) DEFAULT NULL,
  `account_status` varchar(50) DEFAULT 'ACTIVED',
  `primary_email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `second_email` varchar(255) DEFAULT NULL,
  `third_email` varchar(255) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `halo_device_number` varchar(100) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `source_table` varchar(100) DEFAULT 'trimble_accounts',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trimble_accounts`
--

INSERT INTO `trimble_accounts` (`id`, `full_name`, `account_type`, `account_status`, `primary_email`, `password`, `second_email`, `third_email`, `department`, `team`, `ins_number`, `halo_device_number`, `remark`, `phone`, `source_table`, `created_at`) VALUES
(6, 'OPS', 'Trimble account', 'actived', 'halolaosda21@gmail.com', 'Da2_tb01', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(7, 'OPS', 'Trimble account', 'actived', 'halolaosda22@gmail.com', 'Da2_tb22', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(8, 'OPS', 'Trimble account', 'actived', 'halolaosda23@gmail.com', 'Da2_tb23', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(9, 'OPS', 'Trimble account', 'actived', 'halolaosda24@gmail.com', 'Da2_tb24', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(10, 'OPS', 'Trimble account', 'actived', 'halolaosda25@gmail.com', 'Da2_tb25', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(11, 'OPS', 'Trimble account', 'actived', 'halolaosda26@gmail.com', 'Da2_tb26', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(12, 'OPS', 'Trimble account', 'actived', 'halolaos.220@gmail.com', 'Da2_tb220', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(13, 'OPS', 'Trimble account', 'actived', 'halolaosda28@gmail.com', 'Da2_tb028', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(14, 'OPS', 'Trimble account', 'actived', 'halolaosda29@gmail.com', 'Da2_tb29', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(15, 'OPS', 'Trimble account', 'actived', 'halolaosda210@gmail.com', 'Da2_tb210', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(16, 'OPS', 'Trimble account', 'actived', 'halolaosda211@gmail.com', 'Da2_tb211', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(17, 'OPS', 'Trimble account', 'actived', 'halolaosda213@gmail.com', 'Da2_tb213', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(18, 'OPS', 'Trimble account', 'actived', 'halolaosda214@gmail.com', 'Da2_tb214', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(19, 'OPS', 'Trimble account', 'actived', 'halolaosda215@gmail.com', 'Da2_tb215', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(20, 'OPS', 'Trimble account', 'actived', 'halolaosdas212@gmail.com', 'Da2_tb212', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(21, 'OPS', 'Trimble account', 'actived', 'halolaos.010@gmail.com', 'Da2_tb10', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(22, 'OPS', 'Trimble account', 'actived', 'halolaos268@gmail.com', 'Da2_tb268', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(23, 'OPS', 'Trimble account', 'actived', 'halolaos.247@gmail.com', 'Da2_tb247', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(24, 'OPS', 'Trimble account', 'actived', 'halolaos.237@gmail.com', 'Da2_tb237', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(25, 'OPS', 'Trimble account', 'actived', 'halolaos.259@gmail.com', 'Da2_tb259', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(26, 'OPS', 'Trimble account', 'actived', 'halolaos262@gmail.com', 'Da2_tb262', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(27, 'OPS', 'Trimble account', 'actived', 'halolaos.255@gmail.com', 'Da2_tb255', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(28, 'OPS', 'Trimble account', 'actived', 'halolaos.241@gmail.com', 'Da2_tb241', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(29, 'OPS', 'Trimble account', 'actived', 'halolaos.260@gmail.com', 'Da2_tb260', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(30, 'OPS', 'Trimble account', 'actived', 'halolaos.201@gmail.com', 'Da2_tb201', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(31, 'OPS', 'Trimble account', 'actived', 'halolaos256@gmail.com', 'Da2_tb256', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(32, 'OPS', 'Trimble account', 'actived', 'halolaos.226@gmail.com', 'Da2_tb226', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(33, 'OPS', 'Trimble account', 'actived', 'halolaos.236@gmail.com', 'Da2_tb236', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(34, 'OPS', 'Trimble account', 'actived', 'halolaos.257@gmail.com', 'Da2_tb257', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(35, 'OPS', 'Trimble account', 'actived', 'halolaos.214@gmail.com', 'Da2_tb214', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(36, 'OPS', 'Trimble account', 'actived', 'halolaos.242@gmail.com', 'Da2_tb242', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(37, 'OPS', 'Trimble account', 'actived', 'halolaos.230@gmail.com', 'Da2_tb230', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(38, 'OPS', 'Trimble account', 'actived', 'halolaos.126@gmail.com', 'Da2_tb126', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(39, 'OPS', 'Trimble account', 'actived', 'halolaos.239@gmail.com', 'Da2_tb34', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(40, 'OPS', 'Trimble account', 'actived', 'halolaos.238@gmail.com', 'Da2_tb238', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(41, 'OPS', 'Trimble account', 'actived', 'halolaos.258@gmail.com', 'Da2_tb258', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(42, 'OPS', 'Trimble account', 'actived', 'halolaos275@gmail.com', 'Da2_tb275', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(43, 'OPS', 'Trimble account', 'actived', 'halolaos.229@gmail.com', 'Da2_tb229', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(44, 'OPS', 'Trimble account', 'actived', 'halolaos.254@gmail.com', 'Da2_tb254', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(45, 'OPS', 'Trimble account', 'actived', 'halolaos.234@gmail.com', 'Da2_tb234', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(46, 'OPS', 'Trimble account', 'actived', 'halo.laos.ts.f@gmail.com', 'Da2_tb41', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(47, 'OPS', 'Trimble account', 'actived', 'halolaos267@gmail.com', 'Da2_tb267', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(48, 'OPS', 'Trimble account', 'actived', 'halolaos.233@gmail.com', 'Da2_tb233', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(49, 'OPS', 'Trimble account', 'actived', 'halolaosda27@gmail.com', 'Da2_tb27', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(50, 'OPS', 'Trimble account', 'actived', 'halolaos.074@gmail.com', 'Da2_tb074', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(51, 'OPS', 'Trimble account', 'actived', 'halolaos.130@gmail.com', 'Da2_tb130', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(52, 'OPS', 'Trimble account', 'actived', 'halolaos.123@gmail.com', 'Da2_tb123', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(53, 'OPS', 'Trimble account', 'actived', 'halolaos.122@gmail.com', 'Da2_tb0122', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(54, 'OPS', 'Trimble account', 'actived', 'halolaos.129@gmail.com', 'Da2_tb129', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(55, 'OPS', 'Trimble account', 'actived', 'halolaos.120@gmail.com', 'Da2_tb120', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(56, 'OPS', 'Trimble account', 'actived', 'halolaos.235@gmail.com', 'Da2_tb235', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40'),
(57, 'OPS', 'Trimble account', 'actived', 'halolaos.232@gmail.com', 'Da2_tb232', NULL, NULL, 'OPS', NULL, NULL, NULL, NULL, NULL, 'trimble_accounts', '2026-04-07 08:10:40');

-- --------------------------------------------------------

--
-- Table structure for table `ups`
--

CREATE TABLE `ups` (
  `id` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL DEFAULT 'UPS',
  `halo_id` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `month_used` int(11) DEFAULT NULL,
  `year_used` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `location_local` varchar(150) DEFAULT NULL,
  `ins_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `sv123_user` varchar(150) DEFAULT NULL,
  `sv123_pass` varchar(150) DEFAULT NULL,
  `gmail_address` varchar(150) DEFAULT NULL,
  `gmail_pass` varchar(150) DEFAULT NULL,
  `dgps_mail` varchar(150) DEFAULT NULL,
  `dgps_pass` varchar(150) DEFAULT NULL,
  `bitlocker_pass` varchar(255) DEFAULT NULL,
  `bitlocker_id` varchar(255) DEFAULT NULL,
  `bitlocker_key` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_permissions`
--

CREATE TABLE `user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `can_edit` tinyint(1) DEFAULT 1,
  `can_delete` tinyint(1) DEFAULT 1,
  `view_only` tinyint(1) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_permissions`
--

INSERT INTO `user_permissions` (`id`, `user_id`, `can_edit`, `can_delete`, `view_only`, `updated_at`) VALUES
(1, 6, 1, 0, 0, '2026-06-08 00:30:45'),
(6, 7, 1, 0, 0, '2026-06-08 00:30:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `card_records`
--
ALTER TABLE `card_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `desktops`
--
ALTER TABLE `desktops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `device_mistakes`
--
ALTER TABLE `device_mistakes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `device_transfers`
--
ALTER TABLE `device_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dgps`
--
ALTER TABLE `dgps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `equipment_issue`
--
ALTER TABLE `equipment_issue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `equipment_issues`
--
ALTER TABLE `equipment_issues`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `equipment_stock`
--
ALTER TABLE `equipment_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `google_accounts`
--
ALTER TABLE `google_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ict_devices`
--
ALTER TABLE `ict_devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internet_records`
--
ALTER TABLE `internet_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `laptops`
--
ALTER TABLE `laptops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `monitors`
--
ALTER TABLE `monitors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `office365_accounts`
--
ALTER TABLE `office365_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `powerbanks`
--
ALTER TABLE `powerbanks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `printers`
--
ALTER TABLE `printers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey123_accounts`
--
ALTER TABLE `survey123_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_users`
--
ALTER TABLE `system_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `tablets`
--
ALTER TABLE `tablets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trimble_accounts`
--
ALTER TABLE `trimble_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ups`
--
ALTER TABLE `ups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `card_records`
--
ALTER TABLE `card_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `desktops`
--
ALTER TABLE `desktops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `device_mistakes`
--
ALTER TABLE `device_mistakes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `device_transfers`
--
ALTER TABLE `device_transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dgps`
--
ALTER TABLE `dgps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1008;

--
-- AUTO_INCREMENT for table `equipment_issue`
--
ALTER TABLE `equipment_issue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equipment_issues`
--
ALTER TABLE `equipment_issues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `equipment_stock`
--
ALTER TABLE `equipment_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `google_accounts`
--
ALTER TABLE `google_accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=229;

--
-- AUTO_INCREMENT for table `ict_devices`
--
ALTER TABLE `ict_devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `internet_records`
--
ALTER TABLE `internet_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `laptops`
--
ALTER TABLE `laptops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=412;

--
-- AUTO_INCREMENT for table `monitors`
--
ALTER TABLE `monitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `office365_accounts`
--
ALTER TABLE `office365_accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `phones`
--
ALTER TABLE `phones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `powerbanks`
--
ALTER TABLE `powerbanks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `printers`
--
ALTER TABLE `printers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey123_accounts`
--
ALTER TABLE `survey123_accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=209;

--
-- AUTO_INCREMENT for table `system_users`
--
ALTER TABLE `system_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tablets`
--
ALTER TABLE `tablets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trimble_accounts`
--
ALTER TABLE `trimble_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `ups`
--
ALTER TABLE `ups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
