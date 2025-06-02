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
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `verificado` TINYINT(1) NOT NULL DEFAULT '0',
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `tipo` ENUM('Comum', 'Ong') NOT NULL,
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
  `status` ENUM('Disponível', 'Adotado', 'Desaparecido') NOT NULL DEFAULT 'Disponível',
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
  `cnpj` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_ong`),
  UNIQUE INDEX `cnpj` (`cnpj` ASC)
) ENGINE = InnoDB
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
  `tipo_endereco` ENUM('Residencial', 'Desaparecimento', 'ONG', 'Evento', 'Campanha', 'LocalDenuncia', 'Outro') NOT NULL,
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
  `data_desaparecimento` DATETIME NOT NULL,
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


-- -----------------------------------------------------
-- Table `petcare_db`.`pertence_ong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare_db`.`pertence_ong` (
    `id_pertence_ong` INT NOT NULL AUTO_INCREMENT,
    `fk_pertence_id_usuario` INT NOT NULL,
    `fk_pertence_id_ong` INT NOT NULL,
    PRIMARY KEY (`id_pertence_ong`),
    UNIQUE INDEX `idx_usuario_ong_unique` (`fk_pertence_id_usuario` ASC, `fk_pertence_id_ong` ASC) VISIBLE,
    INDEX `fk_pertence_id_ong_idx` (`fk_pertence_id_ong` ASC) VISIBLE,
    CONSTRAINT `fk_pertence_id_usuario`
        FOREIGN KEY (`fk_pertence_id_usuario`)
        REFERENCES `petcare_db`.`usuarios` (`id_usuario`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_pertence_id_ong`
        FOREIGN KEY (`fk_pertence_id_ong`)
        REFERENCES `petcare_db`.`ong` (`id_ong`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

DELIMITER $$

CREATE PROCEDURE `petcare_db`.`verificar_status_campanha`(
    IN p_id_campanha INT
)
BEGIN
    DECLARE v_data_inicio DATETIME;
    DECLARE v_data_final DATETIME;
    DECLARE v_status_campanha VARCHAR(50);
    DECLARE v_data_atual DATETIME;

    -- Define a data atual
    SET v_data_atual = NOW(); -- Usa a data e hora do servidor MySQL

    -- Pega as datas da campanha
    SELECT
        data_inicio,
        data_final
    INTO
        v_data_inicio,
        v_data_final
    FROM
        `petcare_db`.`Campanhas`
    WHERE
        id_campanhas = p_id_campanha;

    -- Estrutura de Decisão para determinar o status da campanha
    IF v_data_inicio IS NULL THEN -- Campanha não encontrada
        SET v_status_campanha = 'Campanha Não Encontrada';
    ELSEIF v_data_final IS NULL THEN -- Campanha sem data final definida (pode ser contínua ou erro de dados)
        SET v_status_campanha = 'Ativa (Sem Data Final Definida)';
    ELSEIF v_data_inicio > v_data_final THEN -- Datas inconsistentes
        SET v_status_campanha = 'Inválida (Data Final Anterior à Data Início)';
    ELSEIF v_data_atual < v_data_inicio THEN
        SET v_status_campanha = 'Futura';
    ELSEIF v_data_atual BETWEEN v_data_inicio AND v_data_final THEN
        SET v_status_campanha = 'Ativa';
    ELSEIF v_data_atual > v_data_final THEN
        SET v_status_campanha = 'Concluída';
    ELSE
        SET v_status_campanha = 'Status Indeterminado'; -- Caso de erro ou lógica não coberta
    END IF;

    -- Retorna o resultado
    SELECT
        c.id_campanhas,
        c.campanha_nome,
        c.campanhas_tipo,
        c.data_inicio,
        c.data_final,
        v_status_campanha AS status_atual_da_campanha
    FROM
        `petcare_db`.`Campanhas` c
    WHERE
        c.id_campanhas = p_id_campanha;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE listar_animais_para_adocao_por_porte(
    IN p_porte VARCHAR(20)
)
BEGIN
    SELECT
        Animais.id_animal,
        Animais.animal_nome,
        Animais.porte,
        Animais.especie,
        Animais.cor,
        Animais.raca,
        Animais.animal_descricao,
        Usuarios.usuario_nome AS nome_dono,
        Usuarios.email AS email_dono
    FROM
        Animais
    INNER JOIN Usuarios ON Animais.fk_animais_id_usuario = Usuarios.id_usuario
    WHERE
        Animais.porte = p_porte COLLATE utf8mb4_unicode_ci -- Filtrar por porte usando collation para compatibilidade
        AND Animais.status = 'Disponível' -- Garantir que o animal esteja disponível para adoção
    ORDER BY Animais.animal_nome;
END$$

DELIMITER ;

CREATE TABLE IF NOT EXISTS `petcare_db`.`auditoria` (
    `id_auditoria` INT NOT NULL AUTO_INCREMENT,
    `acao` VARCHAR(50) NOT NULL, -- Tipo de ação (ex: 'UPDATE', 'INSERT', 'DELETE')
    `campoAlterado` VARCHAR(100) NOT NULL, -- Nome do campo que foi alterado
    `valorAntes` TEXT NULL, -- Valor do campo ANTES da alteração
    `valorDepois` TEXT NULL, -- Valor do campo DEPOIS da alteração
    `dataAlteracao` DATETIME NOT NULL, -- Data e hora da alteração
    `usuario` VARCHAR(255) NULL, -- Usuário que realizou a alteração
    `id_registro_afetado` INT NULL, -- O ID do registro na tabela original (ex: id_usuario)
    `tabela_afetada` VARCHAR(100) NOT NULL, -- Nome da tabela que foi alterada (ex: 'usuarios')
    PRIMARY KEY (`id_auditoria`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

DELIMITER $$

CREATE TRIGGER `trg_usuarios_after_update_all_fields`
AFTER UPDATE ON `petcare_db`.`usuarios`
FOR EACH ROW
BEGIN
    -- Auditoria para 'usuario_nome'
    IF OLD.usuario_nome <> NEW.usuario_nome THEN
        INSERT INTO `petcare_db`.`auditoria` (acao, campoAlterado, valorAntes, valorDepois, dataAlteracao, usuario, id_registro_afetado, tabela_afetada)
        VALUES ('UPDATE', 'usuario_nome', OLD.usuario_nome, NEW.usuario_nome, NOW(), CURRENT_USER(), OLD.id_usuario, 'usuarios');
    END IF;

    -- Auditoria para 'cpf'
    IF OLD.cpf <> NEW.cpf THEN
        INSERT INTO `petcare_db`.`auditoria` (acao, campoAlterado, valorAntes, valorDepois, dataAlteracao, usuario, id_registro_afetado, tabela_afetada)
        VALUES ('UPDATE', 'cpf', OLD.cpf, NEW.cpf, NOW(), CURRENT_USER(), OLD.id_usuario, 'usuarios');
    END IF;

    -- Auditoria para 'email'
    IF OLD.email <> NEW.email THEN
        INSERT INTO `petcare_db`.`auditoria` (acao, campoAlterado, valorAntes, valorDepois, dataAlteracao, usuario, id_registro_afetado, tabela_afetada)
        VALUES ('UPDATE', 'email', OLD.email, NEW.email, NOW(), CURRENT_USER(), OLD.id_usuario, 'usuarios');
    END IF;

    -- Auditoria para 'verificado'
    IF OLD.verificado <> NEW.verificado THEN
        INSERT INTO `petcare_db`.`auditoria` (acao, campoAlterado, valorAntes, valorDepois, dataAlteracao, usuario, id_registro_afetado, tabela_afetada)
        VALUES ('UPDATE', 'verificado', OLD.verificado, NEW.verificado, NOW(), CURRENT_USER(), OLD.id_usuario, 'usuarios');
    END IF;

    -- Auditoria para 'telefone'
    IF OLD.telefone <> NEW.telefone THEN
        INSERT INTO `petcare_db`.`auditoria` (acao, campoAlterado, valorAntes, valorDepois, dataAlteracao, usuario, id_registro_afetado, tabela_afetada)
        VALUES ('UPDATE', 'telefone', OLD.telefone, NEW.telefone, NOW(), CURRENT_USER(), OLD.id_usuario, 'usuarios');
    END IF;

    -- Auditoria para 'tipo'
    IF OLD.tipo <> NEW.tipo THEN
        INSERT INTO `petcare_db`.`auditoria` (acao, campoAlterado, valorAntes, valorDepois, dataAlteracao, usuario, id_registro_afetado, tabela_afetada)
        VALUES ('UPDATE', 'tipo', OLD.tipo, NEW.tipo, NOW(), CURRENT_USER(), OLD.id_usuario, 'usuarios');
    END IF;

    -- Auditoria para 'senha'
    -- Registre apenas uma indicação de que a senha foi alterada.
    IF OLD.senha <> NEW.senha THEN
        INSERT INTO `petcare_db`.`auditoria` (acao, campoAlterado, valorAntes, valorDepois, dataAlteracao, usuario, id_registro_afetado, tabela_afetada)
        VALUES ('UPDATE', 'senha', 'SENHA_ALTERADA', 'SENHA_ALTERADA', NOW(), CURRENT_USER(), OLD.id_usuario, 'usuarios');
    END IF;

END$$

DELIMITER //
CREATE TRIGGER after_insert_adocao
AFTER INSERT ON adocoes
FOR EACH ROW
BEGIN
  -- Atualiza o status e o novo dono do animal
  UPDATE animais
  SET status = 'Adotado',
      fk_animais_id_usuario = NEW.fk_adocoes_id_usuario
  WHERE id_animal = NEW.fk_adocoes_id_animal;
END;
//
DELIMITER ;

-- trigger de criptografar na inserção.
use petcare_db;
DELIMITER $$

CREATE TRIGGER before_insert_usuario
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    SET NEW.senha = SHA2(NEW.senha, 256);
END$$

DELIMITER ;
-- trigger de criptografar se fizer um update.
DELIMITER $$

CREATE TRIGGER before_update_usuario
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.senha != OLD.senha THEN
        SET NEW.senha = SHA2(NEW.senha, 256);
    END IF;
END$$

DELIMITER ;
-- mudar os usuarios que já estão inseridos.
UPDATE Usuarios
SET senha = SHA2(senha, 256)
WHERE LENGTH(senha) < 64; 

-- Adicionando um index usuario_nome (os outros index criam automaticamente por ser notnull)
CREATE INDEX idx_usuario_nome ON Usuarios(usuario_nome);


-- Adicionando a function de verificar cpf (inspirado no exemplo dado)
use petcare_db;
DELIMITER //

CREATE FUNCTION validaCpf(cpf VARCHAR(14))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(50);
    DECLARE d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11 INT;
    DECLARE soma INT;
    DECLARE cpfLimpo VARCHAR(11);

    
    SET cpfLimpo = REPLACE(REPLACE(REPLACE(cpf, '.', ''), '-', ''), ' ', '');

    -- Verificações se está dentro do tamanho certo
    IF LENGTH(cpfLimpo) != 11 OR
       cpfLimpo IN ('00000000000', '11111111111', '22222222222', '33333333333',
                    '44444444444', '55555555555', '66666666666', '77777777777',
                    '88888888888', '99999999999', '01234567890') THEN
        RETURN 'CPF inválido';
    END IF;

    -- Extrair dígitos
    SET d1 = SUBSTRING(cpfLimpo, 1, 1);
    SET d2 = SUBSTRING(cpfLimpo, 2, 1);
    SET d3 = SUBSTRING(cpfLimpo, 3, 1);
    SET d4 = SUBSTRING(cpfLimpo, 4, 1);
    SET d5 = SUBSTRING(cpfLimpo, 5, 1);
    SET d6 = SUBSTRING(cpfLimpo, 6, 1);
    SET d7 = SUBSTRING(cpfLimpo, 7, 1);
    SET d8 = SUBSTRING(cpfLimpo, 8, 1);
    SET d9 = SUBSTRING(cpfLimpo, 9, 1);

    -- Calculando os digitos
    SET soma = (d1*10 + d2*9 + d3*8 + d4*7 + d5*6 + d6*5 + d7*4 + d8*3 + d9*2) MOD 11;
    SET d10 = 11 - soma;
    IF d10 >= 10 THEN SET d10 = 0; END IF;

    
    SET soma = (d1*11 + d2*10 + d3*9 + d4*8 + d5*7 + d6*6 + d7*5 + d8*4 + d9*3 + d10*2) MOD 11;
    SET d11 = 11 - soma;
    IF d11 >= 10 THEN SET d11 = 0; END IF;

    -- Verificando os digitos
    IF SUBSTRING(cpfLimpo, 10, 1) = d10 AND SUBSTRING(cpfLimpo, 11, 1) = d11 THEN
        SET resultado = 'CPF válido';
    ELSE
        SET resultado = 'CPF inválido';
    END IF;

    RETURN resultado;
END //

DELIMITER ;

-- criando a estrutura de controle.
DELIMITER //

CREATE FUNCTION verificaTipoUsuario(tipo VARCHAR(20))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE mensagem VARCHAR(100);

    IF tipo = 'Comum' THEN
        SET mensagem = 'Usuário comum: pode registrar animais e campanhas.';
    ELSEIF tipo = 'Ong' THEN
        SET mensagem = 'ONG cadastrada: pode registrar animais e campanhas.';
    ELSE
        SET mensagem = 'Tipo de usuário desconhecido.';
    END IF;

    RETURN mensagem;
END //

DELIMITER ;

-- criando a function para dar um resumo basico de usuario

DELIMITER //

CREATE FUNCTION ResumoUsuario(id INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE resultado VARCHAR(255);
    DECLARE nome VARCHAR(100);
    DECLARE tipo_usuario VARCHAR(20);
    DECLARE verificado_usuario BOOLEAN;

    SELECT usuario_nome, tipo, verificado
    INTO nome, tipo_usuario, verificado_usuario
    FROM Usuarios
    WHERE id_usuario = id;

    SET resultado = CONCAT(
        'Usuário: ', nome, ' | Tipo: ', tipo_usuario, 
        ' | Verificado: ', IF(verificado_usuario, 'Sim', 'Não')
    );

    RETURN resultado;
END //

DELIMITER ;

-- criando a function para ver o status da adoção

DELIMITER //

CREATE FUNCTION StatusAdocoes(id_usuario INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE ultimo_nome VARCHAR(100) DEFAULT 'Nenhum';
    DECLARE resultado VARCHAR(255);

    -- Conta quantas adoções o usuário fez
    SELECT COUNT(*) INTO total
    FROM Adocoes
    WHERE fk_adocoes_id_usuario = id_usuario;

    -- Pega o nome do último animal adotado
    SELECT a.animal_nome INTO ultimo_nome
    FROM Adocoes ad
    JOIN Animais a ON a.id_animal = ad.fk_adocoes_id_animal
    WHERE ad.fk_adocoes_id_usuario = id_usuario
    ORDER BY ad.adocao_data DESC
    LIMIT 1;

    -- Monta mensagem final
    SET resultado = CONCAT(
        'Total de adoções: ', total, 
        ' | Último animal adotado: ', ultimo_nome
    );

    RETURN resultado;
END //

DELIMITER ;

CREATE VIEW animais_para_adocao_detalhes AS
SELECT
    a.id_animal,
    a.animal_nome,
    a.porte,
    a.especie,
    a.cor,
    a.raca,
    a.imagem,
    a.animal_descricao,
    a.status, -- Confirmando que é 'Disponível'
    u.usuario_nome AS nome_do_registrador_ou_dono_anterior, -- O usuário que registrou o animal
    u.email AS email_do_registrador,
    u.telefone AS telefone_do_registrador,
    GROUP_CONCAT(
        CONCAT(
            'Data: ', DATE_FORMAT(hs.data_observacao, '%d/%m/%Y'),
            ' - Obs: ', hs.observacoes
        ) ORDER BY hs.data_observacao DESC SEPARATOR ' | '
    ) AS historico_saude_completo,
    e.cidade AS endereco_cidade,
    e.estado AS endereco_estado,
    e.rua AS endereco_rua,
    e.bairro AS endereco_bairro,
    e.cep AS endereco_cep,
    e.tipo_endereco AS endereco_tipo
FROM
    petcare_db.animais a
JOIN
    petcare_db.usuarios u ON a.fk_animais_id_usuario = u.id_usuario -- O usuário que registrou o animal
LEFT JOIN
    petcare_db.registra r ON u.id_usuario = r.fk_Usuarios_id_usuario -- Para pegar o endereço do usuário
LEFT JOIN
    petcare_db.endereco e ON r.fk_Endereco_id_endereco = e.id_endereco -- Detalhes do endereço do usuário
LEFT JOIN
    petcare_db.historico_saude hs ON a.id_animal = hs.fk_historico_id_animal
WHERE
    a.status = 'Disponível'
GROUP BY
    a.id_animal, a.animal_nome, a.porte, a.especie, a.cor, a.raca, a.imagem, a.animal_descricao, a.status,
    u.usuario_nome, u.email, u.telefone,
    e.cidade, e.estado, e.rua, e.bairro, e.cep, e.tipo_endereco;

CREATE VIEW vw_animais_desaparecidos_formatado AS
SELECT
   animais.animal_nome,  
   animais.raca,
   DATE_FORMAT(animais_desaparecidos.data_desaparecimento, '%d/%m/%y') AS data_desaparecimento_formatada,
   endereco.cidade,
   endereco.estado
FROM animais_desaparecidos
JOIN animais ON animais_desaparecidos.fk_animais_dp_id_animal = animais.id_animal
JOIN endereco ON animais_desaparecidos.fk_animais_dp_id_endereco = endereco.id_endereco;
 
  SELECT * FROM vw_animais_desaparecidos_formatado;