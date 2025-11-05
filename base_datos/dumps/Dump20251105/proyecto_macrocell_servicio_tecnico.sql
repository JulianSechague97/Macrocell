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
-- Table structure for table `servicio_tecnico`
--

DROP TABLE IF EXISTS `servicio_tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio_tecnico` (
  `ID_servicio` int(11) NOT NULL,
  `ID_usuario` int(11) DEFAULT NULL,
  `ID_cliente` int(11) DEFAULT NULL,
  `Descripcion_falla` text DEFAULT NULL,
  `Fecha_ingreso` date DEFAULT NULL,
  `Fecha_entrega` date DEFAULT NULL,
  `Estado_servicio` varchar(50) DEFAULT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID_servicio`),
  KEY `ID_usuario` (`ID_usuario`),
  KEY `ID_cliente` (`ID_cliente`),
  CONSTRAINT `servicio_tecnico_ibfk_1` FOREIGN KEY (`ID_usuario`) REFERENCES `empleados` (`ID_usuario`),
  CONSTRAINT `servicio_tecnico_ibfk_2` FOREIGN KEY (`ID_cliente`) REFERENCES `cliente` (`ID_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio_tecnico`
--

LOCK TABLES `servicio_tecnico` WRITE;
/*!40000 ALTER TABLE `servicio_tecnico` DISABLE KEYS */;
INSERT INTO `servicio_tecnico` VALUES (1,1,1,'Router sin señal','2025-09-25','2025-09-27','Entregado',120.00),(2,2,2,'Cable de red dañado','2025-09-26','2025-09-28','Entregado',60.00),(3,3,3,'Antena no responde','2025-09-27','2025-09-30','En reparación',180.00),(4,4,4,'Fuente sin voltaje','2025-09-28','2025-09-29','Entregado',90.00),(5,5,5,'Cámara IP sin conexión','2025-09-29','2025-10-01','Pendiente',150.00);
/*!40000 ALTER TABLE `servicio_tecnico` ENABLE KEYS */;
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
