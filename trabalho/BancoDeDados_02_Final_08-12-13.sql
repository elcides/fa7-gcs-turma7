SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `sisconfin` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `sisconfin`;

-- -----------------------------------------------------
-- Table `sisconfin`.`Usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Usuario` (
  `idUsuario` INT(10) NOT NULL AUTO_INCREMENT ,
  `nomeUsuario` VARCHAR(50) NOT NULL ,
  `email` VARCHAR(100) NOT NULL ,
  `senha` VARCHAR(60) NOT NULL ,
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sisconfin`.`Cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(60) NOT NULL ,
  `endereco` VARCHAR(80) NOT NULL ,
  INDEX `fk_Cliente_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Cliente_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sisconfin`.`Estoque`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Estoque` (
  `nomeProduto` VARCHAR(45) NOT NULL ,
  `quantidadeTotal` INT NOT NULL ,
  INDEX `fk_Estoque_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Estoque_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sisconfin`.`Fornecedor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT ,
  `nomeFornecedor` VARCHAR(60) NOT NULL ,
  `endereco` VARCHAR(80) NOT NULL ,
  INDEX `fk_Fornecedor_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Fornecedor_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sisconfin`.`Funcionario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(60) NOT NULL ,
  `endereco` VARCHAR(80) NOT NULL ,
  INDEX `fk_Funcionario_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Funcionario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sisconfin`.`UsuarioAdcional`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`UsuarioAdcional` (
  `idUsuario` INT(10) NOT NULL AUTO_INCREMENT ,
  `nomeUsuario` VARCHAR(50) NOT NULL ,
  `senha` VARCHAR(60) NOT NULL ,
  INDEX `fk_UsuarioAdcional_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_UsuarioAdcional_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sisconfin`.`PlanoContas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`PlanoContas` (
  `Tipo` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`Tipo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`EstiloMovimentacao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`EstiloMovimentacao` (
  `nome` VARCHAR(40) NOT NULL ,
  `Usuario_idUsuario` INT(10) NOT NULL ,
  INDEX `fk_EstiloMovimentacao_Usuario1` (`Usuario_idUsuario` ASC) ,
  INDEX `fk_EstiloMovimentacao_PlanoContas1` (`PlanoContas_Tipo` ASC) ,
  CONSTRAINT `fk_EstiloMovimentacao_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstiloMovimentacao_PlanoContas1`
    FOREIGN KEY (`PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`PlanoContas` (`Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`CaixaEntrada`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`CaixaEntrada` (
  `idcaixa` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(25) NOT NULL ,
  INDEX `fk_CaixaEntrada_EstiloMovimentacao1` (`EstiloMovimentacao_nome` ASC, `EstiloMovimentacao_Usuario_idUsuario` ASC, `EstiloMovimentacao_PlanoContas_Tipo` ASC) ,
  CONSTRAINT `fk_CaixaEntrada_EstiloMovimentacao1`
    FOREIGN KEY (`EstiloMovimentacao_nome` , `EstiloMovimentacao_Usuario_idUsuario` , `EstiloMovimentacao_PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`EstiloMovimentacao` (`nome` , `Usuario_idUsuario` , `PlanoContas_Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`OutraMovimentacao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`OutraMovimentacao` (
  `idOutraMovimentacao` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(60) NOT NULL ,
  `valor` VARCHAR(45) NOT NULL ,
  INDEX `fk_OutraMovimentacao_EstiloMovimentacao1` (`EstiloMovimentacao_nome` ASC, `EstiloMovimentacao_Usuario_idUsuario` ASC, `EstiloMovimentacao_PlanoContas_Tipo` ASC) ,
  CONSTRAINT `fk_OutraMovimentacao_EstiloMovimentacao1`
    FOREIGN KEY (`EstiloMovimentacao_nome` , `EstiloMovimentacao_Usuario_idUsuario` , `EstiloMovimentacao_PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`EstiloMovimentacao` (`nome` , `Usuario_idUsuario` , `PlanoContas_Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`Cartao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Cartao` (
  `idCartao` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `numero` VARCHAR(70) NOT NULL ,
  INDEX `fk_Cartao_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Cartao_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`CaixaSaida`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`CaixaSaida` (
  `idcaixa` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(25) NOT NULL ,
  `valor` VARCHAR(45) NOT NULL ,
  INDEX `fk_CaixaSaida_EstiloMovimentacao1` (`EstiloMovimentacao_nome` ASC, `EstiloMovimentacao_Usuario_idUsuario` ASC, `EstiloMovimentacao_PlanoContas_Tipo` ASC) ,
  CONSTRAINT `fk_CaixaSaida_EstiloMovimentacao1`
    FOREIGN KEY (`EstiloMovimentacao_nome` , `EstiloMovimentacao_Usuario_idUsuario` , `EstiloMovimentacao_PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`EstiloMovimentacao` (`nome` , `Usuario_idUsuario` , `PlanoContas_Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`Banco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Banco` (
  `idBanco` INT(10) NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(60) NOT NULL ,
  `agencia` VARCHAR(60) NOT NULL ,
  INDEX `fk_Banco_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Banco_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sisconfin`.`BancoSaida`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`BancoSaida` (
  `idBancoSaida` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(25) NOT NULL ,
  `valor` VARCHAR(45) NOT NULL ,
  INDEX `fk_BancoSaida_EstiloMovimentacao1` (`EstiloMovimentacao_nome` ASC, `EstiloMovimentacao_Usuario_idUsuario` ASC, `EstiloMovimentacao_PlanoContas_Tipo` ASC) ,
  INDEX `fk_BancoSaida_Banco1` (`Banco_idBanco` ASC, `Banco_Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_BancoSaida_EstiloMovimentacao1`
    FOREIGN KEY (`EstiloMovimentacao_nome` , `EstiloMovimentacao_Usuario_idUsuario` , `EstiloMovimentacao_PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`EstiloMovimentacao` (`nome` , `Usuario_idUsuario` , `PlanoContas_Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BancoSaida_Banco1`
    FOREIGN KEY (`Banco_idBanco` , `Banco_Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Banco` (`idBanco` , `Usuario_idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`CartaoSaida`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`CartaoSaida` (
  `idCartaoSaida` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(25) NOT NULL ,
  `valor` VARCHAR(45) NOT NULL ,
  INDEX `fk_CartaoSaida_Cartao2` (`Cartao_idCartao` ASC, `Cartao_Usuario_idUsuario` ASC) ,
  INDEX `fk_CartaoSaida_EstiloMovimentacao1` (`EstiloMovimentacao_nome` ASC, `EstiloMovimentacao_Usuario_idUsuario` ASC, `EstiloMovimentacao_PlanoContas_Tipo` ASC) ,
  CONSTRAINT `fk_CartaoSaida_Cartao2`
    FOREIGN KEY (`Cartao_idCartao` , `Cartao_Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Cartao` (`idCartao` , `Usuario_idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CartaoSaida_EstiloMovimentacao1`
    FOREIGN KEY (`EstiloMovimentacao_nome` , `EstiloMovimentacao_Usuario_idUsuario` , `EstiloMovimentacao_PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`EstiloMovimentacao` (`nome` , `Usuario_idUsuario` , `PlanoContas_Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`CartaoEntrada`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`CartaoEntrada` (
  `idCartaoEntrada` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(25) NOT NULL ,

  INDEX `fk_CartaoEntrada_Cartao1` (`Cartao_idCartao` ASC, `Cartao_Usuario_idUsuario` ASC) ,
  INDEX `fk_CartaoEntrada_EstiloMovimentacao1` (`EstiloMovimentacao_nome` ASC, `EstiloMovimentacao_Usuario_idUsuario` ASC, `EstiloMovimentacao_PlanoContas_Tipo` ASC) ,
  CONSTRAINT `fk_CartaoEntrada_Cartao1`
    FOREIGN KEY (`Cartao_idCartao` , `Cartao_Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Cartao` (`idCartao` , `Usuario_idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CartaoEntrada_EstiloMovimentacao1`
    FOREIGN KEY (`EstiloMovimentacao_nome` , `EstiloMovimentacao_Usuario_idUsuario` , `EstiloMovimentacao_PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`EstiloMovimentacao` (`nome` , `Usuario_idUsuario` , `PlanoContas_Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`BancoEntrada`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`BancoEntrada` (
  `idBancoEntrada` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(25) NOT NULL ,
  `valor` VARCHAR(45) NOT NULL ,
  `data` DATE NOT NULL ,
  INDEX `fk_BancoEntrada_EstiloMovimentacao1` (`EstiloMovimentacao_nome` ASC, `EstiloMovimentacao_Usuario_idUsuario` ASC, `EstiloMovimentacao_PlanoContas_Tipo` ASC) ,
  INDEX `fk_BancoEntrada_Banco1` (`Banco_idBanco` ASC, `Banco_Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_BancoEntrada_EstiloMovimentacao1`
    FOREIGN KEY (`EstiloMovimentacao_nome` , `EstiloMovimentacao_Usuario_idUsuario` , `EstiloMovimentacao_PlanoContas_Tipo` )
    REFERENCES `sisconfin`.`EstiloMovimentacao` (`nome` , `Usuario_idUsuario` , `PlanoContas_Tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BancoEntrada_Banco1`
    FOREIGN KEY (`Banco_idBanco` , `Banco_Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Banco` (`idBanco` , `Usuario_idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sisconfin`.`Saldo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sisconfin`.`Saldo` (
  `saldoCaixa` VARCHAR(120) NOT NULL ,
  INDEX `fk_Saldo_Usuario1` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Saldo_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `sisconfin`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


COMMIT;
