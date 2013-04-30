SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL COMMENT 'User name (nickname, etc)' ,
  `email` VARCHAR(45) NOT NULL COMMENT 'User email' ,
  `password` VARCHAR(32) NOT NULL COMMENT 'Password hash' ,
  `created` TIMESTAMP NOT NULL DEFAULT NOW() COMMENT 'User created timestamp' ,
  `updated` TIMESTAMP NOT NULL COMMENT 'User updated timestamp' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `email_UNIQUE` ON `mydb`.`User` (`email` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`UserProperties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`UserProperties` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`UserProperties` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL COMMENT 'User ID' ,
  `surname` VARCHAR(45) NOT NULL COMMENT 'User Surname' ,
  `icq` VARCHAR(45) NOT NULL COMMENT 'User ICQ number\n' ,
  `skype` VARCHAR(45) NOT NULL COMMENT 'User skype account' ,
  `jabber` VARCHAR(45) NOT NULL COMMENT 'User jabber account' ,
  `www` VARCHAR(45) NOT NULL COMMENT 'User website' ,
  `company` VARCHAR(45) NOT NULL COMMENT 'User company name' ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `user`
    FOREIGN KEY (`user_id` )
    REFERENCES `mydb`.`User` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `user_idx` ON `mydb`.`UserProperties` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Role` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Role` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` INT NOT NULL COMMENT 'Role name' ,
  `created` TIMESTAMP NOT NULL ,
  `updated` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`UserRole` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`UserRole` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `role_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `user`
    FOREIGN KEY (`user_id` )
    REFERENCES `mydb`.`User` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `role`
    FOREIGN KEY (`role_id` )
    REFERENCES `mydb`.`Role` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `user_idx` ON `mydb`.`UserRole` (`user_id` ASC) ;

CREATE INDEX `role_idx` ON `mydb`.`UserRole` (`role_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Job` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Job` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(255) NOT NULL COMMENT 'Job title' ,
  `type` ENUM('fulltime','contract','freelance') NOT NULL COMMENT 'Job type' ,
  `description` VARCHAR(255) NOT NULL COMMENT 'Job short description. Full text is stored separately.' ,
  `tags` VARCHAR(255) NOT NULL COMMENT 'Tags list\n' ,
  `price` FLOAT NOT NULL COMMENT 'price' ,
  `expires` TIMESTAMP NOT NULL COMMENT 'Expiration date' ,
  `created` TIMESTAMP NOT NULL ,
  `updated` TIMESTAMP NOT NULL ,
  `status` INT NOT NULL COMMENT 'Job status.' ,
  `author_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_Job_User1`
    FOREIGN KEY (`author_id` )
    REFERENCES `mydb`.`User` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Job_User1_idx` ON `mydb`.`Job` (`author_id` ASC) ;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
