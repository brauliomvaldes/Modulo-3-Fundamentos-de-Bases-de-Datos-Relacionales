-- MySQL Script generated by MySQL Workbench
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema digiwallet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `digiwallet` DEFAULT CHARACTER SET utf8mb3 ;
USE `digiwallet` ;

-- -----------------------------------------------------
-- Table `digiwallet`.`users`
-- -----------------------------------------------------
-- SE SOLICTO:
-- Usuario: Representa a cada usuario individual del sistema de monedero virtual.
-- Atributos:
-- * user_id (clave primaria)
-- * nombre
-- * correo electrónico
-- * contraseña
-- * saldo.       <--- EXCLLUIDO, ESTE ATRIBUTO SE CREO LA TABLA ACCOUNTS

CREATE TABLE IF NOT EXISTS `digiwallet`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(100) NOT NULL,
  `user_lastname` VARCHAR(100) NOT NULL,
  `user_identity_number` VARCHAR(12) NOT NULL UNIQUE,
  `user_email` VARCHAR(100) NOT NULL,
  `user_username` VARCHAR(20) NOT NULL,
  `user_password_hash` VARCHAR(100) NOT NULL,
  `user_created_at` DATE NOT NULL,
  `user_age` TINYINT NOT NULL,
  `user_sex` TINYINT NOT NULL,
  `user_married` TINYINT NOT NULL,
  `user_has_contact` TINYINT NOT NULL,
  `user_state` TINYINT NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `digiwallet`.`banks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`banks` (
  `bank_id` INT NOT NULL AUTO_INCREMENT,
  `bank_nombre` VARCHAR(45) NOT NULL,
  `bank_state` TINYINT NOT NULL,
  PRIMARY KEY (`bank_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `digiwallet`.`currencies`
-- -----------------------------------------------------
-- SE SOLICTO:
-- Moneda: Representa las diferentes monedas que se pueden utilizar en el monedero virtual.
-- Atributos:
-- * currency_id (Primary Key)
-- * currency_name
-- * currency_symbol

