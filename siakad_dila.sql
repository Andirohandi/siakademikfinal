-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2015 at 05:10 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `siakad_dila`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_lulus`(IN `p_kuota` int, IN p_tahun int)
BEGIN
DECLARE done INT DEFAULT FALSE;	
DECLARE a, i INT;

DECLARE cur1 CURSOR for SELECT id_pendaftaran FROM tr_pendaftaran WHERE `status` = 1 and lulus = 0 ORDER BY nilai DESC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

set i = 1;
OPEN cur1;
read_loop : LOOP
FETCH cur1 INTO a;
IF done THEN
LEAVE read_loop;
END IF;
IF i > p_kuota THEN
LEAVE read_loop;
END IF;

UPDATE tr_pendaftaran SET status = 2, lulus = 1, no_urut = i, tahun = p_tahun WHERE id_pendaftaran = a ;



set i = i + 1;

END LOOP;
CLOSE cur1;
UPDATE tr_pendaftaran SET  lulus = 1, tahun = p_tahun WHERE  status = 1 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_seleksi`(IN `p_tahun` INT, IN `p_mulai` INT, IN `p_kelas` INT)
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE a, b, n INT;
	DECLARE m, c, d, e, f, g, k  VARCHAR(100);

	DECLARE cur1 CURSOR FOR SELECT id_pendaftaran, no_urut, name, jenis_kelamin, tempat_lahir, tanggal_lahir, alamat  FROM tr_pendaftaran WHERE STATUS= 2 and tahun = p_tahun and kelas = 0 and reg = 1  ORDER BY nilai DESC ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		
	OPEN cur1;
	read_loop : LOOP
	FETCH cur1 INTO a, b, c, d, e, f, g ;
	IF done THEN 
	LEAVE read_loop;
	END IF;
	UPDATE tr_pendaftaran SET kelas = p_mulai WHERE id_pendaftaran = a ;
	
	SET n = CHAR_LENGTH(b);
	IF n = 1 THEN SET k = CONCAT('00', b);
	ELSEIF n = 2 THEN SET k = CONCAT('0', b);
	ELSE SET k = b;
	END IF;
	SET m = CONCAT(DATE_FORMAT(CURRENT_DATE(), '%y%m'), k  );
	INSERT INTO ref_siswa (nis, id_pendaftaran, kelas, name, jenis_kelamin, tempat_lahir, tanggal_lahir, alamat, active, tahun, username, password) VALUES ( m, a, p_mulai, c, d, e, f , g , 1, p_tahun, m , 12345 );
	set p_mulai = p_mulai + 1;
	if p_mulai > p_kelas THEN
	set p_mulai =  1; 
	END IF;
	
	END LOOP;
	CLOSE cur1;
	
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ref_guru`
--

CREATE TABLE IF NOT EXISTS `ref_guru` (
  `id_guru` int(11) NOT NULL,
  `nm_guru` varchar(30) NOT NULL,
  `alamat` text NOT NULL,
  `telp` varchar(20) NOT NULL,
  `active` int(11) NOT NULL,
  `password` varchar(5) NOT NULL DEFAULT '12345',
  `photo` varchar(200) NOT NULL,
  PRIMARY KEY (`id_guru`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ref_guru`
--

