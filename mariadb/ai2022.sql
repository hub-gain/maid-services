-- --------------------------------------------------------
-- Host:                         192.168.123.4
-- Server version:               10.8.3-MariaDB-1:10.8.3+maria~jammy - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb3 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for atominterferometer2022
CREATE DATABASE IF NOT EXISTS `atominterferometer2022` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `atominterferometer2022`;

-- Dumping structure for procedure atominterferometer2022.addMesswert
DELIMITER //
CREATE PROCEDURE `addMesswert`(IN p_Messwert_Nr int,
	 IN p_Sample_Nr int(5),
	 IN p_Messwert double)
BEGIN
	INSERT INTO `Messwerte` (Messwert_Nr, Sample_Nr, Messwert)
		VALUES (
			p_Messwert_Nr,
			p_Sample_Nr,
			p_Messwert
				);
END//
DELIMITER ;

-- Dumping structure for table atominterferometer2022.AO_Waveforms
CREATE TABLE IF NOT EXISTS `AO_Waveforms` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Waveform_Nr` int(10) unsigned NOT NULL,
  `Zeitwert` double unsigned NOT NULL,
  `Spannung` double NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `waveformnr` (`Waveform_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.ChirpDDS_Sequenzen
CREATE TABLE IF NOT EXISTS `ChirpDDS_Sequenzen` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `DDS1_Sequenz_Nr` int(10) unsigned NOT NULL,
  `DDS_Nr` enum('1','2','3','4','5') NOT NULL,
  `Frequenz` double unsigned DEFAULT NULL,
  `Chirprate` double DEFAULT NULL,
  `Amplitude` decimal(3,1) DEFAULT NULL,
  `Phase` smallint(5) NOT NULL,
  `Referenz` tinytext DEFAULT NULL,
  `Startzeit` double unsigned NOT NULL,
  `Referenzzeit` double unsigned NOT NULL,
  `Stopzeit` double unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `DDS1seqnrindex` (`DDS1_Sequenz_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Tabelle fuer die chirpbaren DDS';

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.DDS_Sequenzen
CREATE TABLE IF NOT EXISTS `DDS_Sequenzen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DDS_Sequenz_Nr` int(10) unsigned NOT NULL,
  `DDS_Nr` enum('1','2','3','4','5') COLLATE latin1_german1_ci NOT NULL,
  `Kanal0_Frequenz` double unsigned NOT NULL,
  `Kanal0_Amplitude` decimal(3,1) NOT NULL,
  `Kanal1_Frequenz` double unsigned NOT NULL,
  `Kanal1_Amplitude` decimal(3,1) NOT NULL,
  `Bezeichnung` tinytext COLLATE latin1_german1_ci DEFAULT NULL,
  `Haltezeit` double unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ddssequenznr` (`DDS_Sequenz_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- Data exporting was unselected.

-- Dumping structure for procedure atominterferometer2022.getNextNumbers
DELIMITER //
CREATE PROCEDURE `getNextNumbers`()
BEGIN
DECLARE test INT;
DECLARE next_Sequenz_Nr, next_Sequenzarray_Nr, next_Waveform_Nr, next_DDS_Sequenz_Nr INT;

SELECT count(id)!=0 INTO test from Sequenzen;
IF test THEN
	SELECT max(Nr)+1 into next_Sequenz_Nr from Sequenzen;
ELSE 
	SET next_Sequenz_Nr=1;
END IF;

SELECT count(id)!=0 INTO test from Sequenz_Arrays;
IF test THEN
	SELECT Array_Nr+1 into next_Sequenzarray_Nr from Sequenz_Arrays order by ID Desc limit 1;
ELSE 
	SET next_Sequenzarray_Nr=1;
END IF;

SELECT count(id)!=0 INTO test from AO_Waveforms;
IF test THEN
	SELECT Waveform_Nr+1 into next_Waveform_Nr from AO_Waveforms order by ID desc limit 1;
ELSE 
	SET next_Waveform_Nr=1;
END IF;

SELECT count(id)!=0 INTO test from DDS_Sequenzen;
IF test THEN
	SELECT DDS_Sequenz_Nr+1 into next_DDS_Sequenz_Nr from DDS_Sequenzen order by ID desc limit 1;
ELSE 
	SET next_DDS_Sequenz_Nr=1;
END IF;

SELECT next_Sequenz_Nr, next_Sequenzarray_Nr, next_Waveform_Nr, next_DDS_Sequenz_Nr;

END//
DELIMITER ;

-- Dumping structure for procedure atominterferometer2022.getNextNumbers2
DELIMITER //
CREATE PROCEDURE `getNextNumbers2`()
BEGIN
DECLARE test INT;
DECLARE next_Sequenzarray_Nr, next_Waveform_Nr, next_DDS_Sequenz_Nr INT;


SELECT count(id)!=0 INTO test from Sequenz_Arrays;
IF test THEN
	SELECT Array_Nr+1 into next_Sequenzarray_Nr from Sequenz_Arrays order by ID Desc limit 1;
ELSE 
	SET next_Sequenzarray_Nr=1;
END IF;

SELECT count(id)!=0 INTO test from AO_Waveforms;
IF test THEN
	SELECT Waveform_Nr+1 into next_Waveform_Nr from AO_Waveforms order by ID desc limit 1;
ELSE 
	SET next_Waveform_Nr=1;
END IF;

SELECT count(id)!=0 INTO test from DDS_Sequenzen;
IF test THEN
	SELECT DDS_Sequenz_Nr+1 into next_DDS_Sequenz_Nr from DDS_Sequenzen order by ID desc limit 1;
ELSE 
	SET next_DDS_Sequenz_Nr=1;
END IF;

SELECT next_Sequenzarray_Nr, next_Waveform_Nr, next_DDS_Sequenz_Nr;

END//
DELIMITER ;

-- Dumping structure for procedure atominterferometer2022.getNumbersForNextMessreihe
DELIMITER //
CREATE PROCEDURE `getNumbersForNextMessreihe`()
BEGIN
DECLARE test INT;
DECLARE next_Messreihen_ID, next_Messwert_Nr INT;

SELECT max(id)+1 INTO next_Messreihen_ID from Messreihen;

SELECT count(Messwert_Nr)!=0 INTO test from Messwerte;
IF test THEN
	SELECT max(Messwert_Nr)+1 into next_Messwert_Nr from Messwerte;
ELSE 
	SET next_Messwert_Nr=1;
END IF;

SELECT next_Messreihen_ID, next_Messwert_Nr;

END//
DELIMITER ;

-- Dumping structure for view atominterferometer2022.letzte Messreihen
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `letzte Messreihen` (
	`ID` INT(10) UNSIGNED NOT NULL,
	`Datum` DATETIME NOT NULL,
	`Kommentar` TEXT NULL COLLATE 'latin1_swedish_ci',
	`Scanparameter` TEXT NULL COLLATE 'latin1_swedish_ci'
) ENGINE=MyISAM;

-- Dumping structure for view atominterferometer2022.letzte Sequenzen
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `letzte Sequenzen` (
	`ID` INT(10) UNSIGNED NOT NULL,
	`Nr` MEDIUMINT(8) UNSIGNED NOT NULL,
	`Datum` DATETIME NOT NULL,
	`Kommentar` TEXT NULL COLLATE 'latin1_german1_ci'
) ENGINE=MyISAM;

-- Dumping structure for table atominterferometer2022.Messreihen
CREATE TABLE IF NOT EXISTS `Messreihen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Datum` datetime NOT NULL,
  `Kommentar` text DEFAULT NULL,
  `Scanparameter` text DEFAULT NULL,
  `PMT_Empfindlichkeit` decimal(4,2) NOT NULL,
  `CC_Orientation_PI` decimal(4,1) NOT NULL COMMENT 'Coriolis Compensator: Orientation of the Coriolis Compensator in degree',
  `CC_Interferometer_Coriolis_Speed` decimal(5,2) NOT NULL COMMENT 'Coriolis Compensator: Tilt speed (rad/s) on Coriolis-Axis during Interferometer phase',
  `CC_Interferometer_2ndAxis_Speed` decimal(5,2) NOT NULL COMMENT 'Coriolis Compensator: Tilt speed (rad/s) on perpendicular-Axis during Interferometer phase',
  `CC_MOT_Coriolis_Speed` decimal(5,2) NOT NULL COMMENT 'Coriolis Compensator: Tilt speed (rad/s) on Coriolis-Axis during alignment pulses (MOT-Phase)',
  `CC_MOT_2ndAxis_Speed` decimal(5,2) NOT NULL COMMENT 'Coriolis Compensator: Tilt speed (rad/s) on perpendicular-Axis during alignment pulses (MOT-Phase)',
  `RamanMasterIntensity` decimal(4,3) DEFAULT NULL COMMENT 'Raman Master Intensity from Photodiode AFTER adjustment',
  `RamanSlaveIntensity` decimal(4,3) DEFAULT NULL COMMENT 'Raman Slave Intensity from Photodiode AFTER adjustment',
  `RamanMasterIntensityBeforeAdjustment` decimal(4,3) DEFAULT NULL COMMENT 'Raman Master Intensity from Photodiode BEFORE adjustment',
  `RamanSlaveIntensityBeforeAdjustment` decimal(4,3) DEFAULT NULL COMMENT 'Raman Slave Intensity from Photodiode BEFORE adjustment',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.Messungen
CREATE TABLE IF NOT EXISTS `Messungen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Datum` datetime NOT NULL,
  `Millisekunden` smallint(3) unsigned zerofill NOT NULL DEFAULT 000,
  `Netzphase` float DEFAULT NULL COMMENT 'Zeit in ms seit NetzTrigger',
  `Sequenz_ID` int(10) unsigned NOT NULL,
  `Messreihen_ID` int(10) unsigned NOT NULL,
  `Messwert_Nr` int(10) unsigned NOT NULL,
  `Messzeit` double unsigned NOT NULL,
  `Scanwert` double DEFAULT NULL,
  `Messungstyp` enum('k+_AOM-Faktor','k+_Flanken','k+_Scannen','k-_AOM-Faktor','k-_Flanken','k-_Scannen','') COLLATE latin1_german1_ci DEFAULT NULL,
  `Timing_Fehler` tinyint(1) NOT NULL,
  `Tilt_X` float DEFAULT NULL,
  `Tilt_Y` float DEFAULT NULL,
  `Tilt_X_Teleskop` float DEFAULT NULL,
  `Tilt_Y_Teleskop` float DEFAULT NULL,
  `Temperatur` float DEFAULT NULL,
  `Drucksensor` float unsigned DEFAULT NULL,
  `Ramanpuls1` float DEFAULT NULL,
  `Ramanpuls2` float DEFAULT NULL,
  `Ramanpuls3` float DEFAULT NULL,
  `Ramanpuls4` float DEFAULT NULL,
  `Ramanpuls5` float DEFAULT NULL,
  `Ramanpuls6` float DEFAULT NULL,
  `Ramanleistung` float DEFAULT NULL,
  `Luftdruck` double DEFAULT NULL,
  `RamanBeatAmplitude` float DEFAULT NULL,
  `CC_MeanTilt_CoriolisAxis` float DEFAULT NULL COMMENT 'Piezo value for backcoupling during the 2nd Raman pulse on Coriolis axis (mu-rad)',
  `CC_MeanTilt_2ndAxis` float DEFAULT NULL COMMENT 'Piezo value for backcoupling during the 2nd Raman pulse on the perpendicular axis (mu-rad)',
  `MOT_Kammer_TiltX` float DEFAULT NULL COMMENT 'Output of the Inklinometer (V) - x-axis',
  `MOT_Kammer_TiltY` float DEFAULT NULL COMMENT 'Output of the Inklinometer (V) - y-axis',
  `Delta_10MHz` float DEFAULT NULL COMMENT 'Difference: GAIN 10MHz - GPS 10MHz in Hz',
  `IonPumpCurrent` float DEFAULT NULL COMMENT 'Output of the Ion pump (V) - for calculation of its current',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.Messwerte
CREATE TABLE IF NOT EXISTS `Messwerte` (
  `Messwert_Nr` int(10) unsigned NOT NULL,
  `Sample_Nr` smallint(5) unsigned NOT NULL,
  `Messwert` double NOT NULL,
  KEY `Messwert_Nr` (`Messwert_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.Nullmessungen
CREATE TABLE IF NOT EXISTS `Nullmessungen` (
  `Messwert_Nr` int(10) unsigned NOT NULL,
  `Sample_Nr` smallint(5) unsigned NOT NULL,
  `Nullmesswert` double NOT NULL,
  KEY `Messwert_Nr` (`Messwert_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.Piezo_Spiegel
CREATE TABLE IF NOT EXISTS `Piezo_Spiegel` (
  `Sequenz_Array_Nr` int(10) unsigned NOT NULL COMMENT 'here the same number as for the Sequenz_array is used',
  `Event_Start` double unsigned NOT NULL,
  `coriolis_NS` double NOT NULL COMMENT 'start angle (rotation about north-south axis) in microradian',
  `coriolis_NS_rate` double NOT NULL COMMENT 'rotation rate (about north-south axis) in microradian per second',
  `coriolis_WE` double NOT NULL COMMENT 'start angle (rotation about west-east axis) in microradian',
  `coriolis_WE_rate` double NOT NULL COMMENT 'rotation rate (about west-east axis) in microradian per second'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='angles and rates for coriolis compensation';

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.Sequenzen
CREATE TABLE IF NOT EXISTS `Sequenzen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nr` mediumint(8) unsigned NOT NULL,
  `Nr_firsttime` tinyint(1) NOT NULL DEFAULT 0,
  `Datum` datetime NOT NULL,
  `Kommentar` text COLLATE latin1_german1_ci DEFAULT NULL,
  `Sequenz_Array_Nr` int(10) unsigned NOT NULL,
  `DDS1_Sequenz_Nr` int(10) unsigned NOT NULL,
  `DDS1_Kanal2_Frequenz` double unsigned NOT NULL,
  `DDS1_Kanal2_Amplitude` decimal(3,1) NOT NULL,
  `DDS1_Kanal3_Frequenz` double unsigned NOT NULL,
  `DDS1_Kanal3_Amplitude` decimal(3,1) NOT NULL,
  `DDS2_Sequenz_Nr` int(10) unsigned NOT NULL,
  `DDS2_Kanal2_Frequenz` double unsigned NOT NULL,
  `DDS2_Kanal2_Amplitude` decimal(3,1) NOT NULL,
  `DDS2_Kanal3_Frequenz` double unsigned NOT NULL,
  `DDS2_Kanal3_Amplitude` decimal(3,1) NOT NULL,
  `Scanstart` tinyint(1) NOT NULL DEFAULT 0,
  `Piezo_Spiegel_Orientierung` double DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `firsttime` (`Nr_firsttime`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- Data exporting was unselected.

-- Dumping structure for table atominterferometer2022.Sequenz_Arrays
CREATE TABLE IF NOT EXISTS `Sequenz_Arrays` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Array_Nr` int(10) unsigned NOT NULL,
  `Eventnummer` double NOT NULL,
  `Kanal` tinytext COLLATE latin1_german1_ci NOT NULL,
  `Info` tinytext COLLATE latin1_german1_ci DEFAULT NULL,
  `Bezeichnung` tinytext COLLATE latin1_german1_ci DEFAULT NULL,
  `Startreferenz` tinytext COLLATE latin1_german1_ci DEFAULT NULL,
  `Startabstand` double DEFAULT NULL,
  `Event_Start` double unsigned NOT NULL,
  `Stoppreferenz` tinytext COLLATE latin1_german1_ci DEFAULT NULL,
  `Stoppabstand` double DEFAULT NULL,
  `Event_Stopp` double unsigned NOT NULL,
  `Event_Dauer` double unsigned NOT NULL,
  `AO_Waveform` tinyint(1) NOT NULL,
  `AO_Waveform_Nr` int(10) unsigned DEFAULT NULL,
  `AO_Formel` text COLLATE latin1_german1_ci DEFAULT NULL,
  `Aktiviert` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `arraynr` (`Array_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- Data exporting was unselected.

-- Dumping structure for view atominterferometer2022.standard2
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `standard2` (
	`ID` INT(10) UNSIGNED NOT NULL,
	`Datum` DATETIME NOT NULL,
	`Kommentar` TEXT NULL COLLATE 'latin1_german1_ci',
	`Launch-Frequenz` DOUBLE UNSIGNED NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for table atominterferometer2022.Vibration_Data
CREATE TABLE IF NOT EXISTS `Vibration_Data` (
  `Timestamp` datetime NOT NULL COMMENT 'zeitpunkt vom LETZTEN Wert',
  `Milliseconds` decimal(3,0) NOT NULL COMMENT 'Millisekunden vom Timestamp',
  `Kanal` enum('cmg3acc','errorsignal','cmg40vel','cmg3masspos','lvdtpos','cmg40ns','cmg40ew') NOT NULL,
  `TriggerOnValue` decimal(5,3) DEFAULT NULL COMMENT 'Sample number, on which the trigger was detected (0.000 to 99.999), "-1" -> no trigger detected',
  `V0` decimal(9,7) NOT NULL,
  `V1` decimal(9,7) NOT NULL,
  `V2` decimal(9,7) NOT NULL,
  `V3` decimal(9,7) NOT NULL,
  `V4` decimal(9,7) NOT NULL,
  `V5` decimal(9,7) NOT NULL,
  `V6` decimal(9,7) NOT NULL,
  `V7` decimal(9,7) NOT NULL,
  `V8` decimal(9,7) NOT NULL,
  `V9` decimal(9,7) NOT NULL,
  `V10` decimal(9,7) NOT NULL,
  `V11` decimal(9,7) NOT NULL,
  `V12` decimal(9,7) NOT NULL,
  `V13` decimal(9,7) NOT NULL,
  `V14` decimal(9,7) NOT NULL,
  `V15` decimal(9,7) NOT NULL,
  `V16` decimal(9,7) NOT NULL,
  `V17` decimal(9,7) NOT NULL,
  `V18` decimal(9,7) NOT NULL,
  `V19` decimal(9,7) NOT NULL,
  `V20` decimal(9,7) NOT NULL,
  `V21` decimal(9,7) NOT NULL,
  `V22` decimal(9,7) NOT NULL,
  `V23` decimal(9,7) NOT NULL,
  `V24` decimal(9,7) NOT NULL,
  `V25` decimal(9,7) NOT NULL,
  `V26` decimal(9,7) NOT NULL,
  `V27` decimal(9,7) NOT NULL,
  `V28` decimal(9,7) NOT NULL,
  `V29` decimal(9,7) NOT NULL,
  `V30` decimal(9,7) NOT NULL,
  `V31` decimal(9,7) NOT NULL,
  `V32` decimal(9,7) NOT NULL,
  `V33` decimal(9,7) NOT NULL,
  `V34` decimal(9,7) NOT NULL,
  `V35` decimal(9,7) NOT NULL,
  `V36` decimal(9,7) NOT NULL,
  `V37` decimal(9,7) NOT NULL,
  `V38` decimal(9,7) NOT NULL,
  `V39` decimal(9,7) NOT NULL,
  `V40` decimal(9,7) NOT NULL,
  `V41` decimal(9,7) NOT NULL,
  `V42` decimal(9,7) NOT NULL,
  `V43` decimal(9,7) NOT NULL,
  `V44` decimal(9,7) NOT NULL,
  `V45` decimal(9,7) NOT NULL,
  `V46` decimal(9,7) NOT NULL,
  `V47` decimal(9,7) NOT NULL,
  `V48` decimal(9,7) NOT NULL,
  `V49` decimal(9,7) NOT NULL,
  `V50` decimal(9,7) NOT NULL,
  `V51` decimal(9,7) NOT NULL,
  `V52` decimal(9,7) NOT NULL,
  `V53` decimal(9,7) NOT NULL,
  `V54` decimal(9,7) NOT NULL,
  `V55` decimal(9,7) NOT NULL,
  `V56` decimal(9,7) NOT NULL,
  `V57` decimal(9,7) NOT NULL,
  `V58` decimal(9,7) NOT NULL,
  `V59` decimal(9,7) NOT NULL,
  `V60` decimal(9,7) NOT NULL,
  `V61` decimal(9,7) NOT NULL,
  `V62` decimal(9,7) NOT NULL,
  `V63` decimal(9,7) NOT NULL,
  `V64` decimal(9,7) NOT NULL,
  `V65` decimal(9,7) NOT NULL,
  `V66` decimal(9,7) NOT NULL,
  `V67` decimal(9,7) NOT NULL,
  `V68` decimal(9,7) NOT NULL,
  `V69` decimal(9,7) NOT NULL,
  `V70` decimal(9,7) NOT NULL,
  `V71` decimal(9,7) NOT NULL,
  `V72` decimal(9,7) NOT NULL,
  `V73` decimal(9,7) NOT NULL,
  `V74` decimal(9,7) NOT NULL,
  `V75` decimal(9,7) NOT NULL,
  `V76` decimal(9,7) NOT NULL,
  `V77` decimal(9,7) NOT NULL,
  `V78` decimal(9,7) NOT NULL,
  `V79` decimal(9,7) NOT NULL,
  `V80` decimal(9,7) NOT NULL,
  `V81` decimal(9,7) NOT NULL,
  `V82` decimal(9,7) NOT NULL,
  `V83` decimal(9,7) NOT NULL,
  `V84` decimal(9,7) NOT NULL,
  `V85` decimal(9,7) NOT NULL,
  `V86` decimal(9,7) NOT NULL,
  `V87` decimal(9,7) NOT NULL,
  `V88` decimal(9,7) NOT NULL,
  `V89` decimal(9,7) NOT NULL,
  `V90` decimal(9,7) NOT NULL,
  `V91` decimal(9,7) NOT NULL,
  `V92` decimal(9,7) NOT NULL,
  `V93` decimal(9,7) NOT NULL,
  `V94` decimal(9,7) NOT NULL,
  `V95` decimal(9,7) NOT NULL,
  `V96` decimal(9,7) NOT NULL,
  `V97` decimal(9,7) NOT NULL,
  `V98` decimal(9,7) NOT NULL,
  `V99` decimal(9,7) NOT NULL,
  KEY `timestamp` (`Timestamp`),
  KEY `kanal` (`Kanal`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for view atominterferometer2022.letzte Messreihen
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `letzte Messreihen`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `letzte Messreihen` AS select `Messreihen`.`ID` AS `ID`,`Messreihen`.`Datum` AS `Datum`,`Messreihen`.`Kommentar` AS `Kommentar`,`Messreihen`.`Scanparameter` AS `Scanparameter` from `Messreihen` order by `Messreihen`.`ID` desc;

-- Dumping structure for view atominterferometer2022.letzte Sequenzen
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `letzte Sequenzen`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `letzte Sequenzen` AS select `Sequenzen`.`ID` AS `ID`,`Sequenzen`.`Nr` AS `Nr`,`Sequenzen`.`Datum` AS `Datum`,`Sequenzen`.`Kommentar` AS `Kommentar` from `Sequenzen` where `Sequenzen`.`Nr_firsttime` = 1 order by `Sequenzen`.`ID` desc;

-- Dumping structure for view atominterferometer2022.standard2
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `standard2`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `standard2` AS select `A`.`ID` AS `ID`,`A`.`Datum` AS `Datum`,`A`.`Kommentar` AS `Kommentar`,`B`.`Kanal0_Frequenz` AS `Launch-Frequenz` from (`Sequenzen` `A` join `DDS_Sequenzen` `B`) where `B`.`DDS_Sequenz_Nr` = `A`.`DDS1_Sequenz_Nr` and `B`.`Bezeichnung` = _latin1'Launch';

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
