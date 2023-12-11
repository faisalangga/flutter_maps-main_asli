-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 05, 2023 at 01:59 PM
-- Server version: 10.2.44-MariaDB-cll-lve
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dhax7142_tokool`
--

-- --------------------------------------------------------

--
-- Table structure for table `so`
--

CREATE TABLE `so` (
  `NO_ID` int(11) NOT NULL,
  `NO_BUKTI` varchar(20) NOT NULL DEFAULT '',
  `NO_JUAL` varchar(20) NOT NULL DEFAULT '',
  `TGL` date DEFAULT '2001-01-01',
  `HARI` decimal(7,0) NOT NULL DEFAULT 0,
  `JTEMPO` date DEFAULT '2001-01-01',
  `TERM` varchar(20) NOT NULL DEFAULT '',
  `PER` varchar(10) NOT NULL DEFAULT '',
  `KODEC` varchar(10) NOT NULL DEFAULT '',
  `NAMAC` varchar(50) NOT NULL DEFAULT '',
  `ALAMAT` varchar(100) NOT NULL DEFAULT '',
  `KOTA` varchar(100) NOT NULL DEFAULT '',
  `NOTES` varchar(70) NOT NULL DEFAULT '',
  `POSTED` decimal(1,0) NOT NULL DEFAULT 0,
  `USRNM` varchar(10) NOT NULL DEFAULT '',
  `FLAG` varchar(2) NOT NULL DEFAULT '',
  `TG_SMP` datetime DEFAULT '2001-01-01 00:00:00',
  `TOTAL` decimal(17,2) NOT NULL DEFAULT 0.00,
  `SISA` decimal(17,2) NOT NULL DEFAULT 0.00,
  `NO_ORDER` varchar(20) NOT NULL DEFAULT '',
  `GOL` varchar(1) NOT NULL DEFAULT '',
  `KD_BRG` varchar(20) NOT NULL DEFAULT '',
  `NA_BRG` varchar(200) NOT NULL DEFAULT '',
  `KG` decimal(17,2) NOT NULL DEFAULT 0.00,
  `HARGA` decimal(17,2) NOT NULL DEFAULT 0.00,
  `JPER` decimal(17,2) NOT NULL DEFAULT 0.00,
  `JPERB` decimal(17,2) NOT NULL DEFAULT 0.00,
  `JPERS` decimal(17,2) NOT NULL DEFAULT 0.00,
  `KIRIM` decimal(17,2) NOT NULL DEFAULT 0.00,
  `PERJ` decimal(17,2) NOT NULL DEFAULT 0.00,
  `PERJB` decimal(17,2) NOT NULL DEFAULT 0.00,
  `LNS` decimal(1,0) NOT NULL DEFAULT 0,
  `KODET` varchar(10) NOT NULL DEFAULT '',
  `NAMAT` varchar(50) NOT NULL DEFAULT '',
  `SLS` int(1) NOT NULL DEFAULT 0,
  `POSTED_ACCEPT` varchar(1) NOT NULL DEFAULT '0',
  `USRNM_ACCEPT` varchar(20) NOT NULL DEFAULT '',
  `TGL_ACCEPT` datetime DEFAULT '2001-01-01 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `so`
--

INSERT INTO `so` (`NO_ID`, `NO_BUKTI`, `NO_JUAL`, `TGL`, `HARI`, `JTEMPO`, `TERM`, `PER`, `KODEC`, `NAMAC`, `ALAMAT`, `KOTA`, `NOTES`, `POSTED`, `USRNM`, `FLAG`, `TG_SMP`, `TOTAL`, `SISA`, `NO_ORDER`, `GOL`, `KD_BRG`, `NA_BRG`, `KG`, `HARGA`, `JPER`, `JPERB`, `JPERS`, `KIRIM`, `PERJ`, `PERJB`, `LNS`, `KODET`, `NAMAT`, `SLS`, `POSTED_ACCEPT`, `USRNM_ACCEPT`, `TGL_ACCEPT`) VALUES
(61, 'SY2211-0021', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:20:39', '3227155500.00', '436975.00', '', 'Y', 'JG001', 'JAGUNG', '791940.00', '4075.00', '0.00', '0.00', '0.00', '354965.00', '2320586284.00', '610935519.00', '0', 'D0021', 'UNIVERSAL AGRI BISNISINDO', 0, '1', 'edwin', '2023-03-05 13:27:10'),
(62, 'SY2211-0022', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:22:08', '999040500.00', '-1415.00', '', 'Y', 'JG001', 'JAGUNG', '232335.00', '4300.00', '0.00', '0.00', '0.00', '233750.00', '1414069574.00', '999128389.00', '0', 'D0035', 'MULIA HERVEST', 1, '0', '', '2001-01-01 00:00:00'),
(63, 'SY2211-0023', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:27:58', '1329494760.00', '4300.00', '', 'Y', 'JG001', 'JAGUNG', '305210.00', '4356.00', '0.00', '0.00', '0.00', '300910.00', '2029394240.40', '1253716093.20', '0', 'D0025', 'SREEYA SEWU INDONESIA', 1, '1', 'edwin', '2023-03-05 13:34:03'),
(64, 'SY2211-0024', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'GCU01', 'GERBANG CAHAYA UTAMA', 'JAKARTA', 'JAKARTA', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:32:30', '64851750.00', '4450.00', '', 'Y', 'JG001', 'JAGUNG', '15170.00', '4275.00', '0.00', '0.00', '0.00', '10720.00', '91446525.00', '45597150.00', '0', 'D0025', 'SREEYA SEWU INDONESIA', 1, '1', 'edwin', '2023-03-05 13:56:36'),
(65, 'SY2211-0025', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:33:54', '1010900000.00', '150370.00', '', 'Y', 'JG001', 'JAGUNG', '229750.00', '4400.00', '0.00', '0.00', '0.00', '79380.00', '714626770.00', '49902930.00', '0', 'D0014', 'CENTRAL WINDU SEJATI', 0, '0', '', '2001-01-01 00:00:00'),
(66, 'SY2211-0026', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:34:59', '690404000.00', '-21040.00', '', 'Y', 'JG001', 'JAGUNG', '156910.00', '4400.00', '0.00', '0.00', '0.00', '177950.00', '939544320.00', '626616320.00', '0', 'D0001', 'CPI-CIREBON', 1, '0', '', '2001-01-01 00:00:00'),
(67, 'SY2211-0027', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:35:34', '1193632000.00', '34100.00', '', 'Y', 'JG001', 'JAGUNG', '271280.00', '4400.00', '0.00', '0.00', '0.00', '237180.00', '2163891059.00', '554985559.00', '0', 'D0022', 'HAIDA AGRICULTURE INDONESIA', 0, '0', '', '2001-01-01 00:00:00'),
(68, 'SY2211-0028', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'AMN001', 'ANGKASA MITRA NIAGA', 'BLORA', 'BLORA', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:36:20', '1726193700.00', '64020.00', '', 'Y', 'JG001', 'JAGUNG', '432630.00', '3990.00', '0.00', '0.00', '0.00', '368610.00', '2748919194.21', '1045538015.97', '0', 'D0030', 'MALINDO-GROBOGAN', 0, '0', '', '2001-01-01 00:00:00'),
(69, 'SY2211-0029', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:37:32', '1078830000.00', '-32610.00', '', 'Y', 'JG001', 'JAGUNG', '239740.00', '4500.00', '0.00', '0.00', '0.00', '272350.00', '1222511063.00', '1222511063.00', '0', 'D0008', 'CPI-KRIAN', 1, '0', '', '2001-01-01 00:00:00'),
(70, 'SY2211-0030', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 12:57:28', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '45955391.00', '45955391.00', '0', 'D0031', 'SINAR INDOCHEM SEMARANG', 1, '0', '', '2001-01-01 00:00:00'),
(71, 'SY2211-0031', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:04:59', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1192873398.00', '756320894.00', '0', 'D0027', 'WIRIFA SAKTI', 1, '0', '', '2001-01-01 00:00:00'),
(72, 'SY2211-0032', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:05:08', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1140840510.00', '1140840510.00', '0', 'D0035', 'MULIA HERVEST', 1, '0', '', '2001-01-01 00:00:00'),
(73, 'SY2211-0033', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:06:45', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '992333448.00', '992333448.00', '0', 'D0022', 'HAIDA AGRICULTURE INDONESIA', 1, '0', '', '2001-01-01 00:00:00'),
(74, 'SY2211-0034', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'Superadmin', 'SO', '2022-11-30 13:06:53', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4034919241.00', '4034919241.00', '0', 'D0017', 'GOLD COIN INDONESIA', 1, '0', '', '2001-01-01 00:00:00'),
(75, 'SY2211-0035', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:07:24', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '846646762.00', '475577262.00', '0', 'D0021', 'UNIVERSAL AGRI BISNISINDO', 1, '0', '', '2001-01-01 00:00:00'),
(76, 'SY2211-0036', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:08:04', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '468471885.00', '468471885.00', '0', 'D0009', 'CPI-SEMARANG', 1, '0', '', '2001-01-01 00:00:00'),
(77, 'SY2211-0037', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:08:31', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '7028574415.00', '7028574415.00', '0', 'D0008', 'CPI-KRIAN', 1, '0', '', '2001-01-01 00:00:00'),
(78, 'SY2211-0038', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'AMN001', 'ANGKASA MITRA NIAGA', 'BLORA', 'BLORA', 'PINDAH PROGRAM', '1', 'MELINDA', 'SO', '2022-11-30 13:08:43', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2262473202.00', '2262473202.00', '0', 'D0030', 'MALINDO-GROBOGAN', 1, '0', '', '2001-01-01 00:00:00'),
(79, 'SY2211-0039', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'MELINDA', 'SO', '2022-11-30 13:09:29', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3611061932.00', '3611061932.00', '0', 'D0001', 'CPI-CIREBON', 1, '0', '', '2001-01-01 00:00:00'),
(80, 'SY2211-0040', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'MELINDA', 'SO', '2022-11-30 13:10:23', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '767545688.00', '767545688.00', '0', 'D0014', 'CENTRAL WINDU SEJATI', 1, '0', '', '2001-01-01 00:00:00'),
(81, 'SY2211-0041', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'MELINDA', 'SO', '2022-11-30 13:12:37', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0022', 'HAIDA AGRICULTURE INDONESIA', 1, '0', '', '2001-01-01 00:00:00'),
(82, 'SY2211-0042', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:13:36', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '386438769.97', '199289308.97', '0', 'D0048', 'BERSIH BIJAK SEJAHTERA', 1, '0', '', '2001-01-01 00:00:00'),
(83, 'SY2211-0043', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:14:22', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '706253310.00', '706253310.00', '0', 'D0025', 'SREEYA SEWU INDONESIA', 1, '0', '', '2001-01-01 00:00:00'),
(84, 'SY2211-0044', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:15:21', '0.00', '0.00', '', 'Y', 'GP001', 'GAPLEK', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '38485000.00', '38485000.00', '0', 'D0006', 'CARGILL-PURWODADI', 1, '0', '', '2001-01-01 00:00:00'),
(85, 'SY2211-0045', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'GCU01', 'GERBANG CAHAYA UTAMA', 'JAKARTA', 'JAKARTA', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:16:07', '0.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1166904000.00', '788438250.00', '0', 'D0025', 'SREEYA SEWU INDONESIA', 1, '0', '', '2001-01-01 00:00:00'),
(86, 'SY2211-0046', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'ANT001', 'ANEKA NIAGA TANI', 'GAJI', 'TUBAN', 'PINDAH PROGRAM', '1', 'Superadmin', 'SO', '2022-11-30 13:16:57', '0.00', '0.00', '', 'Y', 'GP001', 'GAPLEK', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '96224959.00', '96224959.00', '0', 'D0017', 'GOLD COIN INDONESIA', 1, '0', '', '2001-01-01 00:00:00'),
(87, 'SY2212-0001', '', '2022-12-02', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'NYUTIN', 'SO', '2022-12-02 08:06:37', '4525000000.00', '131835.00', '', 'Y', 'JG001', 'JAGUNG', '1000000.00', '4525.00', '0.00', '0.00', '0.00', '868165.00', '7515247210.64', '1968694545.75', '0', 'D0027', 'WIRIFA SAKTI', 0, '0', '', '2001-01-01 00:00:00'),
(88, 'SY2212-0002', '', '2022-12-01', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'SHELVI', 'SO', '2022-12-03 03:56:49', '12551000.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '3260.00', '3850.00', '0.00', '0.00', '0.00', '3260.00', '25102000.00', '12551000.00', '0', 'D0028', 'GUDANG JENU', 1, '0', '', '2001-01-01 00:00:00'),
(89, 'SY2212-0003', '', '2022-12-02', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'IMEL', 'SO', '2022-12-04 03:47:50', '11115000.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '2850.00', '3900.00', '0.00', '0.00', '0.00', '2850.00', '22249500.00', '11115000.00', '0', 'D0028', 'GUDANG JENU', 1, '0', '', '2001-01-01 00:00:00'),
(90, 'SY2211-0047', '', '2022-11-01', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'NYUTIN', 'SO', '2022-12-04 08:09:36', '2128500000.00', '237055.00', '', 'Y', 'JG001', 'JAGUNG', '500000.00', '4257.00', '0.00', '0.00', '0.00', '262945.00', '2179692127.80', '0.00', '0', 'D0025', 'SREEYA SEWU INDONESIA', 0, '0', '', '2001-01-01 00:00:00'),
(91, 'SY2212-0004', '', '2022-12-03', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'IMEL', 'SO', '2022-12-04 10:34:14', '11817000.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '3030.00', '3900.00', '0.00', '0.00', '0.00', '3030.00', '23518500.00', '11682000.00', '0', 'D0028', 'GUDANG JENU', 1, '0', '', '2001-01-01 00:00:00'),
(92, 'SY2212-0005', '', '2022-12-05', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '0', 'NYUTIN', 'SO', '2022-12-06 02:21:19', '2250000000.00', '500000.00', '', 'Y', 'JG001', 'JAGUNG', '500000.00', '4500.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0031', 'SINAR INDOCHEM SEMARANG', 0, '0', '', '2001-01-01 00:00:00'),
(95, 'SY2212-0006', '', '2022-12-09', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'NYUTIN', 'SO', '2022-12-11 01:14:08', '2275000000.00', '285560.00', '', 'Y', 'JG001', 'JAGUNG', '500000.00', '4550.00', '0.00', '0.00', '0.00', '214440.00', '1493973713.05', '0.00', '0', 'D0009', 'CPI-SEMARANG', 0, '0', '', '2001-01-01 00:00:00'),
(96, 'SY2212-0007', '', '2022-12-08', '0', '2001-01-01', '', '12/2022', 'PSB001', 'PUTRA SUKSES BERSAMA', 'KEDIRI', 'KEDIRI', '', '1', 'NYUTIN', 'SO', '2022-12-11 01:25:24', '45687500.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '10750.00', '4250.00', '0.00', '0.00', '0.00', '10750.00', '45322000.00', '45322000.00', '0', 'D0049', 'MALINDO-SURABAYA', 1, '0', '', '2001-01-01 00:00:00'),
(98, 'SY2211-0048', '', '2022-11-30', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'NYUTIN', 'SO', '2022-12-15 09:33:08', '391515000.00', '58260.00', '', 'Y', 'GP001', 'GAPLEK', '91050.00', '4300.00', '0.00', '0.00', '0.00', '32790.00', '191518500.00', '95736000.00', '0', 'D0006', 'CARGILL-PURWODADI', 0, '0', '', '2001-01-01 00:00:00'),
(99, 'SY2212-0008', '', '2022-12-11', '0', '2001-01-01', '', '12/2022', 'PSB001', 'PUTRA SUKSES BERSAMA', 'KEDIRI', 'KEDIRI', '', '1', 'MELINDA', 'SO', '2022-12-17 02:07:34', '47557500.00', '0.00', '', 'Y', 'JG001', 'JAGUNG', '11190.00', '4250.00', '0.00', '0.00', '0.00', '11190.00', '90901069.80', '45448185.00', '0', 'D0049', 'MALINDO-SURABAYA', 1, '0', '', '2001-01-01 00:00:00'),
(100, 'SY2211-0049', '', '2022-11-11', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '0', 'NYUTIN', 'SO', '2022-12-21 09:01:24', '4050000000.00', '1000000.00', '', 'Y', 'JG001', 'JAGUNG', '1000000.00', '4050.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0025', 'SREEYA SEWU INDONESIA', 0, '0', '', '2001-01-01 00:00:00'),
(101, 'SY2211-0050', '', '2022-11-24', '0', '2001-01-01', '', '11/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '0', 'NYUTIN', 'SO', '2022-12-21 09:03:02', '4300000000.00', '1000000.00', '', 'Y', 'JG001', 'JAGUNG', '1000000.00', '4300.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0025', 'SREEYA SEWU INDONESIA', 0, '0', '', '2001-01-01 00:00:00'),
(102, 'SY2212-0009', '', '2022-12-20', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '1', 'NYUTIN', 'SO', '2022-12-21 09:04:49', '7275000000.00', '1500000.00', '', 'Y', 'JG001', 'JAGUNG', '1500000.00', '4850.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0034', 'GOLD COIN-BEKASI', 0, '0', '', '2001-01-01 00:00:00'),
(103, 'SY2212-0010', '', '2022-12-20', '0', '2001-01-01', '', '12/2022', 'AMN001', 'ANGKASA MITRA NIAGA', 'BLORA', 'BLORA', '', '0', 'NYUTIN', 'SO', '2022-12-21 09:07:40', '3254250000.00', '750000.00', '', 'Y', 'JG001', 'JAGUNG', '750000.00', '4339.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0030', 'MALINDO-GROBOGAN', 0, '0', '', '2001-01-01 00:00:00'),
(104, 'SY2212-0011', '', '2022-12-14', '0', '2001-01-01', '', '12/2022', 'ANT001', 'ANEKA NIAGA TANI', 'GAJI', 'TUBAN', '', '1', 'NYUTIN', 'SO', '2022-12-21 09:46:33', '174000000.00', '8760.00', '', 'Y', 'GP001', 'GAPLEK', '40000.00', '4350.00', '0.00', '0.00', '0.00', '31240.00', '271418250.00', '0.00', '0', 'D0017', 'GOLD COIN INDONESIA', 0, '0', '', '2001-01-01 00:00:00'),
(105, 'SY2212-0012', '', '2022-12-21', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '0', 'NYUTIN', 'SO', '2022-12-22 03:38:29', '2275000000.00', '500000.00', '', 'Y', 'JG001', 'JAGUNG', '500000.00', '4550.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0009', 'CPI-SEMARANG', 0, '0', '', '2001-01-01 00:00:00'),
(106, 'SY2212-0013', '', '2022-12-26', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '0', 'NYUTIN', 'SO', '2022-12-26 08:38:10', '4500000000.00', '1000000.00', '', 'Y', 'JG001', 'JAGUNG', '1000000.00', '4500.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0027', 'WIRIFA SAKTI', 0, '0', '', '2001-01-01 00:00:00'),
(107, 'SY2212-0014', '', '2022-12-21', '0', '2001-01-01', '', '12/2022', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '0', 'NYUTIN', 'SO', '2022-12-30 07:07:51', '4500000000.00', '1000000.00', '', 'Y', 'JG001', 'JAGUNG', '1000000.00', '4500.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0025', 'SREEYA SEWU INDONESIA', 0, '0', '', '2001-01-01 00:00:00'),
(108, 'SY2301-0001', '', '2023-01-12', '0', '2001-01-01', '', '01/2023', 'SP001', 'SANDANG PANGAN', 'GAJI', 'TUBAN', '', '0', 'NYUTIN', 'SO', '2023-01-17 01:16:19', '2350000000.00', '500000.00', '', 'Y', 'JG001', 'JAGUNG', '500000.00', '4700.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0', 'D0018', 'NEW HOPE KLETEK', 0, '0', '', '2001-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `so_check`
--

CREATE TABLE `so_check` (
  `no_id` int(13) NOT NULL,
  `no_bukti` varchar(20) NOT NULL DEFAULT '',
  `tipe` varchar(5) NOT NULL DEFAULT '',
  `username` varchar(20) NOT NULL DEFAULT '',
  `tg_smp` datetime DEFAULT '2001-01-01 00:00:00',
  `lat` decimal(9,6) NOT NULL DEFAULT 0.000000,
  `lng` decimal(9,6) NOT NULL DEFAULT 0.000000,
  `foto` longtext NOT NULL,
  `ttd` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `so_check`
--

INSERT INTO `so_check` (`no_id`, `no_bukti`, `tipe`, `username`, `tg_smp`, `lat`, `lng`, `foto`, `ttd`) VALUES
(22, 'APA', 'IN', 'edwin', '2023-03-04 09:59:16', '-8.639226', '115.182865', 'coba mati gps', ''),
(23, 'APA', 'IN', 'edwin', '2023-03-04 09:59:37', '-8.639226', '115.182865', 'coba mati gps', ''),
(63, 'soooo', 'IN', 'edwin', '2023-03-05 10:57:44', '-8.609552', '115.198267', 'foto_soooo_20230305-1054_edwin_IN.jpeg', 'ttd_soooo_20230305-1054_edwin_IN.png'),
(82, 'SO123', 'IN', 'edwin', '2023-03-05 11:57:10', '-8.609551', '115.198266', 'foto_SO123_20230305-1157_edwin_IN.jpeg', 'ttd_SO123_20230305-1157_edwin_IN.png'),
(83, 'SO123', 'OUT', 'edwin', '2023-03-05 11:57:21', '-8.609551', '115.198266', 'foto_SO123_20230305-1157_edwin_OUT.jpeg', 'ttd_SO123_20230305-1157_edwin_OUT.png'),
(84, 'ok', 'IN', 'edwin', '2023-03-05 13:40:20', '-8.609550', '115.198265', '', 'ttd__20230305-1338_edwin_IN.png'),
(85, 'oka', 'IN', 'edwin', '2023-03-05 13:43:23', '-8.609550', '115.198265', '', 'ttd__20230305-1338_edwin_IN.png'),
(86, 'yes', 'IN', 'edwin', '2023-03-05 13:44:03', '-8.609625', '115.198338', '', ''),
(87, 'yes', 'OUT', 'edwin', '2023-03-05 13:44:21', '-8.609625', '115.198338', '', 'ttd_yes_20230305-1344_edwin_OUT.png'),
(88, 'yes', 'IN', 'edwin', '2023-03-05 13:44:35', '-8.609625', '115.198338', '', 'ttd_.png'),
(89, 'yes', 'OUT', 'edwin', '2023-03-05 13:44:47', '-8.609625', '115.198338', '', 'ttd_yes_20230305-1344_edwin_OUT.png'),
(90, 'yes', 'IN', 'edwin', '2023-03-05 13:45:00', '-8.609625', '115.198338', '', 'ttd_.png'),
(91, 'SY2211-0024', 'IN', 'edwin', '2023-03-05 13:56:51', '-8.609549', '115.198267', 'foto_SY2211-0024_20230305-1356_edwin_IN.jpeg', ''),
(92, 'SY2211-0024', 'OUT', 'edwin', '2023-03-05 13:57:05', '-8.609549', '115.198267', 'foto_SY2211-0024_20230305-1357_edwin_OUT.jpeg', 'ttd_SY2211-0024_20230305-1357_edwin_OUT.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` longtext NOT NULL,
  `email` varchar(30) NOT NULL DEFAULT '',
  `first_name` varchar(20) NOT NULL DEFAULT '',
  `last_name` varchar(20) NOT NULL DEFAULT '',
  `address` varchar(50) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `email`, `first_name`, `last_name`, `address`, `phone`) VALUES
('edwin', '202cb962ac59075b964b07152d234b70', 'halo@ymail.com', '', '', '', '081234567890');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `so`
--
ALTER TABLE `so`
  ADD PRIMARY KEY (`NO_ID`,`NO_BUKTI`),
  ADD UNIQUE KEY `NO_BUKTI` (`NO_BUKTI`) USING BTREE,
  ADD KEY `PER` (`PER`) USING BTREE;

--
-- Indexes for table `so_check`
--
ALTER TABLE `so_check`
  ADD PRIMARY KEY (`no_id`),
  ADD KEY `user` (`username`) USING BTREE,
  ADD KEY `no_bukti` (`no_bukti`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `so`
--
ALTER TABLE `so`
  MODIFY `NO_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `so_check`
--
ALTER TABLE `so_check`
  MODIFY `no_id` int(13) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
