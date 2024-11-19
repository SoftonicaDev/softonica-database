-- MySQL Script generated by MySQL Workbench
-- Tue Nov 19 22:04:36 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema softonica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema softonica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `softonica` DEFAULT CHARACTER SET utf8 ;
USE `softonica` ;

-- -----------------------------------------------------
-- Table `softonica`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(42) NOT NULL,
  `password` CHAR(64) NOT NULL,
  `email` VARCHAR(128) NOT NULL,
  `active` BIT(1) NOT NULL DEFAULT 1,
  `locked` BIT(1) NOT NULL DEFAULT 0,
  `failures` TINYINT(3) NOT NULL DEFAULT 0,
  `lastlogon` DATETIME NULL,
  `created` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `name` VARCHAR(48) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `UserAccount_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserAccount`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`profiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`profiles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `fullname` VARCHAR(96) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `UserProfile_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserProfile`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`categories` (
  `id` INT NOT NULL,
  `userid` INT NULL,
  `type` CHAR(3) NOT NULL DEFAULT 'UNK',
  `name` VARCHAR(48) NOT NULL,
  `description` TEXT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `UserCategory_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserCategory`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `accountid` INT NOT NULL,
  `categoryid` INT NOT NULL,
  `amount` DOUBLE NOT NULL DEFAULT 0,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  `paid` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `UserTransaction_idx` (`userid` ASC) VISIBLE,
  INDEX `AccountTransaction_idx` (`accountid` ASC) VISIBLE,
  INDEX `CategoryTransaction_idx` (`categoryid` ASC) VISIBLE,
  CONSTRAINT `UserTransaction`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AccountTransaction`
    FOREIGN KEY (`accountid`)
    REFERENCES `softonica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CategoryTransaction`
    FOREIGN KEY (`categoryid`)
    REFERENCES `softonica`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NULL,
  `name` VARCHAR(48) NOT NULL,
  `background` CHAR(8) NOT NULL,
  `foreground` CHAR(8) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `UserTag_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserTag`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`projects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `name` VARCHAR(96) NOT NULL,
  `description` TEXT NOT NULL,
  `created` DATETIME NOT NULL,
  `updated` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  `active` BIT(1) NOT NULL DEFAULT 1,
  `website` VARCHAR(255) NULL,
  `documentation` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `UserProject_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserProject`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`assignments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NULL,
  `profileid` INT NULL,
  `tagid` INT NULL,
  `transactionid` INT NULL,
  `projectid` INT NULL,
  `created` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `UserAssignment_idx` (`userid` ASC) VISIBLE,
  INDEX `TagAssignment_idx` (`tagid` ASC) VISIBLE,
  INDEX `TransactionAssignment_idx` (`transactionid` ASC) VISIBLE,
  INDEX `ProfileAssignment_idx` (`profileid` ASC) VISIBLE,
  INDEX `ProjectAssignment_idx` (`projectid` ASC) VISIBLE,
  CONSTRAINT `UserAssignment`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TagAssignment`
    FOREIGN KEY (`tagid`)
    REFERENCES `softonica`.`tags` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TransactionAssignment`
    FOREIGN KEY (`transactionid`)
    REFERENCES `softonica`.`transactions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProfileAssignment`
    FOREIGN KEY (`profileid`)
    REFERENCES `softonica`.`profiles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProjectAssignment`
    FOREIGN KEY (`projectid`)
    REFERENCES `softonica`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`experiences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`experiences` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `categoryid` INT NOT NULL,
  `amount` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `CategoryExperience_idx` (`categoryid` ASC) VISIBLE,
  INDEX `UserExperience_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserExperience`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CategoryExperience`
    FOREIGN KEY (`categoryid`)
    REFERENCES `softonica`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`levels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`levels` (
  `level` TINYINT NOT NULL AUTO_INCREMENT,
  `from` DOUBLE NOT NULL DEFAULT 0,
  `to` DOUBLE NOT NULL DEFAULT 1000,
  PRIMARY KEY (`level`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`badges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`badges` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(48) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`achievements` (
  `id` INT NOT NULL,
  `userid` INT NOT NULL,
  `badgeid` INT NOT NULL,
  `created` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `UserAchievement_idx` (`userid` ASC) VISIBLE,
  INDEX `BadgeAchievement_idx` (`badgeid` ASC) VISIBLE,
  CONSTRAINT `UserAchievement`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BadgeAchievement`
    FOREIGN KEY (`badgeid`)
    REFERENCES `softonica`.`badges` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`notifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `message` VARCHAR(500) NOT NULL,
  `created` DATETIME NOT NULL,
  `read` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `UserNotification_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserNotification`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`contributors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`contributors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `projectid` INT NOT NULL,
  `userid` INT NOT NULL,
  `added` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `UserContributor_idx` (`userid` ASC) VISIBLE,
  INDEX `ProjectContributor_idx` (`projectid` ASC) VISIBLE,
  CONSTRAINT `ProjectContributor`
    FOREIGN KEY (`projectid`)
    REFERENCES `softonica`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UserContributor`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`skills` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` CHAR(4) NOT NULL,
  `name` VARCHAR(96) NOT NULL,
  `description` TEXT NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`skillsacquired`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`skillsacquired` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profileid` INT NOT NULL,
  `skillid` INT NOT NULL,
  `created` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `ProfileSkillAcquired_idx` (`profileid` ASC) VISIBLE,
  INDEX `SkillAcquired_idx` (`skillid` ASC) VISIBLE,
  CONSTRAINT `ProfileSkillAcquired`
    FOREIGN KEY (`profileid`)
    REFERENCES `softonica`.`profiles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SkillAcquired`
    FOREIGN KEY (`skillid`)
    REFERENCES `softonica`.`skills` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`services` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` CHAR(4) NOT NULL,
  `name` VARCHAR(48) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`repositories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`repositories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `projectid` INT NOT NULL,
  `serviceid` INT NOT NULL,
  `name` VARCHAR(96) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `notes` TEXT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `ProjectRepository_idx` (`projectid` ASC) VISIBLE,
  INDEX `ServiceRepository_idx` (`serviceid` ASC) VISIBLE,
  CONSTRAINT `ProjectRepository`
    FOREIGN KEY (`projectid`)
    REFERENCES `softonica`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ServiceRepository`
    FOREIGN KEY (`serviceid`)
    REFERENCES `softonica`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`organizations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `projectid` INT NOT NULL,
  `serviceid` INT NOT NULL,
  `name` VARCHAR(96) NOT NULL,
  `description` TEXT NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `ProjectOrganization_idx` (`projectid` ASC) VISIBLE,
  INDEX `ServiceOrganization_idx` (`serviceid` ASC) VISIBLE,
  CONSTRAINT `ProjectOrganization`
    FOREIGN KEY (`projectid`)
    REFERENCES `softonica`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ServiceOrganization`
    FOREIGN KEY (`serviceid`)
    REFERENCES `softonica`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`projectrequirements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`projectrequirements` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `projectid` INT NOT NULL,
  `skillid` INT NOT NULL,
  `created` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `ProjectRequirement_idx` (`projectid` ASC) VISIBLE,
  INDEX `ProjectRequirementSkill_idx` (`skillid` ASC) VISIBLE,
  CONSTRAINT `ProjectRequirement`
    FOREIGN KEY (`projectid`)
    REFERENCES `softonica`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProjectRequirementSkill`
    FOREIGN KEY (`skillid`)
    REFERENCES `softonica`.`skills` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`releases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`releases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `projectid` INT NOT NULL,
  `userid` INT NOT NULL,
  ` name` VARCHAR(96) NOT NULL,
  `description` TEXT NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `ProjectRelease_idx` (`projectid` ASC) VISIBLE,
  INDEX `UserRelease_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `ProjectRelease`
    FOREIGN KEY (`projectid`)
    REFERENCES `softonica`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UserRelease`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`resetpasswords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`resetpasswords` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `token` VARCHAR(800) NOT NULL,
  `expire` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `UserResetPassword_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserResetPassword`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `softonica`.`verifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `softonica`.`verifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `token` VARCHAR(800) NOT NULL,
  `expire` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `UserVerification_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `UserVerification`
    FOREIGN KEY (`userid`)
    REFERENCES `softonica`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;