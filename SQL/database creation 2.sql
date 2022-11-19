-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema heroku_e87e366c90dde4a
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema heroku_e87e366c90dde4a
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `heroku_e87e366c90dde4a` DEFAULT CHARACTER SET utf8 ;
USE `heroku_e87e366c90dde4a` ;

-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`PersonalIdTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`PersonalIdTypes` (
  `PersonalIdTypeId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`PersonalIdTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Users` (
  `UserId` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `LastName1` NVARCHAR(50) NOT NULL,
  `LastName2` NVARCHAR(50) NOT NULL,
  `Email` NVARCHAR(100) NULL,
  `Birthdate` DATE NULL,
  `VaccinationCount` TINYINT(1) NULL,
  `Password` VARBINARY(50) NULL,
  `PersonalIdTypeId` INT NOT NULL,
  `Personald` VARCHAR(45) NULL,
  `Admin` TINYINT(1) NULL,
  PRIMARY KEY (`UserId`),
  INDEX `fk_Users_PersonalIdTypes1_idx` (`PersonalIdTypeId` ASC) ,
  CONSTRAINT `fk_Users_PersonalIdTypes1`
    FOREIGN KEY (`PersonalIdTypeId`)
    REFERENCES `heroku_e87e366c90dde4a`.`PersonalIdTypes` (`PersonalIdTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Participants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Participants` (
  `ParticipantId` INT NOT NULL AUTO_INCREMENT,
  `ParticipantName` NVARCHAR(100) NULL,
  PRIMARY KEY (`ParticipantId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Movies` (
  `MovieId` BIGINT NOT NULL AUTO_INCREMENT,
  `Title` NVARCHAR(50) NULL,
  `Year` INT NULL,
  `MinAge` TINYINT NULL,
  `Duration` TIME NULL,
  `ParticipantId` INT NOT NULL,
  `PictureURL` VARCHAR(500) NULL,
  PRIMARY KEY (`MovieId`),
  INDEX `fk_Movies_Participants1_idx` (`ParticipantId` ASC) ,
  CONSTRAINT `fk_Movies_Participants1`
    FOREIGN KEY (`ParticipantId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Participants` (`ParticipantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Genres` (
  `GenreId` INT NOT NULL AUTO_INCREMENT,
  `GenreName` VARCHAR(45) NULL,
  PRIMARY KEY (`GenreId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`GenresPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`GenresPerMovie` (
  `MovieId` BIGINT NOT NULL,
  `GenreId` INT NOT NULL,
  PRIMARY KEY (`MovieId`, `GenreId`),
  INDEX `fk_Movies_has_Genres_Genres1_idx` (`GenreId` ASC) ,
  INDEX `fk_Movies_has_Genres_Movies_idx` (`MovieId` ASC) ,
  CONSTRAINT `fk_Movies_has_Genres_Movies`
    FOREIGN KEY (`MovieId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movies_has_Genres_Genres1`
    FOREIGN KEY (`GenreId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Genres` (`GenreId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Languages` (
  `LanguageId` INT NOT NULL AUTO_INCREMENT,
  `LanguageName` VARCHAR(45) NULL,
  PRIMARY KEY (`LanguageId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`LanguagesPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`LanguagesPerMovie` (
  `LanguageId` INT NOT NULL,
  `MovieId` BIGINT NOT NULL,
  PRIMARY KEY (`LanguageId`, `MovieId`),
  INDEX `fk_Languages_has_Movies_Movies1_idx` (`MovieId` ASC) ,
  INDEX `fk_Languages_has_Movies_Languages1_idx` (`LanguageId` ASC) ,
  CONSTRAINT `fk_Languages_has_Movies_Languages1`
    FOREIGN KEY (`LanguageId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Languages` (`LanguageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Languages_has_Movies_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Prices` (
  `PriceId` INT NOT NULL AUTO_INCREMENT,
  `PriceTitle` VARCHAR(20) NULL,
  PRIMARY KEY (`PriceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`PriceHistoric`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`PriceHistoric` (
  `PriceHistoricId` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NULL,
  `Amount` DECIMAL(7,2) NULL,
  `PriceId` INT NOT NULL,
  PRIMARY KEY (`PriceHistoricId`, `PriceId`),
  INDEX `fk_PriceHistoric_Prices1_idx` (`PriceId` ASC) ,
  CONSTRAINT `fk_PriceHistoric_Prices1`
    FOREIGN KEY (`PriceId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Prices` (`PriceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`PricesPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`PricesPerMovie` (
  `PriceId` INT NOT NULL,
  `MovieId` BIGINT NOT NULL,
  PRIMARY KEY (`PriceId`, `MovieId`),
  INDEX `fk_Prices_has_Movies_Movies1_idx` (`MovieId` ASC) ,
  INDEX `fk_Prices_has_Movies_Prices1_idx` (`PriceId` ASC) ,
  CONSTRAINT `fk_Prices_has_Movies_Prices1`
    FOREIGN KEY (`PriceId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Prices` (`PriceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prices_has_Movies_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`FoodTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`FoodTypes` (
  `FoodTypeId` INT NOT NULL,
  `TypeName` VARCHAR(10) NULL,
  PRIMARY KEY (`FoodTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Foods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Foods` (
  `FoodId` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(100) NULL,
  `Quantity` SMALLINT(1) NULL,
  `Price` DECIMAL(7,2) NULL,
  `FoodTypeId` INT NOT NULL,
  PRIMARY KEY (`FoodId`),
  INDEX `fk_Foods_FoodTypes1_idx` (`FoodTypeId` ASC) ,
  CONSTRAINT `fk_Foods_FoodTypes1`
    FOREIGN KEY (`FoodTypeId`)
    REFERENCES `heroku_e87e366c90dde4a`.`FoodTypes` (`FoodTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`ParticipantsPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`ParticipantsPerMovie` (
  `MovieId` BIGINT NOT NULL,
  `ParticipantId` INT NOT NULL,
  PRIMARY KEY (`MovieId`, `ParticipantId`),
  INDEX `fk_Movies_has_Participants_Participants1_idx` (`ParticipantId` ASC) ,
  INDEX `fk_Movies_has_Participants_Movies1_idx` (`MovieId` ASC) ,
  CONSTRAINT `fk_Movies_has_Participants_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movies_has_Participants_Participants1`
    FOREIGN KEY (`ParticipantId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Participants` (`ParticipantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`ShoppingCarts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`ShoppingCarts` (
  `ShoppingCartsId` INT NOT NULL,
  `UserId` BIGINT NOT NULL,
  PRIMARY KEY (`ShoppingCartsId`),
  INDEX `fk_ShoppingCarts_Users1_idx` (`UserId` ASC) ,
  CONSTRAINT `fk_ShoppingCarts_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Users` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Provinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Provinces` (
  `ProvinceId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`ProvinceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Cinemas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Cinemas` (
  `CinemaId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` NVARCHAR(500) NULL,
  `ProvinceId` INT NOT NULL,
  PRIMARY KEY (`CinemaId`),
  INDEX `fk_Cinemas_Provinces1_idx` (`ProvinceId` ASC) ,
  CONSTRAINT `fk_Cinemas_Provinces1`
    FOREIGN KEY (`ProvinceId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Provinces` (`ProvinceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`CinemaRooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`CinemaRooms` (
  `CinemaRoomId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `CinemaId` INT NOT NULL,
  PRIMARY KEY (`CinemaRoomId`),
  INDEX `fk_CinemaRooms_Cinemas1_idx` (`CinemaId` ASC) ,
  CONSTRAINT `fk_CinemaRooms_Cinemas1`
    FOREIGN KEY (`CinemaId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Cinemas` (`CinemaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Functions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Functions` (
  `MovieId` BIGINT NOT NULL,
  `CinemaRoomId` INT NOT NULL,
  `FunctionId` BIGINT NOT NULL AUTO_INCREMENT,
  `FunctionDate` DATETIME(1) NOT NULL,
  `SelledSeat` TINYINT NOT NULL,
  `CinemaId` INT NOT NULL,
  `LanguageId` INT NOT NULL,
  INDEX `fk_CurrentMovies_Movies1_idx` (`MovieId` ASC) ,
  INDEX `fk_CurrentMovies_CinemaRooms1_idx` (`CinemaRoomId` ASC) ,
  PRIMARY KEY (`FunctionId`),
  INDEX `fk_Functions_Cinemas1_idx` (`CinemaId` ASC) ,
  INDEX `fk_Functions_Languages1_idx` (`LanguageId` ASC) ,
  CONSTRAINT `fk_CurrentMovies_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CurrentMovies_CinemaRooms1`
    FOREIGN KEY (`CinemaRoomId`)
    REFERENCES `heroku_e87e366c90dde4a`.`CinemaRooms` (`CinemaRoomId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Functions_Cinemas1`
    FOREIGN KEY (`CinemaId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Cinemas` (`CinemaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Functions_Languages1`
    FOREIGN KEY (`LanguageId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Languages` (`LanguageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Seats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Seats` (
  `SeatsId` INT NOT NULL AUTO_INCREMENT,
  `Position` VARCHAR(45) NULL,
  PRIMARY KEY (`SeatsId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`SeatsPerFunction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`SeatsPerFunction` (
  `FunctionId` BIGINT NOT NULL,
  `SeatsId` INT NOT NULL,
  `UserId` BIGINT NULL,
  `Avaliable` TINYINT NULL,
  PRIMARY KEY (`FunctionId`, `SeatsId`),
  INDEX `fk_Functions_has_Seats_Seats1_idx` (`SeatsId` ASC) ,
  INDEX `fk_Functions_has_Seats_Functions1_idx` (`FunctionId` ASC) ,
  INDEX `fk_SeatsPerFunction_Users1_idx` (`UserId` ASC) ,
  CONSTRAINT `fk_Functions_has_Seats_Functions1`
    FOREIGN KEY (`FunctionId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Functions` (`FunctionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Functions_has_Seats_Seats1`
    FOREIGN KEY (`SeatsId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Seats` (`SeatsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SeatsPerFunction_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Users` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`FoodsPerCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`FoodsPerCart` (
  `ShoppingCartsId` INT NOT NULL,
  `FoodId` INT NOT NULL,
  `Quantity` TINYINT NULL,
  INDEX `fk_ProductsPeroCart_ShoppingCarts1_idx` (`ShoppingCartsId` ASC) ,
  INDEX `fk_ProductsPeroCart_Foods1_idx` (`FoodId` ASC) ,
  CONSTRAINT `fk_ProductsPeroCart_ShoppingCarts1`
    FOREIGN KEY (`ShoppingCartsId`)
    REFERENCES `heroku_e87e366c90dde4a`.`ShoppingCarts` (`ShoppingCartsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductsPeroCart_Foods1`
    FOREIGN KEY (`FoodId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Foods` (`FoodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`TicketsPerCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`TicketsPerCart` (
  `ShoppingCartsId` INT NOT NULL,
  `FunctionId` BIGINT NOT NULL,
  `PriceId` INT NOT NULL,
  `Quantity` TINYINT NULL,
  INDEX `fk_TicketsPerCart_ShoppingCarts1_idx` (`ShoppingCartsId` ASC) ,
  INDEX `fk_TicketsPerCart_Functions1_idx` (`FunctionId` ASC) ,
  INDEX `fk_TicketsPerCart_Prices1_idx` (`PriceId` ASC) ,
  CONSTRAINT `fk_TicketsPerCart_ShoppingCarts1`
    FOREIGN KEY (`ShoppingCartsId`)
    REFERENCES `heroku_e87e366c90dde4a`.`ShoppingCarts` (`ShoppingCartsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TicketsPerCart_Functions1`
    FOREIGN KEY (`FunctionId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Functions` (`FunctionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TicketsPerCart_Prices1`
    FOREIGN KEY (`PriceId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Prices` (`PriceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`Vaccines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`Vaccines` (
  `VaccinesId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`VaccinesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_e87e366c90dde4a`.`VaccinesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_e87e366c90dde4a`.`VaccinesPerUser` (
  `VaccinesId` INT NOT NULL,
  `UserId` BIGINT NOT NULL,
  `Date` DATE NULL,
  INDEX `fk_Vaccines_has_Users_Users1_idx` (`UserId` ASC) ,
  INDEX `fk_Vaccines_has_Users_Vaccines1_idx` (`VaccinesId` ASC) ,
  CONSTRAINT `fk_Vaccines_has_Users_Vaccines1`
    FOREIGN KEY (`VaccinesId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Vaccines` (`VaccinesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vaccines_has_Users_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `heroku_e87e366c90dde4a`.`Users` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
