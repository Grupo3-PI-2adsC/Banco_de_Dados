USE master ;  
GO  
DROP DATABASE netmed ;  
GO  

-- Cria o banco de dados se ele não existir
IF DB_ID('netmed') IS NULL
BEGIN
    CREATE DATABASE netmed;
END
GO

USE netmed;
GO

-- Criação da tabela empresa
IF OBJECT_ID('empresa', 'U') IS NULL
BEGIN
    CREATE TABLE empresa (
        idEmpresa INT IDENTITY(1,1) PRIMARY KEY,
        nomeFantasia VARCHAR(100),
        razaoSocial VARCHAR(100),
        apelido VARCHAR(60),
        cnpj CHAR(14)
    );
END
GO
-- Criação da tabela usuario
IF OBJECT_ID('usuario', 'U') IS NULL
BEGIN
    CREATE TABLE usuario (
        idUsuario INT IDENTITY(1,1) PRIMARY KEY,
        tipoUsuario VARCHAR(45),
        nome VARCHAR(100),
        email VARCHAR(100) UNIQUE,
        senha VARCHAR(30),
        ativo BIT,
        fkEmpresa INT,
        FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
    );
END
GO


-- 1º Inserção de dados na tabela empresa
IF NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '12345678901234')
BEGIN
    INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj) VALUES
        ('Hospital São Paulo', 'CENTRO MEDICO SÃO PAULO SC LTDA', 'Hospital SP', '12345678901234');
END
GO

IF NOT EXISTS (SELECT * FROM usuario WHERE email = 'raimunda@netmet.com')
BEGIN
    INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa) VALUES
        ('representante', 'Raimunda Neto', 'raimunda@netmed.com', 'Raim@123', 1, 1);
END
GO



-- 2º Inserção de dados na tabela empresa
IF NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '09876543211234')
BEGIN
    INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj) VALUES
        ('CENTRO HOSPITALAR UNIMED', '	UNIMED DE JOINVILLE COOPERATIVA DE TRABALHOS MEDICOS', 'UNIMED', '09876543211234');
END

GO-- Inserção de dados na tabela usuario
IF NOT EXISTS (SELECT * FROM usuario WHERE email = 'cleiton@netmed.com')
BEGIN
    INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa) VALUES
        ('representante', 'Cleiton Olivaras', 'cleiton@netmed.com', 'Clei@123', 1, 2);
END
GO



-- 3º Inserção de dados na tabela empresa

IF NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '09876543210987')
BEGIN
    INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj) VALUES
        ('HOSPITAL SAO JOSE', '	ASSOCIACAO HOSPITALAR SAO JOSE DE JARAGUA DO SUL', 'SAO JOSE', '09876543210987');
END

GO-- Inserção de dados na tabela usuario
IF NOT EXISTS (SELECT * FROM usuario WHERE email = 'alberto@netmet.com')
BEGIN
    INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa) VALUES
        ('representante', 'Alberto Maverique', 'alberto@netmed.com', 'Albe@123', 1, 3);
END
GO

-- Criação da tabela endereco
IF OBJECT_ID('endereco', 'U') IS NULL
BEGIN
    CREATE TABLE endereco (
        idEndereco INT IDENTITY(1,1) PRIMARY KEY,
        cep CHAR(8),
        rua VARCHAR(60),
        bairro VARCHAR(60),
        cidade VARCHAR(60),
        unidadeFederativa VARCHAR(60),
        numero INT,
        complemento VARCHAR(90),
        atual BIT,
        fkEmpresa INT,
        FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
    );
END
GO


-- Criação da tabela maquina
IF OBJECT_ID('maquina', 'U') IS NULL
BEGIN
    CREATE TABLE maquina (
        idMaquina VARCHAR(45) PRIMARY KEY,
        hostName VARCHAR(45) UNIQUE,
        ativo BIT,
        arquitetura INT,
        validado BIT,
        fkEmpresa INT,
        FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
    );
END
GO
USE [netmed]
GO
-- Criação da tabela servicos
IF OBJECT_ID('servicos', 'U') IS NULL
BEGIN
    CREATE TABLE servicos(
        PID INT,
        nome VARCHAR(50),
        estado BIT,
        fkMaquina VARCHAR(45),
        PRIMARY KEY (PID, fkMaquina),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
    );
END
GO

-- Criação da tabela tipoComponente
IF OBJECT_ID('tipoComponente', 'U') IS NULL
BEGIN
    CREATE TABLE tipoComponente (
        idTipoComponente INT,
		fkEmpresa int,
        nomeComponente VARCHAR(45),
        unidadeMedida VARCHAR(10),
        metricaEstabelecida FLOAT,
		Primary key (fkEmpresa, idTipoComponente),
        FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
    );
END
GO

-- Inserção de dados na tabela tipoComponente
-- Verifica se os dados já existem antes de inserir
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 1)
BEGIN
    INSERT INTO tipoComponente VALUES 
        (1, 1, 'Sistema operacional', 'bits', NULL),
        (1, 2, 'Sistema operacional', 'bits', NULL),
        (1, 3, 'Sistema operacional', 'bits', NULL);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 2)
