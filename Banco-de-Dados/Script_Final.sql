-- DROP DATABASE IF EXISTS netmed;
CREATE DATABASE IF NOT EXISTS netmed;
USE netmed;

CREATE TABLE IF NOT EXISTS empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nomeFantasia VARCHAR(100),
    razaoSocial VARCHAR(100),
    apelido VARCHAR(60),
    cnpj CHAR(14)
);
-- insert into empresa values
	-- (null, 'Arcos Dourados', 'Fast Food', 'EME GIGANTE', '12345678901234');

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
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(30),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- insert into usuario values
	-- (null, 'recepção', 'Raimunda', 'raimunda@netmet.com' ,'1234', 1);

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
    metricaEstabelecida DOUBLE
);
INSERT INTO tipoComponente VALUES 
	(1, 'Sistema operacional', 'bits', null),
    (2, 'Memoria', 'GiB', 70.0),
	(3, 'Processador', 'GHz', 2.0),
	(4, 'Rede', 'Pacotes', 500000.0),
	(5, 'Disco ', 'Gib', 7988696064.0),
	(6, 'Volume  ', 'Gib', null),
	(7, 'Serviços   ', '%', null);

CREATE TABLE IF NOT EXISTS dadosFixos (
    idDadosFixos INT NOT NULL,
    fkMaquina INT,
    fkTipoComponente INT,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
	descrição varchar(200),
    PRIMARY KEY (idDadosFixos, fkMaquina, fkTipoComponente), -- Chave primária composta
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente)
);


CREATE TABLE IF NOT EXISTS dadosTempoReal (
    idDadosTempoReal INT AUTO_INCREMENT,
    fkDadosFixos INT,
    fkMaquina INT,
    fkTipoComponente INT,
    dataHora DATETIME,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
    -- unidadeMedida VARCHAR(150),
    PRIMARY KEY  (idDadosTempoReal, fkDadosFixos, fkMaquina, fkTipoComponente),
    FOREIGN KEY (fkDadosFixos) REFERENCES dadosFixos(idDadosFixos),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

CREATE TABLE IF NOT EXISTS fixosRede (
	idFixosRede INT AUTO_INCREMENT,
    fkMaquina INT,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(45),
    PRIMARY KEY (idFixosRede, fkMaquina),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

CREATE TABLE IF NOT EXISTS variaveisRede (
	idVariaveisRede INT AUTO_INCREMENT,
    fkFixosRede INT,
    fkMaquina INT,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(45),
    PRIMARY KEY (idVariaveisRede, fkFixosRede, fkMaquina),
    FOREIGN KEY (fkFixosRede) REFERENCES fixosRede(idFixosRede),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);


-- SELECT * FROM empresa;
-- SELECT * FROM endereco;
-- SELECT * FROM usuario;
-- SELECT * FROM maquina;
-- SELECT * FROM tipoComponente;
-- SELECT * FROM dadosTempoReal;
-- SELECT * FROM dadosFixos;
-- SELECT * FROM fixosRede;
-- SELECT * FROM variaveisRede;