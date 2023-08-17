-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb3 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`direcciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT(10) NOT NULL,
  `piso` INT(10) NOT NULL,
  `puerta` INT(10) NOT NULL,
  `codigo_postal` INT(5) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  `dirección` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `dirección_idx` (`dirección` ASC),
  CONSTRAINT `fk_dirección`
    FOREIGN KEY (`dirección`)
    REFERENCES `pizzeria`.`direcciones` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  `direccion_tienda` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dirección_tienda_UNIQUE` (`direccion_tienda` ASC),
  CONSTRAINT `fk_dirección_tienda`
    FOREIGN KEY (`direccion_tienda`)
    REFERENCES `pizzeria`.`direcciones` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `telefon` INT(9) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `cargo` ENUM('repartidor', 'cocinero', 'personalT') NOT NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `tienda_actual_idx` (`tienda_id` ASC),
  CONSTRAINT `tienda_id`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `tipo_entrega` ENUM('Domicilio', 'Tienda') NOT NULL,
  `precio_total` DECIMAL(3,2) NOT NULL,
  `cliente_id` INT NOT NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `cliente_id_idx` (`cliente_id` ASC),
  INDEX `tienda_id_idx` (`tienda_id` ASC),
  CONSTRAINT `fk_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`clientes` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tienda`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`entregas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`entregas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pedido_id` INT NOT NULL,
  `repartidor_id` INT NOT NULL,
  `fecha_hora_entrega` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pedido_id_idx` (`pedido_id` ASC),
  INDEX `fk_repartidor` (`repartidor_id` ASC),
  CONSTRAINT `fk_pedido_entrega`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedidos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_repartidor`
    FOREIGN KEY (`repartidor_id`)
    REFERENCES `pizzeria`.`empleados` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` DECIMAL(3,2) NOT NULL,
  `categoria_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `categoria_id_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_categoria`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `pizzeria`.`categorias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pedido_id_idx` (`pedido_id` ASC),
  INDEX `producto_id_idx` (`producto_id` ASC),
  CONSTRAINT `fk_pedido`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedidos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_producto`
    FOREIGN KEY (`producto_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
