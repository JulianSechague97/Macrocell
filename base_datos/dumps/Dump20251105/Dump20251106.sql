-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
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
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador` (
  `id_admin` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(100) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `password_hashed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_admin`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES (1,'admin','2801',0);
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditoria_empleados`
--

DROP TABLE IF EXISTS `auditoria_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empleado` int(11) NOT NULL,
  `rol_empleado` enum('admin','empleado') DEFAULT NULL,
  `accion` varchar(100) NOT NULL,
  `tabla_afectada` varchar(50) DEFAULT NULL,
  `registro_id` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_empleado` (`id_empleado`),
  KEY `idx_fecha` (`fecha`),
  KEY `idx_tabla` (`tabla_afectada`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_empleados`
--

LOCK TABLES `auditoria_empleados` WRITE;
/*!40000 ALTER TABLE `auditoria_empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_cliente_producto` (`id_cliente`,`id_producto`),
  KEY `fk_carrito_producto` (`id_producto`),
  KEY `fk_carrito_cliente` (`id_cliente`),
  CONSTRAINT `fk_carrito_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE SET NULL,
  CONSTRAINT `fk_carrito_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`ID_producto`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `Cedula` varchar(20) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID_cliente`),
  UNIQUE KEY `Cedula` (`Cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'1010101010','Pedro Ramírez','pedro.ramirez@mail.com','3201111111','Calle 10 #5-15 Bogotá'),(2,'1010101011','Sofía López','sofia.lopez@mail.com','3202222222','Cra 45 #30-22 Cali'),(3,'1010101012','Miguel Duarte','miguel.duarte@mail.com','3203333333','Av 3 #14-55 Medellín'),(4,'1010101013','Diana Moreno','diana.moreno@mail.com','3204444444','Cl 70 #25-13 Bucaramanga'),(5,'1010101014','Jorge Castro','jorge.castro@mail.com','3205555555','Cra 68 #45-33 Bogotá'),(6,'1010101015','Valentina García','valentina.garcia@mail.com','3206666666','Av Boyacá #88-12 Bogotá'),(7,'1010101016','Camilo Ortiz','camilo.ortiz@mail.com','3207777777','Cl 45 #12-60 Cali'),(8,'1010101017','Natalia Vega','natalia.vega@mail.com','3208888888','Cra 10 #20-90 Medellín'),(9,'1010101018','Sebastián Cárdenas','sebastian.cardenas@mail.com','3209999999','Cl 12 #9-34 Cartagena'),(10,'1010101019','Paola Trujillo','paola.trujillo@mail.com','3210000000','Cl 60 #22-41 Pereira'),(11,NULL,'Ana Carabali Uzuga ','anacarabali@gmail.com','3215251358',NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_cliente
BEFORE UPDATE ON cliente
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden actualizar clientes';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_cliente
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden eliminar clientes';
    END IF;
    INSERT INTO auditoria_empleados (id_empleado, rol_empleado, accion, tabla_afectada, registro_id, descripcion)
    VALUES (@current_user_id, @current_user_role, 'DELETE', 'cliente', OLD.ID_cliente, CONCAT('Eliminó cliente: ', OLD.Nombre));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `ID_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `Cedula` varchar(20) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Contrasena_acceso` varchar(100) DEFAULT NULL,
  `rol` enum('admin','empleado') NOT NULL DEFAULT 'empleado',
  `password_hashed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`ID_usuario`),
  UNIQUE KEY `Cedula` (`Cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,NULL,'Administrador Principal','admin@macrocell.com',NULL,'2801','admin',0),(2,'12345678','Juan Perez','juan@example.com','3001234567','123456','empleado',0);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados_backup`
--

DROP TABLE IF EXISTS `empleados_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados_backup` (
  `ID_usuario` int(11) NOT NULL,
  `Cedula` varchar(20) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Contrasena_acceso` varchar(100) DEFAULT NULL,
  `rol` enum('admin','empleado') NOT NULL DEFAULT 'empleado',
  `password_hashed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados_backup`
--

LOCK TABLES `empleados_backup` WRITE;
/*!40000 ALTER TABLE `empleados_backup` DISABLE KEYS */;
INSERT INTO `empleados_backup` VALUES (0,NULL,'admin',NULL,NULL,'2801','admin',0),(1,'1001001001','Laura Gómez','laura.gomez@macrocell.com','3101234567','pass123','empleado',0),(2,'1001001002','Andrés López','andres.lopez@macrocell.com','3112345678','pass123','empleado',0),(3,'1001001003','María Torres','maria.torres@macrocell.com','3123456789','pass123','empleado',0),(4,'1001001004','Carlos Pérez','carlos.perez@macrocell.com','3134567890','pass123','empleado',0),(5,'1001001005','Juliana Ruiz','juliana.ruiz@macrocell.com','3145678901','pass123','empleado',0);
/*!40000 ALTER TABLE `empleados_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `ID_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `ID_cliente` int(11) DEFAULT NULL,
  `Producto` varchar(100) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `Estado` varchar(50) DEFAULT 'Pendiente',
  PRIMARY KEY (`ID_pedido`),
  KEY `fk_pedido_cliente` (`ID_cliente`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`ID_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,NULL,'iPhone 15 Pro Max',1,'Calle 10 # 5-20, Bogotá','2025-10-28 04:50:00','Pendiente'),(2,NULL,'iPhone 15 Pro Max',1,'Calle 10 # 5-20, Bogotá','2025-10-31 06:31:10','Pendiente'),(3,NULL,'Samsung S24 Ultra',2,'Calle 10 # 5-20, Bogotá','2025-10-31 06:45:04','Pendiente'),(4,NULL,'iPhone 15 Pro Max',1,'Calle 10 # 5-20, Bogotá','2025-10-31 06:47:13','Pendiente'),(5,NULL,'iPhone 15 Pro Max',2,'Calle 10 # 5-20, Bogotá','2025-10-31 06:58:25','Pendiente');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` varchar(100) DEFAULT NULL,
  `producto` varchar(100) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'Carlos Pérez','iPhone 15 Pro Max',1,'Calle 10 # 5-20, Bogotá','2025-10-28 04:50:00'),(2,'Carlos Pérez','iPhone 15 Pro Max',1,'Calle 10 # 5-20, Bogotá','2025-10-31 06:31:10'),(3,'Carlos Pérez','Samsung S24 Ultra',2,'Calle 10 # 5-20, Bogotá','2025-10-31 06:45:04'),(4,'Carlos Pérez','iPhone 15 Pro Max',1,'Calle 10 # 5-20, Bogotá','2025-10-31 06:47:13'),(5,'Carlos Pérez','iPhone 15 Pro Max',2,'Calle 10 # 5-20, Bogotá','2025-10-31 06:58:25');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

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
  KEY `idx_nombre` (`Nombre`),
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_producto
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden registrar productos';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_producto
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden actualizar productos';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_producto_update
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
    DECLARE user_rol VARCHAR(20) DEFAULT '';
    IF @current_user_id IS NOT NULL THEN
        SELECT rol INTO user_rol FROM empleados WHERE ID_usuario = @current_user_id;
        IF user_rol = 'empleado' AND (OLD.Precio_venta != NEW.Precio_venta OR OLD.Precio_compra != NEW.Precio_compra) THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'ERROR: Los empleados no tienen permiso para modificar precios';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_producto
BEFORE DELETE ON producto
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden eliminar productos';
    END IF;
    INSERT INTO auditoria_empleados (id_empleado, rol_empleado, accion, tabla_afectada, registro_id, descripcion)
    VALUES (@current_user_id, @current_user_role, 'DELETE', 'producto', OLD.ID_producto, CONCAT('Eliminó producto: ', OLD.Nombre));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_producto_delete
BEFORE DELETE ON producto
FOR EACH ROW
BEGIN
    DECLARE user_rol VARCHAR(20) DEFAULT '';
    IF @current_user_id IS NOT NULL THEN
        SELECT rol INTO user_rol FROM empleados WHERE ID_usuario = @current_user_id;
        IF user_rol = 'empleado' THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'ERROR: Los empleados no tienen permiso para eliminar productos';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `ID_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `NIT` varchar(20) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID_proveedor`),
  UNIQUE KEY `NIT` (`NIT`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'900100100-1','ElectroParts S.A.','contacto@electroparts.com','3101111111','Cra 10 #12-45 Bogotá'),(2,'900100100-2','TecnoSolutions Ltda','ventas@tecnosolutions.com','3102222222','Av 68 #45-23 Medellín'),(3,'900100100-3','MacroImport','info@macroimport.com','3103333333','Cl 70 #24-10 Cali'),(4,'900100100-4','Proveedores del Norte','servicio@pdn.com','3104444444','Av Caracas #33-50 Bogotá'),(5,'900100100-5','Componentes Digitales','soporte@cdigitales.com','3105555555','Cl 45 #9-20 Bucaramanga'),(6,'900015151','Xbox serie X','xboxtiendaonline@xbox.com','330321585','sin direccion'),(7,'952000','play station ','playstation@play.com','5151351351','call 343 #13-23 bogota');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_proveedor
BEFORE INSERT ON proveedor
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden registrar proveedores';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_proveedor
BEFORE UPDATE ON proveedor
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden actualizar proveedores';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_proveedor
BEFORE DELETE ON proveedor
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden eliminar proveedores';
    END IF;
    INSERT INTO auditoria_empleados (id_empleado, rol_empleado, accion, tabla_afectada, registro_id, descripcion)
    VALUES (@current_user_id, @current_user_role, 'DELETE', 'proveedor', OLD.ID_proveedor, CONCAT('Eliminó proveedor: ', OLD.nombre));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_proveedor_delete
BEFORE DELETE ON proveedor
FOR EACH ROW
BEGIN
    DECLARE user_rol VARCHAR(20) DEFAULT '';
    IF @current_user_id IS NOT NULL THEN
        SELECT rol INTO user_rol FROM empleados WHERE ID_usuario = @current_user_id;
        IF user_rol = 'empleado' THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'ERROR: Los empleados no tienen permiso para eliminar proveedores';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `servicio_tecnico`
--

DROP TABLE IF EXISTS `servicio_tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio_tecnico` (
  `ID_servicio` int(11) NOT NULL AUTO_INCREMENT,
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
  KEY `idx_estado` (`Estado_servicio`),
  CONSTRAINT `servicio_tecnico_ibfk_1` FOREIGN KEY (`ID_usuario`) REFERENCES `empleados` (`ID_usuario`),
  CONSTRAINT `servicio_tecnico_ibfk_2` FOREIGN KEY (`ID_cliente`) REFERENCES `cliente` (`ID_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio_tecnico`
--

LOCK TABLES `servicio_tecnico` WRITE;
/*!40000 ALTER TABLE `servicio_tecnico` DISABLE KEYS */;
INSERT INTO `servicio_tecnico` VALUES (1,1,1,'Router sin señal','2025-09-25','2025-09-27','Entregado',120.00),(2,2,2,'Cable de red dañado','2025-09-26','2025-09-28','Entregado',60.00),(3,3,3,'Antena no responde','2025-09-27','2025-09-30','En reparación',180.00),(4,4,4,'Fuente sin voltaje','2025-09-28','2025-09-29','Entregado',90.00),(5,5,5,'Cámara IP sin conexión','2025-09-29','2025-10-01','Pendiente',150.00);
/*!40000 ALTER TABLE `servicio_tecnico` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_servicio_tecnico
AFTER INSERT ON servicio_tecnico
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados (id_empleado, rol_empleado, accion, tabla_afectada, registro_id, descripcion)
    VALUES (@current_user_id, @current_user_role, 'INSERT', 'servicio_tecnico', NEW.ID_servicio, CONCAT('Registró servicio técnico para cliente ID: ', NEW.ID_cliente));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_update_servicio_tecnico
AFTER UPDATE ON servicio_tecnico
FOR EACH ROW
BEGIN
    IF OLD.Estado_servicio != NEW.Estado_servicio THEN
        INSERT INTO auditoria_empleados (id_empleado, rol_empleado, accion, tabla_afectada, registro_id, descripcion)
        VALUES (@current_user_id, @current_user_role, 'UPDATE', 'servicio_tecnico', NEW.ID_servicio, CONCAT('Cambió estado de "', OLD.Estado_servicio, '" a "', NEW.Estado_servicio, '"'));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `soporte`
--

DROP TABLE IF EXISTS `soporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soporte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soporte`
--

LOCK TABLES `soporte` WRITE;
/*!40000 ALTER TABLE `soporte` DISABLE KEYS */;
INSERT INTO `soporte` VALUES (1,'julian','julianheseney12@gmail.com','el dia de ayer compre unos audifonos y salieron dañados, quisiera solicitar una garantia','2025-10-28 04:56:36');
/*!40000 ALTER TABLE `soporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `ID_venta` int(11) NOT NULL,
  `ID_usuario` int(11) DEFAULT NULL,
  `ID_cliente` int(11) DEFAULT NULL,
  `Fecha_venta` date DEFAULT NULL,
  `Total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID_venta`),
  KEY `ID_usuario` (`ID_usuario`),
  KEY `ID_cliente` (`ID_cliente`),
  KEY `idx_fecha_venta` (`Fecha_venta`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`ID_usuario`) REFERENCES `empleados` (`ID_usuario`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`ID_cliente`) REFERENCES `cliente` (`ID_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (0,1,0,'2025-10-25',280.00),(1,1,1,'2025-10-01',560.00),(2,2,2,'2025-10-02',215.00),(3,3,3,'2025-10-03',450.00),(4,4,4,'2025-10-04',320.00),(5,5,5,'2025-10-05',630.00);
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_venta
BEFORE INSERT ON venta
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden registrar ventas';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_venta_insert
BEFORE INSERT ON venta
FOR EACH ROW
BEGIN
    DECLARE user_rol VARCHAR(20) DEFAULT '';
    IF @current_user_id IS NOT NULL THEN
        SELECT rol INTO user_rol FROM empleados WHERE ID_usuario = @current_user_id;
        IF user_rol = 'empleado' THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'ERROR: Los empleados no tienen permiso para registrar ventas';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_venta
BEFORE UPDATE ON venta
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden actualizar ventas';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_venta
BEFORE DELETE ON venta
FOR EACH ROW
BEGIN
    IF @current_user_role = 'empleado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden eliminar ventas';
    END IF;
    INSERT INTO auditoria_empleados (id_empleado, rol_empleado, accion, tabla_afectada, registro_id, descripcion)
    VALUES (@current_user_id, @current_user_role, 'DELETE', 'venta', OLD.ID_venta, CONCAT('Eliminó venta ID: ', OLD.ID_venta));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `venta_producto`
--

DROP TABLE IF EXISTS `venta_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta_producto` (
  `ID_venta` int(11) NOT NULL,
  `ID_producto` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_venta`,`ID_producto`),
  KEY `ID_producto` (`ID_producto`),
  CONSTRAINT `venta_producto_ibfk_1` FOREIGN KEY (`ID_venta`) REFERENCES `venta` (`ID_venta`),
  CONSTRAINT `venta_producto_ibfk_2` FOREIGN KEY (`ID_producto`) REFERENCES `producto` (`ID_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta_producto`
--

LOCK TABLES `venta_producto` WRITE;
/*!40000 ALTER TABLE `venta_producto` DISABLE KEYS */;
INSERT INTO `venta_producto` VALUES (0,1,1),(1,1,2),(1,3,3),(2,5,1),(2,9,5),(3,2,1),(3,8,1),(4,4,2),(5,6,1),(5,7,1),(5,10,2);
/*!40000 ALTER TABLE `venta_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_auditoria`
--

DROP TABLE IF EXISTS `vista_auditoria`;
/*!50001 DROP VIEW IF EXISTS `vista_auditoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_auditoria` AS SELECT 
 1 AS `id`,
 1 AS `empleado_nombre`,
 1 AS `empleado_correo`,
 1 AS `rol_empleado`,
 1 AS `accion`,
 1 AS `tabla_afectada`,
 1 AS `registro_id`,
 1 AS `descripcion`,
 1 AS `fecha`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_productos_mas_vendidos`
--

DROP TABLE IF EXISTS `vista_productos_mas_vendidos`;
/*!50001 DROP VIEW IF EXISTS `vista_productos_mas_vendidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_productos_mas_vendidos` AS SELECT 
 1 AS `ID_producto`,
 1 AS `Nombre`,
 1 AS `Precio_venta`,
 1 AS `Stock_actual`,
 1 AS `total_vendido`,
 1 AS `ingresos_generados`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'proyecto_macrocell'
--

--
-- Dumping routines for database 'proyecto_macrocell'
--
/*!50003 DROP PROCEDURE IF EXISTS `crear_empleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_empleado`(
    IN p_admin_id INT,
    IN p_nombre VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_contrasena VARCHAR(255),
    IN p_rol ENUM('admin', 'empleado')
)
BEGIN
    DECLARE admin_rol VARCHAR(20);
    
    SELECT rol INTO admin_rol FROM empleados WHERE ID_usuario = p_admin_id;
    
    IF admin_rol != 'admin' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Solo administradores pueden crear empleados';
    END IF;
    
    IF EXISTS (SELECT 1 FROM empleados WHERE Nombre = p_correo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: El correo ya está registrado';
    END IF;
    
    SET @current_user_id = p_admin_id;
    SET @current_user_role = 'admin';
    
    INSERT INTO empleados (Nombre, Contrasena_acceso, rol)
    VALUES (p_nombre, p_contrasena, p_rol);
    
    INSERT INTO auditoria_empleados (id_empleado, rol_empleado, accion, tabla_afectada, registro_id, descripcion)
    VALUES (p_admin_id, 'admin', 'INSERT', 'empleados', LAST_INSERT_ID(), CONCAT('Creó empleado: ', p_nombre, ' con rol: ', p_rol));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_current_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_current_user`(
    IN p_empleado_id INT,
    IN p_rol VARCHAR(20)
)
BEGIN
    SET @current_user_id = p_empleado_id;
    SET @current_user_role = p_rol;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_auditoria`
--

/*!50001 DROP VIEW IF EXISTS `vista_auditoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_auditoria` AS select `a`.`id` AS `id`,`e`.`Nombre` AS `empleado_nombre`,`e`.`Correo` AS `empleado_correo`,`a`.`rol_empleado` AS `rol_empleado`,`a`.`accion` AS `accion`,`a`.`tabla_afectada` AS `tabla_afectada`,`a`.`registro_id` AS `registro_id`,`a`.`descripcion` AS `descripcion`,`a`.`fecha` AS `fecha` from (`auditoria_empleados` `a` left join `empleados` `e` on(`a`.`id_empleado` = `e`.`ID_usuario`)) order by `a`.`fecha` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_productos_mas_vendidos`
--

/*!50001 DROP VIEW IF EXISTS `vista_productos_mas_vendidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_productos_mas_vendidos` AS select `p`.`ID_producto` AS `ID_producto`,`p`.`Nombre` AS `Nombre`,`p`.`Precio_venta` AS `Precio_venta`,`p`.`Stock_actual` AS `Stock_actual`,coalesce(sum(`vp`.`Cantidad`),0) AS `total_vendido`,coalesce(sum(`vp`.`Cantidad` * `p`.`Precio_venta`),0) AS `ingresos_generados` from (`producto` `p` left join `venta_producto` `vp` on(`p`.`ID_producto` = `vp`.`ID_producto`)) group by `p`.`ID_producto`,`p`.`Nombre`,`p`.`Precio_venta`,`p`.`Stock_actual` order by coalesce(sum(`vp`.`Cantidad`),0) desc */;
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

-- Dump completed on 2025-11-06  3:00:54
