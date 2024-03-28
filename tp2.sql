CREATE DATABASE PROJETO_TP2;

USE PROJETO_TP2;

CREATE TABLE CARGOS(
	CARGO_ID INT PRIMARY KEY AUTO_INCREMENT,
    DESCRICAO VARCHAR(255) NOT NULL,
    SALARIO_BASE DECIMAL(10, 2) NOT NULL,
    NIVEL_CARGO VARCHAR(20) NOT NULL,
    IMPORTANCIA VARCHAR(10) NOT NULL
);

CREATE TABLE DEPARTAMENTOS (
	DEPARTAMENTO_ID INT PRIMARY KEY AUTO_INCREMENT,
    NOME_DEPARTAMENTO VARCHAR(20) NOT NULL,
    FUNCIONARIO_GEN_ID INT,
    ANDAR INT NOT NULL,
    LOCAL_DEPARTAMENTO VARCHAR(20) NOT NULL
);

CREATE TABLE FUNCIONARIOS (
	FUNCIONARIO_ID INT PRIMARY KEY AUTO_INCREMENT,
    NOME_FUNCIONARIO VARCHAR(50) NOT NULL,
    CARGO_ID INT,
    DEPARTAMENTO_ID INT,
    SALARIO_REAL DECIMAL(10, 2) NOT NULL,
    TIPO_CONTRATO VARCHAR(3) NOT NULL
);

INSERT INTO CARGOS (DESCRICAO, SALARIO_BASE, NIVEL_CARGO, IMPORTANCIA) VALUES
	('Desenvolve habilidades básicas e aprende sobre o ambiente de trabalho.', 1000.00, 'Estagiário', 'Baixa'),
	('Técnico - Executa tarefas específicas com habilidades técnicas adquiridas.', 1500.00, 'Técnico', 'Baixa'),
	('Analisa informações e contribui para decisões organizacionais.', 4000.00, 'Analista', 'Média'),
	('Gerente - Supervisiona equipes e é responsável pela implementação de estratégias.', 12000.00, 'Gerente', 'Alta'),
	('Define diretrizes e objetivos organizacionais de alto nível.', 20000.00, 'Diretor', 'Alta');

INSERT INTO FUNCIONARIOS (NOME_FUNCIONARIO, CARGO_ID, DEPARTAMENTO_ID, SALARIO_REAL, TIPO_CONTRATO) VALUES 
	('Fernanda Costa', 4, 1, 12000.00, 'CLT'),
    ('Fernanda Costa', 4, 5, 12000.00, 'CLT'),
	('Rafael Oliveira', 4, 2, 12500.00, 'CLT'),
    ('Rafael Oliveira', 4, 6, 12500.00, 'CLT'),
	('Juliana Santos', 4, 3, 13000.00, 'CLT'),
	('Lucas Pereira', 4, 1, 900.00, 'PJ'),
	('Patrícia Almeida', 4, 1, 850.00, 'PJ'),
	('Guilherme Lima', 4, 6, 12250.00, 'CLT'),
	('Camila Rodrigues', 2, 1, 1500.00, 'PJ'),
	('Bruno Souza', 2, 2, 1550.00, 'PJ'),
	('Aline Ferreira', 2, 3, 1510.00, 'PJ'),
	('Roberto Castro', 2, 4, 1600.00, 'PJ'),
	('Larissa Santos', 2, 1, 1505.00, 'CLT'),
	('Diego Oliveira', NULL, NULL, 5900.00, 'PJ'),
	('Carolina Alves', 1, 1, 1000.00, 'PJ'),
	('Felipe Pereira', 1, 1, 1000.00, 'PJ'),
	('Renata Costa', 1, 2, 1000.00, 'PJ'),
	('Thiago Silva', 1, 3, 1000.00, 'PJ'),
	('Mariana Oliveira', 1, 4, 1000.00, 'PJ'),
	('Gustavo Santos',1 , 6, 1000.00, 'PJ'),
	('Vanessa Lima', 3, 1, 4900.00, 'CLT'),
	('Leonardo Almeida', 3, 2, 4000.00, 'CLT'),
	('Isabela Ferreira', 3, 3, 6300.00, 'CLT'),
	('Rodrigo Castro', 3, 4, 5000.00, 'CLT'),
	('Carla Santos', 3, 1, 5200.00, 'CLT'),
	('Gabriel Oliveira', 3, 2, 6000.00, 'CLT'),
	('Ana Paula Alves', 5, 1, 20000.00, 'CLT'),
	('Marcos Lima', 5, 2, 21000.00, 'CLT'),
	('Luciana Costa', 5, 4, 19000.00, 'CLT'),
	('Pedro Santos', 5, 5, 17000.00, 'CLT'),
	('Natália Oliveira', 5, 3, 25000.00, 'CLT');