BEGIN
    INSERT INTO tipoComponente VALUES 
        (2, 1,'Memoria', 'GiB', 7.0),
        (2, 2,'Memoria', 'GiB', 7.0),
        (2, 3,'Memoria', 'GiB', 7.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 3)
BEGIN
    INSERT INTO tipoComponente  VALUES 
        (3, 1,'CPU', 'GHz', 13.0),
        (3, 2,'CPU', 'GHz', 13.0),
        (3, 3,'CPU', 'GHz', 13.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 4)
BEGIN
    INSERT INTO tipoComponente VALUES 
        (4, 1,'Rede', 'Pacotes', 3818363.0),
        (4, 2,'Rede', 'Pacotes', 3818363.0),
        (4, 3,'Rede', 'Pacotes', 3818363.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 5)
BEGIN
    INSERT INTO tipoComponente VALUES 
        (5, 1,'Disco', 'GiB', 700000.0),
        (5, 2,'Disco', 'GiB', 700000.0),
        (5, 3,'Disco', 'GiB', 700000.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 6)
BEGIN
    INSERT INTO tipoComponente VALUES 
        (6, 1,'Volume', 'GiB', NULL),
        (6, 2,'Volume', 'GiB', NULL),
        (6, 3,'Volume', 'GiB', NULL);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 7)
BEGIN
    INSERT INTO tipoComponente  VALUES 
        (7, 1,'Serviços', '%', NULL),
        (7, 2,'Serviços', '%', NULL),
        (7, 3,'Serviços', '%', NULL);
END
GO

-- Criação da tabela fixosRede
IF OBJECT_ID('fixosRede', 'U') IS NULL
BEGIN
    CREATE TABLE fixosRede (
        idFixosRede INT IDENTITY(1,1) PRIMARY KEY,
        fkTipoComponente INT,
		fkEmpresaDados int,
        fkMaquina VARCHAR(45),
        nomeCampo VARCHAR(45),
        valorCampo VARCHAR(255),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
        FOREIGN KEY (fkTipoComponente, fkEmpresaDados) REFERENCES tipoComponente(fkEmpresa, idTipoComponente)
    );
END
GO

-- Criação da tabela dadosFixos
IF OBJECT_ID('dadosFixos', 'U') IS NULL
BEGIN
    CREATE TABLE dadosFixos (
        idDadosFixos INT IDENTITY(1,1) PRIMARY KEY,
        fkMaquina VARCHAR(45),
		fkEmpresaDados int,
        fkTipoComponente INT,
        nomeCampo VARCHAR(45),
        valorCampo VARCHAR(150),
        descricao VARCHAR(200),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
        FOREIGN KEY (fkTipoComponente, fkEmpresaDados) REFERENCES tipoComponente(fkEmpresa, idTipoComponente)
    );
END
GO

-- Criação da tabela variaveisRede
IF OBJECT_ID('variaveisRede', 'U') IS NULL
BEGIN
    CREATE TABLE variaveisRede (
        idVariaveisRede INT IDENTITY(1,1) PRIMARY KEY,
        fkFixosRede INT,
        fkMaquina VARCHAR(45),
        dataHora DATETIME,
        nomeCampo VARCHAR(45),
        valorCampo VARCHAR(45),
        FOREIGN KEY (fkFixosRede) REFERENCES fixosRede(idFixosRede),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
    );
END
GO

IF OBJECT_ID('manuais', 'U') IS NULL
BEGIN
    CREATE TABLE manuais (
        idManual INT IDENTITY(1,1) PRIMARY KEY,
        tituloManual VARCHAR(45),
        descricaoManual VARCHAR(100),
        usuarioUltimaAlteracao int,
        dtUltimaAlteracao DATETIME,
		fkUsuarioCriador INT,
        dtCriacao DATETIME,
        FOREIGN KEY (fkUsuarioCriador) REFERENCES usuario(idUsuario),
    );
END
GO


-- Criação da tabela dadosTempoReal
IF OBJECT_ID('dadosTempoReal', 'U') IS NULL
BEGIN
    CREATE TABLE dadosTempoReal (
        idDadosTempoReal INT IDENTITY(1,1) PRIMARY KEY,
        fkDadosFixos INT,
        fkMaquina VARCHAR(45),
		fkEmpresaDados int,
        fkTipoComponente INT,
        dataHora DATETIME,
        nomeCampo VARCHAR(45),
        valorCampo VARCHAR(150),
        FOREIGN KEY (fkDadosFixos) REFERENCES dadosFixos(idDadosFixos),
        FOREIGN KEY (fkTipoComponente, fkEmpresaDados) REFERENCES tipoComponente(fkEmpresa, idTipoComponente),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
    );
END
GO
-- --select * from maquina where idMaquina = 'matteus-Nitro-AN515-57';






