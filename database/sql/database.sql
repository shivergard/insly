-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.41-0ubuntu0.14.04.1 - (Ubuntu)
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table insly.activity_log
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int(10) unsigned NOT NULL,
  `creator_id` int(10) unsigned NOT NULL,
  `action` enum('create','update') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'create',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_person_id_foreign` (`person_id`),
  KEY `activity_log_creator_id_foreign` (`creator_id`),
  CONSTRAINT `activity_log_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `system_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `activity_log_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.activity_log: ~0 rows (approximately)
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;


-- Dumping structure for table insly.address
CREATE TABLE IF NOT EXISTS `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int(10) unsigned NOT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address_person_id_foreign` (`person_id`),
  CONSTRAINT `address_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.address: ~0 rows (approximately)
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;


-- Dumping structure for table insly.education
CREATE TABLE IF NOT EXISTS `education` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(10) unsigned NOT NULL,
  `edu_instance_id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `education_language_id_foreign` (`language_id`),
  KEY `education_edu_instance_id_foreign` (`edu_instance_id`),
  KEY `education_person_id_foreign` (`person_id`),
  CONSTRAINT `education_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `education_edu_instance_id_foreign` FOREIGN KEY (`edu_instance_id`) REFERENCES `instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `education_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.education: ~0 rows (approximately)
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
/*!40000 ALTER TABLE `education` ENABLE KEYS */;


-- Dumping structure for table insly.instance
CREATE TABLE IF NOT EXISTS `instance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instance_language_id_foreign` (`language_id`),
  KEY `instance_person_id_foreign` (`person_id`),
  KEY `instance_name_index` (`name`),
  CONSTRAINT `instance_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `instance_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.instance: ~0 rows (approximately)
/*!40000 ALTER TABLE `instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance` ENABLE KEYS */;


-- Dumping structure for table insly.introduction
CREATE TABLE IF NOT EXISTS `introduction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `introduction_language_id_foreign` (`language_id`),
  KEY `introduction_person_id_foreign` (`person_id`),
  CONSTRAINT `introduction_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `introduction_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.introduction: ~0 rows (approximately)
/*!40000 ALTER TABLE `introduction` DISABLE KEYS */;
/*!40000 ALTER TABLE `introduction` ENABLE KEYS */;


-- Dumping structure for table insly.language
CREATE TABLE IF NOT EXISTS `language` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.language: ~0 rows (approximately)
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
/*!40000 ALTER TABLE `language` ENABLE KEYS */;


-- Dumping structure for table insly.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.migrations: ~10 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`migration`, `batch`) VALUES
	('2014_10_12_000000_create_users_table', 1),
	('2014_10_12_100000_create_password_resets_table', 1),
	('2016_10_02_101718_Clients', 1),
	('2016_10_02_145609_Address', 1),
	('2016_10_02_151114_Language', 1),
	('2016_10_02_151434_Introduction', 1),
	('2016_10_02_151506_Company', 1),
	('2016_10_02_152002_WorkExperience', 1),
	('2016_10_02_153940_Education', 1),
	('2016_10_02_161546_ActivityLog', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;


-- Dumping structure for table insly.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;


-- Dumping structure for table insly.persons
CREATE TABLE IF NOT EXISTS `persons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `birth_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `person_ident` int(11) NOT NULL,
  `creator_id` int(10) unsigned NOT NULL,
  `is_employee` tinyint(1) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `persons_email_unique` (`email`),
  KEY `persons_person_ident_index` (`person_ident`),
  KEY `persons_creator_id_foreign` (`creator_id`),
  CONSTRAINT `persons_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `system_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.persons: ~0 rows (approximately)
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;


-- Dumping structure for table insly.system_users
CREATE TABLE IF NOT EXISTS `system_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_users_person_id_index` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.system_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `system_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_users` ENABLE KEYS */;


-- Dumping structure for table insly.work_experience
CREATE TABLE IF NOT EXISTS `work_experience` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `work_experience_language_id_foreign` (`language_id`),
  KEY `work_experience_company_id_foreign` (`company_id`),
  KEY `work_experience_person_id_foreign` (`person_id`),
  CONSTRAINT `work_experience_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `work_experience_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `work_experience_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table insly.work_experience: ~0 rows (approximately)
/*!40000 ALTER TABLE `work_experience` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_experience` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
