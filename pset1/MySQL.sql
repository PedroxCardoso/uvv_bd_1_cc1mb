
CREATE DATABASE uvv;

-- criação da tabela funcionário, onde a PK é CPF.

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);

-- criação da tabela departamento, onde a PK é NUMERO_DEPARTAMENTO.

CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

-- criação da tabela projeto, onde PK é NUMERO_PROJETO.

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);


CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

-- Criação da tabela trabalha_em onde as PK são CPF_FUNCIONARIO e NUMERO_PROJETO.

CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);

-- criação da tabela localizacoes_departamento, onde as PK são NUMERO_DEPARTAMENTOe LOCAL.

CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);

-- Criação da tabela dependente, onde as PK são CPF_FUNCIONARIO e NOME_DEPENDENTE.

CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);

-- Criação das FK, relacionando-as.

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- INSERÇÃO DOS VALORES.

INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores,751, São Paulo, SP', 'M', 30000.0, '33344555587', 5);
INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000.0, '88866555576', 5);
INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000.0, '98765432168', 4);
INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000.0, '88866555576', 4);
INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças, 55, Piracicaba, SP', 'M', 38000.0, '33344555587', 5);
INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000.0, '33344555587', 5);
INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP ', 'M', 25000.0, '98765432168', 4);
INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000.00, 'NULL', 1);


INSERT INTO dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
INSERT INTO dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho');
INSERT INTO dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa');
INSERT INTO dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
INSERT INTO dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');



INSERT INTO departamento(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES('Pesquisa', 5, '33344555587', '1988-05-22');
INSERT INTO departamento(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES('Administração', 4, '98765432168', '1995-01-01');
INSERT INTO departamento(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES('Matriz', 1, '88866555576', '1981-06-19');


INSERT INTO localizacao_departamento(numero_departamento, `local`)
VALUES(1, 'São Paulo');
INSERT INTO localizacao_departamento(numero_departamento, `local`)
VALUES(4, 'Mauá');
INSERT INTO localizacao_departamento(numero_departamento, `local`)
VALUES(5, 'Santo André');
INSERT INTO localizacao_departamento(numero_departamento, `local`)
VALUES(5, 'Itu');
INSERT INTO localizacao_departamento(numero_departamento, `local`)
VALUES(5, 'São Paulo');


INSERT INTO projeto(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(1, 'ProdutoX', 'Santo André', 5);
INSERT INTO projeto(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(2, 'ProdutoY', 'Itu', 5);
INSERT INTO projeto(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(3, 'ProdutoZ', 'São Paulo', 5);
INSERT INTO projeto(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(10, 'Informatização', 'Mauá', 4);
INSERT INTO projeto(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(20, 'Reorganização', 'São Paulo', 1);
INSERT INTO projeto(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(30, 'Novosbenefícios', 'Mauá', 4);

INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('12345678966', 1, 32.5);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('12345678966', 2, 7.5);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('66688444476', 3, 40.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('45345345376', 1, 20.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('45345345376', 2, 20.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 2, 10.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 3, 10.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 10, 10.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 20, 10.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('99988777767', 30, 30.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('99988777767', 10, 10.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('98798798733', 10, 35.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('98798798733', 30, 5.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('98765432168', 30, 20.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('98765432168', 20, 15.0);
INSERT INTO trabalha_em(cpf_funcionario, numero_projeto, horas)
VALUES('88866555576', 20, NULL);





