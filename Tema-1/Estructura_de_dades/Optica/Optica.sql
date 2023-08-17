-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica_Cul_dAmpolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica_Cul_dAmpolla` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
USE `Optica_Cul_dAmpolla` ;

-- -----------------------------------------------------
-- Table `Optica_Cul_dAmpolla`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_dAmpolla`.`gafas` (
  `gafas_id` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL,
  `montura` ENUM('flotante', 'pasta', 'metálica') NULL,
  `color_cristal` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `precio` VARCHAR(45) NULL,
  `cristalR` FLOAT NULL,
  `cristalL` FLOAT NULL,
  PRIMARY KEY (`gafas_id`),
  INDEX `marcas` (`marca` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_dAmpolla`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_dAmpolla`.`direccion` (
  `direccion_id` INT NOT NULL,
  `calle` VARCHAR(45) NULL,
  `numero` INT NULL,
  `puerta` INT NULL,
  `ciudad` VARCHAR(45) NULL,
  `codigo postal` INT(5) NULL,
  `pais` VARCHAR(45) NULL,
  `tipo` ENUM('cliente', 'proveedor') NULL,
  PRIMARY KEY (`direccion_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_dAmpolla`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_dAmpolla`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `direccion` INT NULL,
  `email` VARCHAR(45) NULL,
  `telefono` INT(9) NULL,
  `alta` YEAR NULL,
  `referencia` VARCHAR(45) NULL,
  PRIMARY KEY (`cliente_id`),
  INDEX `direccion` (`direccion` ASC) VISIBLE,
  INDEX `index3` (`referencia` ASC) INVISIBLE,
  INDEX `index4` (`nombre` ASC) VISIBLE,
  CONSTRAINT `ref`
    FOREIGN KEY (`referencia`)
    REFERENCES `Optica_Cul_dAmpolla`.`cliente` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dir`
    FOREIGN KEY (`direccion`)
    REFERENCES `Optica_Cul_dAmpolla`.`direccion` (`direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_dAmpolla`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_dAmpolla`.`empleados` (
  `empleados_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `antiguedad` DATE NULL,
  PRIMARY KEY (`empleados_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_dAmpolla`.`Optica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_dAmpolla`.`Optica` (
  `Optica_id` INT NOT NULL AUTO_INCREMENT,
  `cliente` INT NULL,
  `empleados` INT NULL,
  `gafas` INT NULL,
  `fiscalia` YEAR NULL,
  `proveedor` INT NOT NULL,
  PRIMARY KEY (`Optica_id`),
  INDEX `proovedor_id` (`proveedor` ASC) INVISIBLE,
  INDEX `cliente_id` (`cliente` ASC) INVISIBLE,
  INDEX `empleados_id` (`empleados` ASC) INVISIBLE,
  INDEX `gafas_id` (`gafas` ASC) VISIBLE,
  CONSTRAINT `gafas`
    FOREIGN KEY (`gafas`)
    REFERENCES `Optica_Cul_dAmpolla`.`gafas` (`gafas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cliente`
    FOREIGN KEY (`cliente`)
    REFERENCES `Optica_Cul_dAmpolla`.`cliente` (`cliente_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `empleados`
    FOREIGN KEY (`empleados`)
    REFERENCES `Optica_Cul_dAmpolla`.`empleados` (`empleados_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_dAmpolla`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_dAmpolla`.`proveedor` (
  `proveedor_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` INT NOT NULL,
  `telefono` INT(9) NOT NULL,
  `fax` INT(9) NULL,
  `nif` VARCHAR(45) NOT NULL,
  `marcas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`proveedor_id`, `telefono`),
  INDEX `direccion` (`direccion` ASC) INVISIBLE,
  INDEX `gafas` (`marcas` ASC) VISIBLE,
  CONSTRAINT ``
    FOREIGN KEY (`marcas`)
    REFERENCES `Optica_Cul_dAmpolla`.`gafas` (`marca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `direccion`
    FOREIGN KEY (`direccion`)
    REFERENCES `Optica_Cul_dAmpolla`.`direccion` (`direccion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
