-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 12 Jun 2019 pada 05.20
-- Versi Server: 10.1.22-MariaDB
-- PHP Version: 7.0.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_pos`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `query_fakturtransaksi`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `query_fakturtransaksi` (
`kd_transaksi` varchar(20)
,`kd_barang` varchar(20)
,`nama_barang` varchar(50)
,`harga_satuan` int(11)
,`jumlah` int(15)
,`subtotal` int(20)
,`kd_transaksilaporan` varchar(20)
,`total` int(11)
,`bayar` int(11)
,`kembali` int(11)
,`tanggal` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `query_laporanpasok`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `query_laporanpasok` (
`kd_pasok` varchar(20)
,`kd_barang` varchar(20)
,`nama_barang` varchar(20)
,`jumlah` int(20)
,`tgl` date
,`stok_total` bigint(20) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `query_stoktotal`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `query_stoktotal` (
`kd_barang` varchar(20)
,`stok_total` bigint(20) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `query_total`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `query_total` (
`total_harga` decimal(36,0)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_barang`
--

CREATE TABLE `tb_barang` (
  `kd_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(20) NOT NULL,
  `jenis_barang` varchar(20) NOT NULL,
  `harga_beli` varchar(20) NOT NULL,
  `harga_jual` varchar(20) NOT NULL,
  `stok` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_barang`
--

INSERT INTO `tb_barang` (`kd_barang`, `nama_barang`, `jenis_barang`, `harga_beli`, `harga_jual`, `stok`) VALUES
('12', 'sabun', 'Peralatan Mandi', '2000', '3000', 20),
('13', 'teh gelas', 'Minuman', '1000', '500', 500);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_laporan`
--

CREATE TABLE `tb_laporan` (
  `kd_transaksilaporan` varchar(20) NOT NULL,
  `total` int(11) NOT NULL,
  `bayar` int(11) NOT NULL,
  `kembali` int(11) NOT NULL,
  `tanggal` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pasok`
--

CREATE TABLE `tb_pasok` (
  `kd_pasok` varchar(20) NOT NULL,
  `kd_barang` varchar(20) NOT NULL,
  `nama_barang` varchar(20) NOT NULL,
  `jumlah` int(20) NOT NULL,
  `tgl` date NOT NULL,
  `pemasok` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pemasok`
--

CREATE TABLE `tb_pemasok` (
  `kd_pemasok` varchar(30) NOT NULL,
  `nama_pemasok` varchar(20) NOT NULL,
  `alamat` varchar(20) NOT NULL,
  `nohp` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_pemasok`
--

INSERT INTO `tb_pemasok` (`kd_pemasok`, `nama_pemasok`, `alamat`, `nohp`) VALUES
('11', '22ww', 'aa', 1234),
('12', 'qqq', 'www', 1111),
('z1', 'ridwan', 'bogor', 9876);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pengguna`
--

CREATE TABLE `tb_pengguna` (
  `kd_pengguna` varchar(50) NOT NULL,
  `nama_pengguna` varchar(50) NOT NULL,
  `jk` varchar(10) NOT NULL,
  `nohp` int(12) NOT NULL,
  `jabatan` varchar(20) NOT NULL,
  `username` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_pengguna`
--

INSERT INTO `tb_pengguna` (`kd_pengguna`, `nama_pengguna`, `jk`, `nohp`, `jabatan`, `username`, `password`) VALUES
('12', 'ridwan', 'Pria', 123456789, 'pilih jabatan', 'manager1', 'mana123'),
('123', 'robbi', 'Pria', 90787, 'admin', 'qaz', '123');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_transaksi`
--

CREATE TABLE `tb_transaksi` (
  `kd_transaksi` varchar(20) NOT NULL,
  `kd_barang` varchar(20) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga_satuan` int(11) NOT NULL,
  `jumlah` int(15) NOT NULL,
  `subtotal` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Trigger `tb_transaksi`
--
DELIMITER $$
CREATE TRIGGER `ajukan_barang` AFTER INSERT ON `tb_transaksi` FOR EACH ROW BEGIN
UPDATE tb_barang
set jumlah = jumlah - new.jumlah
WHERE kd_barang=new.kd_barang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `batal_beli` AFTER DELETE ON `tb_transaksi` FOR EACH ROW BEGIN
UPDATE tb_barang
SET jumlah = jumlah + old.jumlah
WHERE kd_barang=old.kd_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur untuk view `query_fakturtransaksi`
--
DROP TABLE IF EXISTS `query_fakturtransaksi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `query_fakturtransaksi`  AS  select `tb_transaksi`.`kd_transaksi` AS `kd_transaksi`,`tb_transaksi`.`kd_barang` AS `kd_barang`,`tb_transaksi`.`nama_barang` AS `nama_barang`,`tb_transaksi`.`harga_satuan` AS `harga_satuan`,`tb_transaksi`.`jumlah` AS `jumlah`,`tb_transaksi`.`subtotal` AS `subtotal`,`tb_laporan`.`kd_transaksilaporan` AS `kd_transaksilaporan`,`tb_laporan`.`total` AS `total`,`tb_laporan`.`bayar` AS `bayar`,`tb_laporan`.`kembali` AS `kembali`,`tb_laporan`.`tanggal` AS `tanggal` from (`tb_transaksi` join `tb_laporan`) where (`tb_transaksi`.`kd_transaksi` = `tb_laporan`.`kd_transaksilaporan`) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `query_laporanpasok`
--
DROP TABLE IF EXISTS `query_laporanpasok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `query_laporanpasok`  AS  select `tb_pasok`.`kd_pasok` AS `kd_pasok`,`tb_pasok`.`kd_barang` AS `kd_barang`,`tb_pasok`.`nama_barang` AS `nama_barang`,`tb_pasok`.`jumlah` AS `jumlah`,`tb_pasok`.`tgl` AS `tgl`,`query_stoktotal`.`stok_total` AS `stok_total` from (`tb_pasok` join `query_stoktotal`) where (`tb_pasok`.`kd_barang` = `query_stoktotal`.`kd_barang`) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `query_stoktotal`
--
DROP TABLE IF EXISTS `query_stoktotal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `query_stoktotal`  AS  select `tb_pasok`.`kd_barang` AS `kd_barang`,(cast(`tb_barang`.`stok` as unsigned) + `tb_pasok`.`jumlah`) AS `stok_total` from (`tb_pasok` join `tb_barang`) where (`tb_pasok`.`kd_barang` = `tb_barang`.`kd_barang`) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `query_total`
--
DROP TABLE IF EXISTS `query_total`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `query_total`  AS  select sum(`tb_transaksi`.`jumlah`) AS `total_harga` from `tb_transaksi` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_barang`
--
ALTER TABLE `tb_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indexes for table `tb_pasok`
--
ALTER TABLE `tb_pasok`
  ADD PRIMARY KEY (`kd_pasok`);

--
-- Indexes for table `tb_pemasok`
--
ALTER TABLE `tb_pemasok`
  ADD PRIMARY KEY (`kd_pemasok`);

--
-- Indexes for table `tb_pengguna`
--
ALTER TABLE `tb_pengguna`
  ADD PRIMARY KEY (`kd_pengguna`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
