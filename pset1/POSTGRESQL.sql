-- DROP SCHEMA elmasri;

CREATE SCHEMA elmasri AUTHORIZATION pedro;

-- DROP TYPE elmasri.departamento;



CREATE TYPE elmasri.departamento AS (
	numero_departamento int4,
	nome_departamento varchar(15),
	cpf_gerente bpchar(11),
	data_inicio_gerente date);

-- DROP TYPE elmasri.dependente;

CREATE TYPE elmasri.dependente AS (
	cpf_funcionario bpchar(11),
	nome_dependente varchar(15),
	sexo bpchar(1),
	data_nascimento date,
	parentesco varchar(15));

-- DROP TYPE elmasri.funcionario;

CREATE TYPE elmasri.funcionario AS (
	cpf bpchar(11),
	primeiro_nome varchar(15),
	nome_meio bpchar(1),
	ultimo_nome varchar(15),
	data_nascimento date,
	endereco varchar(50),
	sexo bpchar(1),
	salario numeric(10,2),
	cpf_supervisor bpchar(11),
	numero_departamento int4);

-- DROP TYPE elmasri.localizacoes_departamento;

CREATE TYPE elmasri.localizacoes_departamento AS (
	numero_departamento int4,
	"local" varchar(15));

-- DROP TYPE elmasri.projeto;

CREATE TYPE elmasri.projeto AS (
	numero_projeto int4,
	nome_projeto varchar(15),
	local_projeto varchar(15),
	numero_departamento int4);

-- DROP TYPE elmasri.trabalha_em;

CREATE TYPE elmasri.trabalha_em AS (
	cpf_funcionario bpchar(11),
	numero_projeto int4,
	horas numeric(3,1));

-- DROP TYPE elmasri."_departamento";

CREATE TYPE elmasri."_departamento" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = elmasri.departamento,
	DELIMITER = ',');

-- DROP TYPE elmasri."_dependente";

CREATE TYPE elmasri."_dependente" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = elmasri.dependente,
	DELIMITER = ',');

-- DROP TYPE elmasri."_funcionario";

CREATE TYPE elmasri."_funcionario" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = elmasri.funcionario,
	DELIMITER = ',');

-- DROP TYPE elmasri."_localizacoes_departamento";

CREATE TYPE elmasri."_localizacoes_departamento" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = elmasri.localizacoes_departamento,
	DELIMITER = ',');

-- DROP TYPE elmasri."_projeto";

CREATE TYPE elmasri."_projeto" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = elmasri.projeto,
	DELIMITER = ',');

-- DROP TYPE elmasri."_trabalha_em";

CREATE TYPE elmasri."_trabalha_em" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = elmasri.trabalha_em,
	DELIMITER = ',');
-- elmasri.funcionario definition

-- Drop table

-- DROP TABLE elmasri.funcionario;

CREATE TABLE elmasri.funcionario (
	cpf bpchar(11) NOT NULL,
	primeiro_nome varchar(15) NOT NULL,
	nome_meio bpchar(1) NULL,
	ultimo_nome varchar(15) NOT NULL,
	data_nascimento date NULL,
	endereco varchar(50) NULL,
	sexo bpchar(1) NULL,
	salario numeric(10, 2) NULL,
	cpf_supervisor bpchar(11) NOT NULL,
	numero_departamento int4 NOT NULL,
	CONSTRAINT funcionario_pk PRIMARY KEY (cpf),
	CONSTRAINT funcionario_funcionario_fk FOREIGN KEY (cpf_supervisor) REFERENCES elmasri.funcionario(cpf)
);


-- elmasri.departamento definition

-- Drop table

-- DROP TABLE elmasri.departamento;

CREATE TABLE elmasri.departamento (
	numero_departamento int4 NOT NULL,
	nome_departamento varchar(15) NOT NULL,
	cpf_gerente bpchar(11) NOT NULL,
	data_inicio_gerente date NULL,
	CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento),
	CONSTRAINT funcionario_departamento_fk FOREIGN KEY (cpf_gerente) REFERENCES elmasri.funcionario(cpf)
);
CREATE UNIQUE INDEX departamento_idx ON elmasri.departamento USING btree (nome_departamento);


-- elmasri.dependente definition

-- Drop table

-- DROP TABLE elmasri.dependente;

CREATE TABLE elmasri.dependente (
	cpf_funcionario bpchar(11) NOT NULL,
	nome_dependente varchar(15) NOT NULL,
	sexo bpchar(1) NULL,
	data_nascimento date NULL,
	parentesco varchar(15) NULL,
	CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente),
	CONSTRAINT funcionario_dependente_fk FOREIGN KEY (cpf_funcionario) REFERENCES elmasri.funcionario(cpf)
);


-- elmasri.localizacoes_departamento definition

-- Drop table

-- DROP TABLE elmasri.localizacoes_departamento;

CREATE TABLE elmasri.localizacoes_departamento (
	numero_departamento int4 NOT NULL,
	"local" varchar(15) NOT NULL,
	CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local),
	CONSTRAINT departamento_localizacoes_departamento_fk FOREIGN KEY (numero_departamento) REFERENCES elmasri.departamento(numero_departamento)
);


