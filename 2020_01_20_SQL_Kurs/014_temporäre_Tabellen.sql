-- tempor�re Tabellen
-- temporary tables

/*

-- lokale tempor�re Tabellen
-- existiert nur in der aktuellen Session





-- globale tempor�re Tabellen
-- Zugriff auch aus anderen Sessions



-- gibts nur so lange, wie Verbindung da ist

-- kann auch gel�scht werden wie eine normale Tabelle



*/



USE Northwind

-- lokale tempor�re Tabelle
SELECT CustomerID, Freight
INTO #t1
FROM Orders



SELECT *
FROM #t1


-- globale tempor�re Tabelle
SELECT CustomerID, CompanyName
INTO ##t2
FROM Customers
WHERE Country IN('Germany', 'Austria')


SELECT *
FROM ##t2


-- DROP TABLE ##t2