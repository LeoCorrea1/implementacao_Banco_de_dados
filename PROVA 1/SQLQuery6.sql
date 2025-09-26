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

SELECT FN_VerificaAprovacao
----------------------------------------------------------------- 