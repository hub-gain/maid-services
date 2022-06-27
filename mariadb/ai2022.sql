-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: atominterferometer2022
-- ------------------------------------------------------
-- Server version	5.5.57-0+deb7u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AO_Waveforms`
--

DROP TABLE IF EXISTS `AO_Waveforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AO_Waveforms` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Waveform_Nr` int(10) unsigned NOT NULL,
  `Zeitwert` double unsigned NOT NULL,
  `Spannung` double NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `waveformnr` (`Waveform_Nr`)
) ENGINE=MyISAM AUTO_INCREMENT=371312267 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ChirpDDS_Sequenzen`
--

DROP TABLE IF EXISTS `ChirpDDS_Sequenzen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ChirpDDS_Sequenzen` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `DDS1_Sequenz_Nr` int(10) unsigned NOT NULL,
  `DDS_Nr` enum('1','2','3','4','5') NOT NULL,
  `Frequenz` double unsigned DEFAULT NULL,
  `Chirprate` double DEFAULT NULL,
  `Amplitude` decimal(3,1) DEFAULT NULL,
  `Phase` smallint(5) NOT NULL,
  `Referenz` tinytext,
  `Startzeit` double unsigned NOT NULL,
  `Referenzzeit` double unsigned NOT NULL,
  `Stopzeit` double unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `DDS1seqnrindex` (`DDS1_Sequenz_Nr`)
) ENGINE=MyISAM AUTO_INCREMENT=24266340 DEFAULT CHARSET=latin1 COMMENT='Tabelle fuer die chirpbaren DDS';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DDS_Sequenzen`
--

DROP TABLE IF EXISTS `DDS_Sequenzen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DDS_Sequenzen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DDS_Sequenz_Nr` int(10) unsigned NOT NULL,
  `DDS_Nr` enum('1','2','3','4','5') COLLATE latin1_german1_ci NOT NULL,
  `Kanal0_Frequenz` double unsigned NOT NULL,
  `Kanal0_Amplitude` decimal(3,1) NOT NULL,
  `Kanal1_Frequenz` double unsigned NOT NULL,
  `Kanal1_Amplitude` decimal(3,1) NOT NULL,
  `Bezeichnung` tinytext COLLATE latin1_german1_ci,
  `Haltezeit` double unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ddssequenznr` (`DDS_Sequenz_Nr`)
) ENGINE=MyISAM AUTO_INCREMENT=91284988 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Laserleistungen`
--

DROP TABLE IF EXISTS `Laserleistungen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Laserleistungen` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Datum` datetime NOT NULL,
  `Faser4` decimal(4,1) NOT NULL COMMENT 'Leistung in mW (Umrechnung im Auslesprogramm)',
  `Faser4org` smallint(6) NOT NULL COMMENT 'Integer aus Mikrokontroller',
  `Faser5` decimal(4,1) NOT NULL,
  `Faser5org` smallint(6) NOT NULL,
  `Faser6` decimal(4,1) NOT NULL,
  `Faser6org` smallint(6) NOT NULL,
  `Faser7` decimal(4,1) NOT NULL,
  `Faser7org` smallint(6) NOT NULL,
  `Faser8` decimal(4,1) NOT NULL,
  `Faser8org` smallint(6) NOT NULL,
  `Faser9` decimal(4,1) NOT NULL,
  `Faser9org` smallint(6) NOT NULL,
  `1auf3A` decimal(4,1) NOT NULL COMMENT '(vor Faser9)',
  `1auf3Aorg` smallint(6) NOT NULL,
  `1auf3B` decimal(4,1) NOT NULL,
  `1auf3Borg` smallint(6) NOT NULL,
  `MOT_B_Rp` decimal(4,1) NOT NULL COMMENT 'Rueckpumper Eingang vor AOM',
  `MOT_B_Rporg` smallint(6) NOT NULL,
  `MOT_B_Aux` decimal(4,1) NOT NULL COMMENT 'Leistung vor dem Aux Koppler',
  `MOT_B_Auxorg` smallint(6) NOT NULL,
  `MOT_B_Det` decimal(4,1) NOT NULL COMMENT 'Leistung vor der Detektions-Faser',
  `MOT_B_Detorg` smallint(6) NOT NULL,
  `MOT_B_Justage` decimal(4,1) NOT NULL COMMENT 'Leistung auf Justage-Photodiode (macht nur Sinn bei der Verwendung des MOT-Ausgangs als Eingang)',
  `MOT_B_Justageorg` smallint(6) NOT NULL,
  `airpressure` decimal(6,2) DEFAULT NULL COMMENT 'Air Pressure data from GAIN sensor in hPa',
  `sensor_temp` decimal(4,2) DEFAULT NULL COMMENT 'Temperature sensor of the air pressure sensor in Celsius',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4849459 DEFAULT CHARSET=latin1 COMMENT='Photodiodenwerte aus Lasersystem und MOT-Teleskopen';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Messreihen`
