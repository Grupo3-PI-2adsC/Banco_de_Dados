DROP DATABASE IF EXISTS netmed;
CREATE DATABASE IF NOT EXISTS netmed;
USE netmed;

CREATE TABLE IF NOT EXISTS empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nomeFantasia VARCHAR(100),
    razaoSocial VARCHAR(100),
    apelido VARCHAR(60),
    cnpj CHAR(14)
);

CREATE TABLE IF NOT EXISTS endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8),
    rua VARCHAR(60),
    bairro VARCHAR(60),
    cidade VARCHAR(60),
    unidadeFederativa VARCHAR(60),
    numero VARCHAR(20),
    complemento VARCHAR(90),
    fkEmpresa INT,
    atual BOOLEAN,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    tipoUsuario VARCHAR(45),
    nome VARCHAR(100),
    email VARCHAR(100),
    senha VARCHAR(30),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS maquina (
    idMaquina INT AUTO_INCREMENT PRIMARY KEY,
    hostName VARCHAR(45),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS tipoComponente (
	idTipoComponente INT primary key,
    nomeComponente VARCHAR(45),
    unidadeMedida VARCHAR(10),
    metricaEstabelecida DECIMAL(10,10) -- Métricas máximas e minimas?
);

CREATE TABLE IF NOT EXISTS componentes (
    idComponente INT NOT NULL,
    fkMaquina INT,
    fkTipoComponente INT,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    PRIMARY KEY (idComponente, fkMaquina, fkTipoComponente), -- Chave primária composta
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente)
);

CREATE TABLE IF NOT EXISTS dadosTempoReal (
    idDadosTempoReal INT AUTO_INCREMENT PRIMARY KEY,
    fkComponente INT,
    fkMaquina INT,
    fkTipoComponente INT,
    dataHora DATETIME,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    unidadeMedida VARCHAR(150),
    FOREIGN KEY (fkComponente, fkMaquina, fkTipoComponente) 
    REFERENCES componentes(idComponente, fkMaquina, fkTipoComponente)
);

SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM usuario;
SELECT * FROM maquina;
SELECT * FROM componentes;
SELECT * FROM dadosTempoReal;