/*
SQLyog Community v13.3.1 (64 bit)
MySQL - 8.4.7 : Database - personal
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`personal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `personal`;

/*Table structure for table `attender` */

DROP TABLE IF EXISTS `attender`;

CREATE TABLE `attender` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `attender` */

/*Table structure for table `cloud_paid` */

DROP TABLE IF EXISTS `cloud_paid`;

CREATE TABLE `cloud_paid` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `cloud_amount` double NOT NULL DEFAULT '0',
  `updated_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_year_month` (`year`,`month`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `cloud_paid` */

insert  into `cloud_paid`(`id`,`year`,`month`,`cloud_amount`,`updated_date`) values 
(2,2026,5,0,'2026-05-27'),
(13,2026,6,0,'2026-05-25');

/*Table structure for table `company_details` */

DROP TABLE IF EXISTS `company_details`;

CREATE TABLE `company_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` text,
  `gstin` varchar(255) DEFAULT NULL,
  `print_type` int NOT NULL DEFAULT '0',
  `printer_name` varchar(255) DEFAULT NULL,
  `bank_details` varchar(255) DEFAULT NULL,
  `barcode_printer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `company_details` */

insert  into `company_details`(`id`,`shop_name`,`address`,`gstin`,`print_type`,`printer_name`,`bank_details`,`barcode_printer`) values 
(2,'JASXBILL','PHONE - 8667214152\r\nGMAIL - jasxbill@gmail.com\r\nwebsite - jasxbill.in','',2,'','HDFC BANK\r\nName : Jaswa Vijay\r\nAccount number : 50100400246571\r\nIFSC code : HDFC0000500','AP4909');

/*Table structure for table `configure_bank_details` */

DROP TABLE IF EXISTS `configure_bank_details`;

CREATE TABLE `configure_bank_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blocked` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `configure_bank_details` */

insert  into `configure_bank_details`(`id`,`name`,`is_blocked`) values 
(1,'SBI BANK',0),
(2,'CANARA BANK',0),
(3,'AXIS BANK',0),
(4,'IOB BANK',0);

/*Table structure for table `configure_payment_type` */

DROP TABLE IF EXISTS `configure_payment_type`;

CREATE TABLE `configure_payment_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blocked` int unsigned NOT NULL DEFAULT '0',
  `type_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `configure_payment_type` */

insert  into `configure_payment_type`(`id`,`name`,`is_blocked`,`type_id`) values 
(1,'Cash',0,1),
(2,'BANK',0,2);

/*Table structure for table `credit_days` */

DROP TABLE IF EXISTS `credit_days`;

CREATE TABLE `credit_days` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `credit_days` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `credit_days` */

insert  into `credit_days`(`id`,`credit_days`) values 
(1,10);

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `is_eligible_for_commission` tinyint DEFAULT '1',
  `is_active` int DEFAULT '1',
  `gstin` varchar(255) DEFAULT NULL,
  `is_gst` int DEFAULT '0',
  `salesman` int DEFAULT NULL,
  `area` int DEFAULT NULL,
  `credit_limit` double(10,2) NOT NULL DEFAULT '0.00',
  `local` int DEFAULT '1',
  `exchange_point` double(10,3) DEFAULT '0.000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `customers` */

insert  into `customers`(`id`,`name`,`phone_number`,`address`,`date`,`time`,`is_eligible_for_commission`,`is_active`,`gstin`,`is_gst`,`salesman`,`area`,`credit_limit`,`local`,`exchange_point`) values 
(1,'SAI DHEETSHA HEART HOSPITAL','7904612433','SAI DHEETSHA HEART HOSPITAL NO: 1051 EVEN ROAD GH OPP ERODE - 638 009 PH- 90036 24989\r\n7904612433(ADMIN BASKARAN) 6384638471(BHAKYA)','2026-05-18','11:40:05',0,1,'',0,NULL,NULL,0.00,1,0.000),
(2,'SAI DHEETSHA SUPER SPECIALITY MEDICAL CENTRE','7904612433','SAI DHEETSHA SUPER SPECIALITY MEDICAL CENTRE\r\n NO-590 A/B MAIN ROAD NEAR BUS STAND,BHAVANI-638302 PH - 9629022201','2026-05-18','11:40:28',0,1,'',0,NULL,NULL,0.00,1,0.000),
(3,'VETRI MOBILES & HOME APPLIANCES','9384338182','No 4/171-3 Sourastra colony  ,Aruppukottai Main Road, colony Bus stop, valayankulam Madurai -625022.  Ph: 9751780556 State: 33-Tamil Nadu','2026-05-18','11:40:56',0,1,'',0,NULL,NULL,0.00,1,0.000),
(4,'Tamil Crafts','8270176355','No 4 Anna Complex, Kailash Nager Kattur, Trichy,TamilNadu, 620019 Ph: 7540091999','2026-05-18','11:41:17',0,1,'',0,NULL,NULL,0.00,1,0.000),
(5,'HITECH INDIA AGRO INDUSTRY','8838900000','NO,2/200C, DHANAM NAGAR Karayampalayam,Mylampatti,Coimbatore 8870238992---8838900000','2026-05-18','11:41:37',0,1,'',0,NULL,NULL,0.00,1,0.000),
(6,'VETRIVELA ','9080703703','2F/F12, SAMINATHAN NAGAR SURATHOOR BYE PASS, THURAIYUR TAMILNADU, Code:33 Mobile: 9943922981 GSTIN: 33AMFPB8134R2ZS','2026-05-18','11:42:07',0,1,'',0,NULL,NULL,0.00,1,0.000),
(7,'SM Store chennai','9884422517','CHENNAI','2026-05-18','11:42:22',0,1,'',0,NULL,NULL,0.00,1,0.000),
(8,'Everyday Restro Cafe','9994209494','\"Tv kovil main road, srirangam. \r\nMobile 9994209494\" 33BVMPA5007K1ZS','2026-05-18','11:42:43',0,1,'',0,NULL,NULL,0.00,1,0.000),
(9,'AJ Computer centre','9976030500','CHENNAI','2026-05-18','11:43:02',0,1,'',0,NULL,NULL,0.00,1,0.000),
(10,'mapla menswear','9047476247','VALLIUR','2026-05-18','11:43:19',0,1,'',0,NULL,NULL,0.00,1,0.000),
(11,'mohana electrical pudukottai','8122122150',' pudukottai','2026-05-18','11:43:33',0,1,'',0,NULL,NULL,0.00,1,0.000),
(12,'JAngel rehoboth clothing chennai','8056191358','CHENNAI','2026-05-18','11:43:47',0,1,'',0,NULL,NULL,0.00,1,0.000),
(13,'Bike inventory ','9342217202',' nagercoil','2026-05-18','11:44:03',0,1,'',0,NULL,NULL,0.00,1,0.000),
(14,'Guna Gifts(800)','9940125902','chennai','2026-05-18','11:44:26',0,1,'',0,NULL,NULL,0.00,1,0.000),
(15,'Kingston wholesale(550)','7010122543','nagercoil','2026-05-18','11:44:36',0,1,'',0,NULL,NULL,0.00,1,0.000),
(16,'javera clothing','9343201020','4,TSMO Syed Ali Nagar Kurichi Main Road Tirunelveli-627005','2026-05-18','11:49:39',0,1,'',0,NULL,NULL,0.00,1,0.000),
(17,'Somnath agro machine','9597949332','','2026-05-18','11:49:57',0,1,'',0,NULL,NULL,0.00,1,0.000),
(18,'MOULANA(600)','9715825688','ORATHANADU','2026-05-18','15:57:46',0,1,'',0,NULL,NULL,0.00,1,0.000);

/*Table structure for table `customers_exchange_point` */

DROP TABLE IF EXISTS `customers_exchange_point`;

CREATE TABLE `customers_exchange_point` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `bill_id` int NOT NULL,
  `old_point` double(10,3) DEFAULT '0.000',
  `exchange_point` double(10,3) DEFAULT '0.000',
  `total_point` double(10,3) DEFAULT '0.000',
  `uid` int DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `customers_exchange_point` */

/*Table structure for table `expense_entry` */

DROP TABLE IF EXISTS `expense_entry`;

CREATE TABLE `expense_entry` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `exp_type` int NOT NULL,
  `content` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` text,
  `exc_date_time` datetime DEFAULT NULL,
  `entry_date_time` datetime DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`exp_type`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `expense_entry` */

insert  into `expense_entry`(`id`,`exp_type`,`content`,`amount`,`description`,`exc_date_time`,`entry_date_time`,`is_active`,`uid`) values 
(1,1,'ADS',500.00,'','2025-09-09 12:02:00','2026-05-18 12:03:24',1,1),
(2,1,'ADS',500.00,'','2025-10-18 12:03:00','2026-05-18 12:04:07',1,1),
(3,1,'ADS',500.00,'','2025-11-18 12:04:00','2026-05-18 12:04:27',1,1),
(4,1,'ADS',1000.00,'','2025-12-18 12:04:00','2026-05-18 12:04:47',1,1),
(5,1,'ADS',7000.00,'','2026-01-18 12:04:00','2026-05-18 12:05:03',1,1),
(6,1,'ADS',6500.00,'','2026-02-18 12:05:00','2026-05-18 12:05:22',1,1),
(7,1,'ADS',6000.00,'','2026-03-18 12:05:00','2026-05-18 12:05:49',1,1),
(8,1,'ADS',100.00,'','2026-04-18 12:05:00','2026-05-18 12:06:02',1,1),
(9,1,'ADS',1400.00,'','2026-05-18 12:06:00','2026-05-18 12:06:11',1,1),
(10,1,'ads',500.00,'','2026-05-19 10:47:00','2026-05-19 10:47:24',1,1),
(11,2,'BIKES SERVICE',5970.00,'','2026-05-26 17:27:00','2026-05-26 17:27:19',1,1);

/*Table structure for table `expense_type` */

DROP TABLE IF EXISTS `expense_type`;

CREATE TABLE `expense_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `expense_type` */

insert  into `expense_type`(`id`,`type`,`is_active`) values 
(1,'INSTA ADS',1),
(2,'PERSONAL USE',1);

/*Table structure for table `gstin` */

DROP TABLE IF EXISTS `gstin`;

CREATE TABLE `gstin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `gstin` varchar(255) NOT NULL,
  `shop_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `gstin` */

/*Table structure for table `heading` */

DROP TABLE IF EXISTS `heading`;

CREATE TABLE `heading` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `head1` varchar(255) DEFAULT NULL,
  `head2` varchar(255) DEFAULT NULL,
  `head3` varchar(255) DEFAULT NULL,
  `active` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `heading` */

insert  into `heading`(`id`,`head1`,`head2`,`head3`,`active`) values 
(1,'Category','Brand','Product',1000);

/*Table structure for table `order_tables` */

DROP TABLE IF EXISTS `order_tables`;

CREATE TABLE `order_tables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_occupied` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `order_tables` */

/*Table structure for table `pro_bill_exchange` */

DROP TABLE IF EXISTS `pro_bill_exchange`;

CREATE TABLE `pro_bill_exchange` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `old_prod_id` int NOT NULL,
  `new_prod_id` int NOT NULL,
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `pro_bill_exchange` */

/*Table structure for table `prod_batch` */

DROP TABLE IF EXISTS `prod_batch`;

CREATE TABLE `prod_batch` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `cost` double(10,3) DEFAULT '0.000',
  `mrp` double(10,3) DEFAULT '0.000',
  `commission` double(10,3) DEFAULT '0.000',
  `stock` decimal(10,2) NOT NULL,
  `disc_type` int DEFAULT '0' COMMENT '1=rs 2=%',
  `discount` double(10,3) DEFAULT '0.000',
  `date` date DEFAULT NULL,
  `time` time DEFAULT '00:00:00',
  `added_stock` decimal(10,2) NOT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `disc` (`disc_type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `prod_batch` */

insert  into `prod_batch`(`id`,`name`,`product_id`,`cost`,`mrp`,`commission`,`stock`,`disc_type`,`discount`,`date`,`time`,`added_stock`,`uid`) values 
(1,'Z101',1,0.000,5000.000,0.000,0.00,0,0.000,'2026-05-18','11:38:36',0.00,1),
(2,'Z102',2,0.000,5000.000,0.000,0.00,0,0.000,'2026-05-18','11:38:50',0.00,1),
(3,'Z102',3,500.000,500.000,0.000,0.00,0,0.000,'2026-05-20','10:09:53',0.00,1),
(4,'Z103',4,0.000,200.000,0.000,0.00,0,0.000,'2026-05-20','10:23:19',0.00,1);

/*Table structure for table `prod_batch_updated` */

DROP TABLE IF EXISTS `prod_batch_updated`;

CREATE TABLE `prod_batch_updated` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `cost` double(10,3) NOT NULL DEFAULT '0.000',
  `mrp` double(10,3) NOT NULL DEFAULT '0.000',
  `stock` decimal(10,2) NOT NULL,
  `disc_type` int DEFAULT '0' COMMENT '1=rs 2=%',
  `discount` double(10,3) DEFAULT '0.000',
  `date` date DEFAULT NULL,
  `time` time DEFAULT '00:00:00',
  `added_stock` decimal(10,2) NOT NULL,
  `uid` int NOT NULL DEFAULT '0',
  `updatedDate` date DEFAULT NULL,
  `updatedTime` time DEFAULT '00:00:00',
  `updatedUid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `disc` (`disc_type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_batch_updated` */

/*Table structure for table `prod_batch_zero_stock_bill` */

DROP TABLE IF EXISTS `prod_batch_zero_stock_bill`;

CREATE TABLE `prod_batch_zero_stock_bill` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT '00:00:00',
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `batch` (`batch_id`),
  KEY `prod` (`product_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `prod_batch_zero_stock_bill` */

insert  into `prod_batch_zero_stock_bill`(`id`,`batch_id`,`product_id`,`qty`,`date`,`time`,`uid`) values 
(1,'2',2,1.00,'2026-05-18','11:45:19',1),
(2,'2',2,1.00,'2026-05-18','11:45:57',1),
(3,'2',2,1.00,'2026-05-18','11:46:30',1),
(4,'2',2,1.00,'2026-05-18','11:47:06',1),
(5,'2',2,1.00,'2026-05-18','11:47:38',1),
(6,'2',2,1.00,'2026-05-18','11:47:56',1),
(7,'2',2,1.00,'2026-05-18','11:48:26',1),
(8,'2',2,1.00,'2026-05-18','11:48:58',1),
(9,'2',2,1.00,'2026-05-18','11:50:44',1),
(10,'2',2,1.00,'2026-05-18','11:51:20',1),
(11,'1',1,1.00,'2026-05-18','11:52:04',1),
(12,'2',2,1.00,'2026-05-18','11:52:46',1),
(13,'2',2,1.00,'2026-05-18','11:53:08',1),
(14,'2',2,1.00,'2026-05-18','11:53:26',1),
(15,'2',2,1.00,'2026-05-18','11:53:53',1),
(16,'1',1,1.00,'2026-05-18','11:54:29',1),
(17,'1',1,1.00,'2026-05-18','11:55:03',1),
(18,'1',1,1.00,'2026-05-18','15:57:46',1),
(19,'4',4,1.00,'2026-05-20','10:24:01',1);

/*Table structure for table `prod_bill` */

DROP TABLE IF EXISTS `prod_bill`;

CREATE TABLE `prod_bill` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_display` varchar(255) NOT NULL,
  `is_tax_bill` tinyint(1) DEFAULT '1',
  `is_receipt` int DEFAULT '1',
  `total` double(10,3) DEFAULT '0.000',
  `prodDisc` double(10,3) DEFAULT '0.000',
  `extraDisc` double(10,3) DEFAULT '0.000',
  `payable` double(10,3) DEFAULT '0.000',
  `paid` double(10,3) DEFAULT '0.000',
  `balance` double(10,3) DEFAULT '0.000',
  `currentBalance` double(10,3) DEFAULT '0.000',
  `is_balance` int DEFAULT '0',
  `paymentMode` int NOT NULL COMMENT 'prod_bill_payment_mode',
  `paymentType` int DEFAULT '0' COMMENT 'prod_bill_payment_type',
  `uid` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL DEFAULT '00:00:00',
  `is_cancelled` int DEFAULT '0',
  `bill_type` int DEFAULT '1' COMMENT '1=prod bill',
  `cusName` varchar(255) DEFAULT '""',
  `cusPhn` varchar(255) DEFAULT '-',
  `customerId` int DEFAULT NULL,
  `price_category` int NOT NULL,
  `lr_no` varchar(255) DEFAULT NULL,
  `lr_date` date DEFAULT NULL,
  `lr_name` varchar(255) DEFAULT NULL,
  `attender_id` int DEFAULT NULL,
  `description` text,
  `is_new_client` int DEFAULT '0',
  `is_cloud` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `mode` (`paymentMode`),
  KEY `type` (`paymentType`),
  KEY `idx_is_tax_bill` (`is_tax_bill`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill` */

insert  into `prod_bill`(`id`,`bill_display`,`is_tax_bill`,`is_receipt`,`total`,`prodDisc`,`extraDisc`,`payable`,`paid`,`balance`,`currentBalance`,`is_balance`,`paymentMode`,`paymentType`,`uid`,`date`,`time`,`is_cancelled`,`bill_type`,`cusName`,`cusPhn`,`customerId`,`price_category`,`lr_no`,`lr_date`,`lr_name`,`attender_id`,`description`,`is_new_client`,`is_cloud`) values 
(1,'25-1',1,1,2000.000,0.000,0.000,2000.000,2000.000,0.000,0.000,0,2,1,1,'2025-09-26','11:45:19',0,1,'SAI DHEETSHA HEART HOSPITAL','7904612433',1,3,NULL,NULL,NULL,NULL,'Insta Ads',1,0),
(2,'25-2',1,1,2000.000,0.000,0.000,2000.000,2000.000,0.000,0.000,0,2,1,1,'2025-11-03','11:45:57',0,1,'SAI DHEETSHA SUPER SPECIALITY MEDICAL CENTRE','7904612433',2,3,NULL,NULL,NULL,NULL,'referred by 26-1',1,0),
(3,'25-3',1,1,5000.000,0.000,0.000,5000.000,5000.000,0.000,0.000,0,2,1,1,'2025-12-26','11:46:30',0,1,'VETRI MOBILES AND HOME APPLIANCES','9384338182',3,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(4,'26-1',1,1,4000.000,0.000,0.000,4000.000,4000.000,0.000,0.000,0,2,1,1,'2026-01-01','11:47:06',0,1,'Tamil Crafts','8270176355',4,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(5,'26-2',1,1,5000.000,0.000,0.000,5000.000,5000.000,0.000,0.000,0,2,1,1,'2026-01-09','11:47:38',0,1,'HITECH INDIA AGRO INDUSTRY','8838900000',5,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(6,'26-3',1,1,5000.000,0.000,0.000,5000.000,5000.000,0.000,0.000,0,2,1,1,'2026-01-14','11:47:56',0,1,'VETRIVELA','9080703703',6,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(7,'26-4',1,1,5000.000,0.000,0.000,5000.000,5000.000,0.000,0.000,0,2,1,1,'2026-01-27','11:48:26',0,1,'SM Store chennai','9884422517',7,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(8,'26-5',1,1,3000.000,0.000,0.000,3000.000,3000.000,0.000,0.000,0,2,1,1,'2026-02-07','11:48:58',0,1,'Everyday Restro Cafe','9994209494',8,3,NULL,NULL,NULL,NULL,'insta ads\nonline -900',1,0),
(9,'26-6',1,1,4000.000,0.000,0.000,4000.000,4000.000,0.000,0.000,0,2,1,1,'2026-02-13','11:50:43',0,1,'javera clothing','9343201020',16,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(10,'26-7',1,1,5000.000,0.000,0.000,5000.000,5000.000,0.000,0.000,0,2,1,1,'2026-02-27','11:51:19',0,1,'Somnath agro machine','9597949332',17,3,NULL,NULL,NULL,NULL,'referred by 26-5\r\n7k and 2k for referral to 26-5',1,0),
(11,'26-8',1,1,2000.000,0.000,0.000,2000.000,2000.000,0.000,0.000,0,2,1,1,'2026-02-27','11:52:04',0,1,'AJ Computer centre','9976030500',9,3,NULL,NULL,NULL,NULL,'insta ads\nonline - 600',1,0),
(12,'26-9',1,1,4000.000,0.000,0.000,4000.000,4000.000,0.000,0.000,0,1,0,1,'2026-03-09','11:52:46',0,1,'mapla menswear','9047476247',10,3,NULL,NULL,NULL,NULL,'referred by kingston',1,0),
(13,'26-10',1,1,5000.000,0.000,0.000,5000.000,5000.000,0.000,0.000,0,2,1,1,'2026-03-14','11:53:08',0,1,'mohana electrical pudukottai','8122122150',11,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(14,'26-11',1,1,4000.000,0.000,0.000,4000.000,4000.000,0.000,0.000,0,2,1,1,'2026-04-17','11:53:26',0,1,'JAngel rehoboth clothing chennai','8056191358',12,3,NULL,NULL,NULL,NULL,'insta ads',1,0),
(15,'26-12',1,1,6000.000,0.000,0.000,6000.000,6000.000,0.000,0.000,0,2,1,1,'2026-05-02','11:53:53',0,1,'Bike inventory','9342217202',13,3,NULL,NULL,NULL,NULL,'ref by saran',1,0),
(16,'26-13',1,1,5000.000,0.000,0.000,5000.000,5000.000,0.000,0.000,0,2,1,1,'2026-05-07','11:54:29',0,1,'Guna Gifts(800)','9940125902',14,3,NULL,NULL,NULL,NULL,'insta ads \nonine - 800',1,1),
(17,'26-14',1,1,3000.000,0.000,0.000,3000.000,3000.000,0.000,0.000,0,2,1,1,'2026-05-15','11:55:02',0,1,'Kingston wholesale(550)','7010122543',15,3,NULL,NULL,NULL,NULL,'ref by kingston\nonline -550',1,1),
(18,'26-15',1,1,7000.000,0.000,0.000,7000.000,7000.000,5000.000,0.000,1,2,1,1,'2026-05-18','15:57:46',0,1,'Moulana Travels(600)','9715825688',18,3,NULL,NULL,NULL,NULL,'insta ads\nonline - 600 mnt',1,1),
(19,'26-16',1,1,200.000,0.000,0.000,200.000,200.000,0.000,0.000,0,2,1,1,'2026-03-13','10:24:01',0,1,'VETRI MOBILES & HOME APPLIANCES','9384338182',3,3,NULL,NULL,NULL,NULL,'SMALL WORKS',0,0);

/*Table structure for table `prod_bill_cancel` */

DROP TABLE IF EXISTS `prod_bill_cancel`;

CREATE TABLE `prod_bill_cancel` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `reason` text,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billId` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_cancel` */

/*Table structure for table `prod_bill_datechange` */

DROP TABLE IF EXISTS `prod_bill_datechange`;

CREATE TABLE `prod_bill_datechange` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `billId` int NOT NULL,
  `oldDate` date DEFAULT NULL,
  `changeDate` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `billId` (`billId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_datechange` */

/*Table structure for table `prod_bill_details` */

DROP TABLE IF EXISTS `prod_bill_details`;

CREATE TABLE `prod_bill_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `prod_id` int NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `price` double(10,3) DEFAULT '0.000',
  `disc` double(10,3) DEFAULT '0.000',
  `total` double(10,3) DEFAULT '0.000',
  `cost` double(10,3) DEFAULT '0.000',
  `commission` double(10,3) DEFAULT '0.000',
  `gst` int NOT NULL DEFAULT '0',
  `is_cancelled` int DEFAULT '0',
  `cancel_date` datetime DEFAULT NULL,
  `is_exchanged` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `bill` (`bill_id`),
  KEY `prod` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_details` */

insert  into `prod_bill_details`(`id`,`bill_id`,`prod_id`,`qty`,`price`,`disc`,`total`,`cost`,`commission`,`gst`,`is_cancelled`,`cancel_date`,`is_exchanged`) values 
(1,1,1,1.00,2000.000,0.000,2000.000,0.000,0.000,0,0,NULL,0),
(2,2,1,1.00,2000.000,0.000,2000.000,0.000,0.000,0,0,NULL,0),
(3,3,1,1.00,5000.000,0.000,5000.000,0.000,0.000,0,0,NULL,0),
(4,4,1,1.00,4000.000,0.000,4000.000,0.000,0.000,0,0,NULL,0),
(5,5,1,1.00,5000.000,0.000,5000.000,0.000,0.000,0,0,NULL,0),
(6,6,1,1.00,5000.000,0.000,5000.000,0.000,0.000,0,0,NULL,0),
(7,7,1,1.00,5000.000,0.000,5000.000,0.000,0.000,0,0,NULL,0),
(8,8,1,1.00,3000.000,0.000,3000.000,0.000,0.000,0,0,NULL,0),
(9,9,1,1.00,4000.000,0.000,4000.000,0.000,0.000,0,0,NULL,0),
(10,10,1,1.00,5000.000,0.000,5000.000,0.000,0.000,0,0,NULL,0),
(11,11,1,1.00,2000.000,0.000,2000.000,0.000,0.000,0,0,NULL,0),
(12,12,1,1.00,4000.000,0.000,4000.000,0.000,0.000,0,0,NULL,0),
(13,13,1,1.00,5000.000,0.000,5000.000,0.000,0.000,0,0,NULL,0),
(14,14,1,1.00,4000.000,0.000,4000.000,0.000,0.000,0,0,NULL,0),
(15,15,1,1.00,6000.000,0.000,6000.000,0.000,0.000,0,0,NULL,0),
(16,16,1,1.00,5000.000,0.000,5000.000,0.000,0.000,0,0,NULL,0),
(17,17,1,1.00,3000.000,0.000,3000.000,0.000,0.000,0,0,NULL,0),
(18,18,1,1.00,7000.000,0.000,7000.000,0.000,0.000,0,0,NULL,0),
(19,19,4,1.00,200.000,0.000,200.000,0.000,0.000,0,0,NULL,0);

/*Table structure for table `prod_bill_due_collection` */

DROP TABLE IF EXISTS `prod_bill_due_collection`;

CREATE TABLE `prod_bill_due_collection` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `balance` double(10,2) DEFAULT NULL,
  `paid` double(10,2) DEFAULT NULL,
  `finalBalance` double(10,2) DEFAULT NULL,
  `mode` int DEFAULT NULL,
  `bankOption` int DEFAULT NULL,
  `uid` int NOT NULL,
  `collectDate` varchar(255) DEFAULT NULL,
  `collectTime` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billId` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_due_collection` */

insert  into `prod_bill_due_collection`(`id`,`bill_id`,`balance`,`paid`,`finalBalance`,`mode`,`bankOption`,`uid`,`collectDate`,`collectTime`,`date`,`time`) values 
(1,18,5000.00,5000.00,0.00,2,1,1,'2026-05-20','17:59:58','2026-05-20','17:59:58');

/*Table structure for table `prod_bill_payment` */

DROP TABLE IF EXISTS `prod_bill_payment`;

CREATE TABLE `prod_bill_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `cash` double(10,2) DEFAULT '0.00',
  `bank` double(10,2) DEFAULT '0.00',
  `paymentType` int DEFAULT '0' COMMENT 'prod_bill_payment_type',
  PRIMARY KEY (`id`),
  KEY `billid` (`bill_id`),
  KEY `paymentType` (`paymentType`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_payment` */

insert  into `prod_bill_payment`(`id`,`bill_id`,`cash`,`bank`,`paymentType`) values 
(1,1,0.00,2000.00,1),
(2,2,0.00,2000.00,1),
(3,3,0.00,5000.00,1),
(4,4,0.00,4000.00,1),
(5,5,0.00,5000.00,1),
(6,6,0.00,5000.00,1),
(7,7,0.00,5000.00,1),
(8,8,0.00,3000.00,0),
(9,9,0.00,4000.00,1),
(10,10,0.00,5000.00,1),
(11,11,0.00,2000.00,1),
(12,12,4000.00,0.00,0),
(13,13,0.00,5000.00,1),
(14,14,0.00,4000.00,1),
(15,15,0.00,6000.00,1),
(16,16,0.00,5000.00,1),
(17,17,0.00,3000.00,1),
(18,18,0.00,2000.00,1),
(19,19,0.00,200.00,1);

/*Table structure for table `prod_bill_payment_mode` */

DROP TABLE IF EXISTS `prod_bill_payment_mode`;

CREATE TABLE `prod_bill_payment_mode` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `mode` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_payment_mode` */

insert  into `prod_bill_payment_mode`(`id`,`mode`,`is_active`) values 
(1,'cash',1),
(2,'bank',1),
(3,'mixed',1);

/*Table structure for table `prod_bill_payment_type` */

DROP TABLE IF EXISTS `prod_bill_payment_type`;

CREATE TABLE `prod_bill_payment_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_payment_type` */

insert  into `prod_bill_payment_type`(`id`,`type`,`is_active`) values 
(0,'CASH',1),
(1,'UPI',1),
(2,'DEBIT CARD',1),
(3,'CREDIT CARD',1),
(4,'NET BANKING',1),
(5,'WALLET',1),
(6,'CHEQUE',1);

/*Table structure for table `prod_bill_payment_type_change` */

DROP TABLE IF EXISTS `prod_bill_payment_type_change`;

CREATE TABLE `prod_bill_payment_type_change` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `old_cash_amount` double(10,3) DEFAULT NULL,
  `cash_amount` double(10,3) DEFAULT NULL,
  `old_bank_amount` double(10,3) DEFAULT NULL,
  `bank_amount` double(10,3) DEFAULT NULL,
  `bank_mode` int DEFAULT NULL,
  `uid` int DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_bill_payment_type_change` */

/*Table structure for table `prod_brands` */

DROP TABLE IF EXISTS `prod_brands`;

CREATE TABLE `prod_brands` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `prod_brands` */

insert  into `prod_brands`(`id`,`name`,`date`,`time`,`is_active`) values 
(1,'JASXBILL','2026-05-18','11:36:48',1),
(2,'REFERRED BY','2026-05-18','11:36:54',0);

/*Table structure for table `prod_category` */

DROP TABLE IF EXISTS `prod_category`;

CREATE TABLE `prod_category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `prod_category` */

insert  into `prod_category`(`id`,`name`,`date`,`time`,`is_active`) values 
(1,'BILLING SOFTWARE','2026-05-18','11:36:25',1),
(2,'OFFLINE','2026-05-18','11:36:30',0),
(3,'CLOUD PROFIT','2026-05-20','10:09:21',1),
(4,'EXTRA WORK','2026-05-20','10:22:56',1);

/*Table structure for table `prod_cheque_allocation` */

DROP TABLE IF EXISTS `prod_cheque_allocation`;

CREATE TABLE `prod_cheque_allocation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `bill_id` int NOT NULL,
  `allocated_amount` double NOT NULL,
  `allocated_date` date DEFAULT NULL,
  `allocated_time` time DEFAULT NULL,
  `due_date` date NOT NULL,
  `credit_days` int DEFAULT '10',
  `status` enum('ALLOCATED','CLEARED','REVERSED','BOUNCED') DEFAULT 'ALLOCATED',
  `cleared_date` date DEFAULT NULL,
  `cleared_time` time DEFAULT NULL,
  `reversed_date` date DEFAULT NULL,
  `reversed_time` time DEFAULT NULL,
  `reversed_by` int DEFAULT NULL,
  `is_reversed` tinyint DEFAULT '0',
  `uid` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_bill` (`bill_id`),
  KEY `idx_status` (`status`),
  KEY `idx_due_date` (`due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_cheque_allocation` */

/*Table structure for table `prod_cheque_events` */

DROP TABLE IF EXISTS `prod_cheque_events`;

CREATE TABLE `prod_cheque_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `event_type` enum('BOUNCE','EXPIRY','MANUAL_CLEAR') NOT NULL,
  `event_date` date DEFAULT NULL,
  `event_time` time DEFAULT NULL,
  `reason` text,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_event_type` (`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_cheque_events` */

/*Table structure for table `prod_cheque_stock` */

DROP TABLE IF EXISTS `prod_cheque_stock`;

CREATE TABLE `prod_cheque_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `cheque_number` varchar(50) NOT NULL,
  `bank_name` text,
  `status` enum('AVAILABLE','PARTIAL','FULLY_USED','CLEARED','BOUNCED','EXPIRED') DEFAULT 'AVAILABLE',
  `entry_date` date DEFAULT NULL,
  `entry_time` time DEFAULT NULL,
  `uid` int NOT NULL,
  `notes` text,
  `is_active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_customer` (`customer_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_cheque_stock` */

/*Table structure for table `prod_cloud_bill` */

DROP TABLE IF EXISTS `prod_cloud_bill`;

CREATE TABLE `prod_cloud_bill` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `customer_id` int NOT NULL DEFAULT '0',
  `is_closed` tinyint NOT NULL DEFAULT '0',
  `closed_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bill_id` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_cloud_bill` */

/*Table structure for table `prod_cloud_bill_payment` */

DROP TABLE IF EXISTS `prod_cloud_bill_payment`;

CREATE TABLE `prod_cloud_bill_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `customer_id` int NOT NULL DEFAULT '0',
  `year` int NOT NULL,
  `month` int NOT NULL,
  `paid_amount` double NOT NULL DEFAULT '0',
  `paid_date` date DEFAULT NULL,
  `is_paid` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bill_year_month` (`bill_id`,`year`,`month`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_cloud_bill_payment` */

insert  into `prod_cloud_bill_payment`(`id`,`bill_id`,`customer_id`,`year`,`month`,`paid_amount`,`paid_date`,`is_paid`) values 
(3,17,15,2026,5,250,'2026-05-19',1),
(4,17,15,2026,6,550,'2026-05-19',1),
(5,17,15,2026,7,550,'2026-05-19',1),
(6,16,14,2026,5,500,'2026-05-19',1),
(7,16,14,2026,6,500,'2026-05-19',1),
(8,18,18,2026,6,300,'2026-05-27',1),
(9,18,18,2026,5,300,'2026-05-27',1);

/*Table structure for table `prod_ledger` */

DROP TABLE IF EXISTS `prod_ledger`;

CREATE TABLE `prod_ledger` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `entry_date_time` datetime NOT NULL,
  `content` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `is_receipt` tinyint NOT NULL DEFAULT '1' COMMENT '1=billing receipt, 0=expense',
  `ref_id` int DEFAULT NULL COMMENT 'bill_id or expense_entry_id',
  `uid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_ledger` */

insert  into `prod_ledger`(`id`,`entry_date_time`,`content`,`amount`,`is_receipt`,`ref_id`,`uid`) values 
(1,'2026-05-18 16:51:18','OLD BALANCE',8750.00,1,1,1),
(2,'2026-05-19 10:47:00','ads',500.00,0,10,1),
(4,'2026-05-20 10:47:00','Balance Collection # 26-16',5000.00,1,1,1),
(5,'2026-05-26 17:27:00','BIKES SERVICE',5970.00,0,11,1);

/*Table structure for table `prod_lifecycle` */

DROP TABLE IF EXISTS `prod_lifecycle`;

CREATE TABLE `prod_lifecycle` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL DEFAULT '0',
  `batch_id` int NOT NULL,
  `product_id` int NOT NULL,
  `stock_in` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock_out` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock_now` decimal(10,2) NOT NULL,
  `is_zero_stock_bill` int DEFAULT '0',
  `notes` text,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int NOT NULL,
  `stock_type` int DEFAULT '1' COMMENT '1=stock 2=noStock',
  `stockAdjType` int DEFAULT '0' COMMENT '1=add 2=remove',
  PRIMARY KEY (`id`),
  KEY `batch` (`batch_id`),
  KEY `prod` (`product_id`),
  KEY `uid` (`uid`),
  KEY `stock` (`stockAdjType`),
  KEY `billId` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `prod_lifecycle` */

insert  into `prod_lifecycle`(`id`,`bill_id`,`batch_id`,`product_id`,`stock_in`,`stock_out`,`stock_now`,`is_zero_stock_bill`,`notes`,`date`,`time`,`uid`,`stock_type`,`stockAdjType`) values 
(1,0,1,1,0.00,0.00,0.00,0,'WHILE ADD PRODUCT','2026-05-18','11:38:36',1,1,0),
(2,0,2,2,0.00,0.00,0.00,0,'WHILE ADD PRODUCT','2026-05-18','11:38:50',1,1,0),
(3,1,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:45:19',1,1,0),
(4,2,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:45:57',1,1,0),
(5,3,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:46:30',1,1,0),
(6,4,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:47:06',1,1,0),
(7,5,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:47:38',1,1,0),
(8,6,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:47:56',1,1,0),
(9,7,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:48:26',1,1,0),
(10,8,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:48:58',1,1,0),
(11,9,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:50:44',1,1,0),
(12,10,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:51:20',1,1,0),
(13,11,1,1,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:52:04',1,1,0),
(14,12,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:52:46',1,1,0),
(15,13,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:53:08',1,1,0),
(16,14,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:53:26',1,1,0),
(17,15,2,2,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:53:53',1,1,0),
(18,16,1,1,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:54:29',1,1,0),
(19,17,1,1,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','11:55:03',1,1,0),
(20,16,1,1,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-18','15:57:46',1,1,0),
(21,0,3,3,0.00,0.00,0.00,0,'WHILE ADD PRODUCT','2026-05-20','10:09:53',1,1,0),
(22,0,4,4,0.00,0.00,0.00,0,'WHILE ADD PRODUCT','2026-05-20','10:23:19',1,1,0),
(23,16,4,4,0.00,1.00,0.00,1,' BILL WITHOUT STOCK','2026-05-20','10:24:01',1,1,0);

/*Table structure for table `prod_order` */

DROP TABLE IF EXISTS `prod_order`;

CREATE TABLE `prod_order` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL,
  `table_id` int NOT NULL,
  `is_delivered` int DEFAULT '0',
  `is_billed` int DEFAULT '0',
  `is_cancelled` int DEFAULT '0',
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_order` */

/*Table structure for table `prod_order_details` */

DROP TABLE IF EXISTS `prod_order_details`;

CREATE TABLE `prod_order_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `prod_id` int NOT NULL,
  `qty` int NOT NULL,
  `price` double(10,3) DEFAULT '0.000',
  `total` double(10,3) DEFAULT '0.000',
  `is_delivered` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_order_details` */

/*Table structure for table `prod_product` */

DROP TABLE IF EXISTS `prod_product`;

CREATE TABLE `prod_product` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '0',
  `category_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `unit_id` int DEFAULT '1',
  `hsn` int DEFAULT NULL,
  `uid` int NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `gst` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat` (`category_id`),
  KEY `brand` (`brand_id`),
  KEY `uid` (`uid`),
  KEY `unit` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `prod_product` */

insert  into `prod_product`(`id`,`name`,`code`,`category_id`,`brand_id`,`unit_id`,`hsn`,`uid`,`date`,`time`,`is_active`,`gst`) values 
(1,'JASXBILL BILLING SOFTWARE','101',1,1,1,NULL,1,'2026-05-18','11:38:36',1,0),
(3,'CLOUD PROFIT','102',3,1,1,NULL,1,'2026-05-20','10:09:53',1,0),
(4,'EXTRA WORK','103',4,1,1,NULL,1,'2026-05-20','10:23:19',1,0);

/*Table structure for table `prod_product_components` */

DROP TABLE IF EXISTS `prod_product_components`;

CREATE TABLE `prod_product_components` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL COMMENT 'Main product ID',
  `component_product_id` int NOT NULL COMMENT 'Component product ID',
  `quantity` decimal(10,2) DEFAULT '1.00' COMMENT 'Quantity needed',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `compo` (`component_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_product_components` */

/*Table structure for table `prod_purchase` */

DROP TABLE IF EXISTS `prod_purchase`;

CREATE TABLE `prod_purchase` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `prno` varchar(25) NOT NULL DEFAULT '',
  `invno` varchar(255) DEFAULT '',
  `invdate` date DEFAULT NULL,
  `total` double(10,2) NOT NULL DEFAULT '0.00',
  `paid` double(10,2) NOT NULL DEFAULT '0.00',
  `balance` double(10,2) DEFAULT '0.00',
  `discount` double(10,2) DEFAULT '0.00',
  `net` double NOT NULL DEFAULT '0',
  `ent_date` date NOT NULL DEFAULT '0001-01-01',
  `ent_time` time NOT NULL DEFAULT '00:00:00',
  `ent_uid` int unsigned NOT NULL DEFAULT '0',
  `ispending` tinyint unsigned DEFAULT '0',
  `pay_type` int unsigned NOT NULL DEFAULT '0',
  `bank_id` int unsigned NOT NULL DEFAULT '0',
  `deal_id` int unsigned DEFAULT '0',
  `remark` varchar(100) NOT NULL DEFAULT '0',
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancel_date` date DEFAULT '0001-01-01',
  `cancel_time` time DEFAULT '00:00:00',
  `cancel_uid` varchar(10) DEFAULT '0',
  `is_po` tinyint DEFAULT '0',
  `po_status` tinyint DEFAULT '1',
  `pr_id` int DEFAULT NULL,
  `grn_id` int DEFAULT '0',
  `expected_date` date DEFAULT NULL,
  `po_notes` text,
  `offer` text,
  `offer_date` date DEFAULT NULL,
  `lr_no` varchar(255) DEFAULT NULL,
  `lr_date` date DEFAULT NULL,
  `lr_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prno` (`prno`),
  KEY `dealer` (`deal_id`),
  KEY `grnid` (`grn_id`),
  KEY `status` (`po_status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_purchase` */

/*Table structure for table `prod_purchase_counter` */

DROP TABLE IF EXISTS `prod_purchase_counter`;

CREATE TABLE `prod_purchase_counter` (
  `id` int NOT NULL,
  `last_pr_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_counter` */

/*Table structure for table `prod_purchase_details` */

DROP TABLE IF EXISTS `prod_purchase_details`;

CREATE TABLE `prod_purchase_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `prid` int unsigned DEFAULT '0',
  `prods_id` int DEFAULT '0',
  `pack` int DEFAULT '0',
  `qtypack` decimal(10,2) DEFAULT '0.00',
  `quantity` decimal(10,2) unsigned DEFAULT '0.00',
  `free` int unsigned DEFAULT '0',
  `rate` double(10,3) DEFAULT '0.000',
  `mrp` double(10,3) DEFAULT '0.000',
  `totalamt` double(10,3) DEFAULT '0.000',
  `tax` double(10,2) NOT NULL DEFAULT '0.00',
  `tax_amt` double(10,3) DEFAULT '0.000',
  `mrp_vat_amt` double(10,2) DEFAULT '0.00',
  `disc_per` double(10,2) DEFAULT '0.00',
  `disc` double(10,3) DEFAULT '0.000',
  `netamt` double(10,3) DEFAULT '0.000',
  `isinvoicereceived` int unsigned NOT NULL DEFAULT '0',
  `hsn_code` varchar(20) NOT NULL DEFAULT '0',
  `sgst_per` double(10,2) NOT NULL DEFAULT '0.00',
  `cgst_per` double(10,2) NOT NULL DEFAULT '0.00',
  `igst_per` double(10,2) NOT NULL DEFAULT '0.00',
  `sgst_amt` double(10,2) NOT NULL DEFAULT '0.00',
  `cgst_amt` double(10,2) NOT NULL DEFAULT '0.00',
  `igst_amt` double(10,2) NOT NULL DEFAULT '0.00',
  `unitrate` double(10,3) DEFAULT '0.000',
  `unitmrp` double(10,3) DEFAULT '0.000',
  `ordered_qty` int DEFAULT '0',
  `received_qty` int DEFAULT '0',
  `pending_qty` int DEFAULT '0',
  `is_fully_received` tinyint DEFAULT '0',
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = this item was cancelled',
  PRIMARY KEY (`id`),
  KEY `prid` (`prid`),
  KEY `prod` (`prods_id`),
  KEY `fullyreceive` (`is_fully_received`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_purchase_details` */

/*Table structure for table `prod_purchase_edit_log` */

DROP TABLE IF EXISTS `prod_purchase_edit_log`;

CREATE TABLE `prod_purchase_edit_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `purchase_detail_id` int NOT NULL,
  `product_id` int NOT NULL,
  `edit_type` enum('price_edit','cancel') NOT NULL,
  `old_rate` double DEFAULT NULL,
  `new_rate` double DEFAULT NULL,
  `old_mrp` double DEFAULT NULL,
  `new_mrp` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `reason` text,
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_edit_log` */

/*Table structure for table `prod_purchase_entry_details_link` */

DROP TABLE IF EXISTS `prod_purchase_entry_details_link`;

CREATE TABLE `prod_purchase_entry_details_link` (
  `id` int NOT NULL AUTO_INCREMENT,
  `link_id` int NOT NULL,
  `po_detail_id` bigint unsigned NOT NULL,
  `pe_detail_id` bigint unsigned NOT NULL,
  `quantity_received` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_entry_details_link` */

/*Table structure for table `prod_purchase_entry_link` */

DROP TABLE IF EXISTS `prod_purchase_entry_link`;

CREATE TABLE `prod_purchase_entry_link` (
  `id` int NOT NULL AUTO_INCREMENT,
  `po_id` bigint unsigned NOT NULL,
  `pe_id` bigint unsigned NOT NULL,
  `receipt_no` varchar(50) DEFAULT NULL,
  `receipt_date` date DEFAULT NULL,
  `received_by` int DEFAULT NULL,
  `notes` text,
  `created_date` date NOT NULL,
  `created_time` time NOT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_entry_link` */

/*Table structure for table `prod_purchase_order_counter` */

DROP TABLE IF EXISTS `prod_purchase_order_counter`;

CREATE TABLE `prod_purchase_order_counter` (
  `id` int NOT NULL DEFAULT '1',
  `last_po_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_order_counter` */

/*Table structure for table `prod_purchase_request` */

DROP TABLE IF EXISTS `prod_purchase_request`;

CREATE TABLE `prod_purchase_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `req_no` varchar(50) NOT NULL COMMENT 'REQ1, REQ2, REQ3...',
  `req_date` date NOT NULL,
  `req_time` time NOT NULL,
  `deal_id` int DEFAULT NULL COMMENT 'Supplier ID - can be null for TBD supplier',
  `total` decimal(15,2) DEFAULT '0.00' COMMENT 'Total request amount',
  `pr_status` tinyint DEFAULT '1' COMMENT '1=Draft, 2=Submitted, 3=Approved, 4=Rejected, 5=Converted to PO',
  `notes` text COMMENT 'Request notes/justification',
  `requested_by` int NOT NULL COMMENT 'User ID who created the request',
  `approver_id` int DEFAULT NULL COMMENT 'User ID who approved/rejected - for future multi-level approval',
  `approved_date` date DEFAULT NULL COMMENT 'Approval date',
  `approved_time` time DEFAULT NULL COMMENT 'Approval time',
  `approval_notes` text COMMENT 'Approval/rejection notes',
  `po_id` int DEFAULT NULL COMMENT 'Link to PO if converted',
  `is_cancelled` tinyint DEFAULT '0' COMMENT '0=Active, 1=Cancelled',
  `ent_date` date NOT NULL,
  `ent_time` time NOT NULL,
  `ent_uid` int NOT NULL COMMENT 'Entry user ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_no` (`req_no`),
  KEY `deal` (`deal_id`),
  KEY `status` (`pr_status`),
  KEY `po` (`po_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Purchase Request Header';

/*Data for the table `prod_purchase_request` */

/*Table structure for table `prod_purchase_request_counter` */

DROP TABLE IF EXISTS `prod_purchase_request_counter`;

CREATE TABLE `prod_purchase_request_counter` (
  `id` int NOT NULL DEFAULT '1',
  `last_req_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_request_counter` */

/*Table structure for table `prod_purchase_request_details` */

DROP TABLE IF EXISTS `prod_purchase_request_details`;

CREATE TABLE `prod_purchase_request_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pr_id` int NOT NULL COMMENT 'Foreign key to prod_purchase_request',
  `prods_id` int NOT NULL COMMENT 'Product ID',
  `pack` int DEFAULT '1' COMMENT 'Number of packs',
  `qtypack` int DEFAULT '1' COMMENT 'Quantity per pack',
  `quantity` int NOT NULL COMMENT 'Total quantity requested',
  `free` int DEFAULT '0' COMMENT 'Free quantity expected',
  `rate` decimal(15,2) DEFAULT '0.00' COMMENT 'Expected cost per unit',
  `mrp` decimal(15,2) DEFAULT '0.00' COMMENT 'Expected MRP',
  `total` decimal(15,2) DEFAULT '0.00' COMMENT 'Line total',
  `tax` decimal(5,2) DEFAULT '0.00' COMMENT 'Tax percentage',
  `tax_amt` decimal(15,2) DEFAULT '0.00' COMMENT 'Tax amount',
  `disc_per` decimal(5,2) DEFAULT '0.00' COMMENT 'Discount percentage',
  `disc_amt` decimal(15,2) DEFAULT '0.00' COMMENT 'Discount amount',
  `net` decimal(15,2) DEFAULT '0.00' COMMENT 'Net amount',
  `notes` text COMMENT 'Item notes',
  PRIMARY KEY (`id`),
  KEY `idx_pr_id` (`pr_id`),
  KEY `idx_prods_id` (`prods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Purchase Request Line Items';

/*Data for the table `prod_purchase_request_details` */

/*Table structure for table `prod_purchase_return` */

DROP TABLE IF EXISTS `prod_purchase_return`;

CREATE TABLE `prod_purchase_return` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `return_no` varchar(50) DEFAULT NULL,
  `purchase_id` int NOT NULL,
  `supplier_id` int DEFAULT NULL,
  `total` double DEFAULT '0',
  `notes` text,
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_return` */

/*Table structure for table `prod_purchase_return_details` */

DROP TABLE IF EXISTS `prod_purchase_return_details`;

CREATE TABLE `prod_purchase_return_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `return_id` int NOT NULL,
  `purchase_detail_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` double DEFAULT '0',
  `rate` double DEFAULT '0',
  `total` double DEFAULT '0',
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `return_id` (`return_id`),
  KEY `purchase_detail_id` (`purchase_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_return_details` */

/*Table structure for table `prod_purchase_supplier_payment` */

DROP TABLE IF EXISTS `prod_purchase_supplier_payment`;

CREATE TABLE `prod_purchase_supplier_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `prid` int NOT NULL,
  `deal_id` int NOT NULL,
  `total` double(10,2) DEFAULT NULL,
  `paid` double(10,2) DEFAULT NULL,
  `balance` double(10,2) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prid` (`prid`),
  KEY `deal` (`deal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_purchase_supplier_payment` */

/*Table structure for table `prod_purchase_supplier_payment_details` */

DROP TABLE IF EXISTS `prod_purchase_supplier_payment_details`;

CREATE TABLE `prod_purchase_supplier_payment_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `supPayId` int NOT NULL,
  `payable` double(10,2) DEFAULT NULL,
  `paid` double(10,2) DEFAULT NULL,
  `balance` double(10,2) DEFAULT NULL,
  `pay_type` int DEFAULT NULL,
  `pay_mode` int DEFAULT '0',
  `uid` int DEFAULT NULL,
  `notes` text,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payId` (`supPayId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_purchase_supplier_payment_details` */

/*Table structure for table `prod_quotation` */

DROP TABLE IF EXISTS `prod_quotation`;

CREATE TABLE `prod_quotation` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_display` varchar(255) NOT NULL,
  `total` double(10,3) DEFAULT '0.000',
  `prodDisc` double(10,3) DEFAULT '0.000',
  `extraDisc` double(10,3) DEFAULT '0.000',
  `payable` double(10,3) DEFAULT '0.000',
  `is_billed` int DEFAULT '0',
  `is_cancelled` int DEFAULT '0',
  `cusName` varchar(255) DEFAULT NULL,
  `cusPhn` varchar(255) DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_quotation` */

/*Table structure for table `prod_quotation_details` */

DROP TABLE IF EXISTS `prod_quotation_details`;

CREATE TABLE `prod_quotation_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quot_id` int NOT NULL,
  `prod_id` int NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `price` double(10,3) NOT NULL,
  `disc` double(10,3) DEFAULT NULL,
  `total` double(10,3) DEFAULT NULL,
  `gst` int DEFAULT NULL,
  `is_cancelled` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_quotation_details` */

/*Table structure for table `prod_stock_adjustment` */

DROP TABLE IF EXISTS `prod_stock_adjustment`;

CREATE TABLE `prod_stock_adjustment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `batch_id` int NOT NULL,
  `stockType` int NOT NULL COMMENT '1=add 2=minus',
  `stock` decimal(10,2) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `notes` text,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `batch` (`batch_id`),
  KEY `stock` (`stockType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_stock_adjustment` */

/*Table structure for table `prod_stock_totals` */

DROP TABLE IF EXISTS `prod_stock_totals`;

CREATE TABLE `prod_stock_totals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `prods_id` int unsigned NOT NULL DEFAULT '0',
  `stock` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `rack` char(1) NOT NULL DEFAULT '',
  `shelf` int NOT NULL DEFAULT '0',
  `userlog` text,
  `extra1` tinyint unsigned DEFAULT '0',
  `extra2` tinyint unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `store_id_index` (`prods_id`),
  KEY `stock` (`stock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_stock_totals` */

/*Table structure for table `prod_supplier` */

DROP TABLE IF EXISTS `prod_supplier`;

CREATE TABLE `prod_supplier` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `gstin` varchar(255) DEFAULT NULL,
  `is_gst` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prod_supplier` */

/*Table structure for table `prod_supplier_cheque_allocation` */

DROP TABLE IF EXISTS `prod_supplier_cheque_allocation`;

CREATE TABLE `prod_supplier_cheque_allocation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `purchase_id` int NOT NULL,
  `allocated_amount` decimal(10,2) NOT NULL,
  `allocated_date` date NOT NULL,
  `allocated_time` time NOT NULL,
  `allocated_uid` int NOT NULL,
  `due_date` date DEFAULT NULL,
  `credit_days` int DEFAULT '10',
  `status` varchar(20) NOT NULL DEFAULT 'ALLOCATED',
  `cleared_date` date DEFAULT NULL,
  `cleared_time` time DEFAULT NULL,
  `cleared_uid` int DEFAULT NULL,
  `is_reversed` tinyint(1) DEFAULT '0',
  `reversed_date` date DEFAULT NULL,
  `reversed_time` time DEFAULT NULL,
  `reversed_uid` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_purchase` (`purchase_id`),
  KEY `idx_status` (`status`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_supplier_cheque_allocation` */

/*Table structure for table `prod_supplier_cheque_events` */

DROP TABLE IF EXISTS `prod_supplier_cheque_events`;

CREATE TABLE `prod_supplier_cheque_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `event_type` varchar(20) NOT NULL,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `event_uid` int NOT NULL,
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_event_type` (`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_supplier_cheque_events` */

/*Table structure for table `prod_supplier_cheque_stock` */

DROP TABLE IF EXISTS `prod_supplier_cheque_stock`;

CREATE TABLE `prod_supplier_cheque_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int NOT NULL,
  `cheque_number` varchar(255) NOT NULL,
  `bank_name` text,
  `entry_date` date NOT NULL,
  `entry_time` time NOT NULL,
  `entry_uid` int NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'AVAILABLE',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_supplier` (`supplier_id`),
  KEY `idx_status` (`status`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_supplier_cheque_stock` */

/*Table structure for table `prod_units` */

DROP TABLE IF EXISTS `prod_units`;

CREATE TABLE `prod_units` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `convertion_unit` varchar(255) DEFAULT NULL,
  `convertion_calculation` decimal(10,2) DEFAULT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_units` */

insert  into `prod_units`(`id`,`name`,`convertion_unit`,`convertion_calculation`,`is_active`) values 
(1,'NOS',NULL,NULL,1),
(2,'Gram',NULL,NULL,1),
(3,'KG',NULL,NULL,1),
(4,'Meter',NULL,NULL,1),
(5,'length','Feet',20.00,1);

/*Table structure for table `sales_area` */

DROP TABLE IF EXISTS `sales_area`;

CREATE TABLE `sales_area` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sales_area` */

/*Table structure for table `sales_man` */

DROP TABLE IF EXISTS `sales_man`;

CREATE TABLE `sales_man` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sales_man` */

/*Table structure for table `special_permission` */

DROP TABLE IF EXISTS `special_permission`;

CREATE TABLE `special_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `special_permission` */

insert  into `special_permission`(`id`,`content`) values 
(1,'allow to Zero stock billing ');

/*Table structure for table `user_modules` */

DROP TABLE IF EXISTS `user_modules`;

CREATE TABLE `user_modules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `user_modules` */

insert  into `user_modules`(`id`,`module_name`) values 
(1,'Billing'),
(2,'Configuration'),
(3,'Stock Reports'),
(4,'User management'),
(5,'Inventory'),
(6,'Account Report'),
(7,'Admin'),
(8,'Dashboard'),
(10,'Credit Management'),
(11,'order list'),
(12,'Expense');

/*Table structure for table `user_permission` */

DROP TABLE IF EXISTS `user_permission`;

CREATE TABLE `user_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int NOT NULL,
  `uid` int NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mod` (`module_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;

/*Data for the table `user_permission` */

insert  into `user_permission`(`id`,`module_id`,`uid`,`date`,`time`) values 
(70,1,1,'2025-09-19','11:43:23'),
(71,2,1,'2025-09-19','11:43:23'),
(72,3,1,'2025-09-19','11:43:23'),
(73,4,1,'2025-09-19','11:43:23'),
(74,5,1,'2025-09-19','11:43:23'),
(75,6,1,'2025-09-19','11:43:23'),
(76,7,1,'2025-09-19','11:43:23'),
(77,8,1,'2025-09-19','11:43:23'),
(81,8,1,'2025-09-19','11:51:25'),
(102,10,1,'2026-01-16',NULL),
(113,11,1,'2026-01-25',NULL),
(115,1,23,'2026-02-19','12:25:37'),
(116,12,1,'2026-02-19','12:00:00'),
(117,1,22,'2026-02-27','11:51:13'),
(118,12,22,'2026-02-27','11:51:13'),
(119,1,24,'2026-03-05','17:40:35');

/*Table structure for table `user_special_permission` */

DROP TABLE IF EXISTS `user_special_permission`;

CREATE TABLE `user_special_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user_special_permission` */

insert  into `user_special_permission`(`id`,`content_id`,`user_id`) values 
(1,1,1);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  `fullName` varchar(255) DEFAULT NULL,
  `disc_per` int DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`user_name`,`password`,`is_active`,`fullName`,`disc_per`) values 
(1,'admin','aecbf9a63cec1e93327dfc212f31acdb31c4f5d10bedccf8fbb8b042a6f0f39155797bdd04517905ae5d98b69fdc452cdb61b018e10939740ec96f36e133d639',1,'admin',50),
(22,'demo','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,'demo',100),
(23,'hi','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,'hi',100),
(24,'saran','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,'saran',100);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
