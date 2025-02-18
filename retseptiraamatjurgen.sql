-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 18, 2025 kell 02:01 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `retseptiraamatjurgen`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Kustutahind` (IN `deleteId ` INT)   begin
select * from hind;
delete from hind where hind=deleteId;
select * from hind;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisahind` (IN `hind ` INT, IN `toiduaine_id ` INT)   begin 

insert into hind(hind, toiduaine_id)
values (hind, toiduaine_id);
select * from hind;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisakoostis` (IN `kogus` VARCHAR(30), IN `retsept_retsept_id ` INT, IN `toiduaine_id` INT, IN `yhik_id` INT)   begin 

insert into koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
values (kogus, retsept_retsept_id, toiduaine_id, yhik_id);
select * from koostis;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaretsept` (IN `retsepti_nimi` VARCHAR(100), IN `kirjeldus ` VARCHAR(200), IN `juhen` VARCHAR(500), IN `sisetatud_kp ` DATE, IN `kasutaja_id` INT, IN `kategooria_id` INT)   begin 

insert into retsept(retsepti_nimi, kirjeldus, juhen, sisetatud_kp, kasutaja_id, kategooria_id)
values (retsepti_nimi, kirjeldus, juhen, sisetatud_kp, kasutaja_id, kategooria_id);
select * from retsept;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Lisatehtud` (IN `tehtud_kp ` DATE, IN `retsept_id ` INT)   begin 

insert into tehtud(tehtud_kp, retsept_id)
values (tehtud_kp, retsept_id);
select * from tehtud;

end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `hind`
--

CREATE TABLE `hind` (
  `hind_id` int(11) NOT NULL,
  `hind` int(11) DEFAULT NULL,
  `toiduaine_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `hind`
--

