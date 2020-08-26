-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 25 Apr 2018 pada 09.38
-- Versi Server: 10.1.16-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aegis`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `identitas`
--

CREATE TABLE `identitas` (
  `nomor_rfid` varchar(10) NOT NULL,
  `identitas_pengguna` varchar(12) NOT NULL,
  `jenis_pengguna` varchar(11) NOT NULL,
  `nama_pengguna` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `identitas`
--

INSERT INTO `identitas` (`nomor_rfid`, `identitas_pengguna`, `jenis_pengguna`, `nama_pengguna`) VALUES
('2529 0889', '41088034', 'Dosen', 'Rafato'),
('501B7FA4', '18215088', 'Mahasiswa', 'Kulin'),
('8E367A89', '18216199', 'Mahasiswa', 'Rayya'),
('C2 0053A3', '51214002', 'Staff', 'Tuti');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengguna_ruangan`
--

CREATE TABLE `pengguna_ruangan` (
  `waktu_masuk` datetime DEFAULT NULL,
  `waktu_keluar` datetime DEFAULT NULL,
  `nomor_rfid` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pengguna_ruangan`
--

INSERT INTO `pengguna_ruangan` (`waktu_masuk`, `waktu_keluar`, `nomor_rfid`) VALUES
(NULL, NULL, '2529 0889'),
(NULL, NULL, '501B7FA4'),
(NULL, NULL, '8E367A89'),
(NULL, NULL, 'C2 0053A3');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `identitas`
--
ALTER TABLE `identitas`
  ADD PRIMARY KEY (`nomor_rfid`),
  ADD KEY `identitas_pengguna` (`identitas_pengguna`),
  ADD KEY `jenis_pengguna` (`jenis_pengguna`),
  ADD KEY `nama_pengguna` (`nama_pengguna`);

--
-- Indexes for table `pengguna_ruangan`
--
ALTER TABLE `pengguna_ruangan`
  ADD PRIMARY KEY (`nomor_rfid`),
  ADD KEY `nomor_rfid` (`nomor_rfid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
