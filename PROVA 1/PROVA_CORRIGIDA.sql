-----------------------------------------------------------------

SELECT A.Nome , HISTORICO_ESCOLAR.Nota  , DISCIPLINA.Nome_disciplina
FROM ALUNO AS A
INNER JOIN HISTORICO_ESCOLAR ON A.Numero_aluno = HISTORICO_ESCOLAR.Numero_aluno
INNER JOIN DISCIPLINA ON A.Curso = DISCIPLINA.Departamento
WHERE A.Curso LIKE 'CC' AND DISCIPLINA.Nome_disciplina LIKE 'Banco de dados';


-- CORRIGIDO
SELECT  A.Nome , HISTORICO_ESCOLAR.Nota  , DISCIPLINA.Nome_disciplina
FROM ALUNO AS A
INNER JOIN HISTORICO_ESCOLAR ON A.Numero_aluno = HISTORICO_ESCOLAR.Numero_aluno
inner join TURMA ON TURMA.Identificacao_turma = HISTORICO_ESCOLAR.Identificacao_turma
INNER JOIN DISCIPLINA ON TURMA.Numero_disciplina = DISCIPLINA.Numero_disciplina
WHERE DISCIPLINA.Nome_disciplina LIKE 'Banco de dados';


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

GO
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

SELECT DBO.FN_VerificaAprovacao ('Bruno Fernandes', 'MAT2410') as Situacao




--corrigido

GO
CREATE FUNCTION FN_VerificaAprovacaoo (@nomeAluno VARCHAR(50), @Disciplina VARCHAR(50))
RETURNS VARCHAR(50)
AS  
BEGIN
    DECLARE @situacao VARCHAR(50);
    DECLARE @nota CHAR(1);


    SET @nota = (
        SELECT TOP 1 H.Nota
        FROM HISTORICO_ESCOLAR H
        INNER JOIN TURMA T ON T.Numero_disciplina = @Disciplina
        INNER JOIN ALUNO A ON A.Nome = @nomeAluno
        WHERE H.Identificacao_turma = T.Identificacao_turma
    );


    IF (@nota IN ('A','B'))
        SET @situacao = 'ALUNO APROVADO';
    ELSE IF (@nota = 'C')
        SET @situacao = 'ALUNO EM RECUPERACAO';
    ELSE
        SET @situacao = 'ALUNO REPROVADO';

    RETURN @situacao;
END;
GO

SELECT DBO.FN_VerificaAprovacaoo('Bruno Fernandes', 'MAT2410') AS Situacao;

----------------------------------------------------------------- 

-- QUESTAO 11 - 
----------------------------------------------------------------- 

ALTER PROCEDURE usp_convertNOTA
as
begin
     
     declare @NovaNota int
     DECLARE @notaC VARCHAR(50) SET @notaC =(SELECT top 1 HISTORICO_ESCOLAR.Nota
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



--CORRIGIDO 

GO
CREATE PROCEDURE usp_convertNOTA1 
    @nomeAluno VARCHAR(50) = NULL,
    @disciplina VARCHAR(50) = NULL
AS
BEGIN
    SELECT 
        H.Nota AS NotaOriginal,
        CASE 
            WHEN H.Nota = 'A' THEN 10
            WHEN H.Nota = 'B' THEN 9
            WHEN H.Nota = 'C' THEN 8
            ELSE 0
        END AS NotaConvertida
    FROM HISTORICO_ESCOLAR H
    INNER JOIN TURMA T ON T.Identificacao_turma = H.Identificacao_turma
    INNER JOIN ALUNO A ON A.Numero_aluno = H.Numero_aluno
    WHERE 
        (@nomeAluno IS NULL OR A.Nome = @nomeAluno)
        AND (@disciplina IS NULL OR T.Numero_disciplina = @disciplina);
END;
GO

-- Executando
EXEC usp_convertNOTA1 @nomeAluno = 'Bruno Fernandes';

----------------------------------------------------------------- 

-- QUESTAO 12
----------------------------------------------------------------- 
DECLARE @QTD INT;

SELECT @QTD = COUNT(*)
FROM HISTORICO_ESCOLAR
WHERE HISTORICO_ESCOLAR.Identificacao_turma = 85

IF(@QTD >= 5)
    SELECT 'TURMA LOTADA'
    ELSE 
        SELECT 'TURMA COM VAGA'

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
    
    UPDATE HISTORICO_ESCOLAR  (
    SELECT ALUNO.NOME ,HISTORICO_ESCOLAR.Numero_aluno , HISTORICO_ESCOLAR.Identificacao_turma , HISTORICO_ESCOLAR.Nota , @novaNota AS 'Nova Nota'
    from HISTORICO_ESCOLAR
    INNER JOIN ALUNO ON ALUNO.Numero_aluno = HISTORICO_ESCOLAR.Numero_aluno
    WHERE HISTORICO_ESCOLAR.Numero_aluno = @NumeroAluno and HISTORICO_ESCOLAR.Identificacao_turma = @indent_turma)


end;
go

EXEC usp_AtualizarNota 17 , 112 , 'F'


-- CORRIGIDO


CREATE PROCEDURE usp_AtualizarNotaa
    @NumeroAluno INT, 
    @Ident_turma INT, 
    @novaNota VARCHAR(10)
AS 
BEGIN

    UPDATE HISTORICO_ESCOLAR
    SET Nota = @novaNota
    WHERE Numero_aluno = @NumeroAluno
      AND Identificacao_turma = @Ident_turma;


    SELECT 
        A.Nome, 
        H.Numero_aluno, 
        H.Identificacao_turma, 
        H.Nota AS NotaAtualizada
    FROM HISTORICO_ESCOLAR H
    INNER JOIN ALUNO A ON A.Numero_aluno = H.Numero_aluno
    WHERE H.Numero_aluno = @NumeroAluno
      AND H.Identificacao_turma = @Ident_turma;
END;
GO

EXEC usp_AtualizarNotaa 17, 112, 'F';