INSERT INTO DEPARTAMENTOS (NOME_DEPARTAMENTO, FUNCIONARIO_GEN_ID, ANDAR, LOCAL_DEPARTAMENTO) VALUES 
	('Vendas', 1, 1, 'Edifício Principal'),
	('RH', 2, 2, 'Edifício Principal'),
	('TI', 3, 3, 'Edifício Principal'),
	('Financeiro', 4, 4, 'Anexo A'),
	('Marketing', 5, 5, 'Anexo A'),
    ('Relacionamento', 6, 6, 'Anexo A');
    
ALTER TABLE FUNCIONARIOS
ADD CONSTRAINT CARGO_ID
FOREIGN KEY (CARGO_ID) REFERENCES CARGOS(CARGO_ID);

ALTER TABLE FUNCIONARIOS
ADD CONSTRAINT DEPARTAMENTO_ID
FOREIGN KEY (DEPARTAMENTO_ID) REFERENCES DEPARTAMENTOS(DEPARTAMENTO_ID);

ALTER TABLE DEPARTAMENTOS
ADD CONSTRAINT FUNCIONARIO_GEN_ID
FOREIGN KEY (FUNCIONARIO_GEN_ID) REFERENCES FUNCIONARIOS(FUNCIONARIO_ID);

/*
1. Listar individualmente a tabela de Funcionários, Cargos e Departamentos em ordem
alfabética.
*/
SELECT *
FROM FUNCIONARIOS
ORDER BY NOME_FUNCIONARIO ASC;

SELECT *
FROM CARGOS
ORDER BY NIVEL_CARGO ASC;

SELECT *
FROM DEPARTAMENTOS
ORDER BY NOME_DEPARTAMENTO ASC;

/*
2. Listar todos os departamentos que ficam no quinto andar
*/
SELECT NOME_DEPARTAMENTO
FROM DEPARTAMENTOS
WHERE DEPARTAMENTOS.ANDAR = 5;

/*
3. Listar o analista que tem o salário mais alto
*/
SELECT NOME_FUNCIONARIO,
	SALARIO_REAL,
    NIVEL_CARGO
FROM FUNCIONARIOS F
JOIN CARGOS C ON F.CARGO_ID = C.CARGO_ID
WHERE C.NIVEL_CARGO = 'Analista'
ORDER BY F.SALARIO_REAL DESC
	LIMIT 1;

/*
4. Listar os funcionários que têm seu salário maior ou igual ao salário base no departamento
de TI.
*/
SELECT NOME_FUNCIONARIO,
	NIVEL_CARGO,
    NOME_DEPARTAMENTO,
    SALARIO_BASE,
    SALARIO_REAL
FROM FUNCIONARIOS
JOIN CARGOS ON FUNCIONARIOS.CARGO_ID = CARGOS.CARGO_ID
JOIN DEPARTAMENTOS ON FUNCIONARIOS.DEPARTAMENTO_ID = DEPARTAMENTOS.DEPARTAMENTO_ID
WHERE SALARIO_REAL >= SALARIO_BASE
	AND NOME_DEPARTAMENTO = 'TI';

/*
5. Listar qual departamento que possui o maior número de estagiários.
*/
SELECT NOME_DEPARTAMENTO,
    COUNT(FUNCIONARIO_ID) AS NUMERO_ESTAGIARIOS
FROM FUNCIONARIOS
JOIN CARGOS ON FUNCIONARIOS.CARGO_ID = CARGOS.CARGO_ID
JOIN DEPARTAMENTOS ON FUNCIONARIOS.DEPARTAMENTO_ID = DEPARTAMENTOS.DEPARTAMENTO_ID
WHERE NIVEL_CARGO = 'Estagiário'
GROUP BY NOME_DEPARTAMENTO
ORDER BY NUMERO_ESTAGIARIOS DESC;

