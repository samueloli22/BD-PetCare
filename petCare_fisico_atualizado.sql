-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema petcare_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema petcare_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `petcare_bd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `petcare_bd` ;

-- -----------------------------------------------------
-- Table `petcare_bd`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`usuarios` (
  `usuario_nome` VARCHAR(100) NOT NULL,
  `id_usuario_1` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `verificado` TINYINT(1) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `tipo` ENUM('Comum', 'Ong', 'Prefeitura') NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_usuario_1`),
  UNIQUE INDEX `id_usuario_1` (`id_usuario_1` ASC, `cpf` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`animais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`animais` (
  `animal_nome` VARCHAR(100) NULL,
  `porte` ENUM('Pequeno', 'Médio', 'Grande') NOT NULL,
  `especie` VARCHAR(100) NOT NULL,
  `cor` VARCHAR(100) NOT NULL,
  `id_animal` INT NOT NULL AUTO_INCREMENT,
  `raca` VARCHAR(100) NOT NULL,
  `imagem` VARCHAR(255) NOT NULL,
  `animal_descricao` VARCHAR(100) NOT NULL,
  `animal_rg` VARCHAR(20) NOT NULL,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  PRIMARY KEY (`id_animal`),
  UNIQUE INDEX `id_animal` (`id_animal` ASC) VISIBLE,
  INDEX `FK_Animais_2` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `FK_Animais_2`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`adocoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`adocoes` (
  `id_adocoes` INT NOT NULL AUTO_INCREMENT,
  `adocao_data` DATETIME NOT NULL,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  `fk_Animais_id_animal` INT NOT NULL,
  PRIMARY KEY (`id_adocoes`),
  UNIQUE INDEX `id_adocoes` (`id_adocoes` ASC) VISIBLE,
  INDEX `FK_Adocoes_2` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  INDEX `FK_Adocoes_3` (`fk_Animais_id_animal` ASC) VISIBLE,
  CONSTRAINT `FK_Adocoes_2`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Adocoes_3`
    FOREIGN KEY (`fk_Animais_id_animal`)
    REFERENCES `petcare_bd`.`animais` (`id_animal`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`ong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`ong` (
  `id_ong` INT NOT NULL AUTO_INCREMENT,
  `ong_email` VARCHAR(100) NOT NULL,
  `ong_telefone` VARCHAR(20) NOT NULL,
  `ong_descricao` TEXT NOT NULL,
  `ong_nome` VARCHAR(100) NOT NULL,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`id_ong`),
  UNIQUE INDEX `id_ong` (`id_ong` ASC) VISIBLE,
  INDEX `FK_ONG_1` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `FK_ONG_1`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(100) NOT NULL,
  `cep` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(50) NOT NULL,
  `rua` VARCHAR(50) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `tipo_endereco` ENUM('Residencial', 'Desaparecimento', 'ONG', 'Evento', 'Campanha', 'Outro') NOT NULL,
  `fk_ONG_id_ong` INT NOT NULL,
  PRIMARY KEY (`id_endereco`),
  UNIQUE INDEX `id_endereco` (`id_endereco` ASC) VISIBLE,
  INDEX `FK_Endereco_3` (`fk_ONG_id_ong` ASC) VISIBLE,
  CONSTRAINT `FK_Endereco_3`
    FOREIGN KEY (`fk_ONG_id_ong`)
    REFERENCES `petcare_bd`.`ong` (`id_ong`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`animais_desaparecidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`animais_desaparecidos` (
  `data_desaparecimneto` DATETIME NOT NULL,
  `id_animal_des` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  `fk_Animais_id_animal` INT NOT NULL,
  `fk_Endereco_id_endereco` INT NOT NULL,
  PRIMARY KEY (`id_animal_des`),
  UNIQUE INDEX `id_animal_des` (`id_animal_des` ASC) VISIBLE,
  INDEX `FK_Animais_desaparecidos_2` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  INDEX `FK_Animais_desaparecidos_3` (`fk_Animais_id_animal` ASC) VISIBLE,
  INDEX `FK_Animais_desaparecidos_4` (`fk_Endereco_id_endereco` ASC) VISIBLE,
  CONSTRAINT `FK_Animais_desaparecidos_2`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Animais_desaparecidos_3`
    FOREIGN KEY (`fk_Animais_id_animal`)
    REFERENCES `petcare_bd`.`animais` (`id_animal`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Animais_desaparecidos_4`
    FOREIGN KEY (`fk_Endereco_id_endereco`)
    REFERENCES `petcare_bd`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`campanhas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`campanhas` (
  `campanha_nome` VARCHAR(100) NOT NULL,
  `campanhas_tipo` ENUM('vacinacao', 'Castracao', 'Adocao', 'Doacao', 'Outro') NOT NULL,
  `data_inicio` DATETIME NOT NULL,
  `id_campanhas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campanha_descricao` TEXT NOT NULL,
  `data_final` DATETIME NOT NULL,
  `fk_Endereco_id_endereco` INT NOT NULL,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  PRIMARY KEY (`id_campanhas`),
  UNIQUE INDEX `id_campanhas` (`id_campanhas` ASC) VISIBLE,
  INDEX `FK_Campanhas_2` (`fk_Endereco_id_endereco` ASC) VISIBLE,
  INDEX `FK_Campanhas_3` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `FK_Campanhas_2`
    FOREIGN KEY (`fk_Endereco_id_endereco`)
    REFERENCES `petcare_bd`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Campanhas_3`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`denuncias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`denuncias` (
  `denuncia_descricao` TEXT NOT NULL,
  `denuncias_tipo` ENUM('Abandono', 'Maus-tratos', 'Negligência', 'Falta de vacinação', 'Outros') NOT NULL,
  `id_denuncias` INT NOT NULL AUTO_INCREMENT,
  `denuncia_data` DATETIME NOT NULL,
  `fk_Endereco_id_endereco` INT NOT NULL,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  PRIMARY KEY (`id_denuncias`),
  UNIQUE INDEX `id_denuncias` (`id_denuncias` ASC) VISIBLE,
  INDEX `FK_Denuncias_2` (`fk_Endereco_id_endereco` ASC) VISIBLE,
  INDEX `FK_Denuncias_3` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `FK_Denuncias_2`
    FOREIGN KEY (`fk_Endereco_id_endereco`)
    REFERENCES `petcare_bd`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Denuncias_3`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`doacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`doacoes` (
  `doacao_data` DATETIME NOT NULL,
  `id_doacao` INT NOT NULL AUTO_INCREMENT,
  `valor` DOUBLE(10,2) NOT NULL,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  PRIMARY KEY (`id_doacao`),
  UNIQUE INDEX `id_doacao` (`id_doacao` ASC) VISIBLE,
  INDEX `FK_Doacoes_2` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `FK_Doacoes_2`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`evidencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`evidencias` (
  `id_evidencias` INT NOT NULL AUTO_INCREMENT,
  `evidencia_imagem` VARCHAR(255) NOT NULL,
  `fk_Denuncias_id_denuncias` INT NOT NULL,
  PRIMARY KEY (`id_evidencias`),
  INDEX `FK_evidencias_2` (`fk_Denuncias_id_denuncias` ASC) VISIBLE,
  CONSTRAINT `FK_evidencias_2`
    FOREIGN KEY (`fk_Denuncias_id_denuncias`)
    REFERENCES `petcare_bd`.`denuncias` (`id_denuncias`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`historico_saude`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`historico_saude` (
  `observacoes` TEXT NOT NULL,
  `id_historico_saude` INT NOT NULL AUTO_INCREMENT,
  `data_observacao` DATE NOT NULL,
  `fk_Animais_id_animal` INT NOT NULL,
  PRIMARY KEY (`id_historico_saude`),
  INDEX `FK_historico_saude_2` (`fk_Animais_id_animal` ASC) VISIBLE,
  CONSTRAINT `FK_historico_saude_2`
    FOREIGN KEY (`fk_Animais_id_animal`)
    REFERENCES `petcare_bd`.`animais` (`id_animal`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`noticias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`noticias` (
  `noticia_nome` VARCHAR(100) NOT NULL,
  `tipo` ENUM('Campanha de Vacinação', 'Castração', 'Evento Comunitário', 'Adoção', 'Denúncia', 'Informativo Geral') NOT NULL,
  `id_noticia` INT NOT NULL AUTO_INCREMENT,
  `noticia_conteudo` TEXT NOT NULL,
  `noticia_imagem` VARCHAR(255) NOT NULL,
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  PRIMARY KEY (`id_noticia`),
  UNIQUE INDEX `id_noticia` (`id_noticia` ASC) VISIBLE,
  INDEX `FK_Noticias_2` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `FK_Noticias_2`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `petcare_bd`.`registra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_bd`.`registra` (
  `fk_Usuarios_id_usuario_1` INT NOT NULL,
  `fk_Endereco_id_endereco` INT NOT NULL,
  `id_registra` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_registra`),
  INDEX `FK_registra_1` (`fk_Usuarios_id_usuario_1` ASC) VISIBLE,
  INDEX `FK_registra_2` (`fk_Endereco_id_endereco` ASC) VISIBLE,
  CONSTRAINT `FK_registra_1`
    FOREIGN KEY (`fk_Usuarios_id_usuario_1`)
    REFERENCES `petcare_bd`.`usuarios` (`id_usuario_1`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_registra_2`
    FOREIGN KEY (`fk_Endereco_id_endereco`)
    REFERENCES `petcare_bd`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