INSERT INTO `ref_guru` (`id_guru`, `nm_guru`, `alamat`, `telp`, `active`, `password`, `photo`) VALUES
(32005, 'NIngrum Soleha, S.Pd', 'jl.dago barat no 10', '08121122290', 1, '12345', 'empat.jpg'),
(9032007, 'Hj. Yoyoh Kadariah, S.Pd.', 'jl.Cilengkrang', '08121228988', 1, '12345', 'empat.jpg'),
(7032005, 'Dra. Dian Chaerany', 'komplek alamanda', '081322098999', 1, '12345', 'tiga.jpg'),
(6031012, 'Slamet Herdiana S, Pd.', 'Jl. Cikadut No. 12', '08198991281', 1, '12345', 'empat.jpg'),
(5012002, 'Siti Komariah, S.Pd.', 'jl.dago barat', '0819881991', 1, '12345', 'empat.jpg'),
(8032015, 'Dra. Eveline Julita Riah', 'Cigadung Barat ', '081821877878', 1, '12345', 'empat.jpg'),
(8021002, 'Nanang Suhartono, S.Pd., MM.', 'jl. cikutra barat no 108', '08180976765', 1, '12345', 'empat.jpg'),
(4122004, 'Hj. Lilis Pudjarawati, S.Pd.', 'jl.cikutra barat ', '08191156111', 1, '12345', 'empat.jpg'),
(9032002, 'Hj. Sri Yulia Widiati, S.Pd.', 'Jl.Ciheulang no 19 ', '081324765655', 1, '12345', 'empat.jpg'),
(2032003, 'Dra. Hj. Eet Rukmini', 'Jl. Cikutra Barat no 100', '081871766567', 1, '12345', 'empat.jpg'),
(122004, 'Sri Muwarni, S.Pd.', 'JL.soekarno hatta no 10 ', '08987887722', 1, '12345', 'empat.jpg'),
(6031006, 'Ade Sunaryo, BA', 'Jl.Jatihandap no 109', '081765516161', 1, '12345', 'empat.jpg'),
(6032009, 'Rasmita Ningsih T., MM.', 'Jl.Padasuka Barat No 10 ', '08180898786', 1, '12345', 'empat.jpg'),
(7011017, 'Supian, S.Ag.', 'Jl.Venus No 10, Soekarno Hatta', '08180987879', 1, '12345', 'empat.jpg'),
(7211069, 'Slamet, S.Ag., M.Mpd.', 'jl.cisangkuy 2 no 10', '0896322222', 1, '12345', 'empat.jpg'),
(8031003, 'Drs. Yohanes Suwarno', 'jl. cisaat no 10 ', '081221435567', 1, '12345', 'empat.jpg'),
(7011020, 'Engkus Warsakusumah, S.Pd.', 'Jl.Cikutra Timur No 10/8', '08122345221', 1, '12345', 'empat.jpg'),
(8032006, 'Dra. Denti Sri Murdianti', 'Jl.Ciheulang Timur No 10b', '081321234456', 1, '12345', 'empat.jpg'),
(1012006, 'Elly Indaryati', 'Jl.Ujung Berung n0 19/c ', '08180898786', 1, '12345', 'empat.jpg'),
(8022002, 'Reni Mariah, S.Pd.', 'Jl.Dago Timur ', '08176166661', 1, '12345', 'empat.jpg'),
(8032003, 'Betti Ariani S., S.Pd.', 'Jl. Cikutra ', '0818089876', 1, '12345', 'empat.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `ref_kelas`
--

CREATE TABLE IF NOT EXISTS `ref_kelas` (
  `id_kelas` int(11) NOT NULL AUTO_INCREMENT,
  `nm_kelas` varchar(20) NOT NULL,
  `tingkat` smallint(3) NOT NULL,
  `jurusan` varchar(20) NOT NULL,
  PRIMARY KEY (`id_kelas`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `ref_kelas`
--

INSERT INTO `ref_kelas` (`id_kelas`, `nm_kelas`, `tingkat`, `jurusan`) VALUES
(1, '7A', 1, ''),
(2, '7B', 1, ''),
(3, '7C', 1, ''),
(4, '7D`', 1, ''),
(5, '7E', 1, ''),
(6, '7F', 1, ''),
(7, '7G', 1, ''),
(8, '7H', 1, ''),
(9, '7I', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `ref_level`
--

CREATE TABLE IF NOT EXISTS `ref_level` (
  `id_level` smallint(6) NOT NULL AUTO_INCREMENT,
  `nm_level` varchar(30) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_level`),
  KEY `uq_id_level` (`id_level`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ref_level`
--

INSERT INTO `ref_level` (`id_level`, `nm_level`, `active`) VALUES
(1, 'System Administrator', 1),
(2, 'Guru', 1),
(3, 'Wali Kelas', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ref_level_menu_access`
--

CREATE TABLE IF NOT EXISTS `ref_level_menu_access` (
  `id_level_menu_access` smallint(6) NOT NULL AUTO_INCREMENT,
  `id_level` smallint(6) DEFAULT NULL,
  `id_menu_details` tinyint(4) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_level_menu_access`),
  KEY `uq_id_level_menu_access` (`id_level_menu_access`) USING BTREE,
  KEY `id_level` (`id_level`),
  KEY `id_menu_details` (`id_menu_details`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=57 ;

--
-- Dumping data for table `ref_level_menu_access`
--

INSERT INTO `ref_level_menu_access` (`id_level_menu_access`, `id_level`, `id_menu_details`, `active`) VALUES
(1, 1, 1, 1),
(9, 1, 7, 1),
(11, 1, 9, 1),
(12, 1, 4, 1),
(13, 1, 11, 1),
(15, 1, 13, 1),
(16, 1, 14, 1),
(17, 1, 15, 1),
(18, 1, 16, 1),
(20, 1, 17, 1),
(21, 1, 18, 1),
(22, 1, 19, 1),
(23, 1, 20, 1),
(26, 7, 23, 1),
(28, 1, 25, 1),
(31, 1, 28, 1),
(32, 1, 2, 1),
(33, 1, 29, 1),
(34, 1, 30, 1),
(35, 1, 31, 1),
(37, 1, 5, 1),
(38, 1, 33, 1),
(40, 1, 36, 0),
(41, 1, 37, 1),
(42, 1, 38, 0),
(43, 1, 39, 1),
(44, 1, 43, 1),
(45, 2, 41, 1),
(46, 1, 42, 1),
(47, 1, 40, 1),
(48, 1, 41, 1),
(49, 2, 43, 1),
(50, 1, 44, 1),
(51, 3, 42, 1),
(53, 1, 45, 1),
(54, 1, 46, 0),
(55, 1, 47, 1),
(56, 1, 48, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ref_menu_details`
--

CREATE TABLE IF NOT EXISTS `ref_menu_details` (
  `id_menu_details` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nm_menu_details` varchar(21) DEFAULT NULL,
  `url` varchar(21) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `position` tinyint(2) NOT NULL DEFAULT '0',
  `id_menu_groups` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_menu_details`),
  KEY `id_menu_groups` (`id_menu_groups`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=48 ;

--
-- Dumping data for table `ref_menu_details`
--

INSERT INTO `ref_menu_details` (`id_menu_details`, `nm_menu_details`, `url`, `active`, `position`, `id_menu_groups`) VALUES
(1, 'Menu Groups', 'menu_groups', 1, 1, 1),
(2, 'Level', 'level', 1, 5, 1),
(4, 'Menu Details', 'menu_details', 1, 2, 1),
(5, 'User', 'user', 1, 4, 1),
(9, 'Menu Access', 'level_menu_access', 1, 3, 1),
(36, 'Tahun Ajaran_', 'calon_siswa', 1, 1, 4),
(37, 'Calon Siswa', 'tahun_ajaran', 1, 2, 4),
(38, 'Daftar Ulang', 'lulus', 0, 3, 4),
(39, 'Mata Pelajaran', 'mapel', 1, 3, 1),
(40, 'Guru', 'guru', 1, 4, 1),
(42, 'Rapot', 'ajaran', 1, 9, 5),
(43, 'Nilai', 'nilai', 1, 1, 3),
(44, 'Kelas', 'kelas', 1, 8, 1),
(45, 'Siswa', 'siswa', 1, 9, 1),
(46, 'Siswa Tidak Lulus', 'lulus/tidak', 0, 4, 4),
(47, 'Siswa Lulus', 'lulus', 1, 5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `ref_menu_groups`
--

CREATE TABLE IF NOT EXISTS `ref_menu_groups` (
  `id_menu_groups` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nm_menu_groups` varchar(21) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `position` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_menu_groups`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ref_menu_groups`
--

INSERT INTO `ref_menu_groups` (`id_menu_groups`, `nm_menu_groups`, `active`, `position`) VALUES
(1, 'Master', 1, 1),
(3, 'Guru', 1, 3),
(4, 'Pendaftaran ', 1, 4),
(5, 'Wali Kelas', 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `ref_pelajaran`
--

CREATE TABLE IF NOT EXISTS `ref_pelajaran` (
  `id_mapel` int(11) NOT NULL AUTO_INCREMENT,
  `id_guru` int(11) NOT NULL,
  `nm_pelajaran` varchar(20) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_mapel`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `ref_pelajaran`
--

INSERT INTO `ref_pelajaran` (`id_mapel`, `id_guru`, `nm_pelajaran`, `active`) VALUES
(2, 32005, 'Seni Budaya', 1),
(5, 7032005, 'bahasa indonesia', 1),
(4, 9032007, 'Seni Budaya', 1),
(6, 6031012, 'bahasa indonesia', 1),
(7, 5012002, 'bahasa indonesia', 1),
(8, 8032003, 'Bahasa Inggris', 1),
(9, 7032005, 'MATEMATIKA', 1),
(10, 8021002, 'MATEMATIKA', 1),
(11, 4122004, 'IPA', 0),
(12, 9032002, 'IPA', 1),
(13, 2032003, 'IPS', 1),
(14, 6031006, 'PKN ', 1),
(15, 6032009, 'IPS', 1),
(16, 7011017, 'PAI', 1),
(17, 7211069, 'PAI', 1),
(18, 8031003, 'PENJASKES', 1),
(19, 7011020, 'TIK', 1),
(3, 8032006, 'B.Sunda', 1),
(1, 8022002, 'BP', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ref_siswa`
--

CREATE TABLE IF NOT EXISTS `ref_siswa` (
  `nis` varchar(20) NOT NULL,
  `id_pendaftaran` int(11) NOT NULL AUTO_INCREMENT,
  `kelas` tinyint(2) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `jenis_kelamin` varchar(6) DEFAULT NULL,
  `tempat_lahir` varchar(30) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat` text,
  `tahun` smallint(4) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `id_level` tinyint(1) NOT NULL DEFAULT '4',
  `photo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_pendaftaran`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2665 ;

--
-- Dumping data for table `ref_siswa`
--

INSERT INTO `ref_siswa` (`nis`, `id_pendaftaran`, `kelas`, `name`, `username`, `password`, `jenis_kelamin`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `tahun`, `active`, `id_level`, `photo`) VALUES
('101170001', 2332, 1, 'ADE DISMA FAISHAL', '101170001', '12345', 'Pria', 'Bandung', '2002-03-04', 'Jl. Ekologi Komplek Unpad 2', 2010, 1, 4, 'empat.jpg'),
('101170038', 2333, 2, 'AI SITI ROHAETI', '101170038', '12345', 'Wanita', 'Garut', '2002-10-02', 'Sukasari 2', 2010, 1, 4, ''),
('101170076', 2334, 3, 'AJENG SOLIHAT', '101170076', '12345', 'Wanita', 'Bandung', '2002-03-12', 'Sekemirung Kidul', 2010, 1, 4, ''),
('101170114', 2335, 4, 'AMELIA DWI CHANDHARY', '101170114', '12345', 'Wanita', 'Bandung', '2001-11-03', 'Babakan Sembung', 2010, 1, 4, ''),
('101170152', 2336, 5, 'ANNISA FATIMAH AZZAHRA', '101170152', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170191', 2337, 6, 'ARDJIDAN RENANDA PUTRA', '101170191', '12345', 'Pria', 'Bandung', '2002-02-05', 'Kp. Pasirkaliki Tengah', 2010, 1, 4, ''),
('101170229', 2338, 7, 'ASHARI SUKMA MUSTAQIM', '101170229', '12345', 'Pria', 'Bandung', '2002-04-08', 'Jl. Pelesiran No. 58 blok 56', 2010, 1, 4, ''),
('101170008', 2339, 1, 'BINNO MARWA SUPONCO', '101170008', '12345', 'Pria', 'Bandung', '2002-02-06', 'Puyuh Dalam II No. 3', 2010, 1, 4, ''),
('101170156', 2340, 5, 'CANDRA ADE RAHAYU', '101170156', '12345', 'Wanita', 'Bandung', '2001-08-21', 'Sadang Sari', 2010, 1, 4, ''),
('101170010', 2341, 1, 'DEWI BANOWATI ARBAINI', '101170010', '12345', 'Wanita', 'Bandung', '2002-01-18', 'Jl. Teuku Umar No/ 71/60', 2010, 1, 4, ''),
('101170048', 2342, 2, 'DINAR AQILA', '101170048', '12345', 'Wanita', 'Bandung', '2002-05-29', 'Cigadung Wetan No. 120', 2010, 1, 4, ''),
('101170159', 2343, 5, 'ELSYA SANIAYU', '101170159', '12345', 'Wanita', 'Bandung', '2002-10-10', 'Jl Tubagus Ismail 3 No. 43', 2010, 1, 4, ''),
('101170086', 2344, 3, 'FAJRIYANTI ANNA RAMADHANI', '101170086', '12345', 'Wanita', 'Bandung', '2002-03-22', 'Bojong Kacor', 2010, 1, 4, ''),
('101170124', 2345, 4, 'FASYA BILLA SUHENDAR', '101170124', '12345', 'Wanita', 'Bandung', '2002-03-29', 'Sekeloa Tengah belakang No. 5', 2010, 1, 4, ''),
('101170161', 2346, 5, 'FAUJIAH NUR SA''ADAH', '101170161', '12345', 'Pria', 'Bandung', '2002-03-01', 'Jl. Sangkuriang Dalam Cisitu Lama', 2010, 1, 4, ''),
('101170052', 2347, 2, 'HANDIFA CAHYANA', '101170052', '12345', 'Pria', 'Bandung', '2002-05-11', 'Pasirkaliki Reuma', 2010, 1, 4, ''),
('101170089', 2348, 3, 'HELZA VIVIA RAMADHANTY', '101170089', '12345', 'Wanita', 'Bandung', '2001-11-18', 'Jl. Sekeloa Tengah No. 117/152 B', 2010, 1, 4, ''),
('101170128', 2349, 4, 'IWAN FEROLOY S.', '101170128', '12345', 'Pria', 'Bandung', '2001-09-01', 'Bojong Tengah', 2010, 1, 4, ''),
('101170018', 2350, 1, 'JUWONO SAPUTRA', '101170018', '12345', 'Pria', 'Bandung', '2002-08-09', 'Jl. Caladi Dalam No. 85/151 C', 2010, 1, 4, ''),
('101170055', 2351, 2, 'KINANTI SALSABILA RAHMANNISYA', '101170055', '12345', 'Wanita', 'Bandung', '2001-12-22', 'Cibeunying Hegar IV No. 1', 2010, 1, 4, ''),
('101170245', 2352, 7, 'MUHAMAD FADILAH', '101170245', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170282', 2353, 8, 'MUHAMAD YUSUP SUPRIADI', '101170282', '12345', 'Pria', 'Bandung', '2002-01-26', 'Jl. Cigadung Wetan No. 108', 2010, 1, 4, ''),
('101170316', 2354, 9, 'MUHAMMAD FADHIL ALAMSYAH', '101170316', '12345', 'Pria', 'Bandung', '2002-01-10', 'Jl. Sadang Tengah IV No. 9', 2010, 1, 4, ''),
('101170023', 2355, 1, 'MUHAMMAD RAIHAN', '101170023', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170318', 2356, 9, 'NAFA NURANISYA', '101170318', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170024', 2357, 1, 'NENG MILA MIRNAWATI', '101170024', '12345', 'Wanita', 'Garut', '2002-09-05', 'Jl. Dago Giri No.37', 2010, 1, 4, ''),
('101170063', 2358, 2, 'NOVA NOVIYANTI', '101170063', '12345', 'Wanita', 'Bandung', '2001-11-15', 'Jl. Puyuh Dalam No. 138/151 A', 2010, 1, 4, ''),
('101170064', 2359, 2, 'R M RAFLY DWITAMA ARYA AGUNG', '101170064', '12345', 'Pria', 'Bandung', '2003-07-09', 'Jl. Sadang Hegar Palm I No. 1A', 2010, 1, 4, ''),
('101170102', 2360, 3, 'RERRY NOER IMAN', '101170102', '12345', 'Pria', 'Bandung', '2002-01-16', 'Sadang Sari Gg. Intan III No. 31', 2010, 1, 4, ''),
('101170141', 2361, 4, 'ROSA ADERSA', '101170141', '12345', 'Wanita', 'Garut', '2001-11-20', 'Jl Rancakalong', 2010, 1, 4, ''),
('101170178', 2362, 5, 'RUDY ANTORO', '101170178', '12345', 'Pria', 'Bandung', '2001-08-16', 'CIbuntu Awiligar', 2010, 1, 4, ''),
('101170180', 2363, 5, 'SEPRIANA ROSMAIDA', '101170180', '12345', 'Wanita', 'Bandung', '2002-06-22', 'Kp. Cibeunying I', 2010, 1, 4, ''),
('101170218', 2364, 6, 'SHEREN SETIAMANA PUTRI', '101170218', '12345', 'Wanita', 'Bandung', '2002-08-11', 'Jl. Babakan Sembung No. 154', 2010, 1, 4, ''),
('101170293', 2365, 8, 'TEDDY RAHMAT GUNAWAN', '101170293', '12345', 'Pria', 'Bandung', '2002-05-29', 'Dago tengah No. 20/161 C', 2010, 1, 4, ''),
('101170184', 2366, 5, 'YUSSI SUSILAWATI', '101170184', '12345', 'Wanita', 'Bandung', '2001-09-06', 'Jl. Sekemirung No. 13 D', 2010, 1, 4, ''),
('101170221', 2367, 6, 'YUTIKA KHAIRUNNISA', '101170221', '12345', 'Wanita', 'Bandung', '2002-06-13', 'Jl. Sekeloa Timur I No. 15', 2010, 1, 4, ''),
('101170111', 2368, 3, 'ZAHRA AZKYIA NABILA', '101170111', '12345', 'Wanita', 'Bandung', '2001-12-07', 'Sukamantri I No. 51/144 F', 2010, 1, 4, ''),
('101170260', 2369, 8, 'AGUS MULYANA', '101170260', '12345', 'Pria', 'Bandung', '2001-08-09', 'Jl. Bagus Rangin 3 No. 138/50 B', 2010, 1, 4, ''),
('101170298', 2370, 9, 'ALEXANDRA GRACEY ZANETTA', '101170298', '12345', 'Wanita', 'Bandung', '2002-08-17', 'Gg. Menara Air 3 no. 9', 2010, 1, 4, ''),
('101170005', 2371, 1, 'AL-FATH SHOHIBULWAFA S', '101170005', '12345', 'Pria', 'Bandung', '2002-01-12', 'Jl. Cikutra Barat Gg. Bojong', 2010, 1, 4, ''),
('101170042', 2372, 2, 'ALIEF MAULANA SOPHIAN', '101170042', '12345', 'Pria', 'Bogor', '2002-06-19', 'Kp. Sekemirung', 2010, 1, 4, ''),
('101170080', 2373, 3, 'ALVIAN PRATAMA', '101170080', '12345', 'Pria', 'Bandung', '2001-07-23', 'JL. Tubagus ismail Bawah', 2010, 1, 4, ''),
('101170118', 2374, 4, 'AULIA ARIZONA DIDONG', '101170118', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170155', 2375, 5, 'AYU YASINTA QAULAM FADILLAH', '101170155', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170083', 2376, 3, 'DAMAR WULAN PUSPITALOKA', '101170083', '12345', 'Wanita', 'Bandung', '2003-03-21', 'Jl. Sekeloa Utara No. 222', 2010, 1, 4, ''),
('101170120', 2377, 4, 'DESTRI MARVIANI', '101170120', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170157', 2378, 5, 'DESWIYA NURUL AZZAHRA', '101170157', '12345', 'Wanita', 'Bandung', '2001-12-01', 'Jl. Tubagus Ismail Dalam', 2010, 1, 4, ''),
('101170196', 2379, 6, 'ELVINA MULYANI', '101170196', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170198', 2380, 6, 'FIRLLY ANGGRAENI CAHYANINGRUM', '101170198', '12345', 'Wanita', 'Surabaya', '2002-04-24', 'Jl. Dipati Ukur No. 64 A/248', 2010, 1, 4, ''),
('101170199', 2381, 6, 'GHINA KAMILATHINNAJAH', '101170199', '12345', 'Wanita', 'Bandung', '2002-03-31', 'Jl. Cisitu Indah Dalam No. 19 B/160 C', 2010, 1, 4, ''),
('101170126', 2382, 4, 'HANDIKA PRIYADI', '101170126', '12345', 'Pria', 'Bandung', '2002-01-17', 'Kp. Simpang Dago', 2010, 1, 4, ''),
('101170165', 2383, 5, 'IRMAN NUGRAHA', '101170165', '12345', 'Pria', 'Bandung', '2002-05-05', 'Cikondang', 2010, 1, 4, ''),
('101170092', 2384, 3, 'KARMELIA PUTRI', '101170092', '12345', 'Wanita', 'Bandung', '2001-10-07', 'Ligar Jaya Dalam', 2010, 1, 4, ''),
('101170129', 2385, 4, 'KRISNA ADLI HAFIDZ', '101170129', '12345', 'Pria', 'Bandung', '2002-05-16', 'Gg. Mars Dirgahayu No. 18 Awiligar', 2010, 1, 4, ''),
('101170277', 2386, 8, 'LEGIA WATI OKTAVIANI S.', '101170277', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170313', 2387, 9, 'LINA KANIA DEWI', '101170313', '12345', 'Wanita', 'Bandung', '2001-03-24', 'Jl. Lamping Situ', 2010, 1, 4, ''),
('101170019', 2388, 1, 'LYRA ANNISYA FASYA', '101170019', '12345', 'Wanita', 'Bandung', '2002-03-14', 'Jl. Cikutra Barat Gg. Cikondang IV', 2010, 1, 4, ''),
('101170057', 2389, 2, 'MIA LIANA', '101170057', '12345', 'Wanita', 'Bandung', '2001-08-06', 'Jl. Gagak Dalam', 2010, 1, 4, ''),
('101170096', 2390, 3, 'MITA ARIANDINI SURYADI', '101170096', '12345', 'Wanita', 'Bandung', '2002-05-31', 'Jl. Banbayang Timur No. 151/157 C', 2010, 1, 4, ''),
('101170133', 2391, 4, 'MOCHAMMAD AMZAR AZHARI', '101170133', '12345', 'Pria', 'Bandung', '2001-05-21', 'Cibeunying kolot', 2010, 1, 4, ''),
('101170169', 2392, 5, 'MUHAMAD RAFLI', '101170169', '12345', 'Pria', 'Bandung', '2001-12-31', 'Jl. tubagus Ismail Raya No. 31', 2010, 1, 4, ''),
('101170207', 2393, 6, 'MUHAMMAD FAZA DINAN HAKIM', '101170207', '12345', 'Pria', 'Bandung', '2001-10-21', 'Kp. Sukasari I No. 42', 2010, 1, 4, ''),
('101170100', 2394, 3, 'NUR ANNISA NOVIYANTI', '101170100', '12345', 'Wanita', 'Bandung', '2001-11-07', 'Jl. Sekeloa tengah', 2010, 1, 4, ''),
('101170137', 2395, 4, 'ORLANA DEVINA', '101170137', '12345', 'Wanita', 'Bandung', '2002-06-12', 'Kp. Pasirkalkik Tengah No.192', 2010, 1, 4, ''),
('101170214', 2396, 6, 'RIA APRIYANI', '101170214', '12345', 'Wanita', 'Bandung', '2002-04-10', 'Kp. Cibeunying I no. 41', 2010, 1, 4, ''),
('101170249', 2397, 7, 'RICINTA GADISTA', '101170249', '12345', 'Wanita', 'Bandung', '2002-04-22', 'Gg. Cikondang', 2010, 1, 4, ''),
('101170288', 2398, 8, 'RIFKY PRAMUDITA NURISYANTO', '101170288', '12345', 'Pria', 'Bandung', '2002-08-13', 'Jl. Cigadung Raya Timur Sekmir', 2010, 1, 4, ''),
('101170324', 2399, 9, 'RIO NAZAAR PRAYOGA', '101170324', '12345', 'Pria', 'Bandung', '2001-11-06', 'Jl. Gagak Gg. Reuma Kidul II', 2010, 1, 4, ''),
('101170030', 2400, 1, 'RIZKI SADIKIN', '101170030', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170253', 2401, 7, 'SALSABILAH NURFADILAH', '101170253', '12345', 'Wanita', 'Bandung', '2001-01-02', 'Cibeunying Kolot', 2010, 1, 4, ''),
('101170291', 2402, 8, 'SEPPYAN IRAWAN', '101170291', '12345', 'Pria', 'Bandung', '2002-09-12', 'Pasirkaliki Barat', 2010, 1, 4, ''),
('101170328', 2403, 9, 'SINTA DESIYANA', '101170328', '12345', 'Wanita', 'Bandung', '2001-08-31', 'Bojong Mekar', 2010, 1, 4, ''),
('101170220', 2404, 6, 'VEDIA WANTI KUSUMAH', '101170220', '12345', 'Wanita', 'Bandung', '2002-09-03', 'Jl. Taman Sari No. 98 A/96', 2010, 1, 4, ''),
('101170258', 2405, 7, 'YUNITA AMDANI', '101170258', '12345', 'Wanita', 'Bandung', '2002-06-05', 'Jl. Kubang Selatan No. 92', 2010, 1, 4, ''),
('101170148', 2406, 4, 'ZHAHRA BEBIE ANGGISTIE', '101170148', '12345', 'Wanita', 'Bandung', '2001-08-24', 'Jl. Sekeloa Utara No. 156 A/152 C', 2010, 1, 4, ''),
('101170186', 2407, 6, 'ADISTIO RAMADANNA', '101170186', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170223', 2408, 7, 'AISWARAI DIVA AISHA SALSABILHA', '101170223', '12345', 'Wanita', 'Bandung', '2002-04-25', 'Gg. Menara Air No. 1A', 2010, 1, 4, ''),
('101170262', 2409, 8, 'ANISSA NUR FITRIYANI', '101170262', '12345', 'Wanita', 'Bandung', '2001-12-12', 'Jl. Cibeunying Kolot No. 42', 2010, 1, 4, ''),
('101170194', 2410, 6, 'DANDI PRATAMA', '101170194', '12345', 'Pria', 'Bandung', '2002-01-18', 'Jl. Cikutra Barat', 2010, 1, 4, ''),
('101170231', 2411, 7, 'DELLA SAFITRI IBRAHIM', '101170231', '12345', 'Wanita', 'Bandung', '2001-12-17', 'Kp. Pasirkaliki Tengah No. 192', 2010, 1, 4, ''),
('101170269', 2412, 8, 'DIFA ERIKA MEILANI', '101170269', '12345', 'Wanita', 'Bandung', '2002-05-10', 'Pasirkaliki Reuma', 2010, 1, 4, ''),
('101170233', 2413, 7, 'ECA', '101170233', '12345', 'Wanita', 'Sumedang', '2002-03-16', 'Jl. Gama No. 35', 2010, 1, 4, ''),
('101170234', 2414, 7, 'FAHMI ROHIDIN', '101170234', '12345', 'Pria', 'Bandung', '2001-09-12', 'Jl. Tubagus Ismail Babakan Sembung 110 B', 2010, 1, 4, ''),
('101170272', 2415, 8, 'FARIS AMRAN SAMUDERA', '101170272', '12345', 'Pria', 'Bandung', '2002-04-17', 'Cigadung Wetan', 2010, 1, 4, ''),
('101170308', 2416, 9, 'FIKRI PURNOMO', '101170308', '12345', 'Pria', 'Bandung', '2002-10-29', 'Awiligar', 2010, 1, 4, ''),
('101170013', 2417, 1, 'FINA WIDA NINGSIH', '101170013', '12345', 'Wanita', 'Bandung', '2002-04-17', 'Jl. Legok Hiris', 2010, 1, 4, ''),
('101170236', 2418, 7, 'GAZA KARIM AMRULLOH', '101170236', '12345', 'Pria', 'Bandung', '2002-08-22', 'Jl. Cukang Kawung', 2010, 1, 4, ''),
('101170163', 2419, 5, 'HAIRIL AL-KHOIRIZKI', '101170163', '12345', 'Pria', 'Bandung', '2002-06-05', 'Jl. Bangbayang Timur 131/157 C', 2010, 1, 4, ''),
('101170201', 2420, 6, 'ILMA HAKIMA RAHMANI PUTRI', '101170201', '12345', 'Wanita', 'Bandung', '2002-06-27', 'Jl. Sadang Luhur V No. 05', 2010, 1, 4, ''),
('101170166', 2421, 5, 'KAMILA NURAENI', '101170166', '12345', 'Wanita', 'Bandung', '2001-09-13', 'Jiwanaya', 2010, 1, 4, ''),
('101170056', 2422, 2, 'LIANI', '101170056', '12345', 'Wanita', 'Bandung', '2002-05-17', 'Sadang Sari', 2010, 1, 4, ''),
('101170242', 2423, 7, 'MALIK HANIF SUDRAJAT', '101170242', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170280', 2424, 8, 'MUHAMAD HILAL LUTHFI', '101170280', '12345', 'Pria', 'Bandung', '2002-04-18', 'Dago elos I No. 179', 2010, 1, 4, ''),
('101170317', 2425, 9, 'MUHAMMAD FAKHRI RAMADHAN', '101170317', '12345', 'Pria', 'Bandung', '2001-11-12', 'Jl. Sadang luhur I No. 8', 2010, 1, 4, ''),
('101170022', 2426, 1, 'MUHAMMAD ILYAS MUHARIZKI', '101170022', '12345', 'Pria', 'Banyumas', '2002-09-02', 'Jl. Babakan Sari 3', 2010, 1, 4, ''),
('101170135', 2427, 4, 'NABILA AZZAHRA', '101170135', '12345', 'Wanita', 'Bandung', '2002-10-31', 'Jl. Cibeunying Kolot III No. 23', 2010, 1, 4, ''),
('101170065', 2428, 2, 'RADIKA MIRZA RADYASMARA', '101170065', '12345', 'Pria', 'Bandung', '1999-08-06', 'Sadang Luhur No. 56', 2010, 1, 4, ''),
('101170104', 2429, 3, 'RIZAL PUTRA JUHARI', '101170104', '12345', 'Pria', 'Bandung', '2002-08-13', 'Cibeunying Kolot', 2010, 1, 4, ''),
('101170140', 2430, 4, 'RIZKI MAULANA', '101170140', '12345', 'Pria', 'Bandung', '2002-03-08', 'Pasirkaliki Timur Gagak', 2010, 1, 4, ''),
('101170177', 2431, 5, 'ROSITA', '101170177', '12345', 'Wanita', 'Bandung', '2001-11-07', 'Babakan Sembung', 2010, 1, 4, ''),
('101170032', 2432, 1, 'SALSHA SEPTYANI', '101170032', '12345', 'Wanita', 'Bandung', '2002-09-30', 'Jl. Sekeloa No. 125/152 C', 2010, 1, 4, ''),
('101170069', 2433, 2, 'SANTI DESIYANI', '101170069', '12345', 'Wanita', 'Bandung', '2001-12-31', 'Bojong Mekar', 2010, 1, 4, ''),
('101170106', 2434, 3, 'SASHA GARWA GANTIRA', '101170106', '12345', 'Wanita', 'Bandung', '2002-11-27', 'Jl. Haur Pancuh No.25', 2010, 1, 4, ''),
('101170145', 2435, 4, 'SILMI NUR FADHILAH', '101170145', '12345', 'Wanita', 'Bandung', '2002-09-11', 'Pasirkaliki Tengah', 2010, 1, 4, ''),
('101170182', 2436, 5, 'SITI MUSTIKA PURNAMA SARI', '101170182', '12345', 'Wanita', 'Bandung', '2002-06-27', 'Jl. Sekeloa tengah', 2010, 1, 4, ''),
('101170219', 2437, 6, 'SITI NUR AZIZAH', '101170219', '12345', 'Wanita', 'Bandung', '2001-10-18', 'Cigadung Raya Timur No. 55', 2010, 1, 4, ''),
('101170255', 2438, 7, 'SITI ROHMAH', '101170255', '12345', 'Wanita', 'Tasikmalaya', '2001-12-04', 'Kp. Pasirkaliki Tengah', 2010, 1, 4, ''),
('101170329', 2439, 9, 'TAUFIK MAULANA', '101170329', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170257', 2440, 7, 'VIERA AMANDA', '101170257', '12345', 'Wanita', 'Bandung', '2002-01-16', 'Jl. Bojong Kaler', 2010, 1, 4, ''),
('101170295', 2441, 8, 'YANUAR AHADI', '101170295', '12345', 'Pria', 'Bandung', '2002-01-20', 'Babakan Sembung', 2010, 1, 4, ''),
('101170185', 2442, 5, 'ZALFA CHELLINDA', '101170185', '12345', 'Wanita', 'Bandung', '2001-12-21', 'Sukasari I No. 50', 2010, 1, 4, ''),
('101170296', 2443, 9, 'AFIANDRA TIRTA LEGAWA', '101170296', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170004', 2444, 1, 'AKBAR FAUZY', '101170004', '12345', 'Pria', 'Bandung', '2001-12-15', 'Jl. Mars Dirgahayu Awiligar', 2010, 1, 4, ''),
('101170041', 2445, 2, 'AKBAR RAMADHAN', '101170041', '12345', 'Pria', 'Bandung', '2001-12-05', 'Jl. Dago Elos IV', 2010, 1, 4, ''),
('101170079', 2446, 3, 'ALDY DWI ANANDA SUPRIADI', '101170079', '12345', 'Pria', 'Bandung', '2002-04-06', 'Jl. Pelesiran', 2010, 1, 4, ''),
('101170113', 2447, 4, 'ALFI MUHAMMAD RAMADHAN', '101170113', '12345', 'Pria', 'Pati', '2001-11-27', 'Jl. Sadang Luhur III No. 12', 2010, 1, 4, ''),
('101170151', 2448, 5, 'ANISA RAHMITA', '101170151', '12345', 'Wanita', 'Bandung', '2002-07-16', 'Tubagus Ismail Bawah', 2010, 1, 4, ''),
('101170190', 2449, 6, 'ANUGRAH ROBY YUNIAR R.', '101170190', '12345', 'Pria', 'Bandung', '2002-06-18', 'Sadang Sari No. 39', 2010, 1, 4, ''),
('101170226', 2450, 7, 'ARIEF AL GHIFARI', '101170226', '12345', 'Pria', 'Bandung', '2002-07-09', 'Jl. Bojong kaler', 2010, 1, 4, ''),
('101170264', 2451, 8, 'ASIAH AZ-ZAHRO', '101170264', '12345', 'Wanita', 'Bandung', '2000-10-12', 'Kp. Pasir Koja', 2010, 1, 4, ''),
('101170045', 2452, 2, 'BURHANUDIN', '101170045', '12345', 'Pria', 'Bandung', '2002-04-18', 'Kp. Pasirkoja No. 26', 2010, 1, 4, ''),
('101170304', 2453, 9, 'DEA INDRIANI', '101170304', '12345', 'Wanita', 'Bandung', '2002-07-18', 'Jl. Cisitu Lama Blok F', 2010, 1, 4, ''),
('101170009', 2454, 1, 'DEAS FAZZIRAH PUTRI', '101170009', '12345', 'Wanita', 'Bandung', '2003-03-03', 'Bojong Kacor', 2010, 1, 4, ''),
('101170047', 2455, 2, 'DENI RAHMAT PRATAMA', '101170047', '12345', 'Pria', 'Bandung', '2002-01-19', 'Cisitu Lama', 2010, 1, 4, ''),
('101170050', 2456, 2, 'FADHIL MUHAMMAD AGUNG', '101170050', '12345', 'Pria', 'Bandung', '2002-06-21', 'Jl. Sekeloa utara No. 75/153 A', 2010, 1, 4, ''),
('101170087', 2457, 3, 'FAYRILL TSAQIF DLIYATUL-HAQ', '101170087', '12345', 'Pria', 'Bandung', '2002-06-17', 'Jl. Cisitu Lama I No. 90/154 C', 2010, 1, 4, ''),
('101170125', 2458, 4, 'FITRI DEWI LESTARI', '101170125', '12345', 'Wanita', 'Bandung', '2001-12-12', 'Sekeloa Timur', 2010, 1, 4, ''),
('101170200', 2459, 6, 'HASNA AYU SOLEHAT', '101170200', '12345', 'Wanita', 'Bandung', '2002-06-30', 'Kp. Pasirkaliki Reuma', 2010, 1, 4, ''),
('101170237', 2460, 7, 'HUSAIN ABDUL JABBAR', '101170237', '12345', 'Pria', 'Bandung', '2001-08-28', 'Sekeloa Selatan No. 25', 2010, 1, 4, ''),
('101170238', 2461, 7, 'ILHAM FADILLAH', '101170238', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170058', 2462, 2, 'MIA NURHIDAYAH', '101170058', '12345', 'Wanita', 'Bandung', '2002-06-19', 'Jl. Cinaur (Kanayakan)', 2010, 1, 4, ''),
('101170095', 2463, 3, 'MIFTAH MAULANA', '101170095', '12345', 'Pria', 'Bandung', '2001-12-05', 'Jl. Cibeunying kolot', 2010, 1, 4, ''),
('101170132', 2464, 4, 'MITA PERMATA SETIASIH', '101170132', '12345', 'Wanita', 'Bandung', '2002-07-29', 'Jl. Sabar No. 21', 2010, 1, 4, ''),
('101170170', 2465, 5, 'MUHAMMAD FARIS FIRMANSYAH', '101170170', '12345', 'Pria', 'Bandung', '2002-09-11', 'Jl. Gagak Gg. Reuma Tengah I No. 14', 2010, 1, 4, ''),
('101170208', 2466, 6, 'MUHAMMAD HILMI ALMORAVIDS', '101170208', '12345', 'Pria', 'Bandung', '2001-11-08', 'Jl. Pasir Turi No. 7', 2010, 1, 4, ''),
('101170172', 2467, 5, 'NADYA RAFA APRILIA', '101170172', '12345', 'Wanita', 'Bandung', '2002-04-18', 'Jl. Sekeloa No. 9', 2010, 1, 4, ''),
('101170209', 2468, 6, 'NENGSIH ANDRIYANI PUTRI', '101170209', '12345', 'Wanita', 'Bandung', '2002-04-08', 'Jl. Ir. H. Juanda no. 16', 2010, 1, 4, ''),
('101170246', 2469, 7, 'NOVI FITRIYANI', '101170246', '12345', 'Wanita', 'Bandung', '2001-09-13', 'Pasirkaliki Gg. Reuma tengah I', 2010, 1, 4, ''),
('101170284', 2470, 8, 'NURFITHA SARI', '101170284', '12345', 'Wanita', 'Bandung', '2002-05-21', 'Jl. Sekemirung No. C4', 2010, 1, 4, ''),
('101170213', 2471, 6, 'REZA ANANDA PUTRA', '101170213', '12345', 'Pria', 'Bandung', '2002-10-14', 'Gg. Palem III', 2010, 1, 4, ''),
('101170251', 2472, 7, 'RISTA NUR APRILIANI', '101170251', '12345', 'Wanita', 'Bandung', '2002-04-13', 'Jl. Cikutra Barat Gg. Bojong Tengah', 2010, 1, 4, ''),
('101170290', 2473, 8, 'SABILA FATHUN', '101170290', '12345', 'Wanita', 'Bandung', '2001-12-16', 'Cibeunying Kolot', 2010, 1, 4, ''),
('101170327', 2474, 9, 'SEPHIANA DZAHRO NURSYIFA', '101170327', '12345', 'Wanita', 'Bandung', '2002-09-01', 'Jl. Awiligar', 2010, 1, 4, ''),
('101170033', 2475, 1, 'SILPIYANI', '101170033', '12345', 'Wanita', 'Bandung', '2001-12-22', 'Jl. Bangbayang Cihaur', 2010, 1, 4, ''),
('101170070', 2476, 2, 'SITI ADZAHRA DWI MULYANI', '101170070', '12345', 'Wanita', 'Bandung', '2002-08-13', 'Kp. Ligar Mekar', 2010, 1, 4, ''),
('101170108', 2477, 3, 'SYIFA FADIAH IDZNI NABILAH', '101170108', '12345', 'Wanita', 'Bandung', '2001-11-15', 'Gg. Menara Air II No. 2', 2010, 1, 4, ''),
('101170294', 2478, 8, 'VIANA ANGGRAENI SHALEHAH', '101170294', '12345', 'Wanita', 'Bandung', '2001-08-19', 'Sekemirung Kaler', 2010, 1, 4, ''),
('101170222', 2479, 6, 'ZULFAH SAFRANI', '101170222', '12345', 'Wanita', 'Bandung', '2002-10-20', 'Sekemirung Kaler No. 1', 2010, 1, 4, ''),
('101170035', 2480, 1, 'THANTY HERMAWATI', '101170035', '12345', 'Wanita', 'Bandung', '2001-08-01', 'Gg. Palem III No. 190', 2010, 1, 4, ''),
('101170297', 2481, 9, 'AFIFA ULYA ROSYIDA', '101170297', '12345', 'Wanita', 'Bandung', '2002-06-16', 'Jl. Cibeunying Kolot', 2010, 1, 4, ''),
('101170003', 2482, 1, 'AINA SALSABILA SIDIQ', '101170003', '12345', 'Wanita', 'Bandung', '2001-09-26', 'Jl. Dago Giri No.12', 2010, 1, 4, ''),
('101170040', 2483, 2, 'AJENG ARIMBI MUZAKY', '101170040', '12345', 'Wanita', 'Bandung', '2002-04-20', 'Jl. Sekeloa Selatan No. 60 B', 2010, 1, 4, ''),
('101170077', 2484, 3, 'AJRIFA RIESKY SEPTIANDY', '101170077', '12345', 'Pria', 'Bandung', '2001-08-18', 'Jl. Ciheulang No. 37', 2010, 1, 4, ''),
('101170116', 2485, 4, 'ANGGI MUHAMAD YUSUP', '101170116', '12345', 'Pria', 'Garut', '2001-07-29', 'Haur Pancuh I No. 37', 2010, 1, 4, ''),
('101170154', 2486, 5, 'ARIZAL MUHAMMAD FARHAN', '101170154', '12345', 'Pria', 'Bandung', '2002-04-30', 'Sekeloa Timur No. 230', 2010, 1, 4, ''),
('101170082', 2487, 3, 'BINTANG JUNIANTO', '101170082', '12345', 'Pria', 'Bandung', '2001-06-26', 'Jl. Tubagus Ismail Bawah No. 37', 2010, 1, 4, ''),
('101170193', 2488, 6, 'CINDY PERTIWI SUHERMAN', '101170193', '12345', 'Wanita', 'Bandung', '2002-01-01', 'Kp. Karang Asih', 2010, 1, 4, ''),
('101170085', 2489, 3, 'DHEA SIVANY', '101170085', '12345', 'Wanita', 'Bandung', '2002-05-12', 'Rancakalong', 2010, 1, 4, ''),
('101170121', 2490, 4, 'DHIZA BINTANG DANISWARA', '101170121', '12345', 'Wanita', 'Bandung', '2002-06-30', 'Jl. Tubagus Ismail V No. 75', 2010, 1, 4, ''),
('101170158', 2491, 5, 'DIAN AGUS', '101170158', '12345', 'Pria', 'Bandung', '2001-08-27', 'Kp.Pasir Koja ', 2010, 1, 4, ''),
('101170270', 2492, 8, 'ERI SAHMAWATI', '101170270', '12345', 'Wanita', 'Bandung', '2003-01-08', 'Cigadung wetan', 2010, 1, 4, ''),
('101170160', 2493, 5, 'FADHIL MUHAMMAD PRASETYO', '101170160', '12345', 'Pria', 'Bandung', '2001-11-26', 'Cipaheut Kaler', 2010, 1, 4, ''),
('101170273', 2494, 8, 'GANDINI KEMALA RAHMAWATI', '101170273', '12345', 'Wanita', 'Bandung', '2002-03-07', 'Jl. Cigadung Wetan', 2010, 1, 4, ''),
('101170274', 2495, 8, 'HASYA SABILA HANIFA', '101170274', '12345', 'Wanita', 'Bandung', '2002-07-16', 'Legok Hiris No. 133/157 C', 2010, 1, 4, ''),
('101170275', 2496, 8, 'INTAN PUSPITA SARI', '101170275', '12345', 'Wanita', 'Bandung', '2002-01-29', 'Kp. Cibuntu Awiligar', 2010, 1, 4, ''),
('101170312', 2497, 9, 'IRFAN RAHMAN', '101170312', '12345', 'Pria', 'Bandung', '2002-01-16', 'Jl. Tubagus Ismail Depan No. 48/157 A', 2010, 1, 4, ''),
('101170093', 2498, 3, 'LUFTI UTAMI ANGGRAENI', '101170093', '12345', 'Pria', 'Bandung', '2002-01-22', 'Jl. Titiran Dalam 263/151 C', 2010, 1, 4, ''),
('101170243', 2499, 7, 'MARSHA OCHA PRATIWI', '101170243', '12345', 'Wanita', 'Bandung', '2002-03-27', 'Jl. Dipati Ukur Blk. 96', 2010, 1, 4, ''),
('101170278', 2500, 8, 'MEISYA NABILAH SORAYA FIRDAUSI', '101170278', '12345', 'Wanita', 'Bandung', '2002-05-04', 'Jl. Tubagus Ismail Dalam', 2010, 1, 4, ''),
('101170314', 2501, 9, 'MOCHAMAD HAFIDZ ARBIAN', '101170314', '12345', 'Pria', 'Bandung', '2000-01-14', 'Terusan Tubagus Ismail', 2010, 1, 4, ''),
('101170020', 2502, 1, 'MUHAMAD ARYA PAMUNGKAS', '101170020', '12345', 'Pria', 'Bandung', '2002-08-31', 'Jl. Sekeloa No. 14 B', 2010, 1, 4, ''),
('101170060', 2503, 2, 'MUTIARA AZZAHRA HUMAIRA', '101170060', '12345', 'Wanita', 'Bandung', '2001-11-04', 'Sekemirung Kaler', 2010, 1, 4, ''),
('101170319', 2504, 9, 'NIA WIDIANTI', '101170319', '12345', 'Wanita', 'Bandung', '2002-08-20', 'Kp. Ciharalang', 2010, 1, 4, ''),
('101170026', 2505, 1, 'NURUL AENI', '101170026', '12345', 'Wanita', 'Bandung', '2001-07-17', 'Ciharalang', 2010, 1, 4, ''),
('101170174', 2506, 5, 'PRAMESTI TANTRI UTAMI', '101170174', '12345', 'Wanita', 'Bandung', '2001-12-04', 'Bojong tengah', 2010, 1, 4, ''),
('101170287', 2507, 8, 'RAIHAN NUR NABILAH', '101170287', '12345', 'Wanita', 'Bandung', '2001-12-02', 'Jl. Cigadung Wetan No. 143', 2010, 1, 4, ''),
('101170323', 2508, 9, 'RIAN RINALDI', '101170323', '12345', 'Pria', 'Bandung', '2001-05-27', 'Babakan Sembung', 2010, 1, 4, ''),
('101170029', 2509, 1, 'RIDHA FEBRIANI', '101170029', '12345', 'Pria', 'Bandung', '2002-02-07', 'Sadang Sari', 2010, 1, 4, ''),
('101170067', 2510, 2, 'RIDHOVA ABDILLAH ABBAS', '101170067', '12345', 'Pria', 'Bandung', '2002-02-20', 'Kp. Pakar Barat', 2010, 1, 4, ''),
('101170105', 2511, 3, 'RIZKY RAMADHAN', '101170105', '12345', 'Pria', 'Bandung', '2001-11-04', 'Jl. Sadang Legok Kidul No. 5', 2010, 1, 4, ''),
('101170144', 2512, 4, 'SELA MEILASARI', '101170144', '12345', 'Wanita', 'Bandung', '2002-05-21', 'Kp. Pasir Koja', 2010, 1, 4, ''),
('101170179', 2513, 5, 'SELVIA APRILIAN KURNIA SOLIHAT', '101170179', '12345', 'Wanita', 'Bandung', '2002-04-09', 'Jl. Tubagus Ismail Gg. Aquarius 15', 2010, 1, 4, ''),
('101170216', 2514, 6, 'SEPTIAN NURDIANSYAH', '101170216', '12345', 'Pria', 'Bandung', '2001-09-25', 'Bojong mekar', 2010, 1, 4, ''),
('101170254', 2515, 7, 'SITI RIKA AMALIA', '101170254', '12345', 'Wanita', 'Bandung', '2002-06-22', 'Sekemirung Kidul', 2010, 1, 4, ''),
('101170292', 2516, 8, 'SONA ADJIE', '101170292', '12345', 'Pria', 'Bandung', '2000-11-14', 'Babakan Sembung', 2010, 1, 4, ''),
('101170187', 2517, 6, 'AHMAD RUBI ZAELANI', '101170187', '12345', 'Pria', 'Bandung', '2002-10-30', 'Sadang Sari no. 25', 2010, 1, 4, ''),
('101170224', 2518, 7, 'AKMAL HADIANSYAH', '101170224', '12345', 'Pria', 'Bandung', '2002-03-26', 'Jl. Bojong Tengah', 2010, 1, 4, ''),
('101170261', 2519, 8, 'ANISA WEMPI RAHMALIA', '101170261', '12345', 'Wanita', 'Bandung', '2003-01-05', 'Sukasari I', 2010, 1, 4, ''),
('101170300', 2520, 9, 'ANNISA KUSUMA WARDANI', '101170300', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170007', 2521, 1, 'APRIAN RIZKY GUSMAWAN', '101170007', '12345', 'Pria', 'Bandung', '2002-04-08', 'Jl. Sadang Hegar III No. 2', 2010, 1, 4, ''),
('101170044', 2522, 2, 'ASRI FITRIA MUARY', '101170044', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170195', 2523, 6, 'DIAN NURMANSYAH SUBAGJA', '101170195', '12345', 'Wanita', 'Bandung', '2001-05-12', 'Jl. Bangbayang Timur', 2010, 1, 4, ''),
('101170306', 2524, 9, 'EKA AULINA', '101170306', '12345', 'Wanita', 'Bandung', '2002-04-27', 'Cigadung Raya Barat', 2010, 1, 4, ''),
('101170012', 2525, 1, 'ERWIN MAULANA', '101170012', '12345', 'Pria', 'Bandung', '2002-08-21', 'Jl. Pelesiran', 2010, 1, 4, ''),
('101170197', 2526, 6, 'FAUZAN AKMAL GHASSANI', '101170197', '12345', 'Pria', 'Bandung', '2003-09-30', 'Perumahan Sadang Serang B 06/39', 2010, 1, 4, ''),
('101170235', 2527, 7, 'FITRIANDINI WIDHIAHAMIDAH', '101170235', '12345', 'Wanita', 'Bandung', '2001-12-15', 'Sadang Sari', 2010, 1, 4, ''),
('101170309', 2528, 9, 'GILANG RIZKI', '101170309', '12345', 'Pria', 'Bandung', '2002-01-25', 'Jl. Ciheulang', 2010, 1, 4, ''),
('101170017', 2529, 1, 'IFFAN NUR ILMAN SYARIFUDIN', '101170017', '12345', 'Pria', 'Bandung', '2002-04-25', 'Jl. Cigadung Selatan No. 8', 2010, 1, 4, ''),
('101170054', 2530, 2, 'IRFAN SETIAWAN', '101170054', '12345', 'Pria', 'Bandung', '2002-06-14', 'Sekeloa Timur', 2010, 1, 4, ''),
('101170091', 2531, 3, 'IRRAZQI ILYAHSYA', '101170091', '12345', 'Pria', 'Bandung', '2002-01-15', 'Jl. Mars Dirgahayu', 2010, 1, 4, ''),
('101170130', 2532, 4, 'LUSI PUTRI YANTI', '101170130', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170097', 2533, 3, 'MUHAMMAD FATHAN WIRDIYAN', '101170097', '12345', 'Pria', 'Bandung', '2002-07-01', 'Jl. Titiran Dalam no. 45/151 C', 2010, 1, 4, ''),
('101170134', 2534, 4, 'MUHAMMAD RAGHANI ANNUR YAFIE', '101170134', '12345', 'Pria', 'Bandung', '2002-04-12', 'Jl. Sadang Sari Blok G No. 24', 2010, 1, 4, ''),
('101170171', 2535, 5, 'MUHAMMAD RIFQI SUHANA', '101170171', '12345', 'Pria', 'Bandung', '2002-10-30', 'Kp. Babakan', 2010, 1, 4, ''),
('101170062', 2536, 2, 'NAJMI ALGHIFFARI', '101170062', '12345', 'Wanita', 'Bandung', '2002-03-03', 'Sukamantri I No. 180', 2010, 1, 4, ''),
('101170098', 2537, 3, 'NANTIA SRI ZAHRA', '101170098', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170136', 2538, 4, 'NURULITA AULIA', '101170136', '12345', 'Wanita', 'Bandung', '2002-03-12', 'Cibeunying Kolot', 2010, 1, 4, ''),
('101170211', 2539, 6, 'PUTRAKU GAGAH AKANU', '101170211', '12345', 'Pria', 'Bandung', '2002-07-06', 'Kp. Karang Asih No. 284/151 A', 2010, 1, 4, ''),
('101170138', 2540, 4, 'RAIHAN PEBRIANSYAH', '101170138', '12345', 'Pria', 'Bandung', '2002-02-03', 'Kp. Pasir Koja No. 87', 2010, 1, 4, ''),
('101170176', 2541, 5, 'RANTI MULYANI', '101170176', '12345', 'Wanita', 'Bandung', '2002-05-13', 'Gg. Bojong Kaler', 2010, 1, 4, ''),
('101170212', 2542, 6, 'RAYHANI FAUZIYAH AZMI', '101170212', '12345', 'Wanita', 'Bandung', '2001-10-22', 'Gg. Intan I No. 11', 2010, 1, 4, ''),
('101170250', 2543, 7, 'RINA SEPTIANI', '101170250', '12345', 'Wanita', 'Bandung', '2002-09-06', 'Jl. Sekeloa Timur', 2010, 1, 4, ''),
('101170289', 2544, 8, 'RINI FEBRIANI', '101170289', '12345', 'Wanita', 'Bandung', '2002-02-11', 'Jl. Awiligar', 2010, 1, 4, ''),
('101170325', 2545, 9, 'RISMA DAMAYANTI', '101170325', '12345', 'Wanita', 'Bandung', '2002-06-29', 'Sekemirung', 2010, 1, 4, ''),
('101170031', 2546, 1, 'RIZWAN BAROKAH', '101170031', '12345', 'Pria', 'Bandung', '2002-06-29', 'Sadang Luhur', 2010, 1, 4, ''),
('101170326', 2547, 9, 'SALSABILLA WIDYA PRAMESWARI H.', '101170326', '12345', 'Wanita', 'Bandung', '2002-12-27', 'Jl. Taman Hewan No. 15/56', 2010, 1, 4, ''),
('101170034', 2548, 1, 'SYAEFUL RIZKI JULIANA', '101170034', '12345', 'Pria', 'Bandung', '2001-07-19', 'Babakan Sembung', 2010, 1, 4, ''),
('101170071', 2549, 2, 'SYIFA NURUL ISMIE SABILA', '101170071', '12345', 'Wanita', 'Bandung', '2002-06-04', 'Cibeunying Kolot No. 14', 2010, 1, 4, ''),
('101170072', 2550, 2, 'TANIA AJENG HAYU PRAMESTI', '101170072', '12345', 'Wanita', 'Bandung', '2001-12-05', 'Cijotang Indah Raya', 2010, 1, 4, ''),
('101170109', 2551, 3, 'TANTRI WINDI FEBRIANTI', '101170109', '12345', 'Wanita', 'Bandung', '2002-02-27', 'Sekeloa Tengah No. 52', 2010, 1, 4, ''),
('101170330', 2552, 9, 'VANISA RAHMA WIJAYANTI', '101170330', '12345', 'Wanita', 'Bandung', '2002-06-14', 'Jl. Terusan Tubagus Ismail gg. Aquarius No. 3', 2010, 1, 4, ''),
('101170075', 2553, 3, 'AGUNG NUGRAHA', '101170075', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170112', 2554, 4, 'AKBAR MAULANA YUSUF', '101170112', '12345', 'Pria', 'Bandung', '2001-06-24', 'Terusan Tubagus Ismail No. 19', 2010, 1, 4, ''),
('101170149', 2555, 5, 'ALDA AYU UMMI KHOFIFAH', '101170149', '12345', 'Wanita', 'Bandung', '2002-05-19', 'Jl. Haur Mekar E. 30', 2010, 1, 4, ''),
('101170188', 2556, 6, 'ANDRA FEBRIYAN', '101170188', '12345', 'Pria', 'Bandung', '2002-02-10', 'Jl. Wanaya', 2010, 1, 4, ''),
('101170227', 2557, 7, 'ARINI PUTRI DEWI YANTI', '101170227', '12345', 'Wanita', 'Bandung', '2001-10-11', 'Bojong Kaler', 2010, 1, 4, ''),
('101170266', 2558, 8, 'ASYIFA AGUSTINA', '101170266', '12345', 'Wanita', 'Bandung', '2002-08-03', 'Jl. Ciheulang no. 3', 2010, 1, 4, ''),
('101170302', 2559, 9, 'AZHAR PUTRA RAMADHAN', '101170302', '12345', 'Pria', 'Bandung', '2001-11-23', 'Pasirkaliki Barat', 2010, 1, 4, ''),
('101170232', 2560, 7, 'DINA MARYANA', '101170232', '12345', 'Wanita', 'Bandung', '2001-08-24', 'Babakan Sembung No. 86 A', 2010, 1, 4, ''),
('101170049', 2561, 2, 'ELLEN VALENTINA RIZKIA', '101170049', '12345', 'Wanita', 'Bandung', '2003-02-11', 'Babakan Sembung', 2010, 1, 4, ''),
('101170271', 2562, 8, 'FARHAN NUR JAMAL', '101170271', '12345', 'Pria', 'Bandung', '2002-06-01', 'Sekeloa tengah No. 14 B', 2010, 1, 4, ''),
('101170307', 2563, 9, 'FEBRIANI REISA SAPUTRI', '101170307', '12345', '', 'Bandung', '2002-02-20', 'Bojong Mekar', 2010, 1, 4, ''),
('101170014', 2564, 1, 'FITRIA ZAHWA FEBIANTI', '101170014', '12345', 'Wanita', 'Bandung', '2002-02-09', 'Babakan Sembung No. 103', 2010, 1, 4, ''),
('101170051', 2565, 2, 'FRANSISCA MATHILDA ARIVIANI', '101170051', '12345', 'Wanita', 'Bandung', '2002-02-05', 'Sadang Luhur I No. 10', 2010, 1, 4, ''),
('101170310', 2566, 9, 'HAFSHOH HABIBALLOH', '101170310', '12345', 'Pria', 'Bandung', '2001-07-09', 'Jl. Gegerkalong Girang No. 18', 2010, 1, 4, ''),
('101170016', 2567, 1, 'HANA NUR AINI', '101170016', '12345', 'Wanita', 'Bandung', '2001-12-29', 'Jl. Bangbayang No. 45', 2010, 1, 4, ''),
('101170053', 2568, 2, 'HIDAYATULLOH', '101170053', '12345', 'Pria', 'Bandung', '2001-10-19', 'Bojong Mekar', 2010, 1, 4, ''),
('101170127', 2569, 4, 'ICHSAN KURNIAWAN', '101170127', '12345', 'Pria', 'Bandung', '2002-04-01', 'Sadang Sari', 2010, 1, 4, ''),
('101170164', 2570, 5, 'IDFI FAJAR ZAKARIA', '101170164', '12345', 'Pria', 'Bandung', '2002-12-16', 'Jl. Taman Sari No. 35/56', 2010, 1, 4, ''),
('101170202', 2571, 6, 'IRMA MAULANI APRIANTHIE', '101170202', '12345', 'Wanita', 'Bandung', '2002-09-24', 'Jl. Cisitu Lama blok P No. 31', 2010, 1, 4, ''),
('101170239', 2572, 7, 'IRMA NURWAHIDAH', '101170239', '12345', 'Wanita', 'Bandung', '2002-03-02', 'Cisitu Lama', 2010, 1, 4, ''),
('101170276', 2573, 8, 'ISRA ATININGRUM', '101170276', '12345', 'Wanita', 'Bandung', '2002-11-13', 'Bojong mekar', 2010, 1, 4, ''),
('101170203', 2574, 6, 'KHAMELIANA', '101170203', '12345', 'Wanita', 'Bandung', '2002-09-15', 'Jl. Ir. H. Juanda Dalam No. 24/154 A', 2010, 1, 4, ''),
('', 2575, 0, NULL, '', '', 'Wanita', NULL, NULL, NULL, 2010, 0, 4, ''),
('101170206', 2576, 6, 'MUHAMAD NUR ALFIANSYAH', '101170206', '12345', 'Pria', 'Bandung', '2002-03-31', 'Kp. Pasirkaliki Barat No. 29', 2010, 1, 4, ''),
('101170173', 2577, 5, 'NAUFAL MAULANA', '101170173', '12345', 'Wanita', 'Bandung', '2002-06-13', 'Cisitu Lama VII No. 8/154 B', 2010, 1, 4, ''),
('101170210', 2578, 6, 'NOVI ARYANTI', '101170210', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170247', 2579, 7, 'NOVIA DAMAYANTI', '101170247', '12345', 'Wanita', 'Bandung', '2001-11-04', 'Bojong Mekar', 2010, 1, 4, ''),
('101170283', 2580, 8, 'NUR ALI SYARIPATAH', '101170283', '12345', 'Pria', 'Bandung', '2000-10-29', 'jl. Gagak V No. 217/144 F', 2010, 1, 4, ''),
('101170321', 2581, 9, 'QORI FADHLI FATHURRAHMAN ALAMSYAH', '101170321', '12345', 'Pria', 'Bandung', '2002-10-11', 'Perumnas Sadang Serang Gemini No. 27', 2010, 1, 4, ''),
('101170066', 2582, 2, 'RAFA IHSAN ALEKSANDRA', '101170066', '12345', 'Pria', 'Bandung', '2002-04-04', 'Cukang Kawung No. 168/149 A', 2010, 1, 4, ''),
('101170101', 2583, 3, 'REGGY HAFSHAH MAULYANI', '101170101', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170107', 2584, 3, 'SITI HUMAIRA HANUN', '101170107', '12345', 'Wanita', 'Bandung', '2002-05-07', 'Jl. Cibeunying Kolot No. 10', 2010, 1, 4, ''),
('101170146', 2585, 4, 'THALULA DEWI ALYA', '101170146', '12345', 'Wanita', 'Bandung', '2002-06-19', 'Sadang luhur blok 13 no. 3', 2010, 1, 4, ''),
('101170183', 2586, 5, 'UMAR ASKAR AL JABBAR AKBARI', '101170183', '12345', 'Pria', 'Bandung', '2002-04-02', 'Tubagus Ismail V No. 3', 2010, 1, 4, ''),
('101170036', 2587, 1, 'VINA WIDIATI', '101170036', '12345', 'Wanita', 'Bandung', '2001-11-17', 'Sekeloa tengah', 2010, 1, 4, ''),
('101170073', 2588, 2, 'WILDA SALMA FITRIA', '101170073', '12345', 'Wanita', 'Bandung', '2001-12-08', 'Bojong Kaler', 2010, 1, 4, ''),
('101170002', 2589, 1, 'AGISTA NABILAHARIS', '101170002', '12345', 'Wanita', 'Bandung', '2002-08-17', 'Sadang Serang Gg. Palem 3 No. 12', 2010, 1, 4, ''),
('101170039', 2590, 2, 'AJENG ADISTYA', '101170039', '12345', 'Wanita', 'Bandung', '2002-04-11', 'Sadang Serang Gg. Reuma', 2010, 1, 4, ''),
('101170078', 2591, 3, 'ALDIK', '101170078', '12345', 'Pria', 'Tasikmalaya', '2002-05-30', 'Jl. Batik Jonas No. 9', 2010, 1, 4, ''),
('101170115', 2592, 4, 'AMELISCA EKA PUTRI', '101170115', '12345', 'Wanita', 'Bandung', '2002-05-07', 'Ranca Kalong', 2010, 1, 4, ''),
('101170150', 2593, 5, 'ANDI SETIAWAN', '101170150', '12345', 'Pria', 'Bandung', '2001-10-22', 'Jl. Gagak Gg. Pasirhuni I', 2010, 1, 4, ''),
('101170189', 2594, 6, 'ANDRIAN DWI PERMANA', '101170189', '12345', 'Pria', 'Bandung', '2001-04-16', 'Jl. Bangbayang Timur', 2010, 1, 4, ''),
('101170225', 2595, 7, 'ANGGI ANUGRAH BINTARA', '101170225', '12345', 'Wanita', 'Bandung', '2003-01-25', 'Jl. Gagak No. 121', 2010, 1, 4, ''),
('101170263', 2596, 8, 'ARIEF PRATAMA', '101170263', '12345', 'Pria', 'Bandung', '2001-12-14', 'Sekeloa Timur No. 262', 2010, 1, 4, ''),
('101170119', 2597, 4, 'BILQISTHI AZZAHRA QOYYUMI', '101170119', '12345', 'Wanita', 'Bandung', '2002-08-12', 'Perum Sadang Serang Palem 1/34', 2010, 1, 4, ''),
('101170230', 2598, 7, 'CINDY SHINTYA ARTA YANI', '101170230', '12345', 'Wanita', 'Bandung', '2002-06-04', 'Kp. Jiwanaya', 2010, 1, 4, ''),
('101170267', 2599, 8, 'CLARINE MONA SILABAN', '101170267', '12345', 'Wanita', 'Bandung', '2002-01-30', 'Jl.Gagak Dalam II 264/144 C', 2010, 1, 4, ''),
('101170303', 2600, 9, 'CLARISSA AULIA PUTRI', '101170303', '12345', 'Wanita', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170268', 2601, 8, 'DANIS PRIMADANA', '101170268', '12345', 'Pria', 'Bandung', '2001-11-11', 'Sekeloa Timur', 2010, 1, 4, ''),
('101170305', 2602, 9, 'DINI FAJRIYATI', '101170305', '12345', 'Wanita', 'Bandung', '2001-07-13', 'Pasirkaliki Barat', 2010, 1, 4, ''),
('101170011', 2603, 1, 'DWI LISMAUDI WIDYANTI', '101170011', '12345', 'Wanita', 'Bandung', '2001-10-14', 'Sekemirung', 2010, 1, 4, ''),
('101170088', 2604, 3, 'FRILLA VITA NURLATIFA', '101170088', '12345', 'Wanita', 'Bandung', '2002-04-11', 'Sukasari I No. 173', 2010, 1, 4, ''),
('101170015', 2605, 1, 'GUSMAYANTI NURLAELI', '101170015', '12345', 'Wanita', 'Bandung', '2001-08-09', 'Jl. Sukasari II No. 214', 2010, 1, 4, ''),
('101170311', 2606, 9, 'ILMA NUR''AZIZAH', '101170311', '12345', 'Wanita', 'Bandung', '2002-07-05', 'Sadang Sari', 2010, 1, 4, ''),
('101170167', 2607, 5, 'LAZUARDI MUHAMMAD FADILLAH', '101170167', '12345', 'Pria', 'Bandung', '2002-08-14', 'Jl. Pelesiran 131/56', 2010, 1, 4, ''),
('101170204', 2608, 6, 'LISA SAFITRI', '101170204', '12345', 'Wanita', 'Bandung', '2001-02-06', 'Kp. Cipariuk', 2010, 1, 4, ''),
('101170241', 2609, 7, 'MAHENDRA PUTRA ADRIANSYAH', '101170241', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170281', 2610, 8, 'MUHAMAD IQBAL NUGRAHA', '101170281', '12345', 'Pria', 'Bandung', '2001-07-04', 'Sekeloa timur No. 246', 2010, 1, 4, ''),
('101170315', 2611, 9, 'MUHAMAD PADLI PADILLAH', '101170315', '12345', 'Pria', 'Bandung', '2001-08-25', 'Jl. Cikutra Barat', 2010, 1, 4, ''),
('101170021', 2612, 1, 'MUHAMMAD FARIK EFENDI', '101170021', '12345', 'Pria', 'Bandung', '2001-10-03', 'Jl. Tubagus Ismail XV No. 134', 2010, 1, 4, ''),
('101170059', 2613, 2, 'MUHAMMAD HAVIDZHAN SAPUTRA', '101170059', '12345', 'Pria', 'Bandung', '2002-05-15', 'Kp. Pasirkaliki Barat', 2010, 1, 4, ''),
('101170320', 2614, 9, 'NOVIANA TRISNAWATI', '101170320', '12345', 'Wanita', 'Bandung', '2001-11-08', 'Jl. Cibeunying Kolot', 2010, 1, 4, ''),
('101170025', 2615, 1, 'NUR PUTRI SABRINA', '101170025', '12345', 'Wanita', 'Bandung', '2001-12-05', 'Jl. Bangbayang Timur Legok Hiris', 2010, 1, 4, ''),
('101170248', 2616, 7, 'PUNGKY ATHAYA', '101170248', '12345', 'Wanita', 'Bandung', '2002-06-17', 'Kp. Pasirkaliki Tengah No. 47', 2010, 1, 4, ''),
('101170027', 2617, 1, 'QORI NUR AFNI', '101170027', '12345', 'Wanita', 'Bandung', '2002-01-11', 'Jl. Bangbayang Timur No. 132', 2010, 1, 4, ''),
('101170139', 2618, 4, 'RAMA RAMADHAN', '101170139', '12345', 'Pria', 'Bandung', '2000-11-22', 'Jl. Pelesiran', 2010, 1, 4, ''),
('101170175', 2619, 5, 'RANGGA SETIAWAN', '101170175', '12345', 'Pria', 'Bandung', '2002-06-25', 'Jl. Sadang Sari No. 47', 2010, 1, 4, ''),
('101170215', 2620, 6, 'RIO FEBRIANSAH', '101170215', '12345', 'Pria', 'Bandung', '2002-02-25', 'Gg. Bojong Kaler No. 7/1', 2010, 1, 4, ''),
('101170252', 2621, 7, 'RIZKI KURNIA', '101170252', '12345', 'Pria', 'Bandung', '2001-07-18', 'Kp. Pasirkoja No.159', 2010, 1, 4, ''),
('101170143', 2622, 4, 'SALFA YASMIN AZ ZAHRA', '101170143', '12345', 'Wanita', 'Bandung', '2002-04-20', 'Tubagus Ismail Dalam', 2010, 1, 4, ''),
('101170181', 2623, 5, 'SHELLA PEBRIANTI', '101170181', '12345', 'Pria', 'Bandung', '2002-02-05', 'Jl. Dago Blok V No. 430', 2010, 1, 4, ''),
('101170110', 2624, 3, 'WALIYYUDDIN', '101170110', '12345', 'Pria', 'Bandung', '2001-12-18', 'Jl. Taman Sari 96 A/56', 2010, 1, 4, ''),
('101170147', 2625, 4, 'WIDYA PUTRI PERMANA', '101170147', '12345', 'Wanita', 'Bandung', '2001-12-18', 'Jl. Cibeunying Hegar II Blok C', 2010, 1, 4, ''),
('101170259', 2626, 7, 'ZEVICA VEBYS MULYA KESUMA', '101170259', '12345', 'Wanita', 'Bandung', '2002-02-08', 'Jl. Taman Hewan No. 166 A/56', 2010, 1, 4, ''),
('101170299', 2627, 9, 'ALFINA SEPTIA TRIANI', '101170299', '12345', 'Wanita', 'Bandung', '2001-09-04', 'Pasir Koja No. 137', 2010, 1, 4, ''),
('101170006', 2628, 1, 'ALIF AKBAR KURNIA', '101170006', '12345', 'Pria', 'Bandung', '2001-07-12', 'Jl. Bangbayang Timur No. 118/157 C', 2010, 1, 4, ''),
('101170043', 2629, 2, 'ALIPAH ZAHRA WARDANI', '101170043', '12345', 'Wanita', 'Bandung', '2002-11-16', 'Cibeunying Kolot', 2010, 1, 4, ''),
('101170081', 2630, 3, 'ALYA NABILA ZAHRA', '101170081', '12345', 'Wanita', 'Bandung', '2001-12-17', 'Perumahan Sadang Serang no. 41', 2010, 1, 4, ''),
('101170117', 2631, 4, 'ANZIA TIRTA MALIHA', '101170117', '12345', 'Wanita', 'Bandung', '2002-06-04', 'Jl. Ir. H. Juanda 16/154 A', 2010, 1, 4, ''),
('101170153', 2632, 5, 'ARDIANSYAH', '101170153', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170192', 2633, 6, 'ARIF MAULANA NURAHMAN', '101170192', '12345', 'Pria', 'Bandung', '2002-02-24', 'Jl. Cijotang', 2010, 1, 4, ''),
('101170228', 2634, 7, 'ARIQ MAULANA PUTRA', '101170228', '12345', 'Pria', 'Bandung', '2002-06-06', 'Kp. Panyingkiran No. 461', 2010, 1, 4, ''),
('101170265', 2635, 8, 'ASRIL DWI CAHYA PERMANA', '101170265', '12345', '', 'Bandung', '2002-07-08', 'Jl. Sekeloa Timur No. 08', 2010, 1, 4, ''),
('101170301', 2636, 9, 'AYUMITHA NISSA RAMADHANI', '101170301', '12345', 'Wanita', 'Bandung', '2001-12-08', 'Jl. Kyai Luhur No. 6', 2010, 1, 4, ''),
('101170046', 2637, 2, 'DANI RAMADHAN', '101170046', '12345', 'Pria', 'Bandung', '2000-12-22', 'Jl. Sadang Hegar I Gg Aquarius', 2010, 1, 4, ''),
('101170084', 2638, 3, 'DERI FIDLI IRAWAN', '101170084', '12345', 'Pria', 'Bandung', '2001-12-18', 'Pasirkaliki Reuma', 2010, 1, 4, ''),
('101170122', 2639, 4, 'DINDA AYUNINGTIYAS I. H.', '101170122', '12345', 'Wanita', 'Bandung', '2002-01-07', 'Jl Sekeloa Tengah', 2010, 1, 4, ''),
('101170123', 2640, 4, 'FANNI SHOFI SYAFITRI', '101170123', '12345', 'Wanita', 'Bandung', '2003-01-01', 'Cibeunying Kolot IV No. 36 A', 2010, 1, 4, ''),
('101170162', 2641, 5, 'FULQI RAMDANI', '101170162', '12345', 'Pria', 'Bandung', '2001-06-21', 'Sekemirung Kidul', 2010, 1, 4, ''),
('101170090', 2642, 3, 'HERNA ROHANA', '101170090', '12345', 'Wanita', 'Bandung', '2001-04-18', 'Jl. Sekeloa No. 37', 2010, 1, 4, ''),
('101170240', 2643, 7, 'KINANTI KHARISMA MEISYAH', '101170240', '12345', 'Wanita', 'Bandung', '2002-05-18', 'Jl. Melati II Blok 07 No. 22', 2010, 1, 4, ''),
('101170094', 2644, 3, 'MAULIDYA RIZKI FAHRUNISA', '101170094', '12345', 'Wanita', 'Bandung', '2002-05-23', 'Sekemirung Kaler', 2010, 1, 4, ''),
('101170131', 2645, 4, 'MEIRA SRI HASTUTI', '101170131', '12345', 'Wanita', 'Bandung', '2002-05-01', 'Jl. Cikutra Barat No. 127/149 A', 2010, 1, 4, ''),
('101170168', 2646, 5, 'MELI APRIANI', '101170168', '12345', 'Wanita', 'Sumedang', '2002-04-15', 'Jl. Cisitu Lama No. 11 B', 2010, 1, 4, ''),
('101170205', 2647, 6, 'MIFTAH DZAINI', '101170205', '12345', 'Pria', 'Bandung', '2000-01-27', 'Cibeunying Kolot No.20', 2010, 1, 4, ''),
('101170244', 2648, 7, 'MOCHAMAD RIFAT FAUZI', '101170244', '12345', 'Pria', 'Bandung', '2002-10-28', 'Karang Asih', 2010, 1, 4, ''),
('101170279', 2649, 8, 'MOHAMAD GUFRON', '101170279', '12345', 'Pria', 'Kebumen', '2001-01-31', 'Sekeloa Tengah', 2010, 1, 4, ''),
('101170061', 2650, 2, 'NADHIFAH THIFAL KURNIA WIBOWO', '101170061', '12345', 'Wanita', 'Jakarta', '2002-10-29', 'Kp. Cikapayang 268 A/144 F', 2010, 1, 4, ''),
('101170099', 2651, 3, 'NAURA TSABITA SALSABILA AZIZAH', '101170099', '12345', 'Wanita', 'Pangkal Pinang', '2002-02-07', 'Jl. Tubagus Ismail Gg Virgo No. 5', 2010, 1, 4, ''),
('101170285', 2652, 8, 'PROKOPIUS WILLIAM ANDIKA WINDOE', '101170285', '12345', 'Pria', 'Bandung', '2002-07-08', 'Bumi Panyileukan Blok J1 no. 13', 2010, 1, 4, ''),
('101170286', 2653, 8, 'RAHADIAN MUHAMMAD SUTANDAR', '101170286', '12345', 'Pria', 'Bandung', '2002-05-08', 'Jl. Cigadung Indah No. 2', 2010, 1, 4, ''),
('101170322', 2654, 9, 'RAMA PALASARA', '101170322', '12345', 'Pria', 'Bandung', '2001-12-05', 'Bojong', 2010, 1, 4, ''),
('101170028', 2655, 1, 'RENATTA ZAHRA PUTRI MATINDAS', '101170028', '12345', 'Wanita', 'Bandung', '2002-05-04', 'Jl. Sekeloa Tengah No. 16', 2010, 1, 4, ''),
('101170068', 2656, 2, 'RIFA SUKMAYANI', '101170068', '12345', 'Wanita', 'Bandung', '2002-04-09', 'Pasirkaliki Barat', 2010, 1, 4, ''),
('101170103', 2657, 3, 'RITA WIDIA PRATIWI', '101170103', '12345', 'Wanita', 'Bandung', '2003-01-15', 'Sekeloa Selatan', 2010, 1, 4, ''),
('', 2658, 0, NULL, '', '', 'Pria', NULL, NULL, NULL, 2010, 0, 4, ''),
('101170142', 2659, 4, 'ROSY ROCHAYATI', '101170142', '12345', 'Wanita', 'Bandung', '2002-01-20', 'Jl. Cibeunying Kolot No. 79', 2010, 1, 4, ''),
('101170217', 2660, 6, 'SHAHNAZ VANIA ZAHRATUNNISA', '101170217', '12345', 'Wanita', 'Bandung', '2002-05-02', 'Pasirkaliki Reuma', 2010, 1, 4, ''),
('101170256', 2661, 7, 'SYALSA RAYA FATHUREZKI', '101170256', '12345', 'Wanita', 'Bandung', '2002-01-01', 'Jl. Gagak No. 65', 2010, 1, 4, ''),
('101170331', 2662, 9, 'YANUAR FAUZI ISLAMI MUZAKKI', '101170331', '12345', 'Pria', NULL, NULL, NULL, 2010, 1, 4, ''),
('101170037', 2663, 1, 'YULIA RAHMAWATI', '101170037', '12345', 'Wanita', 'Bandung', '2002-07-21', 'Jl. Terusan Ligar Raya', 2010, 1, 4, ''),
('101170074', 2664, 2, 'YULIANTI SETIAWATI', '101170074', '12345', 'Wanita', 'Bandung', '2002-07-01', 'Cigadung Raya Timur', 2010, 1, 4, '');

-- --------------------------------------------------------

--
-- Table structure for table `ref_user`
--

CREATE TABLE IF NOT EXISTS `ref_user` (
  `id_user` varchar(21) NOT NULL,
  `nm_user_first` varchar(21) DEFAULT NULL,
  `nm_user_last` varchar(21) DEFAULT NULL,
  `username` varchar(21) DEFAULT NULL,
  `password` varchar(21) DEFAULT NULL,
  `tahun` smallint(4) DEFAULT NULL,
  `kelas` tinyint(2) DEFAULT NULL,
  `id_level` smallint(6) DEFAULT '3',
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `uq_id_user` (`id_user`) USING BTREE,
  KEY `id_level` (`id_level`),
  KEY `id_level_2` (`id_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ref_user`
--

INSERT INTO `ref_user` (`id_user`, `nm_user_first`, `nm_user_last`, `username`, `password`, `tahun`, `kelas`, `id_level`, `active`) VALUES
('122004', 'Ningrum ', 'Soleha', 'NingrumSoleha', '123456', 0, 0, 2, 1),
('12201', 'Sri', 'Muwarni', 'MuwarniSri', '123456', 2015, 7, 3, 1),
('1234', 'Aldila', 'Karunia', 'laidla', '212121', 0, 0, 3, 1),
('1502345', 'Aldila', 'Karunia', 'admin', 'admin', 2015, 1, 1, 1),
('34567', 'Ibnu', 'Salam', 'ibnu', 'ibnu', NULL, NULL, 2, 1),
('9090', 'Fauzan Fathur', 'Rohman', 'fathur', 'blackberry', 0, 0, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tr_mengajar`
--

CREATE TABLE IF NOT EXISTS `tr_mengajar` (
  `id_mengajar` int(11) NOT NULL AUTO_INCREMENT,
  `id_mapel` int(11) DEFAULT NULL,
  `nis` int(11) DEFAULT NULL,
  `latihan` smallint(3) DEFAULT '0',
  `uts` smallint(3) DEFAULT '0',
  `uas` smallint(3) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_mengajar`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tr_mengajar`
--

INSERT INTO `tr_mengajar` (`id_mengajar`, `id_mapel`, `nis`, `latihan`, `uts`, `uas`, `status`) VALUES
(1, 1, 1507001, 3, 3, 3, 1),
(3, 5, 150789, 5, 5, 5, 1),
(4, 5, 111270001, 80, 80, 80, 1),
(5, 5, 101170001, 80, 85, 90, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tr_pendaftaran`
--

CREATE TABLE IF NOT EXISTS `tr_pendaftaran` (
  `id_pendaftaran` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nisn` varchar(21) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `asal_sekolah` varchar(50) DEFAULT NULL,
  `jenis_kelamin` varchar(6) DEFAULT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat` varchar(50) DEFAULT '',
  `nun` float DEFAULT NULL,
  `no_ijazah` varchar(50) DEFAULT NULL,
  `password` varchar(21) DEFAULT '12345',
  `nilai` float DEFAULT '0',
  `active` tinyint(1) DEFAULT '0',
  `tahun` smallint(4) DEFAULT '0',
  `kelas` tinyint(2) DEFAULT '0',
  `no_urut` smallint(4) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `reg` tinyint(1) DEFAULT '0',
  `lulus` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_pendaftaran`),
  UNIQUE KEY `uq_nisn` (`nisn`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=79 ;

--
-- Dumping data for table `tr_pendaftaran`
--

INSERT INTO `tr_pendaftaran` (`id_pendaftaran`, `nisn`, `name`, `asal_sekolah`, `jenis_kelamin`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `nun`, `no_ijazah`, `password`, `nilai`, `active`, `tahun`, `kelas`, `no_urut`, `status`, `reg`, `lulus`) VALUES
(1, '1234567', 'AL', 'sdn 2 ', 'Pria', NULL, NULL, '', 27, '87777777', '12345', 26, 1, 2010, 0, 0, 1, 1, 1),
(2, '7666666', 'dila', 'sdn 8 ', 'Wanita', NULL, NULL, '', 29, '77888788', '12345', 29, 1, 2014, 1, 1, 2, 1, 1),
(3, '21211111', 'fathur', 'sdn 9', 'Pria', NULL, NULL, '', 27, '626662662', '12345', 27, 1, 2014, 2, 2, 2, 1, 1),
(4, '22222', 'fauzan', 'sdn 2 ', 'Pria', NULL, NULL, '', 22, '88888888', '12345', 22, 1, 2013, 1, 1, 2, 1, 1),
(5, 'oo26363722', 'Ade Isma Faishal', 'sdn 2 cikadut', 'Pria', NULL, NULL, '', 27, '12211111', '12345', 27, 1, 2015, 0, 54, 2, 0, 1),
(6, '0025140723', 'Ai Siti Rohaeti', 'sdn 2 coblong ', 'Wanita', NULL, NULL, '', 27, '201527771', '12345', 27, 1, 2015, 1, 52, 2, 1, 1),
(7, '002729813', 'Ajeng Solihat', 'sdn 1 ', 'Wanita', NULL, NULL, '', 28, '20162222', '12345', 28, 1, 2015, 0, 25, 2, 0, 1),
(8, '0011225891', 'Amelia Dwi Chandhary', 'sdn 1 cikadut', 'Wanita', NULL, NULL, '', 27, '666161616', '12345', 28, 1, 2015, 0, 24, 2, 0, 1),
(9, '00225636058', 'Ardujidan Renanda Putra', 'sdn 1 ', 'Pria', NULL, NULL, '', 28, '201611111', '12345', 28, 1, 2015, 0, 23, 2, 0, 0),
(10, '0026202975', 'Ashari Suka Mustaqim', 'sdn 8 ', 'Pria', NULL, NULL, '', 27, '201511111', '12345', 27, 1, 2015, 0, 47, 2, 0, 1),
(11, '0025636059', 'Binno Marwa Supanco', 'sdn 1 coblong', 'Pria', NULL, NULL, '', 29, '1221111', '12345', 27, 1, 2015, 0, 48, 2, 0, 1),
(12, '0018422429', 'Candra Ade Rahayu', 'sdn 1 sukaasih', 'Wanita', NULL, NULL, '', 29, '11211111', '12345', 29, 1, 2015, 0, 17, 2, 0, 1),
(13, '0027563382', 'Dewi Banowati Arbaini', 'sdn 1 sukaluyu', 'Wanita', NULL, NULL, '', 28, '888181818', '12345', 28, 1, 2015, 0, 26, 2, 0, 1),
(14, '0024093616', 'Dinar Aqila', 'sdn II mekarsari', 'Wanita', NULL, NULL, '', 27, '717717771', '12345', 27, 1, 2015, 0, 49, 2, 0, 1),
(15, '0028678616', 'Elsya Saniayu', 'sdn 11 mekarwangi', 'Wanita', NULL, NULL, '', 29, '81881881881', '12345', 0, 0, 2015, 0, 67, 2, 0, 1),
(16, '0027292888', 'Fajriyanti Anna Ramadhani', 'sdn 1 cikutra', 'Wanita', NULL, NULL, '', 26, '77167771', '12345', 26, 1, 2015, 0, 58, 2, 0, 1),
(17, '002469234', 'Fasya Billa Suhendar', 'Sdn III Mekararum', 'Wanita', NULL, NULL, '', 26, '7717171771', '12345', 26, 1, 2015, 0, 59, 2, 0, 1),
(18, '0024487402', 'Faujiah Nur Sa''adah', 'sdn 1 bojongkoneng', 'Pria', NULL, NULL, '', 29, '111221111', '12345', 30, 1, 2015, 0, 2, 2, 0, 1),
(19, '0023275251', 'Handifa Cahayana', 'sdn 2 cikutra', 'Pria', NULL, NULL, '', 26, '81818818', '12345', 27, 1, 2015, 0, 50, 2, 0, 1),
(20, '0011225921', 'Helza Vivia Ramadhanty', 'sdn 1 sukaasih', 'Wanita', NULL, NULL, '', 28, '12888181881', '12345', 28, 1, 2015, 0, 34, 2, 0, 0),
(21, '001827206', 'Iwan Feroloy S', 'sdn 1 cikadut', 'Pria', NULL, NULL, '', 26, '661555151', '12345', 26, 1, 2015, 0, 61, 2, 0, 1),
(22, '002563082', 'Juwono Saputra', 'sdn 3 sadang serang', 'Pria', NULL, NULL, '', 27, '127771717', '12345', 27, 1, 2015, 0, 51, 2, 0, 1),
(23, '0015136809', 'Kinanti Salasabila Rahmannisya', 'sdn II cicadas', 'Wanita', NULL, NULL, '', 25, '21212222', '12345', 25, 1, 2015, 0, 65, 2, 0, 1),
(24, '0028635033', 'Yutika Khairunnisa', 'sdn 1 cicaheum', 'Wanita', NULL, NULL, '', 28, '27', '12345', 28, 1, 2015, 0, 36, 2, 0, 1),
(25, '001070783', 'Zahra Azkyia Nabila', 'sdn 1 sadang seramg', 'Wanita', NULL, NULL, '', 29, '8828282882', '12345', 29, 1, 2015, 0, 5, 2, 0, 1),
(26, '0023275258', 'Alexandra Gracey Zanetta  ', 'sdn 1 cikutra', 'Wanita', NULL, NULL, '', 29, '11221111', '12345', 29, 1, 2015, 0, 6, 2, 0, 1),
(27, '0027096056', 'Al-Fath Shohibulwafas', 'sdn 11 kiaracondong', 'Pria', NULL, NULL, '', 29, '11211111', '12345', 29, 1, 2015, 0, 7, 2, 0, 1),
(28, '0030195511', 'Damar Wulan Pitaloka', 'sdn 2 sekeloa', 'Wanita', NULL, NULL, '', 26, '717177171', '12345', 26, 1, 2015, 0, 63, 2, 0, 1),
(29, '0011728461', 'Deswiya Nurul Azzahra', 'sdn 1 cikudapateuh', 'Wanita', NULL, NULL, '', 29, '292929922', '12345', 29, 1, 2015, 0, 8, 2, 0, 1),
(30, '0028642250', 'Firlly Anggraeni Cahyaningrum', 'sdn 2 ciambuleuit', 'Wanita', NULL, NULL, '', 27, '212222222', '12345', 27, 1, 2015, 0, 55, 2, 0, 1),
(31, '0025496810', 'Ghina Kamilathinnajah', 'sdn 1 pahlawan', 'Wanita', NULL, NULL, '', 29, '71717177171', '12345', 29, 1, 2015, 0, 9, 2, 0, 1),
(32, '0028678586', 'Handika Priyadi', 'sdn 11 ', 'Pria', NULL, NULL, '', 30, '616166161616', '12345', 30, 1, 2015, 0, 1, 2, 0, 1),
(33, '0023512538', 'Irman Nugraha', 'sdn 1 bojongkoneng', 'Wanita', NULL, NULL, '', 29, '9191991991', '12345', 29, 1, 2015, 0, 10, 2, 0, 1),
(34, '0010421216', 'Karmelia Putri', 'sdn 2 bojongkoneng', 'Wanita', NULL, NULL, '', 30, '21112111', '12345', 30, 1, 2015, 0, 4, 2, 0, 1),
(35, '002353813', 'Krisna Adli Hafidz', 'sdn 1 haurmekar', 'Pria', NULL, NULL, '', 28, '81818818181', '12345', 28, 1, 2015, 0, 31, 2, 0, 1),
(36, '0019986745', 'Lina Kania Dewi', 'sdn 1 bojongkoneng', 'Wanita', NULL, NULL, '', 29, '1616161661', '12345', 29, 1, 2015, 0, 11, 2, 0, 1),
(37, '0023865809', 'Lyra Annisya Fasya', 'sdn 2 haurpancuh', 'Wanita', NULL, NULL, '', 30, '71717177111', '12345', 30, 1, 2015, 0, 3, 2, 0, 1),
(38, '0017054415', 'Muhammad Faza Dinan Hakim', 'sdn 1 sindanglaya', 'Pria', NULL, NULL, '', 29, '128881181', '12345', 29, 1, 2015, 0, 12, 2, 0, 1),
(39, '0015968544', 'Nur Annisa Noviyanti', 'sdn 1 sindanglaya', 'Wanita', NULL, NULL, '', 29, '1666161616', '12345', 29, 1, 2015, 0, 18, 2, 0, 1),
(40, '0012809783', 'Salsabilah Nurfadilah', 'sdn 1 haurpancuh', 'Wanita', NULL, NULL, '', 29, '128199191', '12345', 29, 1, 2015, 0, 13, 2, 0, 1),
(41, '0027677300', 'Seppyan Irawan', 'sdn 1 cikadut', 'Pria', NULL, NULL, '', 29, '1818818181', '12345', 29, 1, 2015, 0, 14, 2, 0, 1),
(42, '001142777', 'Sinta Desiyana', 'sdn 1 haurpancuh', 'Wanita', NULL, NULL, '', 29, '18281818', '12345', 29, 1, 2015, 0, 15, 2, 0, 1),
(43, '0025635483', 'Vedia Wanti Kusumah', 'sd II ciambuleuit', 'Wanita', NULL, NULL, '', 28, '8188188181', '12345', 28, 0, 2015, 0, 32, 2, 0, 1),
(44, '0021288578', 'Yunita Amdani', 'sdn 1 cikadut', 'Wanita', NULL, NULL, '', 28, '81818188111', '12345', 28, 1, 2015, 0, 27, 2, 0, 1),
(45, '0018430704', 'Zhahra Bebie Anggistie', 'sdn 11 ', 'Wanita', NULL, NULL, '', 27, '91919111', '12345', 27, 1, 2015, 0, 53, 2, 0, 1),
(46, '0027590844', 'Aiswarai Diva Aisha Salsabhila', 'sdn 2 sukaasih', 'Wanita', NULL, NULL, '', 28, '818111111', '12345', 28, 1, 2015, 0, 28, 2, 0, 1),
(47, '0017257897', 'Annisa Nur Fitriyani', 'sdn 1 cikadut', 'Wanita', NULL, NULL, '', 28, '211222', '12345', 28, 1, 2015, 0, 29, 2, 0, 1),
(48, '0025391447', 'Faris Amran Samudera', 'sdn 1 cikutra', 'Pria', NULL, NULL, '', 28, '18188181812', '12345', 27, 1, 2015, 0, 46, 2, 0, 1),
(49, '0022291410', 'Gaza Karim Amrulloh', 'sdn 1 mekawangi', 'Wanita', NULL, NULL, '', 29, '1818181111', '12345', 27, 1, 2015, 0, 45, 2, 0, 1),
(50, '0026985665', 'Muhammad Hilal Luthfi', 'sdn 1 cikutra', 'Pria', NULL, NULL, '', 29, '122211111', '12345', 29, 1, 2015, 0, 19, 2, 0, 1),
(51, '141507103', 'Silmi Nur Fadillah', 'sdn 1 dipatiukur', 'Wanita', NULL, NULL, '', 29, '2122222', '12345', 29, 1, 2015, 0, 16, 2, 0, 1),
(52, '0017054392', 'zalfa chelinda', 'sdn 1 coblong', 'Wanita', NULL, NULL, '', 26, '576568866', '12345', 26, 1, 2015, 0, 57, 2, 0, 1),
(53, '0010404788', 'Akbar fauzi', 'sdn 1 cicaheum', 'Pria', NULL, NULL, '', 27, '24368995', '12345', 27, 1, 2015, 0, 42, 2, 0, 1),
(54, '0022639848', 'Aldy dwi ananda', 'sdn 1 dipatiukur', 'Pria', NULL, NULL, '', 27, '65772266', '12345', 27, 1, 2015, 0, 41, 2, 0, 1),
(55, '0027959328', 'Anisa Rahmaita', 'sdn 1 cicaheum', 'Wanita', NULL, NULL, '', 28, '4753882522', '12345', 27, 1, 2015, 0, 39, 2, 0, 1),
(56, '00234470520', 'Arief Al Ghifari', 'sdn 2 cikutra', 'Pria', NULL, NULL, '', 29, '46757534', '12345', 27, 0, 2015, 0, 38, 2, 0, 1),
(57, '0022830138', 'Deni Rahmat Pratama', 'sdn 11 kiaracondong', 'Pria', NULL, NULL, '', 28, '53657855', '12345', 28, 1, 2015, 0, 33, 2, 0, 1),
(58, '0015643682', 'Fitri Dewi Lestari', 'sdn 1 sindanglaya', 'Wanita', NULL, NULL, '', 28, '476476587', '12345', 26, 0, 2015, 0, 62, 2, 0, 1),
(59, '002371629', 'Fadhil Muhammad', 'sdn 1 sukaluyu', 'Pria', NULL, NULL, '', 29, '365786950', '12345', 17, 1, 2015, 0, 66, 2, 0, 1),
(60, '0011225919', 'Syifa Fadiah Idzhni Nabilah', 'sdn 1 haurpancuh', 'Wanita', NULL, NULL, '', 28, '08929802', '12345', 28, 1, 2015, 0, 30, 2, 0, 1),
(61, '0019955095', 'Silpiyani', 'sdn II cicadas', 'Wanita', NULL, NULL, '', 29, '101002872', '12345', 29, 1, 2015, 0, 21, 2, 0, 1),
(62, '0010404367', 'Viana Anggraeni', 'sdn 2 bojongkoneng', 'Wanita', NULL, NULL, '', 26, '537620281', '12345', 26, 1, 2015, 0, 60, 2, 0, 1),
(63, '0027292579', 'Zulfah Safrani', 'sd', 'Wanita', NULL, NULL, '', 29, '287258270', '12345', 29, 1, 2015, 0, 22, 2, 0, 1),
(64, '0018393284', 'Aina Salsabila', 'sdn 2 ciambuleuit', 'Wanita', NULL, NULL, '', 28, '532829622', '12345', 28, 1, 2015, 0, 35, 2, 0, 1),
(65, '0023455909', 'Bintang Junianto', 'sdn 1 coblong', 'Pria', NULL, NULL, '', 29, '2452156890', '12345', 28, 1, 2015, 0, 37, 2, 0, 1),
(66, '0023455900', 'Arizal Muhammad', 'sdn 1 cikadut', 'Pria', NULL, NULL, '', 27, '452380902', '12345', 27, 1, 2015, 0, 43, 2, 0, 1),
(67, '0023455957', 'Cindy Pertiwi', 'sdn 1 cikutra', 'Wanita', NULL, NULL, '', 27, '0279372890', '12345', 27, 1, 2015, 0, 44, 2, 0, 1),
(68, '0018549352', 'Agus', 'sdn 1 cikutra', 'Pria', NULL, NULL, '', 26, '651090082', '12345', 25, 1, 2015, 0, 64, 2, 0, 1),
(69, '0016898027', 'Rizky Ramadhan', 'sdn 1 coblong', 'Pria', NULL, NULL, '', 29, '69202381o', '12345', 29, 1, 2015, 0, 20, 2, 0, 1),
(70, '0027292569', 'Siti Rika', 'sdn 1 haurpancuh', 'Wanita', NULL, NULL, '', 20, '693634933', '12345', 26, 1, 2015, 0, 56, 2, 0, 1),
(71, '2020202', 'Chilman', 'sdn 1 haurgeulis', 'Pria', NULL, NULL, '', 28, '222222', '12345', 0, 0, 2015, 0, 68, 2, 0, 1),
(72, '21212720', 'Nur Aldila Karunia', 'Sdn 1 Cikadut', 'Wanita', NULL, NULL, '', 27, '292929292', '12345', 27, 1, 2015, 0, 40, 2, 0, 1),
(73, '191919191', 'Nofia ', 'sdn 1 cikutra', 'Wanita', NULL, NULL, '', 28, '7777777', '12345', 27, 1, 2015, 0, 3, 2, 0, 1),
(74, '272727272', 'Chilman', 'sdn 1 margahayu', 'Pria', NULL, NULL, '', 27, '717171711', '12345', 27, 1, 2015, 0, 4, 2, 0, 1),
(75, '27122222', 'Ilham', 'sdn 2 antapani', 'Pria', NULL, NULL, '', 28, '18888181', '12345', 28, 1, 2015, 0, 1, 2, 0, 1),
(76, '2222222', 'Diah', 'sdn II ', 'Wanita', NULL, NULL, '', 28, '171771711', '12345', 28, 1, 2015, 0, 2, 2, 0, 1),
(77, '222222', 'aldila karunia', 'sdn 3 ', 'Wanita', NULL, NULL, '', 29, '19191991', '12345', 29, 1, 2016, 0, 1, 2, 0, 1),
(78, '22222`', 'aaaa', 'sdn 2', 'Pria', NULL, NULL, '', 89, '22222', '12345', 89, 1, 2011, 0, 1, 2, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tr_tahun_ajaran`
--

CREATE TABLE IF NOT EXISTS `tr_tahun_ajaran` (
  `id_tahun_ajaran` int(11) NOT NULL AUTO_INCREMENT,
  `tahun` smallint(4) DEFAULT NULL,
  `kelas` tinyint(2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `kuota` smallint(4) DEFAULT NULL,
  PRIMARY KEY (`id_tahun_ajaran`),
  UNIQUE KEY `TAHUN_AJARAN` (`tahun`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `tr_tahun_ajaran`
--

INSERT INTO `tr_tahun_ajaran` (`id_tahun_ajaran`, `tahun`, `kelas`, `status`, `kuota`) VALUES
(10, 2010, 9, 3, 340);

--
-- Triggers `tr_tahun_ajaran`
--
DROP TRIGGER IF EXISTS `seleksi`;
DELIMITER //
CREATE TRIGGER `seleksi` BEFORE UPDATE ON `tr_tahun_ajaran`
 FOR EACH ROW BEGIN
     IF new.status = 2 THEN
	call p_lulus(old.kuota, old.tahun );
   
    ELSEIF new.status = 3 THEN
	call p_seleksi(old.tahun, 1, old.kelas );
   END IF;
    END
//
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