/*
6. Listar todos os funcionários que não possuem um cargo associado.
*/
SELECT NOME_FUNCIONARIO,
	CARGO_ID
FROM FUNCIONARIOS
WHERE CARGO_ID IS NULL;

/*
7. Listar todos os funcionários que estão no andar mais alto.
*/
SELECT NOME_FUNCIONARIO,
	ANDAR
FROM FUNCIONARIOS
JOIN DEPARTAMENTOS ON FUNCIONARIOS.DEPARTAMENTO_ID = DEPARTAMENTOS.DEPARTAMENTO_ID
WHERE ANDAR = (
	SELECT MAX(ANDAR)
    FROM DEPARTAMENTOS);

/*
8. Listar o cargo que possui funcionários que ganham entre 3000 e 5000
*/
SELECT NIVEL_CARGO,
	SALARIO_BASE
FROM CARGOS
WHERE SALARIO_BASE BETWEEN 3000 AND 5000;

/*
9. Listar o nome de todos os gerentes que efetivamente chefiam pelo menos 2 departamentos.
*/
SELECT DISTINCT NOME_FUNCIONARIO
FROM FUNCIONARIOS
JOIN DEPARTAMENTOS ON FUNCIONARIOS.DEPARTAMENTO_ID = DEPARTAMENTOS.DEPARTAMENTO_ID
GROUP BY NOME_FUNCIONARIO
HAVING COUNT(DISTINCT DEPARTAMENTOS.DEPARTAMENTO_ID) >= 2;

/*
10. Listar o cargo que possui o salário mais baixo
*/
SELECT NIVEL_CARGO,
	SALARIO_BASE
FROM CARGOS
ORDER BY SALARIO_BASE ASC
LIMIT 1;

/*
11. Listar o departamento que o salário mais alto.
*/
SELECT NOME_DEPARTAMENTO,
	SALARIO_REAL
FROM FUNCIONARIOS
JOIN DEPARTAMENTOS ON FUNCIONARIOS.DEPARTAMENTO_ID = DEPARTAMENTOS.DEPARTAMENTO_ID
ORDER BY SALARIO_REAL DESC
LIMIT 1;

/*
12. Listar o andar onde ficam os diretores.
*/
SELECT ANDAR,
	NOME_FUNCIONARIO,
    NIVEL_CARGO
FROM FUNCIONARIOS
JOIN CARGOS ON FUNCIONARIOS.CARGO_ID = CARGOS.CARGO_ID
JOIN DEPARTAMENTOS ON FUNCIONARIOS.DEPARTAMENTO_ID = DEPARTAMENTOS.DEPARTAMENTO_ID
WHERE NIVEL_CARGO = 'Diretor';

/*
13. Listar funcionários em ordem alfabética, que atendam a uma lógica criada por você, a partir
do campo escolhido, que foi definido na tabela de funcionários.
*/
SELECT TIPO_CONTRATO,
	COUNT(TIPO_CONTRATO) AS QUANTIDADE_DE_CONTRATOS
FROM FUNCIONARIOS
GROUP BY TIPO_CONTRATO
ORDER BY TIPO_CONTRATO ASC;

/*
14. Listar cargos em ordem alfabética, que atendam a uma lógica criada por você, a partir do
campo escolhido, que foi definido na tabela de cargos.
*/
SELECT NIVEL_CARGO,
	IMPORTANCIA
FROM CARGOS
ORDER BY IMPORTANCIA ASC;

/*
15. Listar departamentos em ordem alfabética, que atendam a uma lógica criada por você, a
partir do campo escolhido, que foi definido na tabela de departamentos.
*/
SELECT LOCAL_DEPARTAMENTO,
    COUNT(LOCAL_DEPARTAMENTO) AS QUANTIDADE_DE_DEPARTAMENTOS_NO_LOCAL
FROM DEPARTAMENTOS
GROUP BY LOCAL_DEPARTAMENTO
ORDER BY LOCAL_DEPARTAMENTO ASC;