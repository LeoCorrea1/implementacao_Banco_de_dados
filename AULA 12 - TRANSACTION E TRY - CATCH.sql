
-- SELECTS / TRANSACTION E ETC...

SELECT
    Pnome,
    Unome,
    Salario,
    CASE 
        WHEN Salario < 20000 THEN 'Baixo'
        WHEN Salario BETWEEN 20000 AND 40000 THEN 'Medio'
        WHEN Salario > 40000 THEN 'Alto'
        ELSE 'Sem Registro'
    END AS 'Categoria Salario'

FROM FUNCIONARIO;


SELECT 
    Pnome,
    Unome,
    Data_Admissao,
    CASE
       when DATEDIFF(DAY,Data_Admissao,GETDATE()) <= 180 THEn 'Recem Admitido'
       when DATEDIFF(DAY,Data_Admissao,GETDATE()) >= 180 THEn 'Admitido a mais de 6 mees'

       ELSE ' Sem Registro'
    end as 'Contratado Em '
FROM FUNCIONARIO;



BEGIN TRANSACTION

update FUNCIONARIO
SET Salario = 30000
    WHERE Pnome LIKE 'Carlos' 

ROLLBACK TRAN


BEGIN TRANSACTION;

UPDATE F
SET F.Salario = F.Salario + 333
FROM FUNCIONARIO F
JOIN DEPARTAMENTO D ON F.Dnr = D.Dnumero
WHERE D.Dnome = 'Pesquisa';

SELECT * FROM FUNCIONARIO;
