CREATE DATABASE bd_Aula;
USE bd_Aula;

CREATE TABLE Professor (
    id_professor INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    data_contratacao DATE NOT NULL
);

CREATE TABLE Aluno (
    id_aluno INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    curso VARCHAR(100) NOT NULL,
    data_matricula DATE NOT NULL
);

CREATE TABLE Media (
    id_media INT IDENTITY PRIMARY KEY,
    id_professor INT NOT NULL,
    id_aluno INT NOT NULL,
    nota DECIMAL(4,2) NOT NULL,
    disciplina VARCHAR(100) NOT NULL,
    semestre VARCHAR(10) NOT NULL,
    data_registro DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);


WITH Numeros AS (
    SELECT TOP 20 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master.sys.all_objects
)
INSERT INTO Professor (nome, email, departamento, data_contratacao)
SELECT 
    CONCAT('Professor ', n), 
    CONCAT('professor', n, '@email.com'), 
    CASE (n % 5) 
        WHEN 0 THEN 'Matemática'
        WHEN 1 THEN 'História'
        WHEN 2 THEN 'Física'
        WHEN 3 THEN 'Química'
        ELSE 'Computação'
    END,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2020-01-01', GETDATE()), '2020-01-01')
FROM Numeros;

DECLARE @Cursos TABLE (curso VARCHAR(100));
INSERT INTO @Cursos (curso) 
VALUES ('Engenharia'), ('Medicina'), ('Direito'), ('Arquitetura'), ('Administração'), 
       ('Psicologia'), ('Computação'), ('Biologia'), ('Física'), ('Química');

WITH Numeros AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master.sys.all_objects
)
-- Inserir os 1000 alunos com um curso temporário (qualquer valor válido)
INSERT INTO Aluno (nome, email, curso, data_matricula)
SELECT 
    CONCAT('Aluno ', n),
    CONCAT('aluno', n, '_', CAST(NEWID() AS VARCHAR(36)), '@email.com'),  -- Garantir email único com NEWID()
    'Curso Temporário',  -- Valor temporário para o curso
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2020-01-01', GETDATE()), '2020-01-01')
FROM Numeros;

-- Atualizar os alunos com cursos aleatórios
WITH CursosAleatorios AS (
    SELECT 
        A.id_aluno,
        C.curso,
        ROW_NUMBER() OVER (PARTITION BY A.id_aluno ORDER BY NEWID()) AS RowNum
    FROM Aluno A
    CROSS JOIN (VALUES 
        ('Engenharia'), ('Medicina'), ('Direito'), ('Arquitetura'), ('Administração'),
        ('Psicologia'), ('Computação'), ('Biologia'), ('Física'), ('Química')
    ) AS C(curso)
)
UPDATE A
SET A.curso = CA.curso
FROM Aluno A
JOIN CursosAleatorios CA ON A.id_aluno = CA.id_aluno
WHERE CA.RowNum = 1;

WITH Numeros AS (
    SELECT TOP 20000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master.sys.all_objects a
    CROSS JOIN master.sys.all_objects b  -- Multiplica o número de linhas
)
INSERT INTO Media (id_professor, id_aluno, nota, disciplina, semestre, data_registro)
SELECT 
    ABS(CHECKSUM(NEWID())) % 20 + 1,  
    ABS(CHECKSUM(NEWID())) % 1000 + 1,
    ROUND(CAST((ABS(CHECKSUM(NEWID())) % 101) / 10.0 AS DECIMAL(4,2)), 2),
    CONCAT('Disciplina ', ABS(CHECKSUM(NEWID())) % 10 + 1),
    CONCAT('202', ABS(CHECKSUM(NEWID())) % 4 + 1, '-', ABS(CHECKSUM(NEWID())) % 2 + 1),
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2020-01-01', GETDATE()), '2020-01-01')
FROM Numeros;


