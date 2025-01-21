SELECT curso, COUNT(*) AS total_alunos FROM Aluno GROUP BY curso


--tirando media das diciplinas por data 
SELECT 
    M.disciplina,
    M.semestre,
    AVG(M.nota) AS media_nota
FROM Media M
GROUP BY M.disciplina, M.semestre
ORDER BY M.disciplina, M.semestre;

SELECT 
    M.disciplina,
    M.semestre,
    AVG(M.nota) AS media_nota,
    COUNT(*) AS total_registros,  -- Conta quantos registros há para cada disciplina e semestre
    P.nome AS Professor,
    A.curso AS Curso
FROM Media M
JOIN Professor P ON M.id_professor = P.id_professor
JOIN Aluno A ON M.id_aluno = A.id_aluno
GROUP BY M.disciplina, M.semestre, P.nome, A.curso
ORDER BY M.disciplina, M.semestre;


SELECT 
    M.disciplina,
    AVG(M.nota) AS media_nota,
    COUNT(DISTINCT M.id_aluno) AS total_alunos 
FROM Media M
GROUP BY M.disciplina
ORDER BY media_nota DESC;

