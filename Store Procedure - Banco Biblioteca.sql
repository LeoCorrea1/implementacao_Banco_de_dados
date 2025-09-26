-- 10 - Contar livros por categoria
CREATE PROCEDURE ContarLivrosPorCategoria
AS
BEGIN
    SELECT 
        c.tipo_categoria AS Categoria, 
        COUNT(l.isbn) AS TotalLivros
    FROM Categoria c
    LEFT JOIN Livro l ON c.id = l.fk_categoria
    GROUP BY c.tipo_categoria;
END;
GO

-- 11 - Listar livros por nacionalidade do autor
CREATE PROCEDURE ListarLivrosPorNacionalidade @nacionalidadeAutor VARCHAR(50)
AS
BEGIN
    SELECT 
        l.titulo AS Livro
    FROM Livro l
    JOIN LivroAutor la ON l.isbn = la.fk_livro
    JOIN Autor a ON la.fk_autor = a.id
    WHERE a.nacionalidade = @nacionalidadeAutor;
END;
GO

-- 12 - Adicionar editora
CREATE PROCEDURE AdicionarEditora @nomeEditora VARCHAR(100)
AS
BEGIN
    INSERT INTO Editora (nome) VALUES (@nomeEditora);
END;
GO

-- 13 - Excluir editora
CREATE PROCEDURE ExcluirEditora @idEditora INT
AS
BEGIN
    DELETE FROM Editora WHERE id = @idEditora;
END;
GO

-- 14 - Listar autores com seus livros
CREATE PROCEDURE ListarAutoresComLivros
AS
BEGIN
    SELECT 
        a.nome AS Autor, 
        l.titulo AS Livro
    FROM Autor a
    JOIN LivroAutor la ON a.id = la.fk_autor
    JOIN Livro l ON la.fk_livro = l.isbn;
END;
GO

-- 15 - Calcular ano médio de publicação por categoria
CREATE PROCEDURE CalcularAnoMedioPorCategoria @nomeCategoria VARCHAR(100)
AS
BEGIN
    SELECT 
        AVG(l.ano) AS AnoMedio
    FROM Livro l
    JOIN Categoria c ON l.fk_categoria = c.id
    WHERE c.tipo_categoria = @nomeCategoria;
END;
GO

-- 16 - Associar autor a um livro
CREATE PROCEDURE AssociarAutorLivro @idAutor INT, @isbnLivro VARCHAR(50)
AS
BEGIN
    INSERT INTO LivroAutor (fk_autor, fk_livro) VALUES (@idAutor, @isbnLivro);
END;
GO

-- 17 - Remover autor de um livro
CREATE PROCEDURE RemoverAutorDeLivro @idAutor INT, @isbnLivro VARCHAR(50)
AS
BEGIN
    DELETE FROM LivroAutor 
    WHERE fk_autor = @idAutor AND fk_livro = @isbnLivro;
END;
GO

-- 18 - Listar livros com mais de um autor
CREATE PROCEDURE ListarLivrosComMaisDeUmAutor
AS
BEGIN
    SELECT 
        l.titulo AS Livro
    FROM Livro l
    JOIN LivroAutor la ON l.isbn = la.fk_livro
    GROUP BY l.isbn, l.titulo
    HAVING COUNT(la.fk_autor) > 1;
END;
GO

-- 19 - Listar livros sem autores
CREATE PROCEDURE ListarLivrosSemAutores
AS
BEGIN
    SELECT 
        l.titulo AS Livro
    FROM Livro l
    LEFT JOIN LivroAutor la ON l.isbn = la.fk_livro
    WHERE la.fk_autor IS NULL;
END;
GO

-- 20 - Listar livros que não pertencem a uma editora específica
CREATE PROCEDURE ListarLivrosSemEditora @idEditora INT
AS
BEGIN
    SELECT 
        l.titulo AS Livro
    FROM Livro l
    WHERE l.fk_editora <> @idEditora OR l.fk_editora IS NULL;
END;
GO
