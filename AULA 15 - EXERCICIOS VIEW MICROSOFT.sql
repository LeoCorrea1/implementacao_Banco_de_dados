-- 1
CREATE VIEW V1 AS
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE EmployeeID NOT IN (
    SELECT ReportsTo FROM Employees WHERE ReportsTo IS NOT NULL
);
GO

-- 2
CREATE VIEW V2 AS
SELECT P.ProductID, P.ProductName, SUM(OD.Quantity) AS TotalVendido
FROM [Order Details] OD
INNER JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, P.ProductName;
GO

-- 3
CREATE VIEW V3 AS
SELECT T.TerritoryID, COUNT(ET.EmployeeID) AS QtdVendedores
FROM Territories T
LEFT JOIN EmployeeTerritories ET ON T.TerritoryID = ET.TerritoryID
GROUP BY T.TerritoryID;
GO

-- 4
CREATE VIEW V4 AS
SELECT TOP 1 C.CompanyName
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
ORDER BY SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) DESC;
GO

-- 5
CREATE VIEW V5 AS
SELECT E.EmployeeID, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS LucroTotal
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID
ORDER BY LucroTotal DESC;
GO

-- 6
CREATE VIEW V6 AS
SELECT P.ProductName, S.CompanyName AS Fornecedor, 
       C.CategoryName AS Categoria, P.UnitPrice, P.Discontinued
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
INNER JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE P.UnitsInStock > 0;
GO
