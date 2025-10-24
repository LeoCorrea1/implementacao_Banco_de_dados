CREATE DATABASE RESTRICOES;
USE RESTRICOES;


CREATE TABLE petShop
(
	id INT PRIMARY KEY IDENTITY,
	nomeDono VARCHAR(50) UNIQUE ,
	nomePet VARCHAR(50) NOT NULL ,
	idadePet INT CHECK ( idadePet > 0 ),
	sexoPet CHAR CHECK ( sexoPet in ( 'M' , 'F', 'N' ))
	
);

INSERT INTO petShop VALUES ('Herysson', 'Logan' , 7, 'M');
INSERT INTO petShop VALUES ('Juca', 'Jaguara' , 10, 'Femea');

CREATE TABLE Produto 
(
	cod INT PRIMARY KEY ,
	nome VARCHAR(50),
	categoria VARCHAR(50)
);

CREATE TABLE Inventario 
(
	id INT PRIMARY KEY IDENTITY,
	codProduto INT,
	quantidade INT,
	minLevel INT,
	maxLevel INT,

	CONSTRAINT fk_inv_produto
		FOREIGN KEY (codProduto)
		REFERENCES Produto ( cod )
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Venda 
(
	idVenda INT PRIMARY KEY IDENTITY,
	codProduto INT,
	quantidade INT
);

--OUTRA FORMA DE CRIAR RESTRIÇAO
--ALTER TABLE Inventario
--ADD CONSTRAINT fk_inv_produto
--FOREIGN KEY (codProduto)
--		REFERENCES Produto ( cod )
--		ON DELETE CASCADE
--		ON UPDATE CASCADE;

INSERT INTO Produto
VALUES (1 ,	'Sabao' , 'Higiene'),
	   (2 , 'Coca' , 'Bebidas'),
	   (3 , 'Spaten 473ml', 'Bebidas'),
	   (4 , 'Belinha' , 'Bebidas'),
	   (5 , 'Catuaba' , 'Bebidas'),
	   (6 , 'Energetico' , 'Bebidas');

INSERT INTO Inventario ( codProduto, quantidade, minLevel, maxLevel)
VALUES (1,8,2,20),
	   (2,100,80,200),
	   (3,1000,800,5000),
	   (4,5,1,10),
	   (5,15,10,100),
	   (6,200,100,500);

SELECT * FROM PRODUTO 
INNER JOIN Inventario ON PRODUTO.cod = Inventario.codProduto;


SELECT * FROM PRODUTO 
RIGHT JOIN Venda ON PRODUTO.cod = venda.codProduto;

DELETE FROM Produto WHERE cod = 4;

UPDATE Produto
SET cod = 87655
WHERE cod = 2;

--ALTER TABLE Inventario
alter table Venda
ADD CONSTRAINT fk_VENDA_produto
FOREIGN KEY (codProduto)
		REFERENCES Produto ( cod )
		ON DELETE SET NULL
	    ON UPDATE CASCADE;

INSERT INTO Venda VALUES (87655,5),
						 (3,10),
						 (3,20),
						 (3,5),
						 (5,1),
						 (4,2),
						 (6,4);
