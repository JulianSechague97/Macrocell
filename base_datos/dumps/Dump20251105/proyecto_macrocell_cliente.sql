-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_macrocell
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID_cliente` int(11) NOT NULL,
  `Cedula` varchar(20) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID_cliente`),
  UNIQUE KEY `Cedula` (`Cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (0,NULL,'Ana Carabali Uzuga ','anacarabali@gmail.com','3215251358',NULL),(1,'1010101010','Pedro Ramírez','pedro.ramirez@mail.com','3201111111','Calle 10 #5-15 Bogotá'),(2,'1010101011','Sofía López','sofia.lopez@mail.com','3202222222','Cra 45 #30-22 Cali'),(3,'1010101012','Miguel Duarte','miguel.duarte@mail.com','3203333333','Av 3 #14-55 Medellín'),(4,'1010101013','Diana Moreno','diana.moreno@mail.com','3204444444','Cl 70 #25-13 Bucaramanga'),(5,'1010101014','Jorge Castro','jorge.castro@mail.com','3205555555','Cra 68 #45-33 Bogotá'),(6,'1010101015','Valentina García','valentina.garcia@mail.com','3206666666','Av Boyacá #88-12 Bogotá'),(7,'1010101016','Camilo Ortiz','camilo.ortiz@mail.com','3207777777','Cl 45 #12-60 Cali'),(8,'1010101017','Natalia Vega','natalia.vega@mail.com','3208888888','Cra 10 #20-90 Medellín'),(9,'1010101018','Sebastián Cárdenas','sebastian.cardenas@mail.com','3209999999','Cl 12 #9-34 Cartagena'),(10,'1010101019','Paola Trujillo','paola.trujillo@mail.com','3210000000','Cl 60 #22-41 Pereira');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-05 14:19:14
