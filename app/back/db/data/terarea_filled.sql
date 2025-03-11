-- MariaDB dump 10.19  Distrib 10.11.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: terarea
-- ------------------------------------------------------
-- Server version	11.6.2-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `terarea`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `terarea` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;

USE `terarea`;

--
-- Table structure for table `ActionLoging`
--

DROP TABLE IF EXISTS `ActionLoging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ActionLoging` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'This is the time at which the workflow occurred',
  `type` mediumtext NOT NULL DEFAULT 'API' COMMENT 'The type of action concerned',
  `action_id` bigint(20) unsigned NOT NULL COMMENT 'The id of the item that is being logged',
  `message` longtext DEFAULT NULL COMMENT 'The error message',
  `code` bigint(20) DEFAULT NULL COMMENT 'The code linked to the action',
  `level` mediumtext DEFAULT NULL COMMENT 'The level of the importance for the code',
  `resolved` tinyint(1) DEFAULT NULL COMMENT 'Inform if the current error is solved',
  PRIMARY KEY (`id`),
  KEY `WorkflowLoging_Actions_FK` (`action_id`),
  CONSTRAINT `WorkflowLoging_Actions_FK` FOREIGN KEY (`action_id`) REFERENCES `Actions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The new loggin table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActionLoging`
--

