-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: fido
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.14.04.1

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
-- Table structure for table `RRUser`
--

DROP TABLE IF EXISTS `RRUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RRUser` (
  `rriD` varchar(767) NOT NULL,
  `PublicKey` varchar(767) DEFAULT NULL,
  `SignCounter` varchar(2000) DEFAULT NULL,
  `AuthenticatorVersion` varchar(2000) DEFAULT NULL,
  `tcDisplayPNGCharacteristics` varchar(2000) DEFAULT NULL,
  `username` varchar(2000) DEFAULT NULL,
  `userId` varchar(2000) DEFAULT NULL,
  `deviceId` varchar(2000) DEFAULT NULL,
  `timeStamp` varchar(2000) DEFAULT NULL,
  `status` varchar(2000) DEFAULT NULL,
  `attestCert` varchar(2000) DEFAULT NULL,
  `attestDataToSign` varchar(2000) DEFAULT NULL,
  `attestSignature` varchar(2000) DEFAULT NULL,
  `attestVerifiedStatus` varchar(2000) DEFAULT NULL,
  `ARAAID` varchar(2000) DEFAULT NULL,
  `ARKeyID` varchar(2000) DEFAULT NULL,
  `ARdeviceId` varchar(2000) DEFAULT NULL,
  `ARusername` varchar(200) DEFAULT NULL,
  `ARstatus` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`rriD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facets`
--

DROP TABLE IF EXISTS `facets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facets` (
  `fId` int(11) NOT NULL AUTO_INCREMENT,
  `fDesc` varchar(250) NOT NULL,
  PRIMARY KEY (`fId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facets`
--

LOCK TABLES `facets` WRITE;
/*!40000 ALTER TABLE `facets` DISABLE KEYS */;
INSERT INTO `facets` VALUES (1,'https://www.head2toes.org'),(2,'android:apk-key-hash:Df+2X53Z0UscvUu6obxC3rIfFyk'),(3,'android:apk-key-hash:bE0f1WtRJrZv/C0y9CM73bAUqiI'),(4,'android:apk-key-hash:Lir5oIjf552K/XN4bTul0VS3GfM'),(5,'https://openidconnect.ebay.com');
/*!40000 ALTER TABLE `facets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-09 17:45:46