INSERT INTO `hind` (`hind_id`, `hind`, `toiduaine_id`) VALUES
(1, 25, 1),
(2, 30, 2),
(3, 45, 3),
(4, 12, 4),
(5, 14, 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kasutaja`
--

CREATE TABLE `kasutaja` (
  `kasutaja_id` int(11) NOT NULL,
  `eesnimi` varchar(50) DEFAULT NULL,
  `perenimi` varchar(50) NOT NULL,
  `email` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kasutaja`
--

INSERT INTO `kasutaja` (`kasutaja_id`, `eesnimi`, `perenimi`, `email`) VALUES
(1, 'Roma', 'Ztsev', 'romagmail.com'),
(2, 'Martn', 'Rosak', 'martingmail.com'),
(3, 'Nikita', 'Litv', 'nikitagmail.com'),
(4, 'Ilja', 'Jun', 'iljagmail.com');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kategooria`
--

CREATE TABLE `kategooria` (
  `kategooria_id` int(11) NOT NULL,
  `kategooria_nimi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kategooria`
--

INSERT INTO `kategooria` (`kategooria_id`, `kategooria_nimi`) VALUES
(1, 'meet'),
(2, 'chees'),
(3, 'magusad'),
(4, 'solased'),
(5, 'suppid');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `koostis`
--

CREATE TABLE `koostis` (
  `koostis_id` int(11) NOT NULL,
  `kogus` int(11) DEFAULT NULL,
  `retsept_retsept_id` int(11) DEFAULT NULL,
  `toiduaine_id` int(11) DEFAULT NULL,
  `yhik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `koostis`
--

INSERT INTO `koostis` (`koostis_id`, `kogus`, `retsept_retsept_id`, `toiduaine_id`, `yhik_id`) VALUES
(4, 2, 1, 1, 1),
(5, 3, 2, 2, 2),
(6, 6, 3, 3, 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `retsept`
--

CREATE TABLE `retsept` (
  `retsept_id` int(11) NOT NULL,
  `retsepti_nimi` varchar(100) DEFAULT NULL,
  `kirjeldus` varchar(200) DEFAULT NULL,
  `juhen` varchar(500) DEFAULT NULL,
  `sisetatud_kp` date DEFAULT NULL,
  `kasutaja_id` int(11) DEFAULT NULL,
  `kategooria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `retsept`
--

INSERT INTO `retsept` (`retsept_id`, `retsepti_nimi`, `kirjeldus`, `juhen`, `sisetatud_kp`, `kasutaja_id`, `kategooria_id`) VALUES
(1, 'tort', 'väga magus', 'sega kõike', '2025-03-03', 1, 1),
(2, 'võileib juustuga', 'võileib, juust', 'sega kõike', '2025-03-03', 2, 2),
(3, 'kohupiim meega', 'kohupiim, mee', 'sega kõike', '2025-03-03', 3, 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tehtud`
--

CREATE TABLE `tehtud` (
  `tehtud_id` int(11) NOT NULL,
  `tehtud_kp` date DEFAULT NULL,
  `retsept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `tehtud`
--

INSERT INTO `tehtud` (`tehtud_id`, `tehtud_kp`, `retsept_id`) VALUES
(1, '2025-03-12', 1),
(2, '2025-03-10', 2),
(3, '2025-02-12', 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `toiduaine`
--

CREATE TABLE `toiduaine` (
  `toiduaine_id` int(11) NOT NULL,
  `toiduaine_nimi` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `toiduaine`
--

INSERT INTO `toiduaine` (`toiduaine_id`, `toiduaine_nimi`) VALUES
(1, 'milk'),
(2, 'sool'),
(3, 'sugar'),
(4, 'juust'),
(5, 'liha'),
(6, 'munad');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `yhik`
--

CREATE TABLE `yhik` (
  `yhik_id` int(11) NOT NULL,
  `yhik_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `yhik`
--

INSERT INTO `yhik` (`yhik_id`, `yhik_nimi`) VALUES
(1, 'ml'),
(2, 'tl'),
(3, 'sl'),
(4, 'g'),
(5, 'kg');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `hind`
--
ALTER TABLE `hind`
  ADD PRIMARY KEY (`hind_id`),
  ADD KEY `toiduaine_id` (`toiduaine_id`);

--
-- Indeksid tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  ADD PRIMARY KEY (`kasutaja_id`);

--
-- Indeksid tabelile `kategooria`
--
ALTER TABLE `kategooria`
  ADD PRIMARY KEY (`kategooria_id`);

--
-- Indeksid tabelile `koostis`
--
ALTER TABLE `koostis`
  ADD PRIMARY KEY (`koostis_id`),
  ADD KEY `retsept_retsept_id` (`retsept_retsept_id`),
  ADD KEY `toiduaine_id` (`toiduaine_id`),
  ADD KEY `yhik_id` (`yhik_id`);

--
-- Indeksid tabelile `retsept`
--
ALTER TABLE `retsept`
  ADD PRIMARY KEY (`retsept_id`),
  ADD KEY `kasutaja_id` (`kasutaja_id`),
  ADD KEY `kategooria_id` (`kategooria_id`);

--
-- Indeksid tabelile `tehtud`
--
ALTER TABLE `tehtud`
  ADD PRIMARY KEY (`tehtud_id`),
  ADD KEY `retsept_id` (`retsept_id`);

--
-- Indeksid tabelile `toiduaine`
--
ALTER TABLE `toiduaine`
  ADD PRIMARY KEY (`toiduaine_id`);

--
-- Indeksid tabelile `yhik`
--
ALTER TABLE `yhik`
  ADD PRIMARY KEY (`yhik_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `hind`
--
ALTER TABLE `hind`
  MODIFY `hind_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `kategooria`
--
ALTER TABLE `kategooria`
  MODIFY `kategooria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `koostis`
--
ALTER TABLE `koostis`
  MODIFY `koostis_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `retsept`
--
ALTER TABLE `retsept`
  MODIFY `retsept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `tehtud`
--
ALTER TABLE `tehtud`
  MODIFY `tehtud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `toiduaine`
--
ALTER TABLE `toiduaine`
  MODIFY `toiduaine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `yhik`
--
ALTER TABLE `yhik`
  MODIFY `yhik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `hind`
--
ALTER TABLE `hind`
  ADD CONSTRAINT `hind_ibfk_1` FOREIGN KEY (`toiduaine_id`) REFERENCES `toiduaine` (`toiduaine_id`);

--
-- Piirangud tabelile `koostis`
--
ALTER TABLE `koostis`
  ADD CONSTRAINT `koostis_ibfk_1` FOREIGN KEY (`retsept_retsept_id`) REFERENCES `retsept` (`retsept_id`),
  ADD CONSTRAINT `koostis_ibfk_2` FOREIGN KEY (`toiduaine_id`) REFERENCES `toiduaine` (`toiduaine_id`),
  ADD CONSTRAINT `koostis_ibfk_3` FOREIGN KEY (`yhik_id`) REFERENCES `yhik` (`yhik_id`);

--
-- Piirangud tabelile `retsept`
--
ALTER TABLE `retsept`
  ADD CONSTRAINT `retsept_ibfk_1` FOREIGN KEY (`kasutaja_id`) REFERENCES `kasutaja` (`kasutaja_id`),
  ADD CONSTRAINT `retsept_ibfk_2` FOREIGN KEY (`kategooria_id`) REFERENCES `kategooria` (`kategooria_id`);

--
-- Piirangud tabelile `tehtud`
--
ALTER TABLE `tehtud`
  ADD CONSTRAINT `tehtud_ibfk_1` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
