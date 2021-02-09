/*
SQLyog Community v13.1.5  (32 bit)
MySQL - 10.5.7-MariaDB-1:10.5.7+maria~focal : Database - bd2_grupo2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bd2_grupo2` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `bd2_grupo2`;

/*Table structure for table `categorias_de_tiendas` */

DROP TABLE IF EXISTS `categorias_de_tiendas`;

CREATE TABLE `categorias_de_tiendas` (
  `categorias_de_tiendas_id_pkey` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_id_pkey` varchar(25) NOT NULL,
  `descripción` varchar(175) DEFAULT NULL,
  PRIMARY KEY (`categorias_de_tiendas_id_pkey`,`nombre_id_pkey`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `categorias_de_tiendas` */

insert  into `categorias_de_tiendas`(`categorias_de_tiendas_id_pkey`,`nombre_id_pkey`,`descripción`) values 
(1,'Electrodomesticos','Todo en electrodomesticos'),
(2,'Comida','Compra y venta de comida'),
(3,'Supermarket','Alimentos sellados'),
(4,'Entretenimiento',NULL);

/*Table structure for table `categorías_de_productos` */

DROP TABLE IF EXISTS `categorías_de_productos`;

CREATE TABLE `categorías_de_productos` (
  `categorías_de_productos_nombre_categoría_id_pkey` varchar(35) NOT NULL,
  `categorías_de_productos_id_pkey` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripción` varchar(175) DEFAULT NULL,
  PRIMARY KEY (`categorías_de_productos_nombre_categoría_id_pkey`),
  KEY `categorías_de_productos_id_pkey` (`categorías_de_productos_id_pkey`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `categorías_de_productos` */

insert  into `categorías_de_productos`(`categorías_de_productos_nombre_categoría_id_pkey`,`categorías_de_productos_id_pkey`,`descripción`) values 
('De baja',4,'Prontos a salir del mercado'),
('Especiales',3,'Poductos especiales de cada tienda'),
('Nuevos',1,'Productos recientemente agregados'),
('Temporada',2,'Productos de temporada');

/*Table structure for table `compras` */

DROP TABLE IF EXISTS `compras`;

CREATE TABLE `compras` (
  `costo_total` double NOT NULL DEFAULT 0,
  `fecha_de_compra` datetime NOT NULL,
  `nmro_factura_id_pkey` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_correo_usuario_cliente_foreign` varchar(50) NOT NULL,
  `tienda_nombre_foreign` varchar(35) NOT NULL,
  `tienda_correo_usuario_administrador_de_tienda_foreign` varchar(50) NOT NULL,
  PRIMARY KEY (`nmro_factura_id_pkey`,`tienda_nombre_foreign`,`tienda_correo_usuario_administrador_de_tienda_foreign`),
  KEY `compras_usuario_correo_usuario_foreign_index` (`usuario_correo_usuario_cliente_foreign`),
  KEY `Asociada` (`tienda_nombre_foreign`,`tienda_correo_usuario_administrador_de_tienda_foreign`),
  CONSTRAINT `Asociada` FOREIGN KEY (`tienda_nombre_foreign`, `tienda_correo_usuario_administrador_de_tienda_foreign`) REFERENCES `tiendas` (`nombre_id_pkey`, `usuario_correo_usuario_id_foreign`),
  CONSTRAINT `Realiza` FOREIGN KEY (`usuario_correo_usuario_cliente_foreign`) REFERENCES `usuarios` (`usuario_correo_usuario_id_pkey`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `compras` */

insert  into `compras`(`costo_total`,`fecha_de_compra`,`nmro_factura_id_pkey`,`usuario_correo_usuario_cliente_foreign`,`tienda_nombre_foreign`,`tienda_correo_usuario_administrador_de_tienda_foreign`) values 
(36,'2021-01-06 00:00:00',1,'anayala@gmail.com','MiniGames','jesusm@gmail.com'),
(450,'2021-01-02 00:00:00',2,'rosao@gmail.com','Jose C.A','josem@gmail.com'),
(450,'2021-01-02 00:00:00',3,'anayala@gmail.com','Jose C.A','josem@gmail.com'),
(20.5,'2021-01-04 18:35:03',4,'miriam@gmail.com','MiniGames','jesusm@gmail.com'),
(10.5,'2021-01-01 00:00:00',5,'rosao@gmail.com','Todo Compras','crladuran15@gmail.com'),
(10.5,'2021-01-04 00:00:00',6,'anayala@gmail.com','Rotary bistro','jimenaluces@gmail.com');

/*Table structure for table `compras_productos` */

DROP TABLE IF EXISTS `compras_productos`;

CREATE TABLE `compras_productos` (
  `producto_id_foreign` bigint(20) unsigned NOT NULL,
  `tienda_nombre_tienda_foreign` varchar(35) NOT NULL,
  `nmro_factura_id_foreign` bigint(20) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL DEFAULT 0,
  `costo` float unsigned NOT NULL DEFAULT 0,
  `usuario_correo_usuario_foreign` varchar(50) NOT NULL,
  PRIMARY KEY (`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`nmro_factura_id_foreign`,`usuario_correo_usuario_foreign`),
  KEY `Compone` (`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`usuario_correo_usuario_foreign`),
  KEY `Establece` (`nmro_factura_id_foreign`),
  CONSTRAINT `Compone` FOREIGN KEY (`producto_id_foreign`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`) REFERENCES `productos` (`producto_id_pkey`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `compras_productos` */

insert  into `compras_productos`(`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`nmro_factura_id_foreign`,`cantidad`,`costo`,`usuario_correo_usuario_foreign`) values 
(3,'Jose C.A',2,1,450,'josem@gmail.com'),
(5,'Rotary bistro',6,1,10.5,'jimenaluces@gmail.com'),
(6,'Todo Compras',5,1,10.5,'crladuran15@gmail.com'),
(7,'MiniGames',1,1,15.5,'jesusm@gmail.com'),
(10,'Jose C.A',3,1,450,'josem@gmail.com'),
(11,'MiniGames',1,1,20.5,'jesusm@gmail.com'),
(12,'MiniGames',4,1,20.5,'jesusm@gmail.com');

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `producto_id_pkey` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tienda_nombre_tienda_foreign` varchar(35) NOT NULL,
  `nombre_de_producto` varchar(35) NOT NULL,
  `descripción_de_producto` varchar(175) DEFAULT NULL,
  `cantidad_en_inventario` int(10) unsigned NOT NULL DEFAULT 0,
  `precio` float unsigned NOT NULL DEFAULT 0,
  `descuento_producto` float unsigned DEFAULT 0,
  `usuario_correo_usuario_foreign` varchar(50) NOT NULL,
  `estado_de_producto` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`producto_id_pkey`,`tienda_nombre_tienda_foreign`,`usuario_correo_usuario_foreign`),
  KEY `Vende` (`tienda_nombre_tienda_foreign`,`usuario_correo_usuario_foreign`),
  CONSTRAINT `Vende` FOREIGN KEY (`tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`) REFERENCES `tiendas` (`nombre_id_pkey`, `usuario_correo_usuario_id_foreign`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `productos` */

insert  into `productos`(`producto_id_pkey`,`tienda_nombre_tienda_foreign`,`nombre_de_producto`,`descripción_de_producto`,`cantidad_en_inventario`,`precio`,`descuento_producto`,`usuario_correo_usuario_foreign`,`estado_de_producto`) values 
(1,'Jose C.A','Microondas LG',NULL,100,200,0,'josem@gmail.com',1),
(2,'Todo compras','Aceite de oliva',NULL,100,1.5,0,'crladuran15@gmail.com',1),
(3,'Jose C.A','Lavadora Samsung',NULL,99,450,0,'josem@gmail.com',1),
(4,'MiniGames','LOL',NULL,150,20.5,0,'jesusm@gmail.com',1),
(5,'Rotary bistro','Lasagna',NULL,9,10.5,0,'jimenaluces@gmail.com',1),
(6,'Todo compras','Lícor de cafe',NULL,14,10.5,0,'crladuran15@gmail.com',1),
(7,'MiniGames','Cooking Mama',NULL,149,15.5,0,'jesusm@gmail.com',1),
(8,'Rotary bistro','Torta de chocolate',NULL,10,5.5,0,'jimenaluces@gmail.com',1),
(9,'Todo compras','Cereales mixto',NULL,150,5.5,0,'crladuran15@gmail.com',1),
(10,'Jose C.A','Secadora Samsung',NULL,49,450,0,'josem@gmail.com',1),
(11,'MiniGames','FiFa20','Divertido Juego de futbol que nunca cambia',149,20.5,0,'jesusm@gmail.com',1),
(12,'MiniGames','Fifa2021',NULL,199,20.5,0,'jesusm@gmail.com',1);

/*Table structure for table `productos_categorías_de_productos` */

DROP TABLE IF EXISTS `productos_categorías_de_productos`;

CREATE TABLE `productos_categorías_de_productos` (
  `producto_id_foreign` bigint(20) unsigned NOT NULL,
  `tienda_nombre_tienda_foreign` varchar(35) NOT NULL,
  `categoría_de_producto_nombre_categoría_foreign` varchar(35) NOT NULL,
  `categoría_de_producto_id_foreign` bigint(20) unsigned NOT NULL,
  `usuario_correo_usuario_foreign` varchar(50) NOT NULL,
  PRIMARY KEY (`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`categoría_de_producto_nombre_categoría_foreign`,`categoría_de_producto_id_foreign`,`usuario_correo_usuario_foreign`),
  KEY `Agrupan` (`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`usuario_correo_usuario_foreign`),
  CONSTRAINT `Agrupan` FOREIGN KEY (`producto_id_foreign`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`) REFERENCES `productos` (`producto_id_pkey`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `productos_categorías_de_productos` */

insert  into `productos_categorías_de_productos`(`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`categoría_de_producto_nombre_categoría_foreign`,`categoría_de_producto_id_foreign`,`usuario_correo_usuario_foreign`) values 
(1,'Jose C.A','Nuevos',1,'josem@gmail.com'),
(2,'Todo compras','Nuevos',1,'crladuran15@gmail.com'),
(3,'Jose C.A','Nuevos',1,'josem@gmail.com'),
(4,'MiniGames','Nuevos',1,'jesusm@gmail.com'),
(6,'Todo compras','Nuevos',1,'crladuran15@gmail.com'),
(7,'MiniGames','De baja',4,'jesusm@gmail.com'),
(8,'Rotary bistro','Nuevos',1,'jimenaluces@gmail.com'),
(9,'Todo compras','Nuevos',1,'crladuran15@gmail.com'),
(10,'Jose C.A','Temporada',2,'josem@gmail.com'),
(11,'MiniGames','Temporada',3,'jesusm@gmail.com'),
(12,'MiniGames','Nuevos',1,'jesusm@gmail.com');

/*Table structure for table `productos_imágenes` */

DROP TABLE IF EXISTS `productos_imágenes`;

CREATE TABLE `productos_imágenes` (
  `productos_imágenes_ruta_pkey` varchar(250) NOT NULL,
  `producto_id_foreign` bigint(20) unsigned NOT NULL,
  `tienda_nombre_tienda_foreign` varchar(35) NOT NULL,
  `usuario_correo_usuario_foreign` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`productos_imágenes_ruta_pkey`),
  KEY `productos_imágenes_produc_id_tienda_nombre_usuario_correo_index` (`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`usuario_correo_usuario_foreign`),
  CONSTRAINT `Posee` FOREIGN KEY (`producto_id_foreign`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`) REFERENCES `productos` (`producto_id_pkey`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `productos_imágenes` */

/*Table structure for table `productos_subcategorías_de_productos` */

DROP TABLE IF EXISTS `productos_subcategorías_de_productos`;

CREATE TABLE `productos_subcategorías_de_productos` (
  `producto_id_foreign` bigint(20) unsigned NOT NULL,
  `tienda_nombre_tienda_foreign` varchar(35) NOT NULL,
  `subcategorías_de_productos_id_foreign` bigint(20) unsigned NOT NULL,
  `usuario_correo_usuario_foreign` varchar(50) NOT NULL,
  PRIMARY KEY (`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`subcategorías_de_productos_id_foreign`,`usuario_correo_usuario_foreign`),
  KEY `Categoriza` (`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`usuario_correo_usuario_foreign`),
  KEY `SubDiv` (`subcategorías_de_productos_id_foreign`),
  CONSTRAINT `Categoriza` FOREIGN KEY (`producto_id_foreign`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`) REFERENCES `productos` (`producto_id_pkey`, `tienda_nombre_tienda_foreign`, `usuario_correo_usuario_foreign`),
  CONSTRAINT `SubDiv` FOREIGN KEY (`subcategorías_de_productos_id_foreign`) REFERENCES `subcategorías_de_productos` (`subcategorías_de_productos_id_pkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `productos_subcategorías_de_productos` */

insert  into `productos_subcategorías_de_productos`(`producto_id_foreign`,`tienda_nombre_tienda_foreign`,`subcategorías_de_productos_id_foreign`,`usuario_correo_usuario_foreign`) values 
(1,'Jose C.A',1,'josem@gmail.com'),
(2,'Todo Compras',1,'crladuran15@gmail.com'),
(3,'Jose C.A',2,'josem@gmail.com'),
(4,'MiniGames',1,'jesusm@gmail.com'),
(6,'Todo Compras',2,'crladuran15@gmail.com'),
(7,'MiniGames',5,'jesusm@gmail.com'),
(8,'Rotary bistro',2,'jimenaluces@gmail.com'),
(9,'Todo Compras',2,'crladuran15@gmail.com'),
(10,'Jose C.A',3,'josem@gmail.com'),
(11,'MiniGames',4,'jesusm@gmail.com'),
(12,'MiniGames',3,'jesusm@gmail.com');

/*Table structure for table `subcategorias_de_tiendas` */

DROP TABLE IF EXISTS `subcategorias_de_tiendas`;

CREATE TABLE `subcategorias_de_tiendas` (
  `descripción` varchar(175) DEFAULT NULL,
  `categorias_de_tiendas_id_pkey` bigint(20) unsigned NOT NULL,
  `categoría_de_tienda_nombre_id_foreign` varchar(25) NOT NULL,
  `subcategorias_de_tiendas_id_pkey` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subcategorias_de_tienda_nombre_unique` varchar(25) NOT NULL,
  PRIMARY KEY (`subcategorias_de_tiendas_id_pkey`),
  KEY `subcat_tienda_cat_tiendas_id_cat_tienda_nombre_index` (`categorias_de_tiendas_id_pkey`,`categoría_de_tienda_nombre_id_foreign`),
  CONSTRAINT `Dividen` FOREIGN KEY (`categorias_de_tiendas_id_pkey`, `categoría_de_tienda_nombre_id_foreign`) REFERENCES `categorias_de_tiendas` (`categorias_de_tiendas_id_pkey`, `nombre_id_pkey`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `subcategorias_de_tiendas` */

insert  into `subcategorias_de_tiendas`(`descripción`,`categorias_de_tiendas_id_pkey`,`categoría_de_tienda_nombre_id_foreign`,`subcategorias_de_tiendas_id_pkey`,`subcategorias_de_tienda_nombre_unique`) values 
('Ferreteria',1,'Electrodomesticos',1,'Ferreteria'),
('Aparatos',1,'Electrodomesticos',2,'Aparatos'),
('Gourmet',2,'Comida',3,'Gourmet'),
('Rapida',2,'Comida',4,'Fresca'),
('Empaquetada',3,'Supermarket',5,'Empaquetada'),
('Fresca',3,'Supermarket',6,'Fresca'),
('Videojuegos',4,'Entretenimiento',7,'Videojuegos'),
('Moda',4,'Entretenimiento',8,'Moda');

/*Table structure for table `subcategorías_de_productos` */

DROP TABLE IF EXISTS `subcategorías_de_productos`;

CREATE TABLE `subcategorías_de_productos` (
  `categoría_de_producto_nombre_categoría_id_foreign` varchar(35) NOT NULL,
  `categorías_de_productos_id_foreign` bigint(20) unsigned NOT NULL,
  `nombre_subcategoría` varchar(35) NOT NULL,
  `descripción` varchar(175) DEFAULT NULL,
  `subcategorías_de_productos_id_pkey` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`subcategorías_de_productos_id_pkey`),
  KEY `subcategoría_producto_cat_producto_nombre_cat_producto_id_index` (`categoría_de_producto_nombre_categoría_id_foreign`,`categorías_de_productos_id_foreign`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `subcategorías_de_productos` */

insert  into `subcategorías_de_productos`(`categoría_de_producto_nombre_categoría_id_foreign`,`categorías_de_productos_id_foreign`,`nombre_subcategoría`,`descripción`,`subcategorías_de_productos_id_pkey`) values 
('Nuevos',1,'Ultimo mes','Cargadas recientemente',1),
('Nuevos',1,'Ofertas','Nuevas ofertas',2),
('Temporada',2,'Verano',NULL,3),
('Temporada',2,'Invierno',NULL,4),
('De baja',4,'Proximos a salir',NULL,5);

/*Table structure for table `tiendas` */

DROP TABLE IF EXISTS `tiendas`;

CREATE TABLE `tiendas` (
  `dirección` varchar(175) NOT NULL,
  `teléfono` varchar(15) DEFAULT NULL,
  `cód_postal` varchar(10) NOT NULL,
  `nombre_id_pkey` varchar(35) NOT NULL,
  `usuario_correo_usuario_id_foreign` varchar(50) NOT NULL,
  `estado_de_tienda` tinyint(1) NOT NULL DEFAULT 1,
  `descripción` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`nombre_id_pkey`,`usuario_correo_usuario_id_foreign`),
  KEY `Administra` (`usuario_correo_usuario_id_foreign`),
  CONSTRAINT `Administra` FOREIGN KEY (`usuario_correo_usuario_id_foreign`) REFERENCES `usuarios` (`usuario_correo_usuario_id_pkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tiendas` */

insert  into `tiendas`(`dirección`,`teléfono`,`cód_postal`,`nombre_id_pkey`,`usuario_correo_usuario_id_foreign`,`estado_de_tienda`,`descripción`) values 
('San Felix',NULL,'8050','Ferretodo','mariap@gmail.com',0,NULL),
('Puerto Ordaz',NULL,'8050','Jose C.A','josem@gmail.com',0,NULL),
('Puerto Ordaz',NULL,'8050','MiniGames','jesusm@gmail.com',0,NULL),
('Puerto Ordaz',NULL,'8050','Miracle Shop','luisa@gmail.com',1,NULL),
('Puerto Ordaz',NULL,'8050','Rotary bistro','jimenaluces@gmail.com',1,NULL),
('Puerto Ordaz',NULL,'8050','Todo compras','crladuran15@gmail.com',1,NULL);

/*Table structure for table `tiendas_categorias_de_tiendas` */

DROP TABLE IF EXISTS `tiendas_categorias_de_tiendas`;

CREATE TABLE `tiendas_categorias_de_tiendas` (
  `tienda_nombre_id_foreign` varchar(35) NOT NULL,
  `categoría_de_tienda_id_foreign` bigint(20) unsigned NOT NULL,
  `categoria_de_tienda_nombre_foreign` varchar(25) NOT NULL,
  `usuario_correo_usuario_id_foreign` varchar(50) NOT NULL,
  PRIMARY KEY (`tienda_nombre_id_foreign`,`categoría_de_tienda_id_foreign`,`categoria_de_tienda_nombre_foreign`,`usuario_correo_usuario_id_foreign`),
  KEY `Vinculan` (`tienda_nombre_id_foreign`,`usuario_correo_usuario_id_foreign`),
  KEY `Tienen` (`categoría_de_tienda_id_foreign`,`categoria_de_tienda_nombre_foreign`),
  CONSTRAINT `Tienen` FOREIGN KEY (`categoría_de_tienda_id_foreign`, `categoria_de_tienda_nombre_foreign`) REFERENCES `categorias_de_tiendas` (`categorias_de_tiendas_id_pkey`, `nombre_id_pkey`),
  CONSTRAINT `Vinculan` FOREIGN KEY (`tienda_nombre_id_foreign`, `usuario_correo_usuario_id_foreign`) REFERENCES `tiendas` (`nombre_id_pkey`, `usuario_correo_usuario_id_foreign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tiendas_categorias_de_tiendas` */

insert  into `tiendas_categorias_de_tiendas`(`tienda_nombre_id_foreign`,`categoría_de_tienda_id_foreign`,`categoria_de_tienda_nombre_foreign`,`usuario_correo_usuario_id_foreign`) values 
('FerreTodo',1,'Electrodomesticos','mariap@gmail.com'),
('Jose C.A',1,'Electrodomesticos','josem@gmail.com'),
('MiniGames',4,'Entretenimiento','jesusm@gmail.com'),
('Miracle Shop',4,'Entretenimiento','luisa@gmail.com'),
('Rotary bistro',2,'Comida','jimenaluces@gmail.com'),
('Todo Compras',3,'Supermarket','crladuran15@gmail.com');

/*Table structure for table `tiendas_subcategorias_de_tiendas` */

DROP TABLE IF EXISTS `tiendas_subcategorias_de_tiendas`;

CREATE TABLE `tiendas_subcategorias_de_tiendas` (
  `tienda_nombre_id_foreign` varchar(35) NOT NULL,
  `subcategoría_de_tienda_id_foreign` bigint(20) unsigned NOT NULL,
  `usuario_correo_usuario_id_foreign` varchar(50) NOT NULL,
  PRIMARY KEY (`tienda_nombre_id_foreign`,`subcategoría_de_tienda_id_foreign`,`usuario_correo_usuario_id_foreign`),
  KEY `Clasifican` (`tienda_nombre_id_foreign`,`usuario_correo_usuario_id_foreign`),
  KEY `Relacionan` (`subcategoría_de_tienda_id_foreign`),
  CONSTRAINT `Clasifican` FOREIGN KEY (`tienda_nombre_id_foreign`, `usuario_correo_usuario_id_foreign`) REFERENCES `tiendas` (`nombre_id_pkey`, `usuario_correo_usuario_id_foreign`),
  CONSTRAINT `Relacionan` FOREIGN KEY (`subcategoría_de_tienda_id_foreign`) REFERENCES `subcategorias_de_tiendas` (`subcategorias_de_tiendas_id_pkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tiendas_subcategorias_de_tiendas` */

insert  into `tiendas_subcategorias_de_tiendas`(`tienda_nombre_id_foreign`,`subcategoría_de_tienda_id_foreign`,`usuario_correo_usuario_id_foreign`) values 
('Ferretodo',1,'mariap@gmail.com'),
('Jose C.A',2,'josem@gmail.com'),
('MiniGames',7,'jesusm@gmail.com'),
('Miracle Shop',8,'luisa@gmail.com'),
('Rotary bistro',3,'jimenaluces@gmail.com'),
('Todo Compras',5,'crladuran15@gmail.com');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `nombres` varchar(35) NOT NULL,
  `apellidos` varchar(35) NOT NULL,
  `cédula` varchar(20) NOT NULL,
  `usuario_correo_usuario_id_pkey` varchar(50) NOT NULL,
  `teléfono` varchar(15) DEFAULT NULL,
  `tipo_de_usuario` char(1) NOT NULL DEFAULT '1',
  `contraseña` binary(32) NOT NULL,
  PRIMARY KEY (`usuario_correo_usuario_id_pkey`),
  UNIQUE KEY `cédula` (`cédula`),
  CONSTRAINT `usuarios_correo_usuario` CHECK (`usuario_correo_usuario_id_pkey` like '%@%.%')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

insert  into `usuarios`(`nombres`,`apellidos`,`cédula`,`usuario_correo_usuario_id_pkey`,`teléfono`,`tipo_de_usuario`,`contraseña`) values 
('Ana','Ayala','27296149','anayala@gmail.com','04148648879','1','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Braulio','Zapata','27407957','braulio@gmail.com','04148505588','3','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Carla','Duran','27296144','crladuran15@gmail.com','04148506538','3','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Daniel','Fernandez','25405967','danielf@gmail.com','04148648879','1','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Jesus','Martinez','29632167','jesusm@gmail.com','04148648879','2','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Jimena','Luces','27205267','jimenaluces@gmail.com','04148648879','2','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Jose','Muñoz','27208267','josem@gmail.com','04148648879','2','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Luisa','Lopez','2720896','luisa@gmail.com','04148648888','2','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Maria','Perez','27208967','mariap@gmail.com','04148648889','2','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Miriam','Sagaray','27299663','miriam@gmail.com','04148648879','1','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Pablo','Huerto','27289663','pabloh@gmail.com','04148648879','1','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Ricardo','Natera','27202818','ranatera@gmail.com','04148648888','3','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('Rosa','Orozco','27289655','rosao@gmail.com','04148648879','1','admin1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0');

/* Trigger structure for table `categorias_de_tiendas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_categorias_de_tiendas_eliminar_subcategorias` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_categorias_de_tiendas_eliminar_subcategorias` BEFORE DELETE ON `categorias_de_tiendas` FOR EACH ROW   BEGIN
    DELETE FROM subcategorias_de_tiendas
    WHERE categorias_de_tiendas_id_pkey = OLD.categorias_de_tiendas_id_pkey;
END */$$


DELIMITER ;

/* Trigger structure for table `categorias_de_tiendas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_categorías_de_tiendas_eliminar_tiendas` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_categorías_de_tiendas_eliminar_tiendas` BEFORE DELETE ON `categorias_de_tiendas` FOR EACH ROW 
BEGIN
  DELETE FROM tiendas_categorias_de_tiendas WHERE categoría_de_tienda_id_foreign = OLD.categorias_de_tiendas_id_pkey;	
END */$$


DELIMITER ;

/* Trigger structure for table `categorías_de_productos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_categorías_de_productos_eliminar_productos_categorías` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_categorías_de_productos_eliminar_productos_categorías` BEFORE DELETE ON `categorías_de_productos` FOR EACH ROW   BEGIN
    DELETE FROM productos_categorías_de_productos
    WHERE categoría_de_producto_id_foreign = OLD.categorías_de_productos_id_pkey;
END */$$


DELIMITER ;

/* Trigger structure for table `categorías_de_productos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_categorias_de_productos_eliminar_subcategorias` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_categorias_de_productos_eliminar_subcategorias` BEFORE DELETE ON `categorías_de_productos` FOR EACH ROW   BEGIN
    DELETE FROM subcategorías_de_productos
    WHERE categorías_de_productos_id_foreign = OLD.categorías_de_productos_id_pkey;
END */$$


DELIMITER ;

/* Trigger structure for table `compras_productos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_compras_productos_salida_inventario` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_compras_productos_salida_inventario` AFTER INSERT ON `compras_productos` FOR EACH ROW   BEGIN
    UPDATE productos
    SET cantidad_en_inventario = cantidad_en_inventario - NEW.cantidad
    WHERE producto_id_pkey = NEW.producto_id_foreign;
END */$$


DELIMITER ;

/* Trigger structure for table `subcategorias_de_tiendas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_subcategorias_de_tiendas_eliminar_tiendas` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_subcategorias_de_tiendas_eliminar_tiendas` BEFORE DELETE ON `subcategorias_de_tiendas` FOR EACH ROW BEGIN
	DELETE FROM tiendas_subcategorias_de_tiendas 
	WHERE subcategorias_de_tienda_id_foreign = OLD.subcategorias_de_tiendas_id_pkey;
    END */$$


DELIMITER ;

/* Trigger structure for table `subcategorías_de_productos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_subcategorias_de_productos_eliminar_productos` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_subcategorias_de_productos_eliminar_productos` BEFORE DELETE ON `subcategorías_de_productos` FOR EACH ROW   BEGIN
    DELETE FROM productos_subcategorías_de_productos
    WHERE subcategorías_de_productos_id_foreign = OLD.subcategorías_de_productos_id_pkey;
END */$$


DELIMITER ;

/* Trigger structure for table `tiendas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tgr_tiendas_ocultar_productos` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'usr_bd2_27202818'@'%' */ /*!50003 TRIGGER `tgr_tiendas_ocultar_productos` AFTER UPDATE ON `tiendas` FOR EACH ROW BEGIN
	UPDATE productos 
	SET estado_de_producto = NEW.estado_de_tienda 
	WHERE tienda_nombre_tienda_foreign = NEW.nombre_id_pkey; 
    END */$$


DELIMITER ;
