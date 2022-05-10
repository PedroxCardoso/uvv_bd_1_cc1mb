-- Questão 1.

SELECT AVG(salario) AS media_salarial, d.nome_departamento
FROM funcionario f
INNER JOIN departamento d ON(d.numero_departamento = f.numero_departamento)
GROUP BY d.nome_departamento;

-- Questão 2.

SELECT AVG(salario) AS media_salarial, f.sexo
FROM funcionario f
GROUP BY f.sexo;

-- Questão 3.

SELECT d.nome_departamento,
CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
f.data_nascimento,
timestampdiff(YEAR, f.data_nascimento, now()) AS idade,
f.salario
FROM departamento d
INNER JOIN funcionario f;

-- Questão 4.

SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
timestampdiff(YEAR, f.data_nascimento, now()) AS idade,
f.salario AS "salario atual",
(case 
when (f.salario < 35) then 20
ELSE 15
END) AS taxa_reajuste,
(case
when (f.salario < 35) then f.salario + (f.salario * 0.2)
ELSE f.salario + (f.salario * 0.15)
END) AS salario_ajustado
FROM funcionario f;

-- Questão 5.

WITH gerente AS(
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome,
f.cpf
FROM funcionario f
)
SELECT d.nome_departamento,
CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
f.data_nascimento,
timestampdiff(year, data_nascimento, now()) AS idade,
f.salario,
g.nome AS nome_gerente
FROM departamento d
INNER JOIN funcionario f
ON f.numero_departamento = d.numero_departamento
INNER JOIN gerente g ON g.cpf = d.cpf_gerente
ORDER BY d.nome_departamento ASC, f.salario DESC;

-- Questão 6.

SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
dn.nome_dependente,
d.nome_departamento,
timestampdiff(YEAR, dn.data_nascimento, curdate()) AS idade_dependente,
(CASE
WHEN (dn.sexo = 'M') THEn 'Masculino'
ELSE 'Feminino'
END) AS sexo_dependente
FROM departamento d
INNER JOIN funcionario f
ON f.numero_departamento = d.numero_departamento
INNER JOIN dependente dn ON dn.cpf_funcionario = f.cpf;

-- Questão 7.

SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome, ' ') AS nome_funcionario, dp.nome_departamento,
f.salario 
FROM funcionario f
RIGHT JOIN departamento dp ON(dp.numero_departamento = f.numero_departamento)
LEFT JOIN dependente d ON (f.cpf = d.cpf_funcionario)
WHERE d.cpf_funcionario IS NULL;

-- Questão 8.

SELECT d.nome_departamento,
CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
p.nome_projeto AS projeto, t.horas AS horas
FROM departamento d
LEFT OUTER JOIN projeto p ON(d.numero_departamento = p.numero_departamento)
LEFT OUTER JOIN funcionario f ON(f.numero_departamento = p.numero_departamento)
LEFT OUTER JOIN trabalha_em t ON (t.numero_projeto = p.numero_projeto);    

-- Questao 9.

SELECT d.nome_departamento,
p.nome_projeto AS projeto, 
SUM(DISTINCT(t.horas)) AS horas_totais
FROM trabalha_em t
LEFT OUTER JOIN funcionario f ON(t.cpf_funcionario = f.cpf)
LEFT OUTER JOIN departamento d ON(f.numero_departamento = d.numero_departamento)
LEFT OUTER JOIN projeto p ON(d.numero_departamento = p.numero_departamento)
GROUP BY p.nome_projeto;

-- Questão 10.

SELECT d.nome_departamento,
AVG(f.salario) AS salario 
FROM funcionario f
INNER JOIN departamento d ON(f.numero_departamento = d.numero_departamento)
GROUP BY d.nome_departamento;

-- Questão 11.

SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
p.nome_projeto,
(case
when t.horas > 0 then (t.horas * 50)
ELSE 0
END) AS "total p/hora"
FROM funcionario f
INNER JOIN trabalha_em t ON(t.cpf_funcionario = f.cpf)
INNER JOIN projeto p ON (t.numero_projeto = p.numero_projeto)
GROUP BY p.nome_projeto;

-- Questão 12.

SELECT d.nome_departamento AS nome_departamento,
p.nome_projeto, 
f.primeiro_nome as nome_funcionario,t.horas AS horas_trabalhadas
FROM funcionario f
INNER JOIN departamento d ON (f.numero_departamento = d.numero_departamento)
INNER JOIN projeto p ON (d.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON (p.numero_projeto = t.numero_projeto)
WHERE t.horas = 0;


-- Questão 13.

SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome, ' ') AS nome_funcionario,
(case 
when(f.sexo = "M")then "Masculino"
ELSE "Feminino"
END) AS sexo,
timestampdiff(YEAR, f.data_nascimento, now()) AS idade 
FROM funcionario f
UNION 
SELECT CONCAT (d.nome_dependente, ' ', f.nome_meio, ' ', f.ultimo_nome, ' ') AS nome_dependente,
(case 
when(d.sexo = "M")then "Masculino"
ELSE "Feminino"
END) AS sexo,
timestampdiff(YEAR, d.data_nascimento, now()) AS idade 
FROM dependente d
INNER JOIN funcionario f ON (d.cpf_funcionario = f.cpf)
ORDER BY idade DESC;

-- Questão 14.

SELECT d.nome_departamento, COUNT(f.numero_departamento) AS QntFuncionarios
FROM funcionario f
INNER JOIN departamento d ON(f.numero_departamento = d.numero_departamento)
GROUP BY d.nome_departamento;

-- Questão 15.

SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome, ' ') AS nome_funcionario,
d.nome_departamento, p.nome_projeto
FROM funcionario f
INNER JOIN departamento d ON(f.numero_departamento = d.numero_departamento)
INNER JOIN projeto p ON (d.numero_departamento = p.numero_departamento)
ORDER BY f.primeiro_nome ASC;
