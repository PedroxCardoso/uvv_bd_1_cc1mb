-- QUESTÃO 01

SELECT AVG(salario) AS media_salarial, departamento.nome_departamento
FROM funcionario
INNER JOIN departamento ON(departamento.numero_departamento = funcionario.numero_departamento)
GROUP BY departamento.nome_departamento

--QUESTÃO 03

SELECT AVG(salario) AS media_salarial, funcionario.sexo
FROM funcionario
GROUP BY funcionario.sexo

--QUESTÃO 03

SELECT  d.nome_departamento,
concat(primeiro_nome, " ", nome_meio, ". ", ultimo_nome) AS nomes_funcionarios,
f.data_nascimento,
timestampdiff(year, data_nascimento, now()) AS idade,
f.salario
FROM departamento d
INNER JOIN funcionario f
ON f.numero_departamento = d.numero_departamento;

-- QUESTÃO 04

SELECT CONCAT (primeiro_nome, " ", nome_meio, ". ", ultimo_nome) AS nomes_funcionarios, 
timestampdiff(year, data_nascimento, curdate()) as idade,
f.salario AS salario_atual,
(CASE
WHEN (f.salario < 35000) THEN f.salario + (f.salario * 0.2)
ELSE f.salario + (f.salario * 0.15)
END) AS salario_ajustado
FROM funcionario f;

--QUESTÃO 05



--QUESTÃO 06



--QUESTÃO 07




--QUESTÃO 08



--QUESTÃO 09




--QUESTÃO 10




--QUESTÃO 11




--QUESTÃO 12



--QUESTÃO 13




--QUESTÃO 14



-- QUESTÃO 15



