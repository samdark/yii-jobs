SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE  TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL COMMENT 'User name (nickname, etc)' ,
  `email` VARCHAR(225) NOT NULL COMMENT 'User email' ,
  `password` CHAR(64) NOT NULL COMMENT 'Password hash' ,
  `salt` CHAR(64) NOT NULL COMMENT 'Salt for security purposes' ,
  `created_at` TIMESTAMP NOT NULL DEFAULT NOW() COMMENT 'User created timestamp' ,
  `updated_at` TIMESTAMP NOT NULL COMMENT 'User updated timestamp' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `email_UNIQUE` ON `user` (`email` ASC) ;


-- -----------------------------------------------------
-- Table `user_properties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_properties` ;

CREATE  TABLE IF NOT EXISTS `user_properties` (
  `user_id` INT NOT NULL COMMENT 'User ID' ,
  `surname` VARCHAR(45) NOT NULL COMMENT 'User Surname' ,
  `icq` VARCHAR(45) NOT NULL COMMENT 'User ICQ number\n' ,
  `skype` VARCHAR(45) NOT NULL COMMENT 'User skype account' ,
  `jabber` VARCHAR(45) NOT NULL COMMENT 'User jabber account' ,
  `url` VARCHAR(45) NOT NULL COMMENT 'User website' ,
  `company` VARCHAR(45) NOT NULL COMMENT 'User company name' ,
  PRIMARY KEY (`user_id`) ,
  CONSTRAINT `user`
    FOREIGN KEY (`user_id` )
    REFERENCES `user` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `user_idx` ON `user_properties` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `role` ;

CREATE  TABLE IF NOT EXISTS `role` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` INT NOT NULL COMMENT 'Role name' ,
  `created_at` TIMESTAMP NOT NULL DEFAULT NOW() ,
  `updated_at` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `job_properties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_properties` ;

CREATE  TABLE IF NOT EXISTS `job_properties` (
  `job_id` INT NOT NULL ,
  `descripton_long` TEXT NOT NULL COMMENT 'Long job description' ,
  PRIMARY KEY (`job_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job` ;

CREATE  TABLE IF NOT EXISTS `job` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(255) NOT NULL COMMENT 'Job title' ,
  `type` ENUM('fulltime','contract','freelance') NOT NULL COMMENT 'Job type' ,
  `description_short` VARCHAR(1024) NOT NULL COMMENT 'Job short description. Full text is stored separately.' ,
  `tags` VARCHAR(255) NOT NULL COMMENT 'Tags list\n' ,
  `price` FLOAT NOT NULL COMMENT 'price' ,
  `expires` TIMESTAMP NOT NULL COMMENT 'Expiration date' ,
  `created_at` TIMESTAMP NOT NULL DEFAULT NOW() ,
  `updated_at` TIMESTAMP NOT NULL ,
  `status` TINYINT UNSIGNED NOT NULL COMMENT 'Job status.' ,
  `author_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_Job_User1`
    FOREIGN KEY (`author_id` )
    REFERENCES `user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_job_job_properties1`
    FOREIGN KEY (`id` )
    REFERENCES `job_properties` (`job_id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Job_User1_idx` ON `job` (`author_id` ASC) ;


-- -----------------------------------------------------
-- Table `tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tag` ;

CREATE  TABLE IF NOT EXISTS `tag` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(45) NOT NULL COMMENT 'Tag title' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `title_UNIQUE` ON `tag` (`title` ASC) ;


-- -----------------------------------------------------
-- Table `job_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_tag` ;

CREATE  TABLE IF NOT EXISTS `job_tag` (
  `job_id` INT NOT NULL ,
  `tag_id` INT NOT NULL ,
  PRIMARY KEY (`job_id`, `tag_id`) ,
  CONSTRAINT `fk_job_has_tag_job1`
    FOREIGN KEY (`job_id` )
    REFERENCES `job` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_job_has_tag_tag1`
    FOREIGN KEY (`tag_id` )
    REFERENCES `tag` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_job_has_tag_tag1_idx` ON `job_tag` (`tag_id` ASC) ;

CREATE INDEX `fk_job_has_tag_job1_idx` ON `job_tag` (`job_id` ASC) ;


-- -----------------------------------------------------
-- Table `user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_role` ;

CREATE  TABLE IF NOT EXISTS `user_role` (
  `user_id` INT NOT NULL ,
  `role_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`, `role_id`) ,
  CONSTRAINT `fk_user_has_role_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `user` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_role_role1`
    FOREIGN KEY (`role_id` )
    REFERENCES `role` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_has_role_role1_idx` ON `user_role` (`role_id` ASC) ;

CREATE INDEX `fk_user_has_role_user1_idx` ON `user_role` (`user_id` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
