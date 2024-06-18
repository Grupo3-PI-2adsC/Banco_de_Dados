DROP DATABASE IF EXISTS netmed;
CREATE DATABASE IF NOT EXISTS netmed;
USE netmed;
	
-- 		CREATE USER 'Netmed'@'localhost' IDENTIFIED BY 'Netmed#1@@';
--  		GRANT ALL PRIVILEGES ON * . * TO 'Netmed'@'localhost';
--  		FLUSH PRIVILEGES;

CREATE TABLE IF NOT EXISTS empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nomeFantasia VARCHAR(100),
    razaoSocial VARCHAR(100),
    apelido VARCHAR(60),
    cnpj CHAR(14)
);

CREATE TABLE IF NOT EXISTS usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    tipoUsuario VARCHAR(45),
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(30),
    ativo Boolean,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

insert into empresa values
	(null, 'Hospital São Paulo', 'CENTRO MEDICO SÃO PAULO SC LTDA', 'Hospital SP', '12345678901234');
insert into empresa values
	(null, 'CENTRO HOSPITALAR UNIMED', 'UNIMED DE JOINVILLE COOPERATIVA DE TRABALHOS MEDICOS', 'UNIMED', '09876543211234');
insert into empresa values
	(null, 'HOSPITAL SAO JOSE', 'ASSOCIACAO HOSPITALAR SAO JOSE DE JARAGUA DO SUL', 'SAO JOSE', '09876543210987');	 
	
	
 insert into usuario values
	 (null, 'representante', 'Raimunda Neto', 'raimunda@netmed.com' ,'Raim@123', 1, 1);
 insert into usuario values
	 (null, 'representante', 'Cleiton Olivaras', 'cleiton@netmed.com' ,'Clei@123', 2, 1);
 insert into usuario values
	 (null, 'representante', 'Alberto Maverique', 'alberto@netmet.com' ,'Albe@123', 3, 1);	

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


CREATE TABLE IF NOT EXISTS manuais (
    idManual INT AUTO_INCREMENT PRIMARY KEY,
    tituloManual VARCHAR(45),
    descricaoManual VARCHAR(100),
    usuárioUltimaAlteracao VARCHAR(100) UNIQUE,
    dtUltimaAlteracao DATE,
    fkUsuarioCriador INT,
    dtCriacao DATE,
    FOREIGN KEY (fkUsuarioCriador) REFERENCES usuario(idUsuario)
);

CREATE TABLE IF NOT EXISTS maquina (
    idMaquina varchar(45) PRIMARY KEY,
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
    fkMaquina varchar(45) ,
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
    idDadosFixos INT NOT NULL auto_increment,
    fkMaquina varchar(45) ,
    fkTipoComponente INT,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(150),
	descricao varchar(200),
    PRIMARY KEY (idDadosFixos, fkMaquina, fkTipoComponente), -- Chave primária composta
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente)
);


CREATE TABLE IF NOT EXISTS dadosTempoReal (
    idDadosTempoReal INT AUTO_INCREMENT,
    fkDadosFixos INT,
    fkMaquina varchar(45) ,
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
    fkMaquina varchar(45) ,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(255),
    PRIMARY KEY (idFixosRede, fkMaquina),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

CREATE TABLE IF NOT EXISTS variaveisRede (
	idVariaveisRede INT AUTO_INCREMENT,
    fkFixosRede INT,
    fkMaquina varchar(45) ,
    dataHora DATETIME,
    nomeCampo VARCHAR(45),
    valorCampo VARCHAR(45),
    PRIMARY KEY (idVariaveisRede, fkFixosRede, fkMaquina),
    FOREIGN KEY (fkFixosRede) REFERENCES fixosRede(idFixosRede),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);
SELECT * FROM usuario WHERE email = 'raimunda@netmet.com' AND senha = '1234';
-- use netmed
insert into maquina values ('vmNaFe', 'sla', 1, 64, 0, 1);
-- delete from maquina where idMaquina = 2
-- select idDadosFixos from dadosFixos where fkMaquina = 1 and fkTipoComponente = 2 and nomeCampo = 'total de memoria do computador'
-- truncate table dadosTempoReal;
-- SELECT * FROM empresa;
-- SELECT * FROM endereco;	
-- SELECT * FROM usuario;
-- SELECT * FROM maquina;
-- SELECT * FROM tipoComponente;
-- SELECT * FROM dadosTempoReal;
-- SELECT * FROM dadosFixos order by 3;
-- SELECT * FROM fixosRede;
-- SELECT * FROM variaveisRede;

select * from dadosFixos where fkMaquina = 'matteus-Nitro-AN515-57';
select idDadosFixos from dadosFixos where fkMaquina = 'matteus-Nitro-AN515-57' and fkTipoComponente = 2 and nomeCampo = 'total de memoria do computador'
