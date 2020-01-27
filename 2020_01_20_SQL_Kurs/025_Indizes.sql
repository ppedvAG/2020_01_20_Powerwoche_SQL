-- Erstellen von Indizes


-- CREATE CLUSTERED INDEX IX_TestIndexName ON Tabelle (Spalte[, Spalte]);


-- EXEC sp_helpindex Tabellenname --> welche Indizes gibt es in der Tabelle + Info zu den Indizes (clustered, nonclustered...)

SELECT CompanyName, CustomerID, City
FROM Customers
WHERE Country = 'Germany'



-- MAXDOP
-- Maximal Degree Of Parallelism


SELECT CompanyName, CustomerID, City
FROM Customers
WHERE Country = 'Germany'
OPTION (MAXDOP 2)
-- das würde bedeuten, dass die Abfrage 2 CPUs verwenden darf (MAXDOP = maximal degree of parallelism)
-- sehr vorsichtig damit umgehen!!!


set statistics io , time on

USE AdventureWorks2016CTP3
SELECT *
FROM Sales.SalesOrderDetail
ORDER BY ProductID