LOCK TABLES `ActionLoging` WRITE;
/*!40000 ALTER TABLE `ActionLoging` DISABLE KEYS */;
/*!40000 ALTER TABLE `ActionLoging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ActionTemplate`
--

DROP TABLE IF EXISTS `ActionTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ActionTemplate` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'action' COMMENT 'The type of the template',
  `json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'The json content for the template.',
  `service_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ActionTemplate_Services_FK` (`service_id`),
  CONSTRAINT `ActionTemplate_Services_FK` FOREIGN KEY (`service_id`) REFERENCES `Services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci COMMENT='The table containing the templates for the action that the website has to offer.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActionTemplate`
--

LOCK TABLES `ActionTemplate` WRITE;
/*!40000 ALTER TABLE `ActionTemplate` DISABLE KEYS */;
INSERT INTO `ActionTemplate` VALUES
(1,'trigger','{\n    \"name\": \"Every hour\",\n    \"description\": \"This action trigger every hour at a specific minute set by you.\",\n    \"service\": {\n        \"ignore:id\": 5,\n        \"ignore:url_extra\": \"/api/time/current/zone\",\n        \"url_params\": {\n            \"drop:timeZone\": [\n                \"opt:Africa/Addis_Ababa\",\n                \"opt:Africa/Cairo\",\n                \"opt:Africa/Casablanca\",\n                \"opt:Africa/Dakar\",\n                \"opt:Africa/Johannesburg\",\n                \"opt:Africa/Kinshasa\",\n                \"opt:Africa/Lagos\",\n                \"opt:Africa/Nairobi\",\n                \"opt:America/Bogota\",\n                \"opt:America/Buenos_Aires\",\n                \"opt:America/Chicago\",\n                \"opt:America/Lima\",\n                \"opt:America/Los_Angeles\",\n                \"opt:America/Mexico_City\",\n                \"opt:America/Montreal\",\n                \"opt:America/New_York\",\n                \"opt:America/Santiago\",\n                \"opt:America/Sao_Paulo\",\n                \"opt:America/Toronto\",\n                \"opt:Asia/Bangkok\",\n                \"opt:Asia/Jakarta\",\n                \"opt:Asia/Seoul\",\n                \"opt:Asia/Shanghai\",\n                \"opt:Asia/Tokyo\",\n                \"opt:Australia/Brisbane\",\n                \"opt:Australia/Melbourne\",\n                \"opt:Australia/Perth\",\n                \"opt:Australia/Sydney\",\n                \"opt:Europe/Berlin\",\n                \"opt:Europe/London\",\n                \"opt:Europe/Madrid\",\n                \"opt:Europe/Moscow\",\n                \"default:Europe/Paris\",\n                \"opt:Europe/Rome\"\n            ]\n        },\n        \"ignore:method\": \"GET\",\n        \"ignore:response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ],\n            \"response_content\": {\n                \"minute\": \"$ref{body.minute}\"\n            }\n        },\n        \"verification\": {\n            \"minute\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:10\",\n                    \"opt:20\",\n                    \"opt:30\",\n                    \"opt:40\",\n                    \"opt:50\"\n                ]\n            }\n        },\n        \"ignore:vars\": {\n            \"date\": \"$ref{body.date}\",\n            \"location\": \"$ref{body.timeZone}\",\n            \"day\": \"$ref{body.dayOfWeek}\",\n            \"current_time\": \"$ref{body.time}\"\n        }\n    }\n}',5),
(2,'trigger','{\n    \"name\": \"Every day\",\n    \"description\": \"This action trigger every day at a specific time set by you.\",\n    \"service\": {\n        \"ignore:id\": 5,\n        \"ignore:url_extra\": \"/api/time/current/zone\",\n        \"url_params\": {\n            \"drop:timeZone\": [\n                \"opt:Africa/Addis_Ababa\",\n                \"opt:Africa/Cairo\",\n                \"opt:Africa/Casablanca\",\n                \"opt:Africa/Dakar\",\n                \"opt:Africa/Johannesburg\",\n                \"opt:Africa/Kinshasa\",\n                \"opt:Africa/Lagos\",\n                \"opt:Africa/Nairobi\",\n                \"opt:America/Bogota\",\n                \"opt:America/Buenos_Aires\",\n                \"opt:America/Chicago\",\n                \"opt:America/Lima\",\n                \"opt:America/Los_Angeles\",\n                \"opt:America/Mexico_City\",\n                \"opt:America/Montreal\",\n                \"opt:America/New_York\",\n                \"opt:America/Santiago\",\n                \"opt:America/Sao_Paulo\",\n                \"opt:America/Toronto\",\n                \"opt:Asia/Bangkok\",\n                \"opt:Asia/Jakarta\",\n                \"opt:Asia/Seoul\",\n                \"opt:Asia/Shanghai\",\n                \"opt:Asia/Tokyo\",\n                \"opt:Australia/Brisbane\",\n                \"opt:Australia/Melbourne\",\n                \"opt:Australia/Perth\",\n                \"opt:Australia/Sydney\",\n                \"opt:Europe/Berlin\",\n                \"opt:Europe/London\",\n                \"opt:Europe/Madrid\",\n                \"opt:Europe/Moscow\",\n                \"default:Europe/Paris\",\n                \"opt:Europe/Rome\"\n            ]\n        },\n        \"ignore:method\": \"GET\",\n        \"ignore:response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ],\n            \"response_content\": {\n                \"hour\": \"$ref{body.hour}\",\n                \"minute\": \"$ref{body.minute}\"\n            }\n        },\n        \"verification\": {\n            \"hour\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\"\n                ]\n            },\n            \"minute\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:10\",\n                    \"opt:20\",\n                    \"opt:30\",\n                    \"opt:40\",\n                    \"opt:50\"\n                ]\n            }\n        },\n        \"ignore:vars\": {\n            \"date\": \"$ref{body.date}\",\n            \"location\": \"$ref{body.timeZone}\",\n            \"day\": \"$ref{body.dayOfWeek}\",\n            \"current_time\": \"$ref{body.time}\"\n        }\n    }\n}',5),
(3,'trigger','{\n    \"name\": \"Every week\",\n    \"description\": \"This action trigger every week in a specific day and at a specific time set by you.\",\n    \"service\": {\n        \"ignore:id\": 5,\n        \"ignore:url_extra\": \"/api/time/current/zone\",\n        \"url_params\": {\n            \"drop:timeZone\": [\n                \"opt:Africa/Addis_Ababa\",\n                \"opt:Africa/Cairo\",\n                \"opt:Africa/Casablanca\",\n                \"opt:Africa/Dakar\",\n                \"opt:Africa/Johannesburg\",\n                \"opt:Africa/Kinshasa\",\n                \"opt:Africa/Lagos\",\n                \"opt:Africa/Nairobi\",\n                \"opt:America/Bogota\",\n                \"opt:America/Buenos_Aires\",\n                \"opt:America/Chicago\",\n                \"opt:America/Lima\",\n                \"opt:America/Los_Angeles\",\n                \"opt:America/Mexico_City\",\n                \"opt:America/Montreal\",\n                \"opt:America/New_York\",\n                \"opt:America/Santiago\",\n                \"opt:America/Sao_Paulo\",\n                \"opt:America/Toronto\",\n                \"opt:Asia/Bangkok\",\n                \"opt:Asia/Jakarta\",\n                \"opt:Asia/Seoul\",\n                \"opt:Asia/Shanghai\",\n                \"opt:Asia/Tokyo\",\n                \"opt:Australia/Brisbane\",\n                \"opt:Australia/Melbourne\",\n                \"opt:Australia/Perth\",\n                \"opt:Australia/Sydney\",\n                \"opt:Europe/Berlin\",\n                \"opt:Europe/London\",\n                \"opt:Europe/Madrid\",\n                \"opt:Europe/Moscow\",\n                \"default:Europe/Paris\",\n                \"opt:Europe/Rome\"\n            ]\n        },\n        \"ignore:method\": \"GET\",\n        \"ignore:response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ],\n            \"response_content\": {\n            	\"day\": \"$ref{body.dayOfWeek}\",\n                \"hour\": \"$ref{body.hour}\",\n                \"minute\": \"$ref{body.minute}\"\n            }\n        },\n        \"verification\": {\n        	\"day\": {\n        		\"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:Monday\",\n                    \"opt:Tuesday\",\n                    \"opt:Wednesday\",\n                    \"opt:Thursday\",\n                    \"opt:Friday\",\n                    \"opt:Saturday\",\n                    \"opt:Sunday\"\n                ]\n            },\n            \"hour\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\"\n                ]\n            },\n            \"minute\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:10\",\n                    \"opt:20\",\n                    \"opt:30\",\n                    \"opt:40\",\n                    \"opt:50\"\n                ]\n            }\n        },\n        \"ignore:vars\": {\n            \"date\": \"$ref{body.date}\",\n            \"location\": \"$ref{body.timeZone}\",\n            \"day\": \"$ref{body.dayOfWeek}\",\n            \"current_time\": \"$ref{body.time}\"\n        }\n    }\n}',5),
(4,'trigger','{\n    \"name\": \"Every month\",\n    \"description\": \"This action trigger every month in a specific day and at a specific time set by you.\",\n    \"service\": {\n        \"ignore:id\": 5,\n        \"ignore:url_extra\": \"/api/time/current/zone\",\n        \"url_params\": {\n            \"drop:timeZone\": [\n                \"opt:Africa/Addis_Ababa\",\n                \"opt:Africa/Cairo\",\n                \"opt:Africa/Casablanca\",\n                \"opt:Africa/Dakar\",\n                \"opt:Africa/Johannesburg\",\n                \"opt:Africa/Kinshasa\",\n                \"opt:Africa/Lagos\",\n                \"opt:Africa/Nairobi\",\n                \"opt:America/Bogota\",\n                \"opt:America/Buenos_Aires\",\n                \"opt:America/Chicago\",\n                \"opt:America/Lima\",\n                \"opt:America/Los_Angeles\",\n                \"opt:America/Mexico_City\",\n                \"opt:America/Montreal\",\n                \"opt:America/New_York\",\n                \"opt:America/Santiago\",\n                \"opt:America/Sao_Paulo\",\n                \"opt:America/Toronto\",\n                \"opt:Asia/Bangkok\",\n                \"opt:Asia/Jakarta\",\n                \"opt:Asia/Seoul\",\n                \"opt:Asia/Shanghai\",\n                \"opt:Asia/Tokyo\",\n                \"opt:Australia/Brisbane\",\n                \"opt:Australia/Melbourne\",\n                \"opt:Australia/Perth\",\n                \"opt:Australia/Sydney\",\n                \"opt:Europe/Berlin\",\n                \"opt:Europe/London\",\n                \"opt:Europe/Madrid\",\n                \"opt:Europe/Moscow\",\n                \"default:Europe/Paris\",\n                \"opt:Europe/Rome\"\n            ]\n        },\n        \"ignore:method\": \"GET\",\n        \"ignore:response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ],\n            \"response_content\": {\n            	\"day\": \"$ref{body.day}\",\n                \"hour\": \"$ref{body.hour}\",\n                \"minute\": \"$ref{body.minute}\"\n            }\n        },\n        \"verification\": {\n        	\"day\": {\n        		\"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\",\n                    \"opt:24\",\n                    \"opt:25\",\n                    \"opt:26\",\n                    \"opt:27\",\n                    \"opt:28\",\n                    \"opt:29\",\n                    \"opt:30\",\n                    \"opt:31\"\n                ]\n            },\n            \"hour\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\"\n                ]\n            },\n            \"minute\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:10\",\n                    \"opt:20\",\n                    \"opt:30\",\n                    \"opt:40\",\n                    \"opt:50\"\n                ]\n            }\n        },\n        \"ignore:vars\": {\n            \"date\": \"$ref{body.date}\",\n            \"location\": \"$ref{body.timeZone}\",\n            \"day\": \"$ref{body.dayOfWeek}\",\n            \"current_time\": \"$ref{body.time}\"\n        }\n    }\n}',5),
(5,'trigger','{\n    \"name\": \"Every year\",\n    \"description\": \"This action trigger every year in a specific month, day and at a specific time set by you.\",\n    \"service\": {\n        \"ignore:id\": 5,\n        \"ignore:url_extra\": \"/api/time/current/zone\",\n        \"url_params\": {\n            \"drop:timeZone\": [\n                \"opt:Africa/Addis_Ababa\",\n                \"opt:Africa/Cairo\",\n                \"opt:Africa/Casablanca\",\n                \"opt:Africa/Dakar\",\n                \"opt:Africa/Johannesburg\",\n                \"opt:Africa/Kinshasa\",\n                \"opt:Africa/Lagos\",\n                \"opt:Africa/Nairobi\",\n                \"opt:America/Bogota\",\n                \"opt:America/Buenos_Aires\",\n                \"opt:America/Chicago\",\n                \"opt:America/Lima\",\n                \"opt:America/Los_Angeles\",\n                \"opt:America/Mexico_City\",\n                \"opt:America/Montreal\",\n                \"opt:America/New_York\",\n                \"opt:America/Santiago\",\n                \"opt:America/Sao_Paulo\",\n                \"opt:America/Toronto\",\n                \"opt:Asia/Bangkok\",\n                \"opt:Asia/Jakarta\",\n                \"opt:Asia/Seoul\",\n                \"opt:Asia/Shanghai\",\n                \"opt:Asia/Tokyo\",\n                \"opt:Australia/Brisbane\",\n                \"opt:Australia/Melbourne\",\n                \"opt:Australia/Perth\",\n                \"opt:Australia/Sydney\",\n                \"opt:Europe/Berlin\",\n                \"opt:Europe/London\",\n                \"opt:Europe/Madrid\",\n                \"opt:Europe/Moscow\",\n                \"default:Europe/Paris\",\n                \"opt:Europe/Rome\"\n            ]\n        },\n        \"ignore:method\": \"GET\",\n        \"ignore:response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ],\n            \"response_content\": {\n            	\"month\": \"$ref{body.month}\",\n            	\"day\": \"$ref{body.day}\",\n                \"hour\": \"$ref{body.hour}\",\n                \"minute\": \"$ref{body.minute}\"\n            }\n        },\n        \"verification\": {\n        	\"month\": {\n        		\"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"defaut:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\"\n                ]\n        	},\n        	\"day\": {\n        		\"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\",\n                    \"opt:24\",\n                    \"opt:25\",\n                    \"opt:26\",\n                    \"opt:27\",\n                    \"opt:28\",\n                    \"opt:29\",\n                    \"opt:30\",\n                    \"opt:31\"\n                ]\n            },\n            \"hour\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\"\n                ]\n            },\n            \"minute\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:10\",\n                    \"opt:20\",\n                    \"opt:30\",\n                    \"opt:40\",\n                    \"opt:50\"\n                ]\n            }\n        },\n        \"ignore:vars\": {\n            \"date\": \"$ref{body.date}\",\n            \"location\": \"$ref{body.timeZone}\",\n            \"day\": \"$ref{body.dayOfWeek}\",\n            \"current_time\": \"$ref{body.time}\"\n        }\n    }\n}',5),
(6,'trigger','{\n    \"name\": \"Specific time\",\n    \"description\": \"This action trigger at a specific time set by you. It is good to set a reminder.\",\n    \"service\": {\n        \"ignore:id\": 5,\n        \"ignore:url_extra\": \"/api/time/current/zone\",\n        \"url_params\": {\n            \"drop:timeZone\": [\n                \"opt:Africa/Addis_Ababa\",\n                \"opt:Africa/Cairo\",\n                \"opt:Africa/Casablanca\",\n                \"opt:Africa/Dakar\",\n                \"opt:Africa/Johannesburg\",\n                \"opt:Africa/Kinshasa\",\n                \"opt:Africa/Lagos\",\n                \"opt:Africa/Nairobi\",\n                \"opt:America/Bogota\",\n                \"opt:America/Buenos_Aires\",\n                \"opt:America/Chicago\",\n                \"opt:America/Lima\",\n                \"opt:America/Los_Angeles\",\n                \"opt:America/Mexico_City\",\n                \"opt:America/Montreal\",\n                \"opt:America/New_York\",\n                \"opt:America/Santiago\",\n                \"opt:America/Sao_Paulo\",\n                \"opt:America/Toronto\",\n                \"opt:Asia/Bangkok\",\n                \"opt:Asia/Jakarta\",\n                \"opt:Asia/Seoul\",\n                \"opt:Asia/Shanghai\",\n                \"opt:Asia/Tokyo\",\n                \"opt:Australia/Brisbane\",\n                \"opt:Australia/Melbourne\",\n                \"opt:Australia/Perth\",\n                \"opt:Australia/Sydney\",\n                \"opt:Europe/Berlin\",\n                \"opt:Europe/London\",\n                \"opt:Europe/Madrid\",\n                \"opt:Europe/Moscow\",\n                \"default:Europe/Paris\",\n                \"opt:Europe/Rome\"\n            ]\n        },\n        \"ignore:method\": \"GET\",\n        \"ignore:response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ],\n            \"response_content\": {\n            	\"year\": \"$ref{body.year}\",\n            	\"month\": \"$ref{body.month}\",\n            	\"day\": \"$ref{body.day}\",\n                \"hour\": \"$ref{body.hour}\",\n                \"minute\": \"$ref{body.minute}\"\n            }\n        },\n        \"verification\": {\n        	\"year\": {\n        		\"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:2025\",\n                    \"opt:2026\",\n                    \"opt:2027\",\n                    \"opt:2028\",\n                    \"opt:2029\",\n                    \"opt:2030\",\n                    \"opt:2031\",\n                    \"opt:2032\",\n                    \"opt:2033\",\n                    \"opt:2034\",\n                    \"opt:2035\",\n                    \"opt:2036\",\n                    \"opt:2037\",\n                    \"opt:2038\",\n                    \"opt:2039\",\n                    \"opt:2040\",\n                    \"opt:2041\",\n                    \"opt:2042\",\n                    \"opt:2043\",\n                    \"opt:2044\",\n                    \"opt:2045\",\n                    \"opt:2046\",\n                    \"opt:2047\",\n                    \"opt:2048\",\n                    \"opt:2049\",\n                    \"opt:2050\",\n                    \"opt:2051\",\n                    \"opt:2052\",\n                    \"opt:2053\",\n                    \"opt:2054\",\n                    \"opt:2055\",\n                    \"opt:2056\",\n                    \"opt:2057\",\n                    \"opt:2058\",\n                    \"opt:2059\",\n                    \"opt:2060\",\n                    \"opt:2061\",\n                    \"opt:2062\",\n                    \"opt:2063\",\n                    \"opt:2064\",\n                    \"opt:2065\",\n                    \"opt:2066\",\n                    \"opt:2067\",\n                    \"opt:2068\",\n                    \"opt:2069\",\n                    \"opt:2070\",\n                    \"opt:2071\",\n                    \"opt:2072\",\n                    \"opt:2073\",\n                    \"opt:2074\",\n                    \"opt:2075\",\n                    \"opt:2076\",\n                    \"opt:2077\",\n                    \"opt:2078\",\n                    \"opt:2079\",\n                    \"opt:2080\",\n                    \"opt:2081\",\n                    \"opt:2082\",\n                    \"opt:2083\",\n                    \"opt:2084\",\n                    \"opt:2085\",\n                    \"opt:2086\",\n                    \"opt:2087\",\n                    \"opt:2088\",\n                    \"opt:2089\",\n                    \"opt:2090\",\n                    \"opt:2091\",\n                    \"opt:2092\",\n                    \"opt:2093\",\n                    \"opt:2094\",\n                    \"opt:2095\",\n                    \"opt:2096\",\n                    \"opt:2097\",\n                    \"opt:2098\",\n                    \"opt:2099\",\n                    \"opt:2100\"\n                ]\n        	},\n        	\"month\": {\n        		\"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"defaut:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\"\n                ]\n        	},\n        	\"day\": {\n        		\"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\",\n                    \"opt:24\",\n                    \"opt:25\",\n                    \"opt:26\",\n                    \"opt:27\",\n                    \"opt:28\",\n                    \"opt:29\",\n                    \"opt:30\",\n                    \"opt:31\"\n                ]\n            },\n            \"hour\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:1\",\n                    \"opt:2\",\n                    \"opt:3\",\n                    \"opt:4\",\n                    \"opt:5\",\n                    \"opt:6\",\n                    \"opt:7\",\n                    \"opt:8\",\n                    \"opt:9\",\n                    \"opt:10\",\n                    \"opt:11\",\n                    \"opt:12\",\n                    \"opt:13\",\n                    \"opt:14\",\n                    \"opt:15\",\n                    \"opt:16\",\n                    \"opt:17\",\n                    \"opt:18\",\n                    \"opt:19\",\n                    \"opt:20\",\n                    \"opt:21\",\n                    \"opt:22\",\n                    \"opt:23\"\n                ]\n            },\n            \"minute\": {\n                \"ignore:verification_operator\": [\n                    \"default:==\",\n                    \"opt:!=\",\n                    \"opt:<>\",\n                    \"opt:<\",\n                    \"opt:>\",\n                    \"opt:<=\",\n                    \"opt:>=\",\n                    \"opt:<=>\"\n                ],\n                \"drop:verification_value\": [\n                    \"default:0\",\n                    \"opt:10\",\n                    \"opt:20\",\n                    \"opt:30\",\n                    \"opt:40\",\n                    \"opt:50\"\n                ]\n            }\n        },\n        \"ignore:vars\": {\n            \"date\": \"$ref{body.date}\",\n            \"location\": \"$ref{body.timeZone}\",\n            \"day\": \"$ref{body.dayOfWeek}\",\n            \"current_time\": \"$ref{body.time}\"\n        }\n    }\n}',5),
(7,'trigger','{\n    \"name\": \"Weather\",\n    \"description\": \"Get the weather.\",\n    \"service\": {\n        \"ignore:id\": 6,\n        \"ignore:url_extra\": \"/current.json\",\n        \"url_params\": {\n            \"ignore:key\": \"$ref{secrets.token}\",\n            \"input:q\": \"Enter your zone or city\"\n        },\n        \"ignore:method\": \"GET\",\n        \"ignore:response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ],\n            \"response_content\": {\n            	\"weather\": \"$ref{body.current.condition.text}\"\n            }\n        },\n		\"verification\": {\n			\"weather\": {\n				\"ignore:verification_operator\": [\n            		\"default:==\",\n            		\"opt:!=\",\n            		\"opt:<>\",\n            		\"opt:<\",\n            		\"opt:>\",\n            		\"opt:<=\",\n            		\"opt:>=\",\n            		\"opt:<=>\"\n        		],\n        		\"drop:verification_value\": [\n    				\"default:Sunny\",\n					\"opt:Clear\",\n    				\"opt:Partly cloudy\",\n					\"opt:Cloudy\",\n    				\"opt:Overcast\",\n    				\"opt:Mist\",\n    				\"opt:Patchy rain possible\",\n					\"opt:Patchy snow possible\",\n    				\"opt:Patchy sleet possible\",\n    				\"opt:Patchy freezing drizzle possible\",\n    				\"opt:Thundery outbreaks possible\",\n    				\"opt:Blowing snow\",\n    				\"opt:Blizzard\",\n    				\"opt:Fog\",\n    				\"opt:Freezing fog\",\n    				\"opt:Patchy light drizzle\",\n    				\"opt:Light drizzle\",\n    				\"opt:Freezing drizzle\",\n    				\"opt:Heavy freezing drizzle\",\n    				\"opt:Patchy light rain\",\n    				\"opt:Light rain\",\n					\"opt:Moderate rain at times\",\n    				\"opt:Moderate rain\",\n    				\"opt:Heavy rain at times\",\n    				\"opt:Heavy rain\",\n    				\"opt:Light freezing rain\",\n    				\"opt:Moderate or heavy freezing rain\",\n    				\"opt:Light sleet\",\n    				\"opt:Moderate or heavy sleet\",\n    				\"opt:Patchy light snow\",\n    				\"opt:Light snow\",\n    				\"opt:Patchy moderate snow\",\n    				\"opt:Moderate snow\",\n    				\"opt:Patchy heavy snow\",\n    				\"opt:Heavy snow\",\n    				\"opt:Ice pellets\",\n    				\"opt:Light rain shower\",\n    				\"opt:Moderate or heavy rain shower\",\n    				\"opt:Torrential rain shower\",\n    				\"opt:Light sleet showers\",\n    				\"opt:Moderate or heavy sleet showers\",\n    				\"opt:Light snow showers\",\n    				\"opt:Moderate or heavy snow showers\",\n    				\"opt:Light showers of ice pellets\",\n    				\"opt:Moderate or heavy showers of ice pellets\",\n    				\"opt:Patchy light rain with thunder\",\n    				\"opt:Moderate or heavy rain with thunder\",\n    				\"opt:Patchy light snow with thunder\",\n    				\"opt:Moderate or heavy snow with thunder\"\n				]\n			}\n		},\n        \"vars\": {\n            \"city\": \"$ref{body.location.name}\",\n            \"region\": \"$ref{body.location.region}\",\n            \"country\": \"$ref{body.location.country}\",\n            \"latitude\": \"$ref{body.location.lat}\",\n            \"longitude\": \"$ref{body.location.lon}\",\n            \"localtime\": \"$ref{body.location.localtime}\",\n            \"celsius_temperature\": \"$ref{body.current.temp_c}\",\n            \"fahrenheit_temperature\": \"$ref{body.current.temp_f}\",\n            \"weather\": \"$ref{body.current.condition.text}\"\n        }\n    }\n}',6),
(8,'action','{\n    \"name\": \"SMS\",\n    \"description\": \"Send an sms on a phone number.\",\n    \"service\": {\n        \"ignore:id\": 10,\n        \"ignore:url_extra\": \"text\",\n        \"body\": {\n            \"textarea:message\": \"Enter a message\",\n            \"ignore:key\": \"$ref{secrets.token}\",\n            \"input:phone\": \"Enter your phone. (You need to put enter it in international format)\"\n        },\n        \"ignore:method\": \"POST\",\n        \"response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ]\n        }\n    }\n}',10),
(9,'action','{\n    \"name\": \"Ntfy notifications\",\n    \"description\": \"Notify the user on a specific channel on ntfy.\",\n    \"service\": {\n        \"ignore:id\": 7,\n        \"ignore:url_extra\": \"/{channel_name}\",\n        \"url_body_params\": {\n        	\"input:channel_name\": \"Enter a channel name\"\n        },\n        \"body\": {\n        	\"input:body\": \"Enter a message\"\n        },\n        \"ignore:method\": \"POST\",\n        \"header\": {\n            \"input:title\": \"Enter a title (Optional)\"\n        },\n        \"response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ]\n        }\n    }\n}',7),
(10,'action','{\n    \"name\": \"Pushover notifications\",\n    \"description\": \"Notify the user on Pushover.\",\n    \"service\": {\n        \"ignore:id\": 14,\n        \"ignore:url_extra\": \"/messages.json\",\n        \"body\": {\n            \"input:user\": \"Enter your user key\",\n        	\"ignore:token\": \"$ref{secrets.token}\",\n        	\"input:title\": \"Enter a title (Optional)\",\n            \"textarea:message\": \"Enter a message\",\n            \"drop:priority\": [\n            	\"default:0\",\n            	\"opt:1\"\n            ],\n            \"drop:sound\": [\n				\"default:none\",\n    			\"opt:pushover\",\n    			\"opt:bike\",\n    			\"opt:bugle\",\n    			\"opt:cashregister\",\n    			\"opt:classical\",\n    			\"opt:cosmic\",\n    			\"opt:falling\",\n    			\"opt:gamelan\",\n    			\"opt:incoming\",\n    			\"opt:intermission\",\n    			\"opt:magic\",\n    			\"opt:mechanical\",\n    			\"opt:pianobar\",\n    			\"opt:siren\",\n    			\"opt:spacealarm\",\n    			\"opt:tugboat\",\n    			\"opt:alien\",\n    			\"opt:climb\",\n    			\"opt:persistent\",\n    			\"opt:echo\",\n    			\"opt:updown\"\n            ]\n        },\n        \"ignore:method\": \"POST\",\n        \"response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ]\n        }\n    }\n}',14),
(11,'action','{\n    \"name\": \"Telegram bot\",\n    \"description\": \"Our own Telegram bot will send you a message. Our bot tag is @TerareaBot\",\n    \"service\": {\n        \"ignore:id\": 12,\n        \"ignore:url_extra\": \"/bot$ref{secrets.token}/sendMessage\",\n        \"body\": {\n            \"input:chat_id\": \"Enter your own chat id (You need to send a message to our bot so that it can find you correctly.)\",\n        	\"textarea:text\": \"Enter a message\"\n        },\n        \"ignore:method\": \"POST\",\n        \"response\": {\n            \"int:code\": [\n                \"default:200\",\n                \"min:100\",\n                \"max:500\"\n            ]\n        }\n    }\n}',12);
/*!40000 ALTER TABLE `ActionTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Actions`
--

DROP TABLE IF EXISTS `Actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Actions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(400) NOT NULL DEFAULT 'zero two, darling, darling... DARLING !!!',
  `trigger` mediumtext NOT NULL DEFAULT 'Elle est où la pierre ?',
  `consequences` mediumtext DEFAULT 'DANS LA POCHE !!!',
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'The author of the current action',
  `tags` longtext DEFAULT NULL COMMENT 'The tags used to find the the actions the user created.',
  `running` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'L''information sur si le l''action est en fonctionnement',
  `description` varchar(2000) NOT NULL DEFAULT 'Some description' COMMENT 'The description of the workflow.',
  `colour` varchar(100) NOT NULL DEFAULT '#f1f1f1' COMMENT 'The colour of the workflow.',
  PRIMARY KEY (`id`),
  KEY `Actions_Users_FK` (`user_id`),
  CONSTRAINT `Actions_Users_FK` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='triggers and actions of ifttt\nexample: if bad_guy then nuts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Actions`
--

LOCK TABLES `Actions` WRITE;
/*!40000 ALTER TABLE `Actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ActiveOauths`
--

DROP TABLE IF EXISTS `ActiveOauths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ActiveOauths` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` mediumtext DEFAULT NULL COMMENT 'The token temporarily provided by the sso',
  `token_expiration` datetime DEFAULT current_timestamp() COMMENT 'The date when it expires',
  `token_lifespan` bigint(20) unsigned DEFAULT NULL COMMENT 'The time for which a token is alive before being invalidated',
  `refresh_link` varchar(2048) DEFAULT NULL COMMENT 'The link to be used to refresh the login token',
  `service_id` bigint(20) unsigned NOT NULL COMMENT 'The id of the service that is concerned',
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'The id of the user to which this token belongs to',
  PRIMARY KEY (`id`),
  KEY `ActiveOauths_Services_FK` (`service_id`),
  KEY `ActiveOauths_Users_FK` (`user_id`),
  CONSTRAINT `ActiveOauths_Services_FK` FOREIGN KEY (`service_id`) REFERENCES `Services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ActiveOauths_Users_FK` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The current OAuths that are still valid.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActiveOauths`
--

LOCK TABLES `ActiveOauths` WRITE;
/*!40000 ALTER TABLE `ActiveOauths` DISABLE KEYS */;
/*!40000 ALTER TABLE `ActiveOauths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Connections`
--

DROP TABLE IF EXISTS `Connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Connections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(900) DEFAULT NULL COMMENT 'The token of the user.',
  `user_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The e-mail of the user.',
  `expiration_date` datetime DEFAULT NULL COMMENT 'The date at which the token is invalidated.',
  PRIMARY KEY (`id`),
  KEY `Connections_Users_FK` (`user_id`),
  CONSTRAINT `Connections_Users_FK` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The active connections of the server.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Connections`
--

LOCK TABLES `Connections` WRITE;
/*!40000 ALTER TABLE `Connections` DISABLE KEYS */;
/*!40000 ALTER TABLE `Connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Services`
--

DROP TABLE IF EXISTS `Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL COMMENT 'The name of the service.',
  `url` varchar(2048) NOT NULL COMMENT 'The url that will be used to access the service.',
  `api_key` varchar(1024) DEFAULT NULL COMMENT 'The api token.',
  `category` varchar(200) NOT NULL COMMENT 'This is the type of service offered by the api.',
  `frequency` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The amount of times the service is used.',
  `type` varchar(200) NOT NULL DEFAULT 'service' COMMENT 'The type of the api.',
  `tags` longtext DEFAULT NULL COMMENT 'The keywords to search for the api',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `oauth` tinyint(1) DEFAULT NULL COMMENT 'Inform the code if the service is authenticated via OAuth.',
  `colour` varchar(1024) DEFAULT '#FFFFFF' COMMENT 'This is the colour used for the services.',
  `description` mediumtext DEFAULT NULL COMMENT 'The description for the service.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Services_UNIQUE_1` (`name`),
  UNIQUE KEY `Services_UNIQUE` (`url`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Info about the api''s and what they have to offer.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services`
--

LOCK TABLES `Services` WRITE;
/*!40000 ALTER TABLE `Services` DISABLE KEYS */;
INSERT INTO `Services` VALUES
(1,'google','https://www.googleapis.com','AIzaSyDQCfKgdSZFUHi3sVbjYpvoRYlq5bPGk0k','multi-service',0,'service','google service','2024-10-30 20:42:43',1,'#f4fefe','Discover Google, the essential search engine that organizes the world\'s information. Whether you\'re looking for news, tutorials, scientific articles, or videos, Google helps you find answers in seconds. Explore the Google universe to discover innovative products like YouTube, Gmail, and much more.'),
(2,'github','https://api.github.com','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','developer tools',0,'service','github service','2024-10-30 20:42:47',1,'#303030','Discord is a dynamic communication platform, perfect for communities and friends. Join themed servers where you can chat via text, voice, or video. Whether you\'re into gaming, tech, or just staying connected with friends, Discord makes communication easy and fun. Download Discord to explore its many features and create your own community space.'),
(3,'discord','https://discord.com/api','1300105402708394078','social media',0,'service','discord service','2024-10-30 20:42:53',1,'#5865F2','GitHub is the largest collaborative platform for developers, enabling teamwork on coding projects. Share code, manage projects, and discover solutions built by the community. GitHub provides powerful features for version control and open-source contributions, making software development accessible and collaborative for all.'),
(4,'spotify','https://api.spotify.com/v1','NULL','music',0,'service','spotify service','2024-10-30 20:42:59',1,'#1db954','Spotify is a world-renowned music streaming service, offering access to millions of songs, podcasts, and personalized playlists. Discover new artists, listen to your favorite tracks, and enjoy a seamless listening experience on all your devices. Download Spotify to dive into the world of music and find the soundtrack to your life.'),
(5,'time','https://timeapi.io','NULL','time',0,'service','time:api','2024-11-03 18:06:14',0,'#1db954','The service in charge of gathering the time.'),
(6,'weather','https://api.weatherapi.com/v1','ba625b1d83ac4af2bc9195516242909','weather',0,'service','weather:api','2024-11-03 18:07:53',0,'#1db954','The service in charge of the gathering the weather.'),
(7,'ntfy','https://ntfy.sh','NULL','notification',0,'service','ntfy:api:notification','2024-11-03 18:20:33',0,'#00FF00','The service in charge of sending a notification to the user on the ntfy app.'),
(8,'bitcoin','https://api.coindesk.com',NULL,'currency',0,'service','currency:bitcoin:api','2024-11-02 16:57:37',0,'#1db954','The service in charge of gathering information about bitcoin.\nThe service in charge of sending e-mails\nThe service in charge gathering data from the nasa api'),
(9,'nasa','https://api.nasa.gov','1hoCdrKvMZ51NkfHh5UbSal2c95NeGkc6CmNnJTL','nasa',0,'service','nasa:api:info','2024-11-02 17:35:19',0,'#0000FF','The service in charge gathering data from the nasa api.'),
(10,'sms','https://textbelt.com','ee425ac4740f34a038ea880509c025e6e76d11d8d8WWH1VzOLtk4mlRiX6hrf65i','sms',0,'service','sms:sending:api','2024-11-05 14:38:26',0,'#0F0FFF','The service in charge of sending sms\'s.'),
(11,'dad jokes','https://official-joke-api.appspot.com',NULL,'dad jokes',0,'service','dad:jokes:api','2024-11-05 14:58:40',0,'#FFF0F0','The service in chage of making you laugh, or not because dad jokes aren\'t usually that fun.'),
(12,'telegram','https://api.telegram.org','7750459962:AAHQdfE32dul89-jgKBl8ky-kGtZga_6jyc','telegram bot',0,'service','telegram:bot:messaging','2024-11-05 22:09:32',0,'#0088CC','The service in charge of providing a telegram bot to the server.'),
(13,'spoonacular','https://api.spoonacular.com','606618e63a64482585f37a1e658a0586','food info',0,'service','food:recommendation:api:info','2024-11-05 23:19:41',0,'#00843c','The service in charge of giving you nutritional info and delicious recipies.'),
(14,'Pushover','https://api.pushover.net/1','apu7in8rkgcakxy1wumuw9qou3fbh6','notification',0,'service','notification','2025-02-06 20:24:50',0,'#1db954','A service to get notifications');
/*!40000 ALTER TABLE `Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserOauthConnection`
--

DROP TABLE IF EXISTS `UserOauthConnection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserOauthConnection` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `provider_name` mediumtext NOT NULL COMMENT 'The name of the service provider.',
  `client_id` mediumtext NOT NULL COMMENT 'The id of the initial account that allows us to start the OAuth process, here noreply-terarea@gmail.com.',
  `client_secret` mediumtext NOT NULL COMMENT 'The secret of the initial account that allows us to start the OAuth process, here noreply-terarea@gmail.com.',
  `provider_scope` mediumtext NOT NULL COMMENT 'The information that is queried from the provider.',
  `authorisation_base_url` varchar(2048) NOT NULL COMMENT 'The url that allows the front-end to spawn a login page with the provider.',
  `token_grabber_base_url` varchar(2048) NOT NULL COMMENT 'The link allowing the backend to get the information returned by the provider during the login.',
  `user_info_base_url` varchar(2048) NOT NULL COMMENT 'Get the user info.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserOauthConnection_UNIQUE_1` (`provider_name`) USING HASH,
  UNIQUE KEY `UserOauthConnection_UNIQUE_2` (`client_id`) USING HASH,
  UNIQUE KEY `UserOauthConnection_UNIQUE` (`client_secret`) USING HASH,
  UNIQUE KEY `UserOauthConnection_UNIQUE_3` (`token_grabber_base_url`) USING HASH,
  UNIQUE KEY `UserOauthConnection_UNIQUE_4` (`user_info_base_url`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The table containing the information for the OAuths that will be used to allow users to log into their accounts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserOauthConnection`
--

LOCK TABLES `UserOauthConnection` WRITE;
/*!40000 ALTER TABLE `UserOauthConnection` DISABLE KEYS */;
INSERT INTO `UserOauthConnection` VALUES
(1,'google','797599558338-f00pkbq9al3rt49d10s9ggb5so18der8.apps.googleusercontent.com','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','email','https://accounts.google.com/o/oauth2/v2/auth','https://oauth2.googleapis.com/token','https://www.googleapis.com/oauth2/v1/userinfo'),
(2,'github','Ov23lipEL0GHD6nKkUgt','c9ee8ea9e494d1121057efe34fb5a2dfe68e8b3c','user:email','https://github.com/login/oauth/authorize','https://github.com/login/oauth/access_token','https://api.github.com/user/emails'),
(3,'discord','1300105402708394078','0anvO2U4tEt3cwQWRXDakRAkgfoIlpf3','identify+email','https://discord.com/oauth2/authorize','https://discord.com/api/oauth2/token','https://discord.com/api/users/@me'),
(4,'spotify','b7b1b92155c24fc1a6a5bdd561264ee5','0cbcad81cc134bc687c223f3de9f3a30','user-read-email','https://accounts.spotify.com/authorize','https://accounts.spotify.com/api/token','https://api.spotify.com/v1/me');
/*!40000 ALTER TABLE `UserOauthConnection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL COMMENT 'The user''s username.',
  `email` varchar(320) NOT NULL COMMENT 'The email that the user provided.',
  `password` varchar(1000) DEFAULT NULL COMMENT 'The hashed password of the user.',
  `method` varchar(200) DEFAULT NULL COMMENT 'The method the user used to log in: local, google, github, etc...',
  `favicon` varchar(900) DEFAULT NULL COMMENT 'The link to the icon of the user account.',
  `admin` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Informs the server if the user is an administrator or not.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Users_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The table in charge of tracking the user accounts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Verification`
--

DROP TABLE IF EXISTS `Verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Verification` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term` mediumtext DEFAULT NULL COMMENT 'This is the identification for the code reference.',
  `definition` mediumtext NOT NULL COMMENT 'This is the content you want to store, i.e: the verification code.',
  `expiration` datetime DEFAULT NULL COMMENT 'The time left before the code expires.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Verification_UNIQUE` (`definition`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This is the table in charge of storing the verification codes for user side events.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Verification`
--

LOCK TABLES `Verification` WRITE;
/*!40000 ALTER TABLE `Verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `Verification` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-11 11:03:07
