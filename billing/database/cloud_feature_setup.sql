-- ============================================================
-- Cloud Feature Setup
-- ============================================================

-- 1. Add is_cloud column to prod_bill
ALTER TABLE prod_bill ADD COLUMN IF NOT EXISTS `is_cloud` TINYINT NOT NULL DEFAULT 0;

-- 2. Cloud subscription tracker (one per bill)
CREATE TABLE IF NOT EXISTS `prod_cloud_bill` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bill_id`     INT NOT NULL,
  `customer_id` INT NOT NULL DEFAULT 0,
  `is_closed`   TINYINT NOT NULL DEFAULT 0,
  `closed_date` DATE DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bill_id` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Monthly client cloud payment records
CREATE TABLE IF NOT EXISTS `prod_cloud_bill_payment` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bill_id`     INT NOT NULL,
  `customer_id` INT NOT NULL DEFAULT 0,
  `year`        INT NOT NULL,
  `month`       INT NOT NULL,
  `paid_amount` DOUBLE NOT NULL DEFAULT 0,
  `paid_date`   DATE DEFAULT NULL,
  `is_paid`     TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bill_year_month` (`bill_id`, `year`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Monthly cloud settlement I pay to cloud provider
CREATE TABLE IF NOT EXISTS `cloud_paid` (
  `id`           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `year`         INT NOT NULL,
  `month`        INT NOT NULL,
  `cloud_amount` DOUBLE NOT NULL DEFAULT 0,
  `updated_date` DATE DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_year_month` (`year`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
