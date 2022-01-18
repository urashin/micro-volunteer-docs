-- MySQL Script generated by MySQL Workbench
-- Thu Jan  6 06:41:46 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema volunteerdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema volunteerdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `volunteerdb` DEFAULT CHARACTER SET utf8 ;
USE `volunteerdb` ;

-- -----------------------------------------------------
-- Table `volunteerdb`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`Users` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`Users` (
  `user_id` VARCHAR(64) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` VARCHAR(64) NULL,
  `email` VARCHAR(256) NULL,
  `password` VARCHAR(512) NULL,
  `status` INT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`CheckinArea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`CheckinArea` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`CheckinArea` (
  `area_id` INT NOT NULL AUTO_INCREMENT,
  `area_name` VARCHAR(45) NULL,
  `location` GEOMETRY NULL,
  `radius` INT NULL,
  `editor_id` VARCHAR(64) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`area_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`VolunteerHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`VolunteerHistory` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`VolunteerHistory` (
  `history_id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `location` GEOMETRY NULL,
  `area_id` INT NULL,
  `volunteer_id` VARCHAR(64) NOT NULL,
  `handicapped_id` VARCHAR(64) NOT NULL,
  `handicap_type` INT NULL,
  `handicap_level` INT NULL,
  `satisfaction` INT NULL,
  `thanks_comment` VARCHAR(256) NULL,
  `status` INT NULL,
  PRIMARY KEY (`history_id`),
  INDEX `user_id_idx` (`volunteer_id` ASC) VISIBLE,
  INDEX `handicapped_id_idx` (`handicapped_id` ASC) VISIBLE,
  INDEX `VolunteerHistory.area_id_idx` (`area_id` ASC) VISIBLE,
  CONSTRAINT `VolunteerHistory.volunteer_id`
    FOREIGN KEY (`volunteer_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `VolunteerHistory.handicapped_id`
    FOREIGN KEY (`handicapped_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `VolunteerHistory.area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `volunteerdb`.`CheckinArea` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`VolunteerSummary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`VolunteerSummary` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`VolunteerSummary` (
  `summary_id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `volunteer_id` VARCHAR(64) NULL,
  `handicap_type` INT NULL,
  `thanks_num` INT NULL,
  PRIMARY KEY (`summary_id`),
  INDEX `user_id_idx` (`volunteer_id` ASC) VISIBLE,
  CONSTRAINT `VolunteerSummary.volunteer_id`
    FOREIGN KEY (`volunteer_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`SnsId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`SnsId` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`SnsId` (
  `user_id` VARCHAR(64) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sns_id` VARCHAR(64) NOT NULL,
  `sns_type` INT NOT NULL,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  PRIMARY KEY (`sns_id`),
  CONSTRAINT `SnsId.user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`HandicapInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`HandicapInfo` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`HandicapInfo` (
  `handicapinfo_id` INT NOT NULL AUTO_INCREMENT,
  `handicapped_id` VARCHAR(64) NOT NULL,
  `handicap_type` INT NOT NULL,
  `handicap_level` INT NOT NULL,
  `reliability_th` INT NULL,
  `severity` INT NULL,
  `comment` VARCHAR(128) NULL,
  PRIMARY KEY (`handicapinfo_id`),
  INDEX `handicapped_id_idx` (`handicapped_id` ASC) VISIBLE,
  CONSTRAINT `HandicapInfo.handicapped_id`
    FOREIGN KEY (`handicapped_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`Session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`Session` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`Session` (
  `session_id` VARCHAR(128) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `Session.user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`Help`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`Help` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`Help` (
  `help_id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `handicapped_id` VARCHAR(64) NOT NULL,
  `volunteer_id` VARCHAR(64) NULL,
  `location` GEOMETRY NULL,
  `area_id` INT NULL,
  `handicap_type` INT NULL,
  `handicap_level` INT NULL,
  `reliability_th` INT NULL,
  `severity` INT NULL,
  `comment` VARCHAR(128) NULL,
  `status` INT NULL COMMENT '助けを呼ぶ',
  PRIMARY KEY (`help_id`),
  INDEX `handicapped_id_idx` (`handicapped_id` ASC) VISIBLE,
  INDEX `volunteer_id_idx` (`volunteer_id` ASC) VISIBLE,
  INDEX `Help.area_id_idx` (`area_id` ASC) VISIBLE,
  CONSTRAINT `Help.handicapped_id`
    FOREIGN KEY (`handicapped_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Help.volunteer_id`
    FOREIGN KEY (`volunteer_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Help.area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `volunteerdb`.`CheckinArea` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`MyGeometry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`MyGeometry` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`MyGeometry` (
  `user_id` VARCHAR(64) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location` GEOMETRY NOT NULL,
  `status` INT NOT NULL,
  `area_id` INT NULL,
  INDEX `area_id_idx` (`area_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `volunteerdb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `volunteerdb`.`CheckinArea` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteerdb`.`HandicapMaster`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteerdb`.`HandicapMaster` ;

CREATE TABLE IF NOT EXISTS `volunteerdb`.`HandicapMaster` (
  `handicap_type` INT NOT NULL,
  `handicap_level` INT NOT NULL,
  `comment` VARCHAR(512) NULL,
  `title` VARCHAR(45) NOT NULL,
  `icon_path` VARCHAR(512) NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;