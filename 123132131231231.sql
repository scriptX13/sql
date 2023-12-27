-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema phones_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema phones_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `phones_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `phones_store` ;

-- -----------------------------------------------------
-- Table `phones_store`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`brands` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 537
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 132
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`feature_values`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`feature_values` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone_id` INT NOT NULL,
  `feature_id` INT NOT NULL,
  `value` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `phone_id` (`phone_id` ASC) VISIBLE,
  INDEX `feature_id` (`feature_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`features` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `last_order_time` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `total_price` DECIMAL(10,2) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `phones_store`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`phones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(255) NOT NULL,
  `brand_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `brand_id` (`brand_id` ASC) VISIBLE,
  INDEX `category_id` (`category_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`order_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `phone_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `total_price` DECIMAL(10,2) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `phone_id` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `order_items_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `phones_store`.`orders` (`id`),
  CONSTRAINT `order_items_ibfk_2`
    FOREIGN KEY (`phone_id`)
    REFERENCES `phones_store`.`phones` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`order_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`order_statuses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `phones_store`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`reviews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `phone_id` INT NOT NULL,
  `text` TEXT NOT NULL,
  `rating` TINYINT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `phone_id` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `reviews_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `phones_store`.`users` (`id`),
  CONSTRAINT `reviews_ibfk_2`
    FOREIGN KEY (`phone_id`)
    REFERENCES `phones_store`.`phones` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `phones_store` ;

-- -----------------------------------------------------
-- Placeholder table for view `phones_store`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phones_store`.`order_details` (`order_id` INT, `user_name` INT, `phone_model` INT, `quantity` INT, `total_price` INT);

-- -----------------------------------------------------
-- procedure delete_order
-- -----------------------------------------------------

DELIMITER $$
USE `phones_store`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_order`(
    IN order_id INT,
    OUT deleted_rows INT
)
BEGIN
    DELETE FROM orders WHERE id = order_id;
    SET deleted_rows = ROW_COUNT();
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `phones_store`.`order_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `phones_store`.`order_details`;
USE `phones_store`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `phones_store`.`order_details` AS select `o`.`id` AS `order_id`,`u`.`name` AS `user_name`,`p`.`model` AS `phone_model`,`oi`.`quantity` AS `quantity`,`oi`.`total_price` AS `total_price` from (((`phones_store`.`orders` `o` join `phones_store`.`users` `u` on((`o`.`user_id` = `u`.`id`))) join `phones_store`.`order_items` `oi` on((`o`.`id` = `oi`.`order_id`))) join `phones_store`.`phones` `p` on((`oi`.`phone_id` = `p`.`id`)));
USE `phones_store`;

DELIMITER $$
USE `phones_store`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `phones_store`.`update_last_order_time`
AFTER INSERT ON `phones_store`.`orders`
FOR EACH ROW
UPDATE users SET last_order_time = CURRENT_TIMESTAMP WHERE id = NEW.user_id$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
