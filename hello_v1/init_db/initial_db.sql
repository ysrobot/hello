-- MySQL Script generated by MySQL Workbench
-- 08/24/16 21:15:40
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Blog_db` ;

-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Blog_db` DEFAULT CHARACTER SET utf8 ;
USE `Blog_db` ;

-- -----------------------------------------------------
-- Table `Blog_db`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blog_db`.`roles` ;

CREATE TABLE IF NOT EXISTS `Blog_db`.`roles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `default` TINYINT(1) NULL DEFAULT NULL,
  `permissions` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC),
  INDEX `ix_roles_default` (`default` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Blog_db`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blog_db`.`users` ;

CREATE TABLE IF NOT EXISTS `Blog_db`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(64) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `username` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `role_id` INT(11) NULL DEFAULT NULL,
  `password_hash` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `confirmed` TINYINT(1) NULL DEFAULT NULL,
  `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `location` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `about_me` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `member_since` DATETIME NULL DEFAULT NULL,
  `last_seen` DATETIME NULL DEFAULT NULL,
  `avatar_hash` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ix_users_email` (`email` ASC),
  UNIQUE INDEX `ix_users_username` (`username` ASC),
  INDEX `role_id` (`role_id` ASC),
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`role_id`)
    REFERENCES `Blog_db`.`roles` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 403
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Blog_db`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blog_db`.`posts` ;

CREATE TABLE IF NOT EXISTS `Blog_db`.`posts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `body` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `body_html` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `timestamp` DATETIME NULL DEFAULT NULL,
  `author_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `author_id` (`author_id` ASC),
  INDEX `ix_posts_timestamp` (`timestamp` ASC),
  CONSTRAINT `posts_ibfk_1`
    FOREIGN KEY (`author_id`)
    REFERENCES `Blog_db`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 401
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Blog_db`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blog_db`.`comments` ;

CREATE TABLE IF NOT EXISTS `Blog_db`.`comments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `body` TEXT NULL DEFAULT NULL,
  `body_html` TEXT NULL DEFAULT NULL,
  `timestamp` DATETIME NULL DEFAULT NULL,
  `disabled` TINYINT(1) NULL DEFAULT NULL,
  `author_id` INT(11) NULL DEFAULT NULL,
  `post_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `author_id` (`author_id` ASC),
  INDEX `post_id` (`post_id` ASC),
  INDEX `ix_comments_timestamp` (`timestamp` ASC),
  CONSTRAINT `comments_ibfk_1`
    FOREIGN KEY (`author_id`)
    REFERENCES `Blog_db`.`users` (`id`),
  CONSTRAINT `comments_ibfk_2`
    FOREIGN KEY (`post_id`)
    REFERENCES `Blog_db`.`posts` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Blog_db`.`follows`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blog_db`.`follows` ;

CREATE TABLE IF NOT EXISTS `Blog_db`.`follows` (
  `follower_id` INT(11) NOT NULL,
  `followed_id` INT(11) NOT NULL,
  `timestamp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`follower_id`, `followed_id`),
  INDEX `followed_id` (`followed_id` ASC),
  CONSTRAINT `follows_ibfk_1`
    FOREIGN KEY (`follower_id`)
    REFERENCES `Blog_db`.`users` (`id`),
  CONSTRAINT `follows_ibfk_2`
    FOREIGN KEY (`followed_id`)
    REFERENCES `Blog_db`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
