-- Ledger table for tracking cash in (billing receipts) and cash out (expenses)
CREATE TABLE IF NOT EXISTS `prod_ledger` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `entry_date_time` datetime NOT NULL,
  `content` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `is_receipt` tinyint NOT NULL DEFAULT '1' COMMENT '1=billing receipt, 0=expense',
  `ref_id` int DEFAULT NULL COMMENT 'bill_id or expense_entry_id',
  `uid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