--

DROP TABLE IF EXISTS `Messreihen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Messreihen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Datum` datetime NOT NULL,
  `Kommentar` text,
  `Scanparameter` text,
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
) ENGINE=MyISAM AUTO_INCREMENT=9642 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Messungen`
--

DROP TABLE IF EXISTS `Messungen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Messungen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Datum` datetime NOT NULL,
  `Millisekunden` smallint(3) unsigned zerofill NOT NULL DEFAULT '000',
  `Netzphase` decimal(3,1) DEFAULT NULL COMMENT 'Zeit in ms seit NetzTrigger',
  `Sequenz_ID` int(10) unsigned NOT NULL,
  `Messreihen_ID` int(10) unsigned NOT NULL,
  `Messwert_Nr` int(10) unsigned NOT NULL,
  `Messzeit` double unsigned NOT NULL,
  `Image` binary(1) DEFAULT NULL,
  `Scanwert` double DEFAULT NULL,
  `Messungstyp` enum('k+_AOM-Faktor','k+_Flanken','k+_Scannen','k-_AOM-Faktor','k-_Flanken','k-_Scannen') COLLATE latin1_german1_ci DEFAULT NULL,
  `Timing_Fehler` tinyint(1) NOT NULL,
  `Tilt_X` decimal(5,4) DEFAULT NULL,
  `Tilt_Y` decimal(5,4) DEFAULT NULL,
  `Tilt_X_Teleskop` decimal(5,4) DEFAULT NULL,
  `Tilt_Y_Teleskop` decimal(5,4) DEFAULT NULL,
  `Temperatur` decimal(6,4) DEFAULT NULL,
  `Drucksensor` decimal(3,2) unsigned DEFAULT NULL,
  `Ramanpuls1` float DEFAULT NULL,
  `Ramanpuls2` float DEFAULT NULL,
  `Ramanpuls3` float DEFAULT NULL,
  `Ramanpuls4` float DEFAULT NULL,
  `Ramanpuls5` float DEFAULT NULL,
  `Ramanpuls6` float DEFAULT NULL,
  `Ramanleistung` float DEFAULT NULL,
  `Luftdruck` double DEFAULT NULL,
  `RamanBeatAmplitude` float DEFAULT NULL,
  `CC_MeanTilt_CoriolisAxis` decimal(4,1) DEFAULT NULL COMMENT 'Piezo value for backcoupling during the 2nd Raman pulse on Coriolis axis (mu-rad)',
  `CC_MeanTilt_2ndAxis` decimal(4,1) DEFAULT NULL COMMENT 'Piezo value for backcoupling during the 2nd Raman pulse on the perpendicular axis (mu-rad)',
  `MOT_Kammer_TiltX` decimal(4,3) DEFAULT NULL COMMENT 'Output of the Inklinometer (V) - x-axis',
  `MOT_Kammer_TiltY` decimal(4,3) DEFAULT NULL COMMENT 'Output of the Inklinometer (V) - y-axis',
  `Delta_10MHz` float DEFAULT NULL COMMENT 'Difference: GAIN 10MHz - GPS 10MHz in Hz',
  `IonPumpCurrent` decimal(3,2) DEFAULT NULL COMMENT 'Output of the Ion pump (V) - for calculation of its current',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4089339 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Messwerte`
