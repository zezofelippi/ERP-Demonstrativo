-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: localhost    Database: erp_vazia
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `idcliente_CLIENTE` int(11) NOT NULL AUTO_INCREMENT,
  `Nomedocliente_CLIENTE` varchar(50) DEFAULT NULL,
  `Enderecodocliente_CLIENTE` varchar(50) DEFAULT NULL,
  `Telefonedocliente_CLIENTE` varchar(13) DEFAULT NULL,
  `Cep_CLIENTE` varchar(10) DEFAULT NULL,
  `idvendedor_VENDEDOR` int(11) DEFAULT NULL,
  `Datadenascimento_CLIENTE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`idcliente_CLIENTE`),
  KEY `idvendedor_VENDEDOR` (`idvendedor_VENDEDOR`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idvendedor_VENDEDOR`) REFERENCES `vendedor` (`idvendedor_VENDEDOR`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_bd_campo`
--

DROP TABLE IF EXISTS `dd_bd_campo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_bd_campo` (
  `DDBDC_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDBDC_CAMPO_FISICO` varchar(70) DEFAULT NULL,
  `DDBDC_CAMPO_APELIDO` varchar(70) DEFAULT NULL,
  `DDBDC_REQUERIDO` varchar(70) DEFAULT NULL,
  `DDBDC_DESCRICAO_CAMPO` varchar(200) DEFAULT NULL,
  `DDBDT_CODIGO` int(11) NOT NULL,
  `DDBDFC_CODIGO` int(11) NOT NULL,
  PRIMARY KEY (`DDBDC_CODIGO`),
  KEY `DDBDT_CODIGO` (`DDBDT_CODIGO`),
  KEY `DDBDFC_CODIGO` (`DDBDFC_CODIGO`),
  CONSTRAINT `dd_bd_campo_ibfk_1` FOREIGN KEY (`DDBDT_CODIGO`) REFERENCES `dd_bd_tabelas` (`DDBDT_CODIGO`),
  CONSTRAINT `dd_bd_campo_ibfk_2` FOREIGN KEY (`DDBDFC_CODIGO`) REFERENCES `dd_bd_formato_campo` (`DDBDFC_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_bd_campo`
--

LOCK TABLES `dd_bd_campo` WRITE;
/*!40000 ALTER TABLE `dd_bd_campo` DISABLE KEYS */;
INSERT INTO `dd_bd_campo` VALUES (59,'Descricaodoproduto_PRODUTO','Descricao do produto','N','Stgdfgdf',83,1),(60,'Precodecusto_PRODUTO','Preco de custo','N','Ghfghfg',83,6),(61,'Precodevenda_PRODUTO','Preco de venda','N','Sdfgfdgd',83,6),(62,'Lucro_PRODUTO','Lucro','N','Sfgfgd',83,6),(63,'Descricaodamarca_MARCA','Descrição da marca','N','Dfgdfgd',84,1),(64,'Descricaodogrupo_GRUPO','Descrição do grupo','N','Dfgdfgf',85,1),(65,'Nomedofuncionario_FUNCIONARIO','Nome do funcionario','N','Sfsfgs',86,1),(66,'Comissao_VENDEDOR','Comissão','N','Sdgsfgf',87,6),(67,'Nomedocliente_CLIENTE','Nome do cliente','N','Dfgdfgd',88,1),(68,'Enderecodocliente_CLIENTE','Endereço do cliente','N','Fgfdgfd',88,1),(69,'Telefonedocliente_CLIENTE','Telefone do cliente','N','Dfgfdgdf',88,2),(70,'Cep_CLIENTE','Cep','N','Dfdfhgd',88,4),(71,'Datadenascimento_CLIENTE','Data de nascimento','N','Dggf',88,5);
/*!40000 ALTER TABLE `dd_bd_campo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_bd_chave_estrangeira`
--

DROP TABLE IF EXISTS `dd_bd_chave_estrangeira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_bd_chave_estrangeira` (
  `DDBDCE_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDBDT_CODIGO` int(11) NOT NULL,
  `DDBDCP_CODIGO` int(11) NOT NULL,
  `DDBDCE_REQUERIDO` char(1) NOT NULL,
  PRIMARY KEY (`DDBDCE_CODIGO`),
  KEY `DDBDT_CODIGO` (`DDBDT_CODIGO`),
  KEY `DDBDCP_CODIGO` (`DDBDCP_CODIGO`),
  CONSTRAINT `dd_bd_chave_estrangeira_ibfk_1` FOREIGN KEY (`DDBDT_CODIGO`) REFERENCES `dd_bd_tabelas` (`DDBDT_CODIGO`),
  CONSTRAINT `dd_bd_chave_estrangeira_ibfk_2` FOREIGN KEY (`DDBDCP_CODIGO`) REFERENCES `dd_bd_chave_primaria` (`DDBDCP_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_bd_chave_estrangeira`
--

LOCK TABLES `dd_bd_chave_estrangeira` WRITE;
/*!40000 ALTER TABLE `dd_bd_chave_estrangeira` DISABLE KEYS */;
INSERT INTO `dd_bd_chave_estrangeira` VALUES (40,87,82,'S'),(41,83,80,'N'),(42,83,81,'N'),(43,83,83,'N'),(44,88,83,'N');
/*!40000 ALTER TABLE `dd_bd_chave_estrangeira` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_bd_chave_primaria`
--

DROP TABLE IF EXISTS `dd_bd_chave_primaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_bd_chave_primaria` (
  `DDBDCP_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDBDT_CODIGO` int(11) NOT NULL,
  `DDBDCP_CAMPO_FISICO` varchar(70) DEFAULT NULL,
  `DDBDCP_CAMPO_APELIDO` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`DDBDCP_CODIGO`),
  KEY `DDBDT_CODIGO` (`DDBDT_CODIGO`),
  CONSTRAINT `dd_bd_chave_primaria_ibfk_1` FOREIGN KEY (`DDBDT_CODIGO`) REFERENCES `dd_bd_tabelas` (`DDBDT_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_bd_chave_primaria`
--

LOCK TABLES `dd_bd_chave_primaria` WRITE;
/*!40000 ALTER TABLE `dd_bd_chave_primaria` DISABLE KEYS */;
INSERT INTO `dd_bd_chave_primaria` VALUES (79,83,'idproduto_PRODUTO','id produto'),(80,84,'idmarca_MARCA','id marca'),(81,85,'idgrupo_GRUPO','id grupo'),(82,86,'idfuncionario_FUNCIONARIO','id funcionario'),(83,87,'idvendedor_VENDEDOR','id vendedor'),(84,88,'idcliente_CLIENTE','id cliente');
/*!40000 ALTER TABLE `dd_bd_chave_primaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_bd_formato_campo`
--

DROP TABLE IF EXISTS `dd_bd_formato_campo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_bd_formato_campo` (
  `DDBDFC_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDBDFC_DESCRICAO_CAMPO` varchar(50) DEFAULT NULL,
  `DDBDFC_FORMATO_FISICO` varchar(50) DEFAULT NULL,
  `DDBDFC_FORMATO_APELIDO` varchar(50) DEFAULT NULL,
  `DDBDFC_TIPO` varchar(30) DEFAULT NULL,
  `DDBDFC_TAMANHO` varchar(5) DEFAULT NULL,
  `DDBDFC_CASA_DECIMAL` int(11) DEFAULT NULL,
  PRIMARY KEY (`DDBDFC_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_bd_formato_campo`
--

LOCK TABLES `dd_bd_formato_campo` WRITE;
/*!40000 ALTER TABLE `dd_bd_formato_campo` DISABLE KEYS */;
INSERT INTO `dd_bd_formato_campo` VALUES (1,'DESCRIÇÃO(50)',NULL,NULL,'VARCHAR','50',NULL),(2,'TELEFONE','!\\(##\\)####-####;1;_','(  )____-____','VARCHAR','13',NULL),(3,'CELULAR','!\\(##\\)#####-####;1;_','(  )_____-____','VARCHAR','14',NULL),(4,'CEP','##.###\\-###;#;_','__-___-___','VARCHAR','10',NULL),(5,'DATA',NULL,NULL,'TIMESTAMP',NULL,NULL),(6,'VALOR MONETÁRIO(10,2)',NULL,NULL,'DOUBLE','10',2),(7,'QTDE',NULL,NULL,'DOUBLE','10',3),(8,'VALOR MONETÁRIO(10,4)',NULL,NULL,'DOUBLE','10',4);
/*!40000 ALTER TABLE `dd_bd_formato_campo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_bd_tabelas`
--

DROP TABLE IF EXISTS `dd_bd_tabelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_bd_tabelas` (
  `DDBDT_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDBDT_TABELA_FISICA` varchar(50) DEFAULT NULL,
  `DDBDT_TABELA_APELIDO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`DDBDT_CODIGO`),
  UNIQUE KEY `DDBDT_TABELA_APELIDO` (`DDBDT_TABELA_APELIDO`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_bd_tabelas`
--

LOCK TABLES `dd_bd_tabelas` WRITE;
/*!40000 ALTER TABLE `dd_bd_tabelas` DISABLE KEYS */;
INSERT INTO `dd_bd_tabelas` VALUES (83,'PRODUTO','PRODUTO'),(84,'MARCA','MARCA'),(85,'GRUPO','GRUPO'),(86,'FUNCIONARIO','FUNCIONARIO'),(87,'VENDEDOR','VENDEDOR'),(88,'CLIENTE','CLIENTE');
/*!40000 ALTER TABLE `dd_bd_tabelas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_botao_atalho`
--

DROP TABLE IF EXISTS `dd_botao_atalho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_botao_atalho` (
  `DDBA_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDM_CODIGO` int(11) NOT NULL,
  `DDBA_POSICAO` int(11) NOT NULL,
  PRIMARY KEY (`DDBA_CODIGO`),
  KEY `DDM_CODIGO` (`DDM_CODIGO`),
  CONSTRAINT `dd_botao_atalho_ibfk_1` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_botao_atalho`
--

LOCK TABLES `dd_botao_atalho` WRITE;
/*!40000 ALTER TABLE `dd_botao_atalho` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_botao_atalho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_classes_para_forms`
--

DROP TABLE IF EXISTS `dd_classes_para_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_classes_para_forms` (
  `DDCPF_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDCPF_DESCRICAO` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DDCPF_CODIGO`),
  UNIQUE KEY `DDCPF_DESCRICAO` (`DDCPF_DESCRICAO`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_classes_para_forms`
--

LOCK TABLES `dd_classes_para_forms` WRITE;
/*!40000 ALTER TABLE `dd_classes_para_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_classes_para_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_combobox`
--

DROP TABLE IF EXISTS `dd_combobox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_combobox` (
  `ddcb_codigo` int(11) NOT NULL AUTO_INCREMENT,
  `ddcb_nome_combobox` varchar(40) NOT NULL,
  `ddm_codigo` int(11) DEFAULT NULL,
  `ddbdt_codigo` int(11) NOT NULL,
  `ddbdc_codigo` int(11) NOT NULL,
  `DDBDCE_CODIGO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ddcb_codigo`),
  KEY `ddm_codigo` (`ddm_codigo`),
  KEY `ddbdt_codigo` (`ddbdt_codigo`),
  KEY `ddbdc_codigo` (`ddbdc_codigo`),
  KEY `DDBDCE_CODIGO` (`DDBDCE_CODIGO`),
  CONSTRAINT `dd_combobox_ibfk_1` FOREIGN KEY (`ddm_codigo`) REFERENCES `dd_menu` (`DDM_CODIGO`),
  CONSTRAINT `dd_combobox_ibfk_3` FOREIGN KEY (`ddbdt_codigo`) REFERENCES `dd_bd_tabelas` (`DDBDT_CODIGO`),
  CONSTRAINT `dd_combobox_ibfk_4` FOREIGN KEY (`ddbdc_codigo`) REFERENCES `dd_bd_campo` (`DDBDC_CODIGO`),
  CONSTRAINT `dd_combobox_ibfk_5` FOREIGN KEY (`DDBDCE_CODIGO`) REFERENCES `dd_bd_chave_estrangeira` (`DDBDCE_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_combobox`
--

LOCK TABLES `dd_combobox` WRITE;
/*!40000 ALTER TABLE `dd_combobox` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_combobox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_groupbox`
--

DROP TABLE IF EXISTS `dd_groupbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_groupbox` (
  `DDGB_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDGB_LEFT` int(11) DEFAULT NULL,
  `DDGB_TOP` int(11) DEFAULT NULL,
  `DDGB_HEIGHT` int(11) DEFAULT NULL,
  `DDGB_WIDTH` int(11) DEFAULT NULL,
  `DDM_CODIGO` int(11) DEFAULT NULL,
  `DDTS_CODIGO` int(11) DEFAULT NULL,
  `DDGB_CAPTION` varchar(50) DEFAULT NULL,
  `DDGB_NAME` varchar(5) DEFAULT NULL,
  `DDGB_TIPO_TELA` char(1) DEFAULT NULL COMMENT ' P PESQUISA C CADASTRO',
  PRIMARY KEY (`DDGB_CODIGO`),
  KEY `DDM_CODIGO` (`DDM_CODIGO`),
  KEY `DDTS_CODIGO` (`DDTS_CODIGO`),
  CONSTRAINT `dd_groupbox_ibfk_1` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`),
  CONSTRAINT `dd_groupbox_ibfk_2` FOREIGN KEY (`DDTS_CODIGO`) REFERENCES `dd_tab_sheet` (`DDTS_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_groupbox`
--

LOCK TABLES `dd_groupbox` WRITE;
/*!40000 ALTER TABLE `dd_groupbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_groupbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_menu`
--

DROP TABLE IF EXISTS `dd_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_menu` (
  `DDM_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDMM_CODIGO` int(11) DEFAULT NULL,
  `DDM_CODMODULO_CODMENU` varchar(4) DEFAULT NULL,
  `DDM_CAPTION` varchar(50) DEFAULT NULL,
  `DDM_SEQUENCIA_MENU` int(11) DEFAULT NULL,
  `DDBDT_CODIGO` int(11) DEFAULT NULL,
  `DDCPF_CODIGO` int(11) DEFAULT NULL,
  `DDM_CAMINHO_ICONE` varchar(400) DEFAULT NULL,
  `DDM_NAME` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`DDM_CODIGO`),
  KEY `DDMM_CODIGO` (`DDMM_CODIGO`),
  KEY `DDBDT_CODIGO` (`DDBDT_CODIGO`),
  KEY `DDCPF_CODIGO` (`DDCPF_CODIGO`),
  CONSTRAINT `dd_menu_ibfk_1` FOREIGN KEY (`DDMM_CODIGO`) REFERENCES `dd_modulo_menu` (`DDMM_CODIGO`),
  CONSTRAINT `dd_menu_ibfk_2` FOREIGN KEY (`DDBDT_CODIGO`) REFERENCES `dd_bd_tabelas` (`DDBDT_CODIGO`),
  CONSTRAINT `dd_menu_ibfk_3` FOREIGN KEY (`DDCPF_CODIGO`) REFERENCES `dd_classes_para_forms` (`DDCPF_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_menu`
--

LOCK TABLES `dd_menu` WRITE;
/*!40000 ALTER TABLE `dd_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_modulo_menu`
--

DROP TABLE IF EXISTS `dd_modulo_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_modulo_menu` (
  `DDMM_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDMM_DESCRICAO` varchar(50) DEFAULT NULL,
  `DDMM_SEQUENCIA_MODULO` int(11) DEFAULT NULL,
  PRIMARY KEY (`DDMM_CODIGO`),
  UNIQUE KEY `DDMM_DESCRICAO` (`DDMM_DESCRICAO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_modulo_menu`
--

LOCK TABLES `dd_modulo_menu` WRITE;
/*!40000 ALTER TABLE `dd_modulo_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_modulo_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_modulo_menu_classes_forms`
--

DROP TABLE IF EXISTS `dd_modulo_menu_classes_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_modulo_menu_classes_forms` (
  `DDMMCF_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDMM_CODIGO` int(11) DEFAULT NULL,
  `DDCPF_CODIGO` int(11) DEFAULT NULL,
  PRIMARY KEY (`DDMMCF_CODIGO`),
  KEY `DDCPF_CODIGO` (`DDCPF_CODIGO`),
  KEY `DDMM_CODIGO` (`DDMM_CODIGO`),
  CONSTRAINT `dd_modulo_menu_classes_forms_ibfk_1` FOREIGN KEY (`DDCPF_CODIGO`) REFERENCES `dd_classes_para_forms` (`DDCPF_CODIGO`),
  CONSTRAINT `dd_modulo_menu_classes_forms_ibfk_2` FOREIGN KEY (`DDMM_CODIGO`) REFERENCES `dd_modulo_menu` (`DDMM_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_modulo_menu_classes_forms`
--

LOCK TABLES `dd_modulo_menu_classes_forms` WRITE;
/*!40000 ALTER TABLE `dd_modulo_menu_classes_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_modulo_menu_classes_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_page_control`
--

DROP TABLE IF EXISTS `dd_page_control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_page_control` (
  `DDPC_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDPC_NOME` varchar(70) DEFAULT NULL,
  `DDM_CODIGO` int(11) NOT NULL,
  PRIMARY KEY (`DDPC_CODIGO`),
  KEY `DDM_CODIGO` (`DDM_CODIGO`),
  CONSTRAINT `dd_page_control_ibfk_1` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`),
  CONSTRAINT `dd_page_control_ibfk_2` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_page_control`
--

LOCK TABLES `dd_page_control` WRITE;
/*!40000 ALTER TABLE `dd_page_control` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_page_control` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_pesquisa_entre_datas`
--

DROP TABLE IF EXISTS `dd_pesquisa_entre_datas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_pesquisa_entre_datas` (
  `ddped_codigo` int(11) NOT NULL AUTO_INCREMENT,
  `ddped_nome_pesquisa` varchar(35) NOT NULL,
  `ddbdc_codigo` int(11) NOT NULL,
  `ddm_codigo` int(11) DEFAULT NULL,
  `DDPED_TOP` int(11) DEFAULT NULL,
  `DDPED_LEFT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ddped_codigo`),
  KEY `ddbdc_codigo` (`ddbdc_codigo`),
  KEY `ddm_codigo` (`ddm_codigo`),
  CONSTRAINT `dd_pesquisa_entre_datas_ibfk_1` FOREIGN KEY (`ddbdc_codigo`) REFERENCES `dd_bd_campo` (`DDBDC_CODIGO`),
  CONSTRAINT `dd_pesquisa_entre_datas_ibfk_2` FOREIGN KEY (`ddm_codigo`) REFERENCES `dd_menu` (`DDM_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_pesquisa_entre_datas`
--

LOCK TABLES `dd_pesquisa_entre_datas` WRITE;
/*!40000 ALTER TABLE `dd_pesquisa_entre_datas` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_pesquisa_entre_datas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_posicao_botao_pesquisa`
--

DROP TABLE IF EXISTS `dd_posicao_botao_pesquisa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_posicao_botao_pesquisa` (
  `DDPBP_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDM_CODIGO` int(11) DEFAULT NULL,
  `DDPBP_LEFT` int(11) DEFAULT NULL,
  `DDPBP_TOP` int(11) DEFAULT NULL,
  PRIMARY KEY (`DDPBP_CODIGO`),
  KEY `DDM_CODIGO` (`DDM_CODIGO`),
  CONSTRAINT `dd_posicao_botao_pesquisa_ibfk_1` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_posicao_botao_pesquisa`
--

LOCK TABLES `dd_posicao_botao_pesquisa` WRITE;
/*!40000 ALTER TABLE `dd_posicao_botao_pesquisa` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_posicao_botao_pesquisa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_posicao_groupbox_botoes`
--

DROP TABLE IF EXISTS `dd_posicao_groupbox_botoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_posicao_groupbox_botoes` (
  `DDPGB_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDM_CODIGO` int(11) DEFAULT NULL,
  `DDPGB_LEFT` int(11) DEFAULT NULL,
  `DDPGB_TOP` int(11) DEFAULT NULL,
  PRIMARY KEY (`DDPGB_CODIGO`),
  KEY `DDM_CODIGO` (`DDM_CODIGO`),
  CONSTRAINT `dd_posicao_groupbox_botoes_ibfk_1` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_posicao_groupbox_botoes`
--

LOCK TABLES `dd_posicao_groupbox_botoes` WRITE;
/*!40000 ALTER TABLE `dd_posicao_groupbox_botoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_posicao_groupbox_botoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_tab_sheet`
--

DROP TABLE IF EXISTS `dd_tab_sheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_tab_sheet` (
  `DDTS_CODIGO` int(11) NOT NULL,
  `DDTS_CAPTION` varchar(70) DEFAULT NULL,
  `DDTS_POSICAO` int(11) DEFAULT NULL,
  `DDPC_CODIGO` int(11) NOT NULL,
  PRIMARY KEY (`DDTS_CODIGO`),
  KEY `DDPC_CODIGO` (`DDPC_CODIGO`),
  CONSTRAINT `dd_tab_sheet_ibfk_1` FOREIGN KEY (`DDPC_CODIGO`) REFERENCES `dd_page_control` (`DDPC_CODIGO`),
  CONSTRAINT `dd_tab_sheet_ibfk_2` FOREIGN KEY (`DDPC_CODIGO`) REFERENCES `dd_page_control` (`DDPC_CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_tab_sheet`
--

LOCK TABLES `dd_tab_sheet` WRITE;
/*!40000 ALTER TABLE `dd_tab_sheet` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_tab_sheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_tela_campo`
--

DROP TABLE IF EXISTS `dd_tela_campo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_tela_campo` (
  `DDTC_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDGB_CODIGO` int(11) NOT NULL,
  `DDTC_TOP` int(11) NOT NULL,
  `DDTC_LEFT` int(11) NOT NULL,
  `DDTC_HEIGHT` int(11) NOT NULL,
  `DDTC_WIDTH` int(11) NOT NULL,
  `DDBDC_CODIGO` int(11) DEFAULT NULL,
  `DDBDCP_CODIGO` int(11) DEFAULT NULL,
  `ddcb_codigo` int(11) DEFAULT NULL,
  PRIMARY KEY (`DDTC_CODIGO`),
  KEY `DDGB_CODIGO` (`DDGB_CODIGO`),
  KEY `DDBDC_CODIGO` (`DDBDC_CODIGO`),
  KEY `DDBDCP_CODIGO` (`DDBDCP_CODIGO`),
  KEY `ddcb_codigo` (`ddcb_codigo`),
  CONSTRAINT `dd_tela_campo_ibfk_1` FOREIGN KEY (`DDGB_CODIGO`) REFERENCES `dd_groupbox` (`DDGB_CODIGO`),
  CONSTRAINT `dd_tela_campo_ibfk_2` FOREIGN KEY (`DDBDC_CODIGO`) REFERENCES `dd_bd_campo` (`DDBDC_CODIGO`),
  CONSTRAINT `dd_tela_campo_ibfk_3` FOREIGN KEY (`DDBDCP_CODIGO`) REFERENCES `dd_bd_chave_primaria` (`DDBDCP_CODIGO`),
  CONSTRAINT `dd_tela_campo_ibfk_4` FOREIGN KEY (`ddcb_codigo`) REFERENCES `dd_combobox` (`ddcb_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_tela_campo`
--

LOCK TABLES `dd_tela_campo` WRITE;
/*!40000 ALTER TABLE `dd_tela_campo` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_tela_campo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_tela_campo_grid`
--

DROP TABLE IF EXISTS `dd_tela_campo_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_tela_campo_grid` (
  `DDTCG_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDBDC_CODIGO` int(11) DEFAULT NULL,
  `DDBDCP_CODIGO` int(11) DEFAULT NULL,
  `DDM_CODIGO` int(11) DEFAULT NULL,
  `DDTCG_TAMANHO` int(11) DEFAULT NULL,
  `DDTCG_POSICAO` int(11) DEFAULT NULL,
  `DDBDT_CODIGO` int(11) DEFAULT NULL COMMENT 'CAMPO USADO P/ INSERIR CHAVE ESTRANGEIRA',
  PRIMARY KEY (`DDTCG_CODIGO`),
  KEY `DDBDC_CODIGO` (`DDBDC_CODIGO`),
  KEY `DDBDCP_CODIGO` (`DDBDCP_CODIGO`),
  KEY `DDM_CODIGO` (`DDM_CODIGO`),
  KEY `DDBDT_CODIGO` (`DDBDT_CODIGO`),
  CONSTRAINT `dd_tela_campo_grid_ibfk_1` FOREIGN KEY (`DDBDC_CODIGO`) REFERENCES `dd_bd_campo` (`DDBDC_CODIGO`),
  CONSTRAINT `dd_tela_campo_grid_ibfk_2` FOREIGN KEY (`DDBDCP_CODIGO`) REFERENCES `dd_bd_chave_primaria` (`DDBDCP_CODIGO`),
  CONSTRAINT `dd_tela_campo_grid_ibfk_3` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`),
  CONSTRAINT `dd_tela_campo_grid_ibfk_4` FOREIGN KEY (`DDBDT_CODIGO`) REFERENCES `dd_bd_tabelas` (`DDBDT_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_tela_campo_grid`
--

LOCK TABLES `dd_tela_campo_grid` WRITE;
/*!40000 ALTER TABLE `dd_tela_campo_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_tela_campo_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dd_tela_campo_pesquisa`
--

DROP TABLE IF EXISTS `dd_tela_campo_pesquisa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dd_tela_campo_pesquisa` (
  `DDTCP_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DDBDC_CODIGO` int(11) DEFAULT NULL,
  `DDBDCP_CODIGO` int(11) DEFAULT NULL,
  `DDM_CODIGO` int(11) DEFAULT NULL,
  `DDTCP_TOP` int(11) DEFAULT NULL,
  `DDTCP_LEFT` int(11) DEFAULT NULL,
  `DDTCP_HEIGHT` int(11) DEFAULT NULL,
  `DDTCP_WIDTH` int(11) DEFAULT NULL,
  `DDCB_CODIGO` int(11) DEFAULT NULL,
  `DDTCP_TIPO_COMPONENTE` char(1) DEFAULT NULL COMMENT 'G GROUPBOX D DBGRID',
  PRIMARY KEY (`DDTCP_CODIGO`),
  KEY `DDBDC_CODIGO` (`DDBDC_CODIGO`),
  KEY `DDBDCP_CODIGO` (`DDBDCP_CODIGO`),
  KEY `DDM_CODIGO` (`DDM_CODIGO`),
  KEY `DDCB_CODIGO` (`DDCB_CODIGO`),
  CONSTRAINT `dd_tela_campo_pesquisa_ibfk_1` FOREIGN KEY (`DDBDC_CODIGO`) REFERENCES `dd_bd_campo` (`DDBDC_CODIGO`),
  CONSTRAINT `dd_tela_campo_pesquisa_ibfk_2` FOREIGN KEY (`DDBDCP_CODIGO`) REFERENCES `dd_bd_chave_primaria` (`DDBDCP_CODIGO`),
  CONSTRAINT `dd_tela_campo_pesquisa_ibfk_3` FOREIGN KEY (`DDM_CODIGO`) REFERENCES `dd_menu` (`DDM_CODIGO`),
  CONSTRAINT `dd_tela_campo_pesquisa_ibfk_4` FOREIGN KEY (`DDCB_CODIGO`) REFERENCES `dd_combobox` (`ddcb_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dd_tela_campo_pesquisa`
--

LOCK TABLES `dd_tela_campo_pesquisa` WRITE;
/*!40000 ALTER TABLE `dd_tela_campo_pesquisa` DISABLE KEYS */;
/*!40000 ALTER TABLE `dd_tela_campo_pesquisa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionario` (
  `idfuncionario_FUNCIONARIO` int(11) NOT NULL AUTO_INCREMENT,
  `Nomedofuncionario_FUNCIONARIO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idfuncionario_FUNCIONARIO`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo` (
  `idgrupo_grupo` int(11) NOT NULL,
  `Descricaodogrupo_GRUPO` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca`
--

DROP TABLE IF EXISTS `marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marca` (
  `idmarca_marca` int(11) NOT NULL,
  `Descricaodamarca_MARCA` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produto` (
  `idproduto_PRODUTO` int(11) NOT NULL AUTO_INCREMENT,
  `Descricaodoproduto_PRODUTO` varchar(50) DEFAULT NULL,
  `Precodecusto_PRODUTO` double DEFAULT NULL,
  `Precodevenda_PRODUTO` double DEFAULT NULL,
  `Lucro_PRODUTO` double DEFAULT NULL,
  `idmarca_MARCA` int(11) DEFAULT NULL,
  `idgrupo_GRUPO` int(11) DEFAULT NULL,
  `idvendedor_VENDEDOR` int(11) DEFAULT NULL,
  PRIMARY KEY (`idproduto_PRODUTO`),
  KEY `idmarca_MARCA` (`idmarca_MARCA`),
  KEY `idgrupo_GRUPO` (`idgrupo_GRUPO`),
  KEY `idvendedor_VENDEDOR` (`idvendedor_VENDEDOR`),
  CONSTRAINT `produto_ibfk_3` FOREIGN KEY (`idvendedor_VENDEDOR`) REFERENCES `vendedor` (`idvendedor_VENDEDOR`)
) ENGINE=InnoDB AUTO_INCREMENT=14610 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendedor` (
  `idvendedor_VENDEDOR` int(11) NOT NULL AUTO_INCREMENT,
  `Comissao_VENDEDOR` double DEFAULT NULL,
  `idfuncionario_FUNCIONARIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`idvendedor_VENDEDOR`),
  KEY `idfuncionario_FUNCIONARIO` (`idfuncionario_FUNCIONARIO`),
  CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`idfuncionario_FUNCIONARIO`) REFERENCES `funcionario` (`idfuncionario_FUNCIONARIO`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-18 11:45:40