-- elmasri.projeto definition

-- Drop table

-- DROP TABLE elmasri.projeto;

CREATE TABLE elmasri.projeto (
	numero_projeto int4 NOT NULL,
	nome_projeto varchar(15) NOT NULL,
	local_projeto varchar(15) NULL,
	numero_departamento int4 NOT NULL,
	CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto),
	CONSTRAINT departamento_projeto_fk FOREIGN KEY (numero_departamento) REFERENCES elmasri.departamento(numero_departamento)
);
CREATE UNIQUE INDEX projeto_idx ON elmasri.projeto USING btree (nome_projeto);


-- elmasri.trabalha_em definition

-- Drop table

-- DROP TABLE elmasri.trabalha_em;

CREATE TABLE elmasri.trabalha_em (
	cpf_funcionario bpchar(11) NOT NULL,
	numero_projeto int4 NOT NULL,
	horas numeric(3, 1) NOT NULL,
	CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto),
	CONSTRAINT funcionario_trabalha_em_fk FOREIGN KEY (cpf_funcionario) REFERENCES elmasri.funcionario(cpf),
	CONSTRAINT projeto_trabalha_em_fk FOREIGN KEY (numero_projeto) REFERENCES elmasri.projeto(numero_projeto)
);





INSERT INTO elmasri.dependente
       (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
       VALUES('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
       INSERT INTO elmasri.dependentes
       (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
       VALUES('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho');
       INSERT INTO elmasri.dependente
       (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
       VALUES('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa');
       INSERT INTO elmasri.dependente
       (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
       VALUES('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
       INSERT INTO elmasri.dependentes
       (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
       VALUES('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
       INSERT INTO elmasri.dependente
       (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
       VALUES('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
       INSERT INTO elmasri.dependente
       (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
       VALUES('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');



INSERT INTO elmasri.departamento
      (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
      VALUES('Pesquisa', 5, '33344555587', '1988-05-22');
      INSERT INTO elmasri.departamento
      (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
      VALUES('Administração', 4, '98765432168', '1995-01-01');
      INSERT INTO elmasri.departamento
      (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
      VALUES('Matriz', 1, '88866555576', '1981-06-19');



INSERT INTO elmasri.localizacao_departamento
      (numero_departamento, `local`)
       VALUES(1, 'São Paulo');
       INSERT INTO elmasri.localizacao_departamento
       (numero_departamento, `local`)
       VALUES(4, 'Mauá');
       INSERT INTO elmasri.localizacao_departamento
       (numero_departamento, `local`)
       VALUES(5, 'Santo André');
       INSERT INTO elmasri.localizacao_departamento
       (numero_departamento, `local`)
       VALUES(5, 'Itu');
       INSERT INTO elmasri.localizacao_departamento
       (numero_departamento, `local`)
        VALUES(5, 'São Paulo');


INSERT INTO elmasri.projeto
        (numero_projeto, nome_projeto, local_projeto, numero_departamento)
        VALUES(1, 'ProdutoX', 'Santo André', 5);
        INSERT INTO elmasri.projeto
        (numero_projeto, nome_projeto, local_projeto, numero_departamento)
        VALUES(2, 'ProdutoY', 'Itu', 5);
        INSERT INTO elmasri.projeto
        (numero_projeto, nome_projeto, local_projeto, numero_departamento)
        VALUES(3, 'ProdutoZ', 'São Paulo', 5);
        INSERT INTO elmasri.projeto
        (numero_projeto, nome_projeto, local_projeto, numero_departamento)
        VALUES(10, 'Informatização', 'Mauá', 4);
        INSERT INTO elmasri.projeto
        (numero_projeto, nome_projeto, local_projeto, numero_departamento)
        VALUES(20, 'Reorganização', 'São Paulo', 1);
        INSERT INTO elmasri.projeto
        (numero_projeto, nome_projeto, local_projeto, numero_departamento)
        VALUES(30, 'Novosbenefícios', 'Mauá', 4);

INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('12345678966', 1, 32.5);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('12345678966', 2, 7.5);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('66688444476', 3, 40.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('45345345376', 1, 20.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('45345345376', 2, 20.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('33344555587', 2, 10.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('33344555587', 3, 10.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('33344555587', 10, 10.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('33344555587', 20, 10.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('99988777767', 30, 30.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('99988777767', 10, 10.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('98798798733', 10, 35.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('98798798733', 30, 5.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('98765432168', 30, 20.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('98765432168', 20, 15.0);
        INSERT INTO elmasri.trabalha_em
        (cpf_funcionario, numero_projeto, horas)
        VALUES('88866555576', 20, NULL);


INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores,751, São Paulo, SP', 'M', 30000.0, '33344555587', 5);
         INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000.0, '88866555576', 5);
         INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000.0, '98765432168', 4);
         INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000.0, '88866555576', 4);
         INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças, 55, Piracicaba, SP', 'M', 38000.0, '33344555587', 5);
         INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000.0, '33344555587', 5);
         INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP ', 'M', 25000.0, '98765432168', 4);
         INSERT INTO elmasri.funcionario
         (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
         VALUES('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000.00, 'NULL', 1);








