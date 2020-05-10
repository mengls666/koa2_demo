-- MySQL dump 10.13  Distrib 5.7.29, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: blog_dev
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `house`
--

DROP TABLE IF EXISTS `house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `house` (
  `name` varchar(100) NOT NULL,
  `owner_id` int(10) NOT NULL,
  `amount` int(10) NOT NULL,
  PRIMARY KEY (`name`,`owner_id`),
  KEY `owner_of_house` (`owner_id`),
  CONSTRAINT `owner_of_house` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house`
--

LOCK TABLES `house` WRITE;
/*!40000 ALTER TABLE `house` DISABLE KEYS */;
INSERT INTO `house` VALUES ('1ds',26,1),('test',25,1056),('test',26,199),('test',27,10),('test1',25,82),('test1',27,10);
/*!40000 ALTER TABLE `house` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market`
--

DROP TABLE IF EXISTS `market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `owner_id` int(10) NOT NULL,
  `amount` int(10) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_of_market` (`owner_id`),
  CONSTRAINT `owner_of_market` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market`
--

LOCK TABLES `market` WRITE;
/*!40000 ALTER TABLE `market` DISABLE KEYS */;
INSERT INTO `market` VALUES (1,'test',26,0,10),(5,'test',25,0,100),(6,'test',25,9,100),(7,'test',27,23,100),(8,'test',25,10,1),(9,'test',25,10,1),(10,'test',25,10,1),(11,'test1',25,0,1),(12,'test',26,1,1);
/*!40000 ALTER TABLE `market` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `update the house` BEFORE INSERT ON `market` FOR EACH ROW BEGIN
DECLARE msg VARCHAR(200);
update house set amount = amount - NEW.amount where (owner_id=NEW.owner_id and amount >=NEW.amount and name = NEW.name);
if ROW_COUNT() <> 1 then
	set msg = '库存不足！';
    SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `buyer` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `amount` int(10) NOT NULL,
  `market_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `buyer` (`buyer`),
  KEY `market_id` (`market_id`),
  CONSTRAINT `buyer` FOREIGN KEY (`buyer`) REFERENCES `users` (`id`),
  CONSTRAINT `market_id` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (1,25,'test',10,1),(2,25,'test',10,1),(3,25,'test',10,1),(4,25,'test',10,1),(5,26,'test',40,5),(6,25,'test',0,1),(7,25,'test',0,1),(8,25,'test',0,1),(9,25,'test',0,1),(10,25,'test',0,1),(11,25,'test',0,1),(12,25,'test',0,1),(13,25,'test',0,1),(14,25,'test',0,1),(15,25,'test',10,1),(16,25,'test',10,7),(17,25,'test',10,7),(18,25,'test',10,7),(19,25,'test',10,7),(20,25,'test',10,7),(21,25,'test',10,7),(22,25,'test',1,7),(23,25,'test',1,7),(24,25,'test',1,7),(25,25,'test',0,7),(26,25,'test',1,7),(27,25,'test',1,7),(28,25,'test',1,7),(29,25,'test',1,7),(30,25,'test',10,7),(31,27,'test',10,5),(32,27,'test1',10,11),(33,26,'test',1,6);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `update things` BEFORE INSERT ON `order_detail` FOR EACH ROW BEGIN
DECLARE msg VARCHAR(200);
update market set amount = amount - NEW.amount where (market.id=NEW.market_id and amount >=NEW.amount);
if ROW_COUNT() <> 1 then
	set msg = '库存不足！';
    SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
end if;
select price,owner_id from market where id = NEW.market_id into @price,@seller;
set @totprice = NEW.amount * @price;
update users set amount = amount - @totprice where id=NEW.buyer and amount >=@totprice;
if ROW_COUNT() <> 1 then
	set msg = '余额不足！';
    SIGNAL SQLSTATE 'HY001' SET MESSAGE_TEXT = msg;
end if;

update users set amount = amount + @totprice where id=@seller;
INSERT INTO house set name = NEW.name, owner_id = NEW.buyer,amount = NEW.amount
ON DUPLICATE KEY UPDATE amount = amount + NEW.amount;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `userpwd` varchar(32) NOT NULL COMMENT '用户密码',
  `nickname` varchar(50) NOT NULL COMMENT '用户昵称',
  `amount` double NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (25,'abc','900150983cd24fb0d6963f7d28e17f72','mengls',96910),(26,'def','4ed9407630eb1000c0f6b63842defa7d','def',1000),(27,'cde','a256e6b336afdc38c564789c399b516c','cde',6790);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-11  1:33:51
