-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema petcare_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema petcare_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `petcare_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `petcare_db` ;

-- -----------------------------------------------------
-- Table `petcare_db`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `usuario_nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `verificado` TINYINT(1) NOT NULL DEFAULT '0',
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `tipo` ENUM('Comum', 'Ong', 'Prefeitura') NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `cpf` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`animais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`animais` (
  `id_animal` INT NOT NULL AUTO_INCREMENT,
  `animal_nome` VARCHAR(100) NULL DEFAULT NULL,
  `porte` ENUM('Pequeno', 'Médio', 'Grande') NOT NULL,
  `especie` VARCHAR(100) NOT NULL,
  `cor` VARCHAR(100) NOT NULL,
  `raca` VARCHAR(100) NOT NULL,
  `imagem` VARCHAR(255) NOT NULL,
  `animal_descricao` VARCHAR(100) NOT NULL,
  `animal_rg` VARCHAR(20) NULL DEFAULT NULL,
  `status' ENUM('Disponível', 'Adotado', 'Desaparecido') NOT NULL DEFAULT 'Disponível',
  `fk_animais_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_animal`),
  UNIQUE INDEX `animal_rg` (`animal_rg` ASC) VISIBLE,
  INDEX `fk_animais_id_usuario` (`fk_animais_id_usuario` ASC) VISIBLE,
  CONSTRAINT `animais_ibfk_1`
    FOREIGN KEY (`fk_animais_id_usuario`)
    REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`adocoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`adocoes` (
  `id_adocoes` INT NOT NULL AUTO_INCREMENT,
  `adocao_data` DATETIME NOT NULL,
  `fk_adocoes_id_usuario` INT NOT NULL,
  `fk_adocoes_id_animal` INT NOT NULL,
  PRIMARY KEY (`id_adocoes`),
  INDEX `fk_adocoes_id_usuario` (`fk_adocoes_id_usuario` ASC) VISIBLE,
  INDEX `fk_adocoes_id_animal` (`fk_adocoes_id_animal` ASC) VISIBLE,
  CONSTRAINT `adocoes_ibfk_1`
    FOREIGN KEY (`fk_adocoes_id_usuario`)
    REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `adocoes_ibfk_2`
    FOREIGN KEY (`fk_adocoes_id_animal`)
    REFERENCES `petcare_db`.`animais` (`id_animal`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`ong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`ong` (
  `id_ong` INT NOT NULL AUTO_INCREMENT,
  `ong_email` VARCHAR(100) NOT NULL,
  `ong_telefone` VARCHAR(20) NOT NULL,
  `ong_descricao` TEXT NULL DEFAULT NULL,
  `ong_nome` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `fk_ONG_id_usuario_1` INT NOT NULL,
  PRIMARY KEY (`id_ong`),
  UNIQUE INDEX `cnpj` (`cnpj` ASC) VISIBLE,
  INDEX `fk_ONG_id_usuario_1` (`fk_ONG_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `ong_ibfk_1`
    FOREIGN KEY (`fk_ONG_id_usuario_1`)
    REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(100) NOT NULL,
  `cep` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(50) NOT NULL,
  `rua` VARCHAR(50) NOT NULL,
  `bairro` VARCHAR(100) NULL DEFAULT NULL,
  `tipo_endereco` ENUM('Residencial', 'Desaparecimento', 'ONG', 'Evento', 'Campanha', 'Outro') NOT NULL,
  `fk_enderecol_id_ong` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_endereco`),
  INDEX `fk_enderecol_id_ong` (`fk_enderecol_id_ong` ASC) VISIBLE,
  CONSTRAINT `endereco_ibfk_1`
    FOREIGN KEY (`fk_enderecol_id_ong`)
    REFERENCES `petcare_db`.`ong` (`id_ong`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`animais_desaparecidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`animais_desaparecidos` (
  `id_animal_des` INT NOT NULL AUTO_INCREMENT,
  `data_desaparecimneto` DATETIME NOT NULL,
  `fk_animaisdp_id_usuario` INT NOT NULL,
  `fk_animais_dp_id_animal` INT NOT NULL,
  `fk_animais_dp_id_endereco` INT NOT NULL,
  PRIMARY KEY (`id_animal_des`),
  INDEX `fk_animaisdp_id_usuario` (`fk_animaisdp_id_usuario` ASC) VISIBLE,
  INDEX `fk_animais_dp_id_animal` (`fk_animais_dp_id_animal` ASC) VISIBLE,
  INDEX `fk_animais_dp_id_endereco` (`fk_animais_dp_id_endereco` ASC) VISIBLE,
  CONSTRAINT `animais_desaparecidos_ibfk_1`
    FOREIGN KEY (`fk_animaisdp_id_usuario`)
    REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `animais_desaparecidos_ibfk_2`
    FOREIGN KEY (`fk_animais_dp_id_animal`)
    REFERENCES `petcare_db`.`animais` (`id_animal`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `animais_desaparecidos_ibfk_3`
    FOREIGN KEY (`fk_animais_dp_id_endereco`)
    REFERENCES `petcare_db`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`campanhas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`campanhas` (
  `id_campanhas` INT NOT NULL AUTO_INCREMENT,
  `campanha_nome` VARCHAR(100) NOT NULL,
  `campanhas_tipo` ENUM('vacinacao', 'Castracao', 'Adocao', 'Doacao', 'Outro') NOT NULL,
  `data_inicio` DATETIME NOT NULL,
  `data_final` DATETIME NOT NULL,
  `campanha_descricao` TEXT NOT NULL,
  `fk_campanha_id_endereco` INT NOT NULL,
  `fk_campanha_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_campanhas`),
  INDEX `fk_campanha_id_endereco` (`fk_campanha_id_endereco` ASC) VISIBLE,
  INDEX `fk_campanha_id_usuario` (`fk_campanha_id_usuario` ASC) VISIBLE,
  CONSTRAINT `campanhas_ibfk_1`
    FOREIGN KEY (`fk_campanha_id_endereco`)
    REFERENCES `petcare_db`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `campanhas_ibfk_2`
    FOREIGN KEY (`fk_campanha_id_usuario`)
    REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`canais_denuncia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`canais_denuncia` (
  `id_canais_denuncia` INT NOT NULL AUTO_INCREMENT,
  `canal_email` VARCHAR(100) NULL DEFAULT NULL,
  `canal_descricao` TEXT NULL DEFAULT NULL,
  `canal_tipo` VARCHAR(100) NOT NULL,
  `nome_instituicao` VARCHAR(100) NOT NULL,
  `canal_telefone` VARCHAR(30) NULL DEFAULT NULL,
  `canal_site` VARCHAR(255) NULL DEFAULT NULL,
  `fk_canal_id_endereco` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_canais_denuncia`),
  INDEX `fk_canal_id_endereco` (`fk_canal_id_endereco` ASC) VISIBLE,
  CONSTRAINT `canais_denuncia_ibfk_1`
    FOREIGN KEY (`fk_canal_id_endereco`)
    REFERENCES `petcare_db`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`historico_saude`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`historico_saude` (
  `id_historico_saude` INT NOT NULL AUTO_INCREMENT,
  `observacoes` TEXT NULL DEFAULT NULL,
  `data_observacao` DATE NOT NULL,
  `fk_historico_id_animal` INT NOT NULL,
  PRIMARY KEY (`id_historico_saude`),
  INDEX `fk_historico_id_animal` (`fk_historico_id_animal` ASC) VISIBLE,
  CONSTRAINT `historico_saude_ibfk_1`
    FOREIGN KEY (`fk_historico_id_animal`)
    REFERENCES `petcare_db`.`animais` (`id_animal`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`noticias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`noticias` (
  `id_noticia` INT NOT NULL AUTO_INCREMENT,
  `noticia_nome` VARCHAR(100) NOT NULL,
  `tipo` ENUM('Campanha de Vacinação', 'Castração', 'Evento Comunitário', 'Adoção', 'Denúncia', 'Informativo Geral') NOT NULL,
  `noticia_conteudo` TEXT NOT NULL,
  `noticia_imagem` VARCHAR(255) NULL DEFAULT NULL,
  `fk_noticia_id_usuario_1` INT NOT NULL,
  PRIMARY KEY (`id_noticia`),
  INDEX `fk_noticia_id_usuario_1` (`fk_noticia_id_usuario_1` ASC) VISIBLE,
  CONSTRAINT `noticias_ibfk_1`
    FOREIGN KEY (`fk_noticia_id_usuario_1`)
    REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare_db`.`registra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`registra` (
  `id_registra` INT NOT NULL AUTO_INCREMENT,
  `fk_Usuarios_id_usuario` INT NOT NULL,
  `fk_Endereco_id_endereco` INT NOT NULL,
  PRIMARY KEY (`id_registra`),
  INDEX `fk_Usuarios_id_usuario` (`fk_Usuarios_id_usuario` ASC) VISIBLE,
  INDEX `fk_Endereco_id_endereco` (`fk_Endereco_id_endereco` ASC) VISIBLE,
  CONSTRAINT `registra_ibfk_1`
    FOREIGN KEY (`fk_Usuarios_id_usuario`)
    REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `registra_ibfk_2`
    FOREIGN KEY (`fk_Endereco_id_endereco`)
    REFERENCES `petcare_db`.`endereco` (`id_endereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
