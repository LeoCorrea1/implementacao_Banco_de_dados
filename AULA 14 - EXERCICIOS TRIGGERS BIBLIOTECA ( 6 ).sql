-- 1
CREATE TRIGGER trg_no_duplicate_title
ON Livro
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 
               FROM Livro l 
               JOIN inserted i ON l.titulo = i.titulo)
        PRINT('Título já existe, inserção bloqueada.')
    ELSE
        INSERT INTO Livro (isbn, titulo, ano, fk_editora, fk_categoria)
        SELECT isbn, titulo, ano, fk_editora, fk_categoria FROM inserted
END
GO

-- 2
CREATE TRIGGER trg_update_ano_publicacao
ON Livro
AFTER INSERT
AS
BEGIN
    UPDATE Livro
    SET ano = YEAR(GETDATE())
    WHERE isbn IN (SELECT isbn FROM inserted)
END
GO

-- 3
CREATE TRIGGER trg_delete_livroautor
ON Livro
AFTER DELETE
AS
BEGIN
    DELETE FROM LivroAutor WHERE fk_livro IN (SELECT isbn FROM deleted)
END
GO

-- 6
CREATE TABLE Auditoria (
    id INT IDENTITY PRIMARY KEY,
    acao VARCHAR(100),
    datahora DATETIME
);
GO

CREATE TRIGGER trg_log_update_livro
ON Livro
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (acao, datahora)
    VALUES ('Livro atualizado', GETDATE());
END
GO

-- 9
CREATE TRIGGER trg_limite_livros_autor
ON LivroAutor
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @autor INT;
    SELECT @autor = fk_autor FROM inserted;

    IF (SELECT COUNT(*) FROM LivroAutor WHERE fk_autor = @autor) >= 5
        PRINT('Autor já tem 5 livros cadastrados.');
    ELSE
        INSERT INTO LivroAutor (fk_livro, fk_autor)
        SELECT fk_livro, fk_autor FROM inserted;
END
GO

-- 10
ALTER TABLE Categoria ADD total_livros INT DEFAULT 0;
GO

CREATE TRIGGER trg_update_total_livros_categoria
ON Livro
AFTER INSERT
AS
BEGIN
    UPDATE Categoria
    SET total_livros = total_livros + 1
    WHERE id IN (SELECT fk_categoria FROM inserted);
END
GO
