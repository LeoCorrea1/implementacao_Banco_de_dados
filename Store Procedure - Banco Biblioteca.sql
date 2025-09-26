-- 10
CREATE PROCEDURE ContarLivrosPorCategoria
AS
BEGIN
    SELECT c.tipo_categoria, COUNT(l.isbn) AS total
    FROM Categoria c
    LEFT JOIN Livro l ON c.id = l.fk_categoria
    GROUP BY c.tipo_categoria;
END;
GO

-- 11
CREATE PROCEDURE ListarLivrosPorNacionalidade @nacionalidadeAutor VARCHAR(50)
AS
BEGIN
    SELECT l.titulo
    FROM Livro l
    JOIN LivroAutor la ON l.isbn = la.fk_livro
    JOIN Autor a ON la.fk_autor = a.id
    WHERE a.nacionalidade = @nacionalidadeAutor;
END;
GO

-- 12
CREATE PROCEDURE AdicionarEditora @nomeEditora VARCHAR(100)
AS
BEGIN
    INSERT INTO Editora (nome) VALUES (@nomeEditora);
END;
GO

-- 13
CREATE PROCEDURE ExcluirEditora @idEditora INT
AS
BEGIN
    DELETE FROM Editora WHERE id = @idEditora;
END;
GO

-- 14
CREATE PROCEDURE ListarAutoresComLivros
AS
BEGIN
    SELECT a.nome, l.titulo
    FROM Autor a
    JOIN LivroAutor la ON a.id = la.fk_autor
    JOIN Livro l ON la.fk_livro = l.isbn;
END;
GO

-- 15
CREATE PROCEDURE CalcularAnoMedioPorCategoria @nomeCategoria VARCHAR(100)
AS
BEGIN
    SELECT AVG(l.ano) AS ano_medio
    FROM Livro l
    JOIN Categoria c ON l.fk_categoria = c.id
    WHERE c.tipo_categoria = @nomeCategoria;
END;
GO

-- 16
CREATE PROCEDURE AssociarAutorLivro @idAutor INT, @isbnLivro VARCHAR(50)
AS
BEGIN
    INSERT INTO LivroAutor (fk_autor, fk_livro) VALUES (@idAutor, @isbnLivro);
END;
GO

-- 17
CREATE PROCEDURE RemoverAutorDeLivro @idAutor INT, @isbnLivro VARCHAR(50)
AS
BEGIN
    DELETE FROM LivroAutor 
    WHERE fk_autor = @idAutor AND fk_livro = @isbnLivro;
END;
GO

-- 18
CREATE PROCEDURE ListarLivrosComMaisDeUmAutor
AS
BEGIN
    SELECT l.titulo
    FROM Livro l
    JOIN LivroAutor la ON l.isbn = la.fk_livro
    GROUP BY l.isbn, l.titulo
    HAVING COUNT(la.fk_autor) > 1;
END;
GO

-- 19
CREATE PROCEDURE ListarLivrosSemAutores
AS
BEGIN
    SELECT l.titulo
    FROM Livro l
    LEFT JOIN LivroAutor la ON l.isbn = la.fk_livro
    WHERE la.fk_autor IS NULL;
END;
GO

-- 20
CREATE PROCEDURE ListarLivrosSemEditora @idEditora INT
AS
BEGIN
    SELECT l.titulo
    FROM Livro l
    WHERE l.fk_editora <> @idEditora OR l.fk_editora IS NULL;
END;
GO
