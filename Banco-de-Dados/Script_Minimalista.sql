CREATE DATABASE IF NOT EXISTS netmed;
USE netmed;


DROP TABLE IF EXISTS endereco;
DROP TABLE IF EXISTS atendente;
DROP TABLE IF EXISTS dadosTemposReal;
DROP TABLE IF EXISTS componentes;
DROP TABLE IF EXISTS maquina;
DROP TABLE IF EXISTS empresa;
 
CREATE DATABASE IF NOT EXISTS netmed;
USE netmed;

CREATE TABLE IF NOT EXISTS empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    cnpj CHAR(14),
    email VARCHAR(45),
    senha VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(60),
    bairro VARCHAR(60),
    cidade VARCHAR(60),
    estado VARCHAR(60),
    cep CHAR(8),
    numero VARCHAR(20),
    complemento VARCHAR(90),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS atendente (
    idAtendimento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    senha VARCHAR(255),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS maquina (
    idMaquina INT AUTO_INCREMENT PRIMARY KEY,
    nomeMaquina VARCHAR(45),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS componentes (
    fkMaquina INT,
    idComponente INT NOT NULL,
    tipoComponente VARCHAR(45),
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    PRIMARY KEY (fkMaquina, idComponente), -- Chave primária composta
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

CREATE TABLE IF NOT EXISTS dadosTempoReal (
    idDadosTempoReal INT AUTO_INCREMENT PRIMARY KEY,
    fkMaquina INT,
    fkComponente INT,
    dataHora DATETIME,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    unidadeMedida VARCHAR(150),
    FOREIGN KEY (fkMaquina, fkComponente) REFERENCES componentes(fkMaquina, idComponente)
);

SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM atendente;
SELECT * FROM maquina;
SELECT * FROM componentes;
SELECT * FROM dadosTempoReal;