--

DROP TABLE IF EXISTS `Messwerte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Messwerte` (
  `Messwert_Nr` int(10) unsigned NOT NULL,
  `Sample_Nr` smallint(5) unsigned NOT NULL,
  `Messwert` double NOT NULL,
  KEY `Messwert_Nr` (`Messwert_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Nullmessungen`
--

DROP TABLE IF EXISTS `Nullmessungen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Nullmessungen` (
  `Messwert_Nr` int(10) unsigned NOT NULL,
  `Sample_Nr` smallint(5) unsigned NOT NULL,
  `Nullmesswert` double NOT NULL,
  KEY `Messwert_Nr` (`Messwert_Nr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Piezo_Spiegel`
--

DROP TABLE IF EXISTS `Piezo_Spiegel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Piezo_Spiegel` (
  `Sequenz_Array_Nr` int(10) unsigned NOT NULL COMMENT 'here the same number as for the Sequenz_array is used',
  `Event_Start` double unsigned NOT NULL,
  `coriolis_NS` double NOT NULL COMMENT 'start angle (rotation about north-south axis) in microradian',
  `coriolis_NS_rate` double NOT NULL COMMENT 'rotation rate (about north-south axis) in microradian per second',
  `coriolis_WE` double NOT NULL COMMENT 'start angle (rotation about west-east axis) in microradian',
  `coriolis_WE_rate` double NOT NULL COMMENT 'rotation rate (about west-east axis) in microradian per second'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='angles and rates for coriolis compensation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Sequenz_Arrays`
--

DROP TABLE IF EXISTS `Sequenz_Arrays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sequenz_Arrays` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Array_Nr` int(10) unsigned NOT NULL,
  `Eventnummer` double NOT NULL,
  `Kanal` tinytext COLLATE latin1_german1_ci NOT NULL,
  `Info` tinytext COLLATE latin1_german1_ci,
  `Bezeichnung` tinytext COLLATE latin1_german1_ci,
  `Startreferenz` tinytext COLLATE latin1_german1_ci,
  `Startabstand` double DEFAULT NULL,
  `Event_Start` double unsigned NOT NULL,
  `Stoppreferenz` tinytext COLLATE latin1_german1_ci,
  `Stoppabstand` double DEFAULT NULL,
  `Event_Stopp` double unsigned NOT NULL,
  `Event_Dauer` double unsigned NOT NULL,
  `AO_Waveform` tinyint(1) NOT NULL,
  `AO_Waveform_Nr` int(10) unsigned DEFAULT NULL,
  `AO_Formel` text COLLATE latin1_german1_ci,
  `Aktiviert` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `arraynr` (`Array_Nr`)
) ENGINE=MyISAM AUTO_INCREMENT=171226169 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Sequenzen`
--

DROP TABLE IF EXISTS `Sequenzen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sequenzen` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nr` mediumint(8) unsigned NOT NULL,
  `Nr_firsttime` tinyint(1) NOT NULL DEFAULT '0',
  `Datum` datetime NOT NULL,
  `Kommentar` text COLLATE latin1_german1_ci,
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
  `DDS3_Startfrequenz` double unsigned NOT NULL,
  `DDS3_Chirprate` double NOT NULL,
  `DDS3_Chirpen` tinyint(1) NOT NULL,
  `DDS3_Amplitude` decimal(3,1) NOT NULL,
  `DDS4_Startfrequenz` double unsigned NOT NULL,
  `DDS4_Amplitude` decimal(3,1) NOT NULL,
  `DDS4_Phase1` smallint(5) unsigned NOT NULL,
  `DDS4_Phase2` smallint(5) unsigned NOT NULL,
  `DDS4_Phaseschieben` tinyint(1) NOT NULL,
  `DDS5_Startfrequenz` double unsigned NOT NULL,
  `DDS5_Chirprate` double NOT NULL,
  `DDS5_Chirpen` tinyint(1) NOT NULL,
  `DDS5_Amplitude` decimal(3,1) NOT NULL,
  `DDS_Chirpreferenz` text COLLATE latin1_german1_ci NOT NULL,
  `Scanstart` tinyint(1) NOT NULL DEFAULT '0',
  `DDS6_Frequenz` double unsigned NOT NULL,
  `DDS6_Amplitude` decimal(3,1) NOT NULL,
  `Piezo_Spiegel_Orientierung` double DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `firsttime` (`Nr_firsttime`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Vibration_Data`
--

DROP TABLE IF EXISTS `Vibration_Data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vibration_Data` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `letzte Messreihen`
--

DROP TABLE IF EXISTS `letzte Messreihen`;
/*!50001 DROP VIEW IF EXISTS `letzte Messreihen`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `letzte Messreihen` (
  `ID` tinyint NOT NULL,
  `Datum` tinyint NOT NULL,
  `Kommentar` tinyint NOT NULL,
  `Scanparameter` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `letzte Sequenzen`
--

DROP TABLE IF EXISTS `letzte Sequenzen`;
/*!50001 DROP VIEW IF EXISTS `letzte Sequenzen`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `letzte Sequenzen` (
  `ID` tinyint NOT NULL,
  `Nr` tinyint NOT NULL,
  `Datum` tinyint NOT NULL,
  `Kommentar` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `standard2`
--

DROP TABLE IF EXISTS `standard2`;
/*!50001 DROP VIEW IF EXISTS `standard2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `standard2` (
  `ID` tinyint NOT NULL,
  `Datum` tinyint NOT NULL,
  `Kommentar` tinyint NOT NULL,
  `Launch-Frequenz` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'atominterferometer2022'
--
/*!50003 DROP PROCEDURE IF EXISTS `addMesswert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addMesswert`(IN p_Messwert_Nr int,
	 IN p_Sample_Nr int(5),
	 IN p_Messwert double)
BEGIN
	INSERT INTO `Messwerte` (Messwert_Nr, Sample_Nr, Messwert)
		VALUES (
			p_Messwert_Nr,
			p_Sample_Nr,
			p_Messwert
				);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNextNumbers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getNextNumbers`()
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNextNumbers2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`ro`@`%` PROCEDURE `getNextNumbers2`()
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNumbersForNextMessreihe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getNumbersForNextMessreihe`()
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `letzte Messreihen`
--

/*!50001 DROP TABLE IF EXISTS `letzte Messreihen`*/;
/*!50001 DROP VIEW IF EXISTS `letzte Messreihen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ro`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `letzte Messreihen` AS select `Messreihen`.`ID` AS `ID`,`Messreihen`.`Datum` AS `Datum`,`Messreihen`.`Kommentar` AS `Kommentar`,`Messreihen`.`Scanparameter` AS `Scanparameter` from `Messreihen` order by `Messreihen`.`ID` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `letzte Sequenzen`
--

/*!50001 DROP TABLE IF EXISTS `letzte Sequenzen`*/;
/*!50001 DROP VIEW IF EXISTS `letzte Sequenzen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ro`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `letzte Sequenzen` AS select `Sequenzen`.`ID` AS `ID`,`Sequenzen`.`Nr` AS `Nr`,`Sequenzen`.`Datum` AS `Datum`,`Sequenzen`.`Kommentar` AS `Kommentar` from `Sequenzen` where (`Sequenzen`.`Nr_firsttime` = 1) order by `Sequenzen`.`ID` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `standard2`
--

/*!50001 DROP TABLE IF EXISTS `standard2`*/;
/*!50001 DROP VIEW IF EXISTS `standard2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `standard2` AS select `A`.`ID` AS `ID`,`A`.`Datum` AS `Datum`,`A`.`Kommentar` AS `Kommentar`,`B`.`Kanal0_Frequenz` AS `Launch-Frequenz` from (`Sequenzen` `A` join `DDS_Sequenzen` `B`) where ((`B`.`DDS_Sequenz_Nr` = `A`.`DDS1_Sequenz_Nr`) and (`B`.`Bezeichnung` = _latin1'Launch')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-14 16:52:26