CREATE TABLE IF NOT EXISTS `digiwallet`.`currencies` (
  `currency_id` INT NOT NULL AUTO_INCREMENT,
  `currency_name` VARCHAR(50) NOT NULL,
  `currency_symbol` VARCHAR(10) NOT NULL,
  `currency_state` TINYINT NOT NULL,
  PRIMARY KEY (`currency_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `digiwallet`.`types_of_accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`types_of_accounts` (
  `toa_id` INT NOT NULL AUTO_INCREMENT,
  `toa_name` VARCHAR(45) NOT NULL,
  `toa_state` TINYINT NOT NULL,
  PRIMARY KEY (`toa_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `digiwallet`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`accounts` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `account_user_id` INT NOT NULL,
  `account_number` VARCHAR(30) NOT NULL UNIQUE,
  `account_balance` FLOAT(12,2) NOT NULL,
  `account_currency_id` INT NOT NULL,
  `account_created_at` DATE NOT NULL,
  `account_type_id` INT NOT NULL,
  `account_bank_id` INT NOT NULL,
  `account_state` TINYINT NOT NULL,
  PRIMARY KEY (`account_id`),
  CONSTRAINT `fk_account_user`
    FOREIGN KEY (`account_user_id`)
    REFERENCES `digiwallet`.`users` (`user_id`),
  CONSTRAINT `fk_bank`
    FOREIGN KEY (`account_bank_id`)
    REFERENCES `digiwallet`.`banks` (`bank_id`),
  CONSTRAINT `fk_currency`
    FOREIGN KEY (`account_currency_id`)
    REFERENCES `digiwallet`.`currencies` (`currency_id`),
  CONSTRAINT `fk_type_account`
    FOREIGN KEY (`account_type_id`)
    REFERENCES `digiwallet`.`types_of_accounts` (`toa_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_account_user` ON `digiwallet`.`accounts` (`account_user_id` ASC) VISIBLE;
CREATE INDEX `fk_currency` ON `digiwallet`.`accounts` (`account_currency_id` ASC) VISIBLE;
CREATE INDEX `fk_bank` ON `digiwallet`.`accounts` (`account_bank_id` ASC) VISIBLE;
CREATE INDEX `fk_type_account` ON `digiwallet`.`accounts` (`account_type_id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `digiwallet`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `digiwallet`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`countries` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `digiwallet`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address_street` VARCHAR(45) NOT NULL,
  `address_city_id` INT NOT NULL,
  `address_country_id` INT NOT NULL,
  `address_phone_number` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`address_id`),
  CONSTRAINT `fk_city`
    FOREIGN KEY (`address_city_id`)
    REFERENCES `digiwallet`.`cities` (`city_id`),
  CONSTRAINT `fk_country`
    FOREIGN KEY (`address_country_id`)
    REFERENCES `digiwallet`.`countries` (`country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_country` ON `digiwallet`.`address` (`address_country_id` ASC) VISIBLE;
CREATE INDEX `fk_city` ON `digiwallet`.`address` (`address_city_id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `digiwallet`.`transactions`
-- -----------------------------------------------------
-- SE SOLICTO:
-- Transacción: Representa cada transacción financiera realizada por los usuarios.
-- Atributos:
-- * transaction_id (Primary Key)
-- * sender_user_id (Foreign Key referenciando a User)
-- * receiver_user_id (Foreign Key referenciando a User)
-- * importe
-- * transaction_date.

CREATE TABLE IF NOT EXISTS `digiwallet`.`transactions` (
  `tr_id` INT NOT NULL AUTO_INCREMENT,
  `tr_number` VARCHAR(20) NOT NULL,
  `tr_sender_user_id` INT NOT NULL,
  `tr_receiver_user_id` INT NOT NULL,
  `tr_amount_sender` FLOAT(12,2) NOT NULL,
  `tr_amount_receiver` FLOAT(12,2) NOT NULL,
  `tr_date` DATE NOT NULL,
  `tr_detail` VARCHAR(100) NOT NULL,
  `tr_currency_sender_id` INT NOT NULL, 
  `tr_currency_receiver_id` INT NOT NULL, 
  `tr_state` TINYINT NOT NULL,
  PRIMARY KEY (`tr_id`),
  CONSTRAINT `fk_receiver_user`
    FOREIGN KEY (`tr_receiver_user_id`)
    REFERENCES `digiwallet`.`users` (`user_id`),
  CONSTRAINT `fk_sender_user`
    FOREIGN KEY (`tr_sender_user_id`)
    REFERENCES `digiwallet`.`users` (`user_id`),
  CONSTRAINT `fk_tr_currency_s`
    FOREIGN KEY (`tr_currency_sender_id`)
    REFERENCES `digiwallet`.`currencies` (`currency_id`),
  CONSTRAINT `fk_tr_currency_r`
    FOREIGN KEY (`tr_currency_receiver_id`)
    REFERENCES `digiwallet`.`currencies` (`currency_id`))
    
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_sender_user` ON `digiwallet`.`transactions` (`tr_sender_user_id` ASC) VISIBLE;
CREATE INDEX `fk_receiver_user` ON `digiwallet`.`transactions` (`tr_receiver_user_id` ASC) VISIBLE;
CREATE INDEX `fk_tr_currency_s` ON `digiwallet`.`transactions` (`tr_currency_sender_id` ASC) VISIBLE;
CREATE INDEX `fk_tr_currency_r` ON `digiwallet`.`transactions` (`tr_currency_receiver_id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `digiwallet`.`contacs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`contacs` (
  `contac_id` INT NOT NULL AUTO_INCREMENT,
  `contact_id_principal` INT NOT NULL,
  `contact_id_referred` INT NOT NULL,
  `contact_state` TINYINT NOT NULL,
  PRIMARY KEY (`contac_id`),
  CONSTRAINT `fk_principal`
    FOREIGN KEY (`contact_id_principal`)
    REFERENCES `digiwallet`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_referred`
    FOREIGN KEY (`contact_id_referred`)
    REFERENCES `digiwallet`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_contact_principal_idx` ON `digiwallet`.`contacs` (`contact_id_principal` ASC) VISIBLE;
CREATE INDEX `fk_referred_idx` ON `digiwallet`.`contacs` (`contact_id_referred` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `digiwallet`.`users_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digiwallet`.`users_address` (
  `ua_id` INT NOT NULL AUTO_INCREMENT,
  `ua_user_id` INT NOT NULL,
  `ua_address_id` INT NOT NULL,
  `ua_state` TINYINT NOT NULL,
  PRIMARY KEY (`ua_id`),
  CONSTRAINT `fk_address_id`
    FOREIGN KEY (`ua_address_id`)
    REFERENCES `digiwallet`.`address` (`address_id`),
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`ua_user_id`)
    REFERENCES `digiwallet`.`users` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_user_id` ON `digiwallet`.`users_address` (`ua_user_id` ASC) VISIBLE;
CREATE INDEX `fk_address_id` ON `digiwallet`.`users_address` (`ua_address_id` ASC) VISIBLE;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- En lo general, se mantuvieron los requerimientos pero se agregaron y omitiron 
-- campos, por ejemplo para evitar eliminar y perder información, se creo campo
-- estado (state) para desactivar movimientos, también, las tablas adicionales
-- se pensaron para un futuro uso si así se estima necesario.

-- -----------------------------------------------------------------------
-- creación de funciones y procedimientos para trabajar con las tablas
-- ----------------------------------------------------------------------- 
-- quitANDo modo estructo para crear o utilizar función y procedimientos
SET global log_bin_trust_function_creators=1;
-- funcion para generar número de transacción aleatorio
delimiter ||
CREATE DEFINER=`root`@`localhost` FUNCTION `gen_tr_number`() 
RETURNS VARCHAR(20)
BEGIN
RETURN (SELECT (REPLACE(RAND(),'.','')));
END;
||
-- fin function 

-- función para recuperar id moneda 
delimiter ||
CREATE DEFINER=`root`@`localhost` FUNCTION `get_currency_id`(id INTEGER) 
RETURNS INTEGER
BEGIN
RETURN (SELECT account_currency_id FROM accounts INNER JOIN users
		ON account_user_id = user_id WHERE user_id = id LIMIT 1);
END;
||
-- fin function

-- procedimiento para actualizar balance por transacciones
delimiter ||
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_balance`
(amount_s FLOAT(12,2), amount_r FLOAT(12,2), id_sender INTEGER, id_receiver INTEGER)
BEGIN
    UPDATE accounts SET account_balance = ROUND((account_balance - amount_s),2) 
    WHERE account_user_id = id_sender;
	UPDATE accounts SET account_balance = ROUND((account_balance + amount_r),2) 
    WHERE account_user_id = id_receiver;
END;
||
-- fin procedimiento

-- procedimiento para reversar fondos al balance 
delimiter ||
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_balance`
(amount_s FLOAT(12,2), amount_r FLOAT(12,2), id_sender INTEGER, id_receiver INTEGER)
BEGIN
    UPDATE accounts SET account_balance = ROUND((account_balance + amount_s),2) 
    WHERE account_user_id = id_sender;
	UPDATE accounts SET account_balance = ROUND((account_balance - amount_r),2) 
    WHERE account_user_id = id_receiver;
END;
||
-- fin procedimiento

-- procedimiento para depositar mismo usuario con mas de una cuenta
delimiter ||
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_deposit`
(amount FLOAT(12,2), id_account_s VARCHAR(30), id_account_r VARCHAR(30))
BEGIN
    UPDATE accounts SET account_balance = ROUND((account_balance - amount),2) 
    WHERE account_id = id_account_s;
    
	UPDATE accounts SET account_balance = ROUND((account_balance + amount),2) 
    WHERE account_id = id_account_r;
END;
||
-- fin procedimiento

