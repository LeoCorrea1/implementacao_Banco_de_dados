-- QUESTAO 14
------------------------------------------------

CREATE PROCEDURE usp_AtualizarNota (@NumeroAluno int, @indent_turma int, @novaNota int)
as 
begin
    ALTER TABLE HISTORICO_ESCOLAR(Nota) VALUES 
    (@novaNota)
    
    