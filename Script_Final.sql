-- Deletar banco de dados se existir
DROP DATABASE IF EXISTS netmed;

-- Cria o banco de dados se ele não existir
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

-- 1º Inserção de dados na tabela empresa
INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj)
SELECT 'Hospital São Paulo', 'CENTRO MEDICO SÃO PAULO SC LTDA', 'Hospital SP', '12345678901234'
WHERE NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '12345678901234');

-- 1º Inserção de dados na tabela usuario
INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa)
SELECT 'representante', 'Raimunda Neto', 'raimunda@netmed.com', 'Raim@123', TRUE, 1
WHERE NOT EXISTS (SELECT * FROM usuario WHERE email = 'raimunda@netmed.com');

-- 2º Inserção de dados na tabela empresa
INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj)
SELECT 'CENTRO HOSPITALAR UNIMED', 'UNIMED DE JOINVILLE COOPERATIVA DE TRABALHOS MEDICOS', 'UNIMED', '09876543211234'
WHERE NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '09876543211234');

-- 2º Inserção de dados na tabela usuario
INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa)
SELECT 'representante', 'Cleiton Olivaras', 'cleiton@netmed.com', 'Clei@123', TRUE, 2
WHERE NOT EXISTS (SELECT * FROM usuario WHERE email = 'cleiton@netmed.com');

-- 3º Inserção de dados na tabela empresa
INSERT INTO empresa (nomeFantasia, razaoSocial, apelido, cnpj)
SELECT 'HOSPITAL SAO JOSE', 'ASSOCIACAO HOSPITALAR SAO JOSE DE JARAGUA DO SUL', 'SAO JOSE', '09876543210987'
WHERE NOT EXISTS (SELECT * FROM empresa WHERE cnpj = '09876543210987');

-- 3º Inserção de dados na tabela usuario
INSERT INTO usuario (tipoUsuario, nome, email, senha, ativo, fkEmpresa)
SELECT 'representante', 'Alberto Maverique', 'alberto@netmed.com', 'Albe@123', TRUE, 3
WHERE NOT EXISTS (SELECT * FROM usuario WHERE email = 'alberto@netmed.com');

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
CREATE TABLE IF NOT EXISTS servicos (
    PID INT,
    nome VARCHAR(50),
    estado BOOLEAN,
    fkMaquina VARCHAR(45),
    PRIMARY KEY (PID, fkMaquina),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

-- Criação da tabela tipoComponente
CREATE TABLE IF NOT EXISTS tipoComponente (
    idTipoComponente INT,
    fkEmpresa INT,
    nomeComponente VARCHAR(45),
    unidadeMedida VARCHAR(10),
    metricaEstabelecida FLOAT,
    PRIMARY KEY (fkEmpresa, idTipoComponente),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- Inserção de dados na tabela tipoComponente
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 1, 1, 'Sistema operacional', 'bits', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 1);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 1, 2, 'Sistema operacional', 'bits', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 1);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 1, 3, 'Sistema operacional', 'bits', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 1);

INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 2, 1, 'Memoria', 'GiB', 7.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 2);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 2, 2, 'Memoria', 'GiB', 7.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 2);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 2, 3, 'Memoria', 'GiB', 7.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 2);

INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 3, 1, 'CPU', 'GHz', 13.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 3);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 3, 2, 'CPU', 'GHz', 13.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 3);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 3, 3, 'CPU', 'GHz', 13.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 3);

INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 4, 1, 'Rede', 'Pacotes', 3818363.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 4);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 4, 2, 'Rede', 'Pacotes', 3818363.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 4);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 4, 3, 'Rede', 'Pacotes', 3818363.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 4);

INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 5, 1, 'Disco', 'GiB', 700000.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 5);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 5, 2, 'Disco', 'GiB', 700000.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 5);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 5, 3, 'Disco', 'GiB', 700000.0 WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 5);

INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 6, 1, 'Volume', 'GiB', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 6);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 6, 2, 'Volume', 'GiB', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 6);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 6, 3, 'Volume', 'GiB', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 6);

INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 7, 1, 'Serviços', '%', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 7);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 7, 2, 'Serviços', '%', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 7);
INSERT INTO tipoComponente (idTipoComponente, fkEmpresa, nomeComponente, unidadeMedida, metricaEstabelecida)
SELECT 7, 3, 'Serviços', '%', NULL WHERE NOT EXISTS (SELECT * FROM tipoComponente WHERE idTipoComponente = 7);

-- Criação da tabela fixosRede
CREATE TABLE IF NOT EXISTS fixosRede (
    idFixosRede INT AUTO_INCREMENT PRIMARY KEY,
    fkTipoComponente INT,
    fkEmpresaDados INT,
    fkMaquina VARCHAR(45),
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(255),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkTipoComponente, fkEmpresaDados) REFERENCES tipoComponente(fkEmpresa, idTipoComponente)
);

-- Criação da tabela dadosFixos
CREATE TABLE IF NOT EXISTS dadosFixos (
    idDadosFixos INT AUTO_INCREMENT PRIMARY KEY,
    fkMaquina VARCHAR(45),
    fkEmpresaDados INT,
    fkTipoComponente INT,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    descricao VARCHAR(200),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkTipoComponente, fkEmpresaDados) REFERENCES tipoComponente(fkEmpresa, idTipoComponente)
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
    fkEmpresaDados INT,
    fkTipoComponente INT,
    dataHora DATETIME,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    FOREIGN KEY (fkDadosFixos) REFERENCES dadosFixos(idDadosFixos),
    FOREIGN KEY (fkTipoComponente, fkEmpresaDados) REFERENCES tipoComponente(fkEmpresa, idTipoComponente),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

-- Exemplo de consulta
-- SELECT * FROM maquina WHERE idMaquina = 'matteus-Nitro-AN515-57';