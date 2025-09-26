
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

-- QUESTAO 10 -  ANALISAR
----------------------------------------------------------------- 
declare @nomeAluno VARCHAR(50) set @nomeAluno = 'Bruno Fernandes';
declare @Disciplina VARCHAR(50) set @Disciplina = 'MAT2410';


CREATE FUNCTION FN_VerificaAprovacao (@nomeAluno VARCHAR(50) , @Disciplina VARCHAR(50))
RETURNS VARCHAR(50)

AS  
BEGIN
     declare @situacao VARCHAR(50)

     DECLARE @nota VARCHAR(50) SET @nota =(SELECT HISTORICO_ESCOLAR.Nota
     FROM HISTORICO_ESCOLAR
     INNER JOIN TURMA ON TURMA.Numero_disciplina = @Disciplina
     WHERE HISTORICO_ESCOLAR.Identificacao_turma = 85)

     if @nota like 'A' OR @nota like 'B'
        begin
            set @situacao = 'ALUNO APROVADO'
        end

     if @nota like 'C' 
        begin
            set @situacao = 'ALUNO EM RECUPERACAO'
        end

    else 
        set @situacao = 'ALUNO REPROVADO'

RETURN @situacao
END;
GO

SELECT dbo.FN_VerificaAprovacao 'Bruno Fernandes', 'MAT2410'
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

create procedure
SELECT HISTORICO_ESCOLAR.Identificacao_turma ,COUNT(HISTORICO_ESCOLAR.Identificacao_turma) FROM HISTORICO_ESCOLAR
GROUP BY HISTORICO_ESCOLAR.Identificacao_turma

IF (

-----------------------------------------------------------------

-- QUESTAO 13
----------------------------------------------------------------- 
ALTER PROCEDURE usp_calculaIdade ( @NumeroAluno int)
as
begin
            

    DECLARE @ano INT SET @ano = YEAR((SELECT ALUNO.Data_Nascimento FROM ALUNO))


    DECLARE @idade INT SET @idade  = YEAR('2025-09-26') - @ano 

    select aluno.Nome , ALUNO.Data_Nascimento 
    from aluno
    where @NumeroAluno = aluno.Numero_aluno
END;
GO

exec usp_calculaIdade 17


-- QUESTAO 14
------------------------------------------------
ALTER PROCEDURE usp_AtualizarNota (@NumeroAluno int, @indent_turma int, @novaNota VARCHAR(10))
as 
begin
    
    SELECT ALUNO.NOME ,HISTORICO_ESCOLAR.Numero_aluno , HISTORICO_ESCOLAR.Identificacao_turma , HISTORICO_ESCOLAR.Nota , @novaNota AS 'Nova Nota'
    from HISTORICO_ESCOLAR
    INNER JOIN ALUNO ON ALUNO.Numero_aluno = HISTORICO_ESCOLAR.Numero_aluno
    WHERE HISTORICO_ESCOLAR.Numero_aluno = @NumeroAluno and HISTORICO_ESCOLAR.Identificacao_turma = @indent_turma


end;
go

EXEC usp_AtualizarNota 17 , 112 , 'F'

