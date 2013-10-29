CREATE DATABASE  IF NOT EXISTS `zanhealth` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `zanhealth`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: zanhealth
-- ------------------------------------------------------
-- Server version	5.5.29-0ubuntu0.12.04.1

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
-- Table structure for table `work_requests`
--

DROP TABLE IF EXISTS `work_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_requests` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `expire` datetime DEFAULT NULL,
  `completed` datetime DEFAULT NULL,
  `work_priority_id` int(11) DEFAULT NULL,
  `type` enum('Breakdown','Preventative') DEFAULT NULL,
  `item_id` int(3) unsigned zerofill NOT NULL,
  `cost` mediumtext,
  `description` mediumtext,
  `status` enum('Open','Closed') DEFAULT NULL,
  `owner` varchar(45) DEFAULT NULL,
  `work_trade_id` int(11) DEFAULT NULL,
  `requestor_id` int(10) unsigned DEFAULT NULL,
  `cause_description` mediumtext,
  `actions_taken` mediumtext,
  `prevention_taken` mediumtext,
  `facility_comments` mediumtext,
  `engineer_comments` mediumtext,
  `manager_comments` mediumtext,
  PRIMARY KEY (`id`),
  KEY `priority` (`work_priority_id`),
  KEY `item` (`item_id`),
  KEY `work_trade` (`work_trade_id`),
  KEY `requestor` (`requestor_id`),
  CONSTRAINT `item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `priority` FOREIGN KEY (`work_priority_id`) REFERENCES `work_priorities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `requestor` FOREIGN KEY (`requestor_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `work_trade` FOREIGN KEY (`work_trade_id`) REFERENCES `work_trades` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_requests`
--

LOCK TABLES `work_requests` WRITE;
/*!40000 ALTER TABLE `work_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_requests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-05  2:12:44
