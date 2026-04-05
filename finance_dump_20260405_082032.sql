-- MySQL dump 10.13  Distrib 8.0.45, for Linux (aarch64)
--
-- Host: localhost    Database: finance_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `category` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `description` text,
  `type` enum('INCOME','EXPENSE') NOT NULL,
  `created_by` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tx_type` (`type`),
  KEY `idx_tx_category` (`category`),
  KEY `idx_tx_date` (`date`),
  KEY `idx_tx_created_by` (`created_by`),
  KEY `idx_tx_deleted_at` (`deleted_at`),
  KEY `idx_tx_amount` (`amount`),
  CONSTRAINT `FKejem3mgn2s0rcputq0m42nx1t` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',85000.00,'Salary','2025-10-05',NULL,'Monthly salary','INCOME',1),(2,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',12000.00,'Rent','2025-10-05',NULL,'Office rent','EXPENSE',1),(3,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',3200.00,'Food','2025-10-05',NULL,'Team lunch expenses','EXPENSE',2),(4,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',8500.00,'Travel','2025-10-05',NULL,'Client visit travel','EXPENSE',2),(5,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',2000.00,'Freelance','2025-10-05',NULL,'Freelance project','INCOME',2),(6,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',85000.00,'Salary','2025-11-05',NULL,'Monthly salary','INCOME',1),(7,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',12000.00,'Rent','2025-11-05',NULL,'Office rent','EXPENSE',1),(8,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',4500.00,'Medical','2025-11-05',NULL,'Health insurance premium','EXPENSE',1),(9,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',1800.00,'Food','2025-11-05',NULL,'Grocery and meals','EXPENSE',2),(10,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',15000.00,'Consulting','2025-11-05',NULL,'Consulting project payout','INCOME',2),(11,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',5000.00,'Utilities','2025-11-05',NULL,'Internet and electricity','EXPENSE',2),(12,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',85000.00,'Salary','2025-12-05',NULL,'Monthly salary','INCOME',1),(13,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',12000.00,'Rent','2025-12-05',NULL,'Office rent','EXPENSE',1),(14,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',22000.00,'Travel','2025-12-05',NULL,'Business trip international','EXPENSE',1),(15,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',3000.00,'Food','2025-12-05',NULL,'Team dinner','EXPENSE',2),(16,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',8000.00,'Freelance','2025-12-05',NULL,'Freelance design work','INCOME',2),(17,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',1200.00,'Medical','2025-12-05',NULL,'Doctor consultation','EXPENSE',2),(18,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',90000.00,'Salary','2026-01-05',NULL,'Monthly salary + bonus','INCOME',1),(19,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',12000.00,'Rent','2026-01-05',NULL,'Office rent','EXPENSE',1),(20,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',6000.00,'Education','2026-01-05',NULL,'Online course subscription','EXPENSE',1),(21,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',2500.00,'Food','2026-01-05',NULL,'Team catering','EXPENSE',2),(22,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',20000.00,'Consulting','2026-01-05',NULL,'Q3 consulting project','INCOME',2),(23,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',3500.00,'Utilities','2026-01-05',NULL,'Cloud services bill','EXPENSE',2),(24,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',9000.00,'Travel','2026-01-05',NULL,'Conference registration','EXPENSE',2),(25,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',85000.00,'Salary','2026-02-05',NULL,'Monthly salary','INCOME',1),(26,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',12000.00,'Rent','2026-02-05',NULL,'Office rent','EXPENSE',1),(27,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',4000.00,'Medical','2026-02-05',NULL,'Annual checkup','EXPENSE',1),(28,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',2800.00,'Food','2026-02-05',NULL,'Office snacks','EXPENSE',2),(29,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',5000.00,'Freelance','2026-02-05',NULL,'Website freelance work','INCOME',2),(30,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',1500.00,'Utilities','2026-02-05',NULL,'Phone bills','EXPENSE',2),(31,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',85000.00,'Salary','2026-03-05',NULL,'Monthly salary','INCOME',1),(32,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',12000.00,'Rent','2026-03-05',NULL,'Office rent','EXPENSE',1),(33,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',7000.00,'Education','2026-03-05',NULL,'Tech certification fee','EXPENSE',1),(34,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',3100.00,'Food','2026-03-05',NULL,'Team lunch meeting','EXPENSE',2),(35,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',12000.00,'Consulting','2026-03-05',NULL,'Short consulting gig','INCOME',2),(36,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',2200.00,'Travel','2026-04-05',NULL,'Local client visits','EXPENSE',2),(37,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',500.00,'Utilities','2026-04-05',NULL,'Domain renewal','EXPENSE',2),(38,'2026-04-05 02:50:32.000000','2026-04-05 02:50:32.000000',3000.00,'Freelance','2026-04-05',NULL,'Logo design project','INCOME',2);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `active` bit(1) NOT NULL,
  `email` varchar(150) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('VIEWER','ANALYST','ADMIN') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`),
  KEY `idx_users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2026-04-05 02:35:54.676795','2026-04-05 02:35:54.676795',_binary '','admin@finance.com','Admin User','$2a$12$wfWgsyUJMtYvnJ4rCWAAIegwWqw2h7OMGetGs2yYQekR5lHiAcqxO','ADMIN'),(2,'2026-04-05 02:35:55.003945','2026-04-05 02:35:55.003945',_binary '','analyst@finance.com','Alice Analyst','$2a$12$KuI31idYZ80m1k/v.6M13.3Bkl2urrXKuBlHDvSoHduov5fmD5E1a','ANALYST'),(3,'2026-04-05 02:35:55.313629','2026-04-05 02:35:55.313629',_binary '','viewer@finance.com','Victor Viewer','$2a$12$a2bsarGTi1gDm.EICy6f8uD.7JT/P7Q5Keo6q4CGDciVodXz.N5pC','VIEWER');
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

-- Dump completed on 2026-04-05  2:50:32
