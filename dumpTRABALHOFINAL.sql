CREATE DATABASE  IF NOT EXISTS `trabalhofinal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `trabalhofinal`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: trabalhofinal
-- ------------------------------------------------------
-- Server version	9.1.0

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
  `id` int NOT NULL,
  `emprestimos` int DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (15,0),(16,0),(18,2),(19,0);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimo`
--

DROP TABLE IF EXISTS `emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_emprestimo` date NOT NULL,
  `data_devolucao` date NOT NULL,
  `id_livro` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_funcionario` int NOT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_livro` (`id_livro`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_funcionario` (`id_funcionario`),
  CONSTRAINT `emprestimo_ibfk_1` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id`) ON DELETE CASCADE,
  CONSTRAINT `emprestimo_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`) ON DELETE CASCADE,
  CONSTRAINT `emprestimo_ibfk_3` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimo`
--

LOCK TABLES `emprestimo` WRITE;
/*!40000 ALTER TABLE `emprestimo` DISABLE KEYS */;
INSERT INTO `emprestimo` VALUES (1,'2025-01-15','2025-01-30',8,15,2,0),(2,'2025-01-15','2025-01-30',8,15,3,0),(3,'2025-01-15','2025-01-30',8,16,2,0),(4,'2025-01-15','2025-01-30',8,18,3,0),(6,'2025-01-15','2025-01-30',8,19,1,0),(8,'2024-12-26','2025-01-10',1,15,2,1),(9,'2024-12-26','2025-01-10',2,16,3,0),(10,'2025-01-15','2025-01-30',3,19,1,0),(11,'2025-01-15','2025-01-30',5,19,1,0),(12,'2025-01-15','2025-01-30',9,16,1,0),(14,'2025-01-15','2025-01-30',7,18,3,0),(15,'2025-01-15','2025-01-30',7,18,4,1),(16,'2025-01-15','2025-01-30',7,18,6,1),(17,'2025-01-15','2025-01-30',7,18,6,0);
/*!40000 ALTER TABLE `emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `funcao` enum('Gerente','Atendente','Outro') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,'carlos.silva@empresa.com','Gerente'),(2,'mariana.almeida@empresa.com','Gerente'),(3,'lucas.pereira@empresa.com','Atendente'),(4,'ana.costa@empresa.com','Atendente'),(6,'rafael.carvalho@empresa.com','Outro'),(7,'rocha.amanda@empresa.com','Atendente');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro`
--

DROP TABLE IF EXISTS `livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `autor` varchar(100) NOT NULL,
  `edicao` varchar(20) DEFAULT NULL,
  `quantidade` int NOT NULL,
  `emprestado` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro`
--

LOCK TABLES `livro` WRITE;
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
INSERT INTO `livro` VALUES (1,'1234567890123','O Senhor dos Anéis: A Sociedade do Anel','J.R.R. Tolkien','1ª',10,0),(2,'2234567890123','Harry Potter e a Pedra Filosofal','J.K. Rowling','1ª',8,0),(3,'3234567890123','O Hobbit - Edição Especial','J.R.R. Tolkien','2ª',20,0),(4,'4234567890123','1984','George Orwell','1ª',5,0),(5,'5234567890123','Dom Quixote','Miguel de Cervantes','4ª',7,0),(6,'6234567890123','A Guerra dos Tronos','George R.R. Martin','1ª',12,0),(7,'7234567890123','O Código Da Vinci','Dan Brown','2ª',9,2),(8,'8234567890123','O Alquimista','Paulo Coelho','1ª',4,0),(9,'9234567890123','A Menina que Roubava Livros','Markus Zusak','3ª',11,0),(11,'1123456789012','O Morro dos Ventos Uivantes','Emily Brontë','1ª',6,0);
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multa`
--

DROP TABLE IF EXISTS `multa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dias_atraso` int NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_multa` datetime DEFAULT CURRENT_TIMESTAMP,
  `emprestimo_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `status` enum('pendente','paga') DEFAULT 'pendente',
  PRIMARY KEY (`id`),
  KEY `emprestimo_id` (`emprestimo_id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `multa_ibfk_1` FOREIGN KEY (`emprestimo_id`) REFERENCES `emprestimo` (`id`),
  CONSTRAINT `multa_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multa`
--

LOCK TABLES `multa` WRITE;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` VALUES (1,5,2.50,'2025-01-15 11:04:58',9,16,'paga'),(2,5,2.50,'2025-01-15 22:20:58',8,15,'paga');
/*!40000 ALTER TABLE `multa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `primeiroNome` varchar(50) NOT NULL,
  `sobrenome` varchar(50) NOT NULL,
  `tipo` enum('Funcionario','Cliente') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'gerente01','senha123','44717328035','Carlos','Silva','Funcionario'),(2,'gerente02','senha456','94697010035','Mariana','Almeida','Funcionario'),(3,'atendente01','senha789','69816621088','Lucas','Pereira','Funcionario'),(4,'atendente02','senha321','85651790012','Ana','Costa','Funcionario'),(6,'outro01','senha987','80042250048','Rafael','Carvalho','Funcionario'),(7,'outro02','senha988','49755716092','Amandaa','Rocha','Funcionario'),(15,'cliente01','senha001','12345678901','Mariana','Souza','Cliente'),(16,'cliente02','senha002','23456789012','João','Pereira','Cliente'),(18,'cliente04','senha004','45678901234','Carlos','Mendes','Cliente'),(19,'cliente05','senha005','56789012345','Luciana','Almeida','Cliente');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-15 22:31:12
