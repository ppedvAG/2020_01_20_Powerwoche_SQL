-- SUBSELECT, SUBQUERY, UNTERABFRAGEN

USE Northwind
-- man kann Subquery im SELECT verwenden (wie eine Spalte)

--SELECT	  'Text'
--		, 100 AS Zahl
--		, 100*3 AS Berechnung
--		, Spaltenname
--		, (SELECT TOP 1 Freight FROM Orders) 
--FROM Tabelle



SELECT	  'Text' AS Text
		, 100 AS Zahl
		, 100*3 AS Berechnung
		, Freight
		, (SELECT TOP 1 Freight FROM Orders) AS Top1 -- wenn Subquery im SELECT verwendet wird (also wie eine Spalte) dann KANN ich einen Namen vergeben, muss aber nicht
FROM Orders



-- Subquery kann auch im FROM verwendet werden - meine Subquery ist dann meine Datenquelle

SELECT *
FROM -- welche Tabelle?
		(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3)  t1 -- wenn Subquery als Datenquelle verwendet wird, MÜSSEN wir einen Namen vergeben (t1) - Name frei wählbar
WHERE t1.Freight > 100



-- Unterabfrage auch im WHERE möglich
-- alle Bestellungen, wo der Frachtkostenwert größer ist als der durchschnittliche Frachtkostenwert?

SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)
ORDER BY Freight



-- Gib mittels Subselect alle Kunden aus, die in einem Land wohnen, aus dem auch Bestellungen verschifft werden

-- in welche Länder wird geliefert?

SELECT ShipCountry
FROM Orders
-- das sind alle (830) Bestellungen - viele Länder sind doppelt



SELECT DISTINCT ShipCountry
FROM Orders
-- 21

SELECT *
FROM Customers
WHERE Country = 'Germany'
		OR Country = 'Austria'


--SELECT *
--FROM Customers
--WHERE Country IN('Germany', 'Austria', 'France', 'Brazil',...)


SELECT *
FROM Customers
WHERE Country IN (SELECT DISTINCT ShipCountry FROM Orders)

-- gibt nicht das gleiche Ergebnis!! NEIN! FAAAAALSCH:
SELECT DISTINCT Country
FROM Customers c INNER JOIN Orders o ON c.Country = o.ShipCountry



-- Gib alle Bestellungen aus, deren Frachtkosten kleiner sind als der Durchschnitt der Frachtkosten.
-- a.	Optional: In absteigender Reihenfolge geordnet (vom größten zum kleinsten Wert).

-- langsam
-- durchschnittliche Frachtkosten?

SELECT AVG(Freight) FROM Orders

-- hier wird immer der aktuelle Wert berechnet:
SELECT *
FROM Orders
WHERE Freight < (SELECT AVG(Freight) FROM Orders)


-- geht auch, ist aber ein fixer Wert:
SELECT *
FROM Orders
WHERE Freight < 78.2442