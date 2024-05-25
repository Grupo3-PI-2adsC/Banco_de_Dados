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
insert into empresa values
	(null, 'Arcos Dourados', 'Fast Food', 'EME GIGANTE', '12345678901234');

CREATE TABLE IF NOT EXISTS endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8),
    rua VARCHAR(60),
    bairro VARCHAR(60),
    cidade VARCHAR(60),
    unidadeFederativa VARCHAR(60),
    numero int,
    complemento VARCHAR(90),
    atual BOOLEAN,
    fkEmpresa INT,
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

insert into usuario values
	(null, 'recepção', 'Raimunda', 'raimunda@netmet.com' ,'1234', 1);

CREATE TABLE IF NOT EXISTS maquina (
    idMaquina INT AUTO_INCREMENT PRIMARY KEY,
    hostName VARCHAR(45) unique,
    ativo Boolean,
    arquitetura int,	
    validado boolean,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS servicos(
	PID int,
    nome VARCHAR(50),
    estado boolean,
    fkMaquina int,
    foreign key (fkMaquina) references maquina(idMaquina),
    primary key (PID, fkMaquina)
);

CREATE TABLE IF NOT EXISTS tipoComponente (
	idTipoComponente INT primary key,
    nomeComponente VARCHAR(45),
    unidadeMedida VARCHAR(10),
    metricaEstabelecida double -- Métricas máximas e minimas?
);
INSERT INTO tipoComponente VALUES 
	(1, 'Sistema operacional', 'bits', null),
    (2, 'Memoria', 'GiB', 70.0),
	(3, 'Processador', 'GHz', 2.0),
	(4, 'Rede', 'Pacotes', 500000.0),
	(5, 'Disco ', 'Gib', 7988696064.0),
	(6, 'Volume  ', 'Gib', null),
	(7, 'Serviços   ', '%', null);

CREATE TABLE IF NOT EXISTS dadosFixos ( -- componentes
    idComponente INT NOT NULL,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
	descrição varchar(200),
    fkMaquina INT,
    fkTipoComponente INT,
    PRIMARY KEY (idComponente, fkMaquina, fkTipoComponente), -- Chave primária composta
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente)
);


CREATE TABLE IF NOT EXISTS dadosTempoReal (
    idDadosTempoReal INT AUTO_INCREMENT,
    dataHora DATETIME,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    fkComponente int,
    fkMaquina INT,
    fkTipoComponente INT,
    -- unidadeMedida VARCHAR(150),
    primary key  (idDadosTempoReal, fkComponente, fkMaquina, fkTipoComponente),
    FOREIGN KEY (fkComponente) REFERENCES dadosFixos(idComponente),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM usuario;
SELECT * FROM maquina;
SELECT * FROM tipoComponente;
SELECT * FROM dadosTempoReal;
SELECT * FROM dadosFixos;