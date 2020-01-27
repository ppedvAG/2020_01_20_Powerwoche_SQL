-- temporäre Tabellen
-- temporary tables

/*

-- lokale temporäre Tabellen
-- existiert nur in der aktuellen Session





-- globale temporäre Tabellen
-- Zugriff auch aus anderen Sessions



-- gibts nur so lange, wie Verbindung da ist

-- kann auch gelöscht werden wie eine normale Tabelle



*/



USE Northwind

-- lokale temporäre Tabelle
SELECT CustomerID, Freight
INTO #t1
FROM Orders



SELECT *
FROM #t1


-- globale temporäre Tabelle
SELECT CustomerID, CompanyName
INTO ##t2
FROM Customers
WHERE Country IN('Germany', 'Austria')


SELECT *
FROM ##t2


-- DROP TABLE ##t2