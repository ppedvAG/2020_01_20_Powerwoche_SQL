-- VIEWS
-- Sichten



-- Syntax:
-- CREATE VIEW vName | v_Name -- v muss nicht dabei stehen, reiner optischer Hinweis darauf, dass es sich dabei um eine VIEW handelt
-- AS
-- SELECT


-- Bsp.:

CREATE VIEW v_GermanCustomers
AS
SELECT CustomerID, CompanyName, ContactName, Phone
FROM Customers
WHERE Country = 'Germany'


SELECT *
FROM v_GermanCustomers

SELECT CustomerID, Phone
FROM v_GermanCustomers

-- geht nicht:
SELECT City
FROM v_GermanCustomers
-- man kann nur Dinge abfragen, die auch in die VIEW übernommen wurden


CREATE VIEW v_Nachbestellungen
AS
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder, s.SupplierID, ContactName, Phone
FROM Products p INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID


SELECT *
FROM v_Nachbestellungen
--WHERE ProductName LIKE '%chai%'