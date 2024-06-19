-- Usar banco de dados 'mysql' como padrão para garantir que 'netmed' possa ser deletado
USE mysql;

-- Excluir o banco de dados 'netmed' se ele existir
DROP DATABASE IF EXISTS netmed;

-- Criação do banco de dados se ele não existir
CREATE DATABASE IF NOT EXISTS netmed;
USE netmed;

-- Criação da tabela empresa
CREATE TABLE IF NOT EXISTS empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nomeFantasia VARCHAR(100),
    razaoSocial VARCHAR(100),
    apelido VARCHAR(60),
    cnpj CHAR(14)
);

-- Inserção de dados na tabela empresa
INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj) 
SELECT 'Arcos Dourados', 'Fast Food', 'EME GIGANTE', '12345678901234'
WHERE NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '12345678901234');

-- Criação da tabela endereco
CREATE TABLE IF NOT EXISTS endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8),
    rua VARCHAR(60),
    bairro VARCHAR(60),
    cidade VARCHAR(60),
    unidadeFederativa VARCHAR(60),
    numero INT,
    complemento VARCHAR(90),
    atual BOOLEAN,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- Criação da tabela usuario
CREATE TABLE IF NOT EXISTS usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    tipoUsuario VARCHAR(45),
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(30),
    ativo BOOLEAN,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- Inserção de dados na tabela usuario
INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa) 
SELECT 'recepção', 'Raimunda', 'raimunda@netmet.com', '1234', TRUE, 1
WHERE NOT EXISTS (SELECT * FROM usuario WHERE email = 'raimunda@netmet.com');

-- Criação da tabela maquina
CREATE TABLE IF NOT EXISTS maquina (
    idMaquina VARCHAR(45) PRIMARY KEY,
    hostName VARCHAR(45) UNIQUE,
    ativo BOOLEAN,
    arquitetura INT,
    validado BOOLEAN,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- Criação da tabela servicos
CREATE TABLE IF NOT EXISTS servicos(
    PID INT,
    nome VARCHAR(50),
    estado BOOLEAN,
    fkMaquina VARCHAR(45),
    PRIMARY KEY (PID, fkMaquina),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

-- Criação da tabela tipoComponente
CREATE TABLE IF NOT EXISTS tipoComponente (
    idTipoComponente INT PRIMARY KEY,
    nomeComponente VARCHAR(45),
    unidadeMedida VARCHAR(10),
    metricaEstabelecida FLOAT
);

-- Inserção de dados na tabela tipoComponente
INSERT INTO tipoComponente (idTipoComponente, nomeComponente, unidadeMedida, metricaEstabelecida)
VALUES 
    (1, 'Sistema operacional', 'bits', NULL),
    (2, 'Memoria', 'GiB', 70.0),
    (3, 'Processador', 'GHz', 2.0),
    (4, 'Rede', 'Pacotes', 500000.0),
    (5, 'Disco', 'GiB', 7988696064.0),
    (6, 'Volume', 'GiB', NULL),
    (7, 'Serviços', '%', NULL)
ON DUPLICATE KEY UPDATE
    nomeComponente = VALUES(nomeComponente),
    unidadeMedida = VALUES(unidadeMedida),
    metricaEstabelecida = VALUES(metricaEstabelecida);

-- Criação da tabela fixosRede
CREATE TABLE IF NOT EXISTS fixosRede (
    idFixosRede INT AUTO_INCREMENT PRIMARY KEY,
    fkMaquina VARCHAR(45),
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(255),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

-- Criação da tabela dadosFixos
CREATE TABLE IF NOT EXISTS dadosFixos (
    idDadosFixos INT AUTO_INCREMENT PRIMARY KEY,
    fkMaquina VARCHAR(45),
    fkTipoComponente INT,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    descricao VARCHAR(200),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente)
);

-- Criação da tabela variaveisRede
CREATE TABLE IF NOT EXISTS variaveisRede (
    idVariaveisRede INT AUTO_INCREMENT PRIMARY KEY,
    fkFixosRede INT,
    fkMaquina VARCHAR(45),
    dataHora DATETIME,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(45),
    FOREIGN KEY (fkFixosRede) REFERENCES fixosRede(idFixosRede),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

-- Criação da tabela manuais
CREATE TABLE IF NOT EXISTS manuais (
    idManual INT AUTO_INCREMENT PRIMARY KEY,
    tituloManual VARCHAR(45),
    descricaoManual VARCHAR(100),
    usuarioUltimaAlteracao INT,
    dtUltimaAlteracao DATETIME,
    fkUsuarioCriador INT,
    dtCriacao DATETIME,
    FOREIGN KEY (fkUsuarioCriador) REFERENCES usuario(idUsuario)
);

-- Criação da tabela dadosTempoReal
CREATE TABLE IF NOT EXISTS dadosTempoReal (
    idDadosTempoReal INT AUTO_INCREMENT PRIMARY KEY,
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

-- Seleciona todas as máquinas com idMaquina 'matteus-Nitro-AN515-57'
SELECT * FROM maquina WHERE idMaquina = 'matteus-Nitro-AN515-57';

-- Inserção de dados na tabela empresa
INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj) 
SELECT 'Arcos Dourados', 'Fast Food', 'EME GIGANTE', '12345678901234'
WHERE NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '12345678901234');

-- Inserção de dados na tabela usuario
INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa) 
SELECT 'recepção', 'Raimunda', 'raimunda@netmet.com', '1234', TRUE, 1
WHERE NOT EXISTS (SELECT * FROM usuario WHERE email = 'raimunda@netmet.com');