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
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `ID_producto` int(11) NOT NULL AUTO_INCREMENT,
  `ID_proveedor` int(11) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Descripcion` text DEFAULT NULL,
  `Precio_compra` decimal(10,2) DEFAULT NULL,
  `Precio_venta` decimal(10,2) DEFAULT NULL,
  `Stock_actual` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_producto`),
  KEY `ID_proveedor` (`ID_proveedor`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`ID_proveedor`) REFERENCES `proveedor` (`ID_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,1,'Router WiFi AX3000','Router de alta velocidad para redes domésticas',150.00,280.00,29),(2,1,'Switch 8 Puertos','Switch Ethernet gigabit de 8 puertos',90.00,180.00,40),(3,2,'Cable UTP Cat6','Cable de red categoría 6 de 20m',15.00,35.00,100),(4,2,'Antena Direccional','Antena para transmisión de señal de largo alcance',200.00,350.00,15),(5,3,'Fuente 12V 5A','Fuente de poder para equipos de red',50.00,90.00,50),(6,3,'Módem LTE','Módem con conexión 4G LTE',220.00,700.00,20),(7,4,'Router WiFi N300','Router económico para pequeñas oficinas',100.00,180.00,25),(8,4,'Cámara IP','Cámara de seguridad IP HD',180.00,320.00,18),(9,5,'Conector RJ45','Conector de red RJ45 estándar',5.00,15.00,200),(10,5,'Tester de Red','Herramienta de prueba de cables de red',70.00,130.00,30);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
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
