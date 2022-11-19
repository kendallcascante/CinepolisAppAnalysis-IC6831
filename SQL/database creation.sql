-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema wkdhtgq1tnwejwox
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wkdhtgq1tnwejwox
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wkdhtgq1tnwejwox` DEFAULT CHARACTER SET utf8 ;
USE `wkdhtgq1tnwejwox` ;

-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`PersonalIdTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`PersonalIdTypes` (
  `PersonalIdTypeId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`PersonalIdTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Users` (
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
  INDEX `fk_Users_PersonalIdTypes1_idx` (`PersonalIdTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_PersonalIdTypes1`
    FOREIGN KEY (`PersonalIdTypeId`)
    REFERENCES `wkdhtgq1tnwejwox`.`PersonalIdTypes` (`PersonalIdTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Participants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Participants` (
  `ParticipantId` INT NOT NULL,
  `ParticipantName` NVARCHAR(100) NULL,
  PRIMARY KEY (`ParticipantId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Movies` (
  `MovieId` BIGINT NOT NULL,
  `Title` NVARCHAR(50) NULL,
  `Year` INT NULL,
  `MinAge` TINYINT NULL,
  `Duration` TIME NULL,
  `ParticipantId` INT NOT NULL,
  PRIMARY KEY (`MovieId`),
  INDEX `fk_Movies_Participants1_idx` (`ParticipantId` ASC) VISIBLE,
  CONSTRAINT `fk_Movies_Participants1`
    FOREIGN KEY (`ParticipantId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Participants` (`ParticipantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Genres` (
  `GenreId` INT NOT NULL,
  `GenreName` VARCHAR(45) NULL,
  PRIMARY KEY (`GenreId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`GenresPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`GenresPerMovie` (
  `MovieId` BIGINT NOT NULL,
  `GenreId` INT NOT NULL,
  PRIMARY KEY (`MovieId`, `GenreId`),
  INDEX `fk_Movies_has_Genres_Genres1_idx` (`GenreId` ASC) VISIBLE,
  INDEX `fk_Movies_has_Genres_Movies_idx` (`MovieId` ASC) VISIBLE,
  CONSTRAINT `fk_Movies_has_Genres_Movies`
    FOREIGN KEY (`MovieId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movies_has_Genres_Genres1`
    FOREIGN KEY (`GenreId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Genres` (`GenreId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Languages` (
  `LanguageId` INT NOT NULL,
  `LanguageName` VARCHAR(45) NULL,
  PRIMARY KEY (`LanguageId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`LanguagesPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`LanguagesPerMovie` (
  `LanguageId` INT NOT NULL,
  `MovieId` BIGINT NOT NULL,
  PRIMARY KEY (`LanguageId`, `MovieId`),
  INDEX `fk_Languages_has_Movies_Movies1_idx` (`MovieId` ASC) VISIBLE,
  INDEX `fk_Languages_has_Movies_Languages1_idx` (`LanguageId` ASC) VISIBLE,
  CONSTRAINT `fk_Languages_has_Movies_Languages1`
    FOREIGN KEY (`LanguageId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Languages` (`LanguageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Languages_has_Movies_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Prices` (
  `PriceId` INT NOT NULL,
  `PriceTitle` VARCHAR(20) NULL,
  PRIMARY KEY (`PriceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`PriceHistoric`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`PriceHistoric` (
  `PriceHistoricId` INT NOT NULL,
  `Date` DATETIME NULL,
  `Amount` DECIMAL(7,2) NULL,
  `PriceId` INT NOT NULL,
  PRIMARY KEY (`PriceHistoricId`, `PriceId`),
  INDEX `fk_PriceHistoric_Prices1_idx` (`PriceId` ASC) VISIBLE,
  CONSTRAINT `fk_PriceHistoric_Prices1`
    FOREIGN KEY (`PriceId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Prices` (`PriceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`PricesPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`PricesPerMovie` (
  `PriceId` INT NOT NULL,
  `MovieId` BIGINT NOT NULL,
  PRIMARY KEY (`PriceId`, `MovieId`),
  INDEX `fk_Prices_has_Movies_Movies1_idx` (`MovieId` ASC) VISIBLE,
  INDEX `fk_Prices_has_Movies_Prices1_idx` (`PriceId` ASC) VISIBLE,
  CONSTRAINT `fk_Prices_has_Movies_Prices1`
    FOREIGN KEY (`PriceId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Prices` (`PriceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prices_has_Movies_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`FoodTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`FoodTypes` (
  `FoodTypeId` INT NOT NULL,
  `TypeName` VARCHAR(10) NULL,
  PRIMARY KEY (`FoodTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Foods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Foods` (
  `FoodId` INT NOT NULL,
  `Name` NVARCHAR(100) NULL,
  `Quantity` SMALLINT(1) NULL,
  `Price` DECIMAL(7,2) NULL,
  `FoodTypeId` INT NOT NULL,
  PRIMARY KEY (`FoodId`),
  INDEX `fk_Foods_FoodTypes1_idx` (`FoodTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_Foods_FoodTypes1`
    FOREIGN KEY (`FoodTypeId`)
    REFERENCES `wkdhtgq1tnwejwox`.`FoodTypes` (`FoodTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`ParticipantsPerMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`ParticipantsPerMovie` (
  `MovieId` BIGINT NOT NULL,
  `ParticipantId` INT NOT NULL,
  PRIMARY KEY (`MovieId`, `ParticipantId`),
  INDEX `fk_Movies_has_Participants_Participants1_idx` (`ParticipantId` ASC) VISIBLE,
  INDEX `fk_Movies_has_Participants_Movies1_idx` (`MovieId` ASC) VISIBLE,
  CONSTRAINT `fk_Movies_has_Participants_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movies_has_Participants_Participants1`
    FOREIGN KEY (`ParticipantId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Participants` (`ParticipantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`ShoppingCarts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`ShoppingCarts` (
  `ShoppingCartsId` INT NOT NULL,
  `UserId` BIGINT NOT NULL,
  PRIMARY KEY (`ShoppingCartsId`),
  INDEX `fk_ShoppingCarts_Users1_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `fk_ShoppingCarts_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Users` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Provinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Provinces` (
  `ProvinceId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`ProvinceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Cinemas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Cinemas` (
  `CinemaId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` NVARCHAR(500) NULL,
  `ProvinceId` INT NOT NULL,
  `FunctionId` BIGINT NOT NULL,
  PRIMARY KEY (`CinemaId`),
  INDEX `fk_Cinemas_Provinces1_idx` (`ProvinceId` ASC) VISIBLE,
  INDEX `fk_Cinemas_Functions1_idx` (`FunctionId` ASC) VISIBLE,
  CONSTRAINT `fk_Cinemas_Provinces1`
    FOREIGN KEY (`ProvinceId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Provinces` (`ProvinceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cinemas_Functions1`
    FOREIGN KEY (`FunctionId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Functions` (`FunctionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`CinemaRooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`CinemaRooms` (
  `CinemaRoomId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `CinemaId` INT NOT NULL,
  PRIMARY KEY (`CinemaRoomId`),
  INDEX `fk_CinemaRooms_Cinemas1_idx` (`CinemaId` ASC) VISIBLE,
  CONSTRAINT `fk_CinemaRooms_Cinemas1`
    FOREIGN KEY (`CinemaId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Cinemas` (`CinemaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Functions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Functions` (
  `MovieId` BIGINT NOT NULL,
  `CinemaRoomId` INT NOT NULL,
  `FunctionId` BIGINT NOT NULL,
  `FunctionDate` DATETIME(1) NOT NULL,
  `SelledSeat` TINYINT NOT NULL,
  INDEX `fk_CurrentMovies_Movies1_idx` (`MovieId` ASC) VISIBLE,
  INDEX `fk_CurrentMovies_CinemaRooms1_idx` (`CinemaRoomId` ASC) VISIBLE,
  PRIMARY KEY (`FunctionId`),
  CONSTRAINT `fk_CurrentMovies_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CurrentMovies_CinemaRooms1`
    FOREIGN KEY (`CinemaRoomId`)
    REFERENCES `wkdhtgq1tnwejwox`.`CinemaRooms` (`CinemaRoomId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Seats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Seats` (
  `SeatsId` INT NOT NULL,
  `Position` VARCHAR(45) NULL,
  PRIMARY KEY (`SeatsId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`SeatsPerFunction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`SeatsPerFunction` (
  `FunctionId` BIGINT NOT NULL,
  `SeatsId` INT NOT NULL,
  `UserId` BIGINT NULL,
  `Avaliable` TINYINT NULL,
  PRIMARY KEY (`FunctionId`, `SeatsId`),
  INDEX `fk_Functions_has_Seats_Seats1_idx` (`SeatsId` ASC) VISIBLE,
  INDEX `fk_Functions_has_Seats_Functions1_idx` (`FunctionId` ASC) VISIBLE,
  INDEX `fk_SeatsPerFunction_Users1_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `fk_Functions_has_Seats_Functions1`
    FOREIGN KEY (`FunctionId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Functions` (`FunctionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Functions_has_Seats_Seats1`
    FOREIGN KEY (`SeatsId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Seats` (`SeatsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SeatsPerFunction_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Users` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`FoodsPerCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`FoodsPerCart` (
  `ShoppingCartsId` INT NOT NULL,
  `FoodId` INT NOT NULL,
  `Quantity` TINYINT NULL,
  INDEX `fk_ProductsPeroCart_ShoppingCarts1_idx` (`ShoppingCartsId` ASC) VISIBLE,
  INDEX `fk_ProductsPeroCart_Foods1_idx` (`FoodId` ASC) VISIBLE,
  CONSTRAINT `fk_ProductsPeroCart_ShoppingCarts1`
    FOREIGN KEY (`ShoppingCartsId`)
    REFERENCES `wkdhtgq1tnwejwox`.`ShoppingCarts` (`ShoppingCartsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductsPeroCart_Foods1`
    FOREIGN KEY (`FoodId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Foods` (`FoodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`TicketsPerCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`TicketsPerCart` (
  `ShoppingCartsId` INT NOT NULL,
  `FunctionId` BIGINT NOT NULL,
  `PriceId` INT NOT NULL,
  `Quantity` TINYINT NULL,
  INDEX `fk_TicketsPerCart_ShoppingCarts1_idx` (`ShoppingCartsId` ASC) VISIBLE,
  INDEX `fk_TicketsPerCart_Functions1_idx` (`FunctionId` ASC) VISIBLE,
  INDEX `fk_TicketsPerCart_Prices1_idx` (`PriceId` ASC) VISIBLE,
  CONSTRAINT `fk_TicketsPerCart_ShoppingCarts1`
    FOREIGN KEY (`ShoppingCartsId`)
    REFERENCES `wkdhtgq1tnwejwox`.`ShoppingCarts` (`ShoppingCartsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TicketsPerCart_Functions1`
    FOREIGN KEY (`FunctionId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Functions` (`FunctionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TicketsPerCart_Prices1`
    FOREIGN KEY (`PriceId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Prices` (`PriceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`Vaccines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`Vaccines` (
  `VaccinesId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`VaccinesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wkdhtgq1tnwejwox`.`VaccinesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wkdhtgq1tnwejwox`.`VaccinesPerUser` (
  `VaccinesId` INT NOT NULL,
  `UserId` BIGINT NOT NULL,
  `Date` DATE NULL,
  PRIMARY KEY (`VaccinesId`, `UserId`),
  INDEX `fk_Vaccines_has_Users_Users1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_Vaccines_has_Users_Vaccines1_idx` (`VaccinesId` ASC) VISIBLE,
  CONSTRAINT `fk_Vaccines_has_Users_Vaccines1`
    FOREIGN KEY (`VaccinesId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Vaccines` (`VaccinesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vaccines_has_Users_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `wkdhtgq1tnwejwox`.`Users` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
