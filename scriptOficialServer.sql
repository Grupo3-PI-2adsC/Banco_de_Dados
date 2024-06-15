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

-- Inserção de dados na tabela empresa
IF NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '12345678901234')
BEGIN
    INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj) VALUES
        ('Arcos Dourados', 'Fast Food', 'EME GIGANTE', '12345678901234');
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

-- Inserção de dados na tabela usuario
IF NOT EXISTS (SELECT * FROM usuario WHERE email = 'raimunda@netmet.com')
BEGIN
    INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa) VALUES
        ('recepção', 'Raimunda', 'raimunda@netmet.com', '1234', 1, 1);
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
        idTipoComponente INT PRIMARY KEY,
        nomeComponente VARCHAR(45),
        unidadeMedida VARCHAR(10),
        metricaEstabelecida FLOAT
    );
END
GO

-- Inserção de dados na tabela tipoComponente
-- Verifica se os dados já existem antes de inserir
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 1)
BEGIN
    INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida) VALUES 
        (1, 'Sistema operacional', 'bits', NULL);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 2)
BEGIN
    INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida) VALUES 
        (2, 'Memoria', 'GiB', 70.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 3)
BEGIN
    INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida) VALUES 
        (3, 'Processador', 'GHz', 2.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 4)
BEGIN
    INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida) VALUES 
        (4, 'Rede', 'Pacotes', 500000.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 5)
BEGIN
    INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida) VALUES 
        (5, 'Disco', 'GiB', 7988696064.0);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 6)
BEGIN
    INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida) VALUES 
        (6, 'Volume', 'GiB', NULL);
END
GO
IF NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 7)
BEGIN
    INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida) VALUES 
        (7, 'Serviços', '%', NULL);
END
GO

-- Criação da tabela fixosRede
IF OBJECT_ID('fixosRede', 'U') IS NULL
BEGIN
    CREATE TABLE fixosRede (
        idFixosRede INT IDENTITY(1,1) PRIMARY KEY,
        fkMaquina VARCHAR(45),
        nomeCampo VARCHAR(45),
        valorCampo VARCHAR(255),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
    );
END
GO

-- Criação da tabela dadosFixos
IF OBJECT_ID('dadosFixos', 'U') IS NULL
BEGIN
    CREATE TABLE dadosFixos (
        idDadosFixos INT IDENTITY(1,1) PRIMARY KEY,
        fkMaquina VARCHAR(45),
        fkTipoComponente INT,
        nomeCampo VARCHAR(45),
        valorCampo VARCHAR(150),
        descricao VARCHAR(200),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
        FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente)
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
        fkTipoComponente INT,
        dataHora DATETIME,
        nomeCampo VARCHAR(45),
        valorCampo VARCHAR(150),
        FOREIGN KEY (fkDadosFixos) REFERENCES dadosFixos(idDadosFixos),
        FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente),
        FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
    );
END
GO
select * from maquina where idMaquina = 'matteus-Nitro-AN515-57';








-- Inserção de dados na tabela empresa
IF NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '12345678901234')
BEGIN
    INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj) VALUES
        ('Arcos Dourados', 'Fast Food', 'EME GIGANTE', '12345678901234');
END
GO

-- Inserção de dados na tabela usuario
IF NOT EXISTS (SELECT * FROM usuario WHERE email = 'raimunda@netmet.com')
BEGIN
    INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa) VALUES
        ('recepção', 'Raimunda', 'raimunda@netmet.com', '1234', 1, 1);
END
GO

