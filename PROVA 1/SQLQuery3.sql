
-- QUESTAO 7  - FEITO
-----------------------------------------------------------------
SELECT A.Nome , HISTORICO_ESCOLAR.Nota  , DISCIPLINA.Nome_disciplina
FROM ALUNO AS A
INNER JOIN HISTORICO_ESCOLAR ON A.Numero_aluno = HISTORICO_ESCOLAR.Numero_aluno
INNER JOIN DISCIPLINA ON A.Curso = DISCIPLINA.Departamento
WHERE A.Curso LIKE 'CC' AND DISCIPLINA.Nome_disciplina LIKE 'Banco de dados';
-----------------------------------------------------------------

-- QUESTAO 8  - ANALISAR
-----------------------------------------------------------------
SELECT D.Nome_disciplina AS 'NOME DISCIPLINA' ,  PRE_REQUISITO.Numero_pre_requisito 
FROM DISCIPLINA AS D
LEFT JOIN PRE_REQUISITO ON D.Numero_disciplina = PRE_REQUISITO.Numero_disciplina
INNER JOIN  DISCIPLINA AS P ON D.Numero_disciplina = P.Numero_disciplina
-----------------------------------------------------------------

-- QUESTAO 9 - FEITO
----------------------------------------------------------------- 
SELECT ALUNO.NOME , DISCIPLINA.Nome_disciplina , TURMA.Semestre, TURMA.Ano, HISTORICO_ESCOLAR.Nota
FROM TURMA
INNER JOIN DISCIPLINA ON TURMA.Numero_disciplina = DISCIPLINA.Numero_disciplina
INNER JOIN HISTORICO_ESCOLAR ON TURMA.Identificacao_turma = HISTORICO_ESCOLAR.Identificacao_turma
INNER JOIN ALUNO ON HISTORICO_ESCOLAR.Numero_aluno = ALUNO.Numero_aluno
WHERE ALUNO.Nome LIKE 'Silva'
----------------------------------------------------------------- 

-- QUESTAO 10 -  NAO FEITO
----------------------------------------------------------------- 
--declare @nomeAluno VARCHAR(50) set @nomeAluno = 'Bruno Fernandes';
--declare @Disciplina VARCHAR(50) set @Disciplina = 'MAT2410';

--CREATE FUNCTION FN_VerificaAprovacao  (@nomeAluno VARCHAR(50) , @Disciplina VARCHAR(50))
--RETURNS VARCHAR(50)

--AS  
--BEGIN
     


--RETURN 
--END;
----------------------------------------------------------------- 


-- QUESTAO 11 - 
----------------------------------------------------------------- 
alter PROCEDURE usp_convertNOTA
as
begin
     
     declare @NovaNota int
     DECLARE @notaC VARCHAR(50) SET @notaC =(SELECT HISTORICO_ESCOLAR.Nota
     FROM HISTORICO_ESCOLAR)

      if @notaC like 'A' 
        begin
            set @NovaNota = 10
        end

      if @notaC like 'B'
        begin
            set @NovaNota = 9
        end

     if @notaC like 'C' 
        begin
            set @NovaNota = 8
        end

    else 
        begin
        set @NovaNota = 0
        end


end;

EXEC usp_convertNOTA
----------------------------------------------------------------- 


-- QUESTAO 12
----------------------------------------------------------------- 

----------------------------------------------------------------- 


-- QUESTAO 13
----------------------------------------------------------------- 

ALTER PROCEDURE usp_CalcularIdadeAluno (@NumeroAluno int)
as
begin

    DECLARE @ano int
    set @ano = YEAR((select ALUNO.Data_Nascimento from aluno ))
    DECLARE @IDADE INT
    set @IDADE = 2025 - @ano

    select aluno.Nome , ALUNO.Data_Nascimento , @IDADE as idade
    from aluno
    where @NumeroAluno = aluno.Numero_aluno

END;
GO

exec dbo.usp_CalcularIdadeAluno 17;


-- QUESTAO 14
------------------------------------------------

CREATE PROCEDURE usp_AtualizarNota (@NumeroAluno int, @indent_turma int, @novaNota int)
as 
begin
    ALTER TABLE HISTORICO_ESCOLAR(Nota) VALUES 
    (@novaNota)

end;
go








