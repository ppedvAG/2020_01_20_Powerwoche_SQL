-- SET Operatoren
-- UNION, UNION ALL, INTERSECT, EXCEPT



-- UNION

-- UNION kann Liste erstellen


USE Northwind



SELECT Country, City, ShipCountry, ShipCity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


SELECT 'Testtext1' AS Test
UNION
SELECT 'Testtext2' -- AS Test -- erlaubt, aber nicht notwendig


-- geht nicht; es m�ssen gleich viele Spalten vorhanden sein
SELECT 'Testtext', 100
UNION
SELECT 'Testtext'

-- Datentypen der Spalten m�ssen �bereinstimmen (oder es muss eine implizite Konvertierung m�glich sein)
SELECT 100, 'Testtext'
UNION
SELECT 'Testtext', 100


-- UNION macht auch ein DISTINCT
SELECT 'Testtext'
UNION
SELECT 'Testtext'

-- wenn ich auch alle doppelten Eintr�ge haben m�chte, dann UNION ALL
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'




-- auch hier wird ein DISTINCT gemacht, und zus�tzlich eine Konvertierung (genauerer Wert wird genommen)
SELECT 100
UNION
SELECT 100.00



-- Spaltennamen m�ssen nicht gleich sein, aber es m�ssen gleich viele Spalten sein und die Datentypen m�ssen �bereinstimmen
SELECT Country, City
FROM Customers
UNION
SELECT ShipCountry, ShipCity
FROM Orders


-- Vorsicht: ich bekomme hier keine Fehlermeldung (weil Datentypen stimmen �berein, Spaltenanzahl auch)
SELECT Country, Phone
FROM Customers
UNION
SELECT ShipCountry, ShipCity
FROM Orders


-- EXEC sp_help Customers


-- funktioniert, SINN??
SELECT Country, 'Text'
FROM Customers
UNION
SELECT ShipCountry, ShipCity
FROM Orders


-- funktioniert; SINN?
SELECT Country, NULL
FROM Customers
UNION
SELECT ShipCountry, ShipCity
FROM Orders

-- Achtung: CustomerID = nvarchar, EmployeeID = int - wieder Fehlermeldung
SELECT CustomerID, Phone
FROM Customers
UNION
SELECT EmployeeID, HomePhone
FROM Employees
-- Conversion failed when converting the nvarchar value 'ALFKI' to data type int.



-- 1) Gib den Firmennamen, die Kontaktperson und die Telefonnummern aller Kunden und aller Supplier in einer Liste aus.
-- a.	Optional: F�ge eine Kategorie �C� f�r Customer und �S� f�r Supplier hinzu.

SELECT CompanyName, ContactName, Phone, 'C' AS Herkunft
FROM Customers
UNION
SELECT CompanyName, ContactName, Phone, 'S'
FROM Suppliers



-- 2) Gib alle Regionen der Kunden und der Angestellten aus.
-- a.	Optional: F�ge eine Kategorie "C" f�r Customer und "E" f�r Employee hinzu.

SELECT ContactName, Region, 'C' AS Herkunft
FROM Customers
UNION
SELECT CONCAT(FirstName, ' ', LastName), Region, 'E'
FROM Employees


-- niedrigsten Frachtkostenwert, OrderID, 'niedrigster Wert'
-- h�chsten Frachtkostenwert, OrderID, 'h�chster Wert'

-- mehrere M�glichkeiten:
-- Subselect im WHERE:

SELECT OrderID, Freight, 'niedrigster Wert' AS Wert
FROM Orders
WHERE Freight = (SELECT MIN(Freight) FROM Orders)
UNION
SELECT OrderID, Freight, 'h�chster Wert'
FROM Orders
WHERE Freight = (SELECT MAX(Freight) FROM Orders)

-- Subselect im FROM als Datenquelle:
SELECT *
FROM (SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert FROM Orders ORDER BY Freight ASC) AS lowest
UNION
SELECT *
FROM (SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert FROM Orders ORDER BY Freight DESC) AS highest -- Subquery als Datenquelle braucht Name!

-- andere M�glichkeit:

-- so gehts nicht, weil das letzte ORDER BY f�r die gesamte Operation gilt
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
FROM Orders
ORDER BY Freight ASC
UNION
SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert
FROM Orders
ORDER BY Freight DESC


-- so gehts aber:
-- mit tempor�rer Tabelle
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
INTO #lowest
FROM Orders
ORDER BY Freight ASC


SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert
INTO #highest
FROM Orders
ORDER BY Freight DESC

SELECT *
FROM #lowest
UNION
SELECT *
FROM #highest


-- DROP #lowest

-- geht, aber nur mit einem Wert min/max:

SELECT MIN(Freight)
FROM Orders
UNION
SELECT MAX(Freight)
FROM Orders


-- geht NICHT: Min/Max pro OrderID = Frachtkosten!
SELECT OrderID, MIN(Freight)
FROM Orders
GROUP BY OrderID
UNION
SELECT OrderID, MAX(Freight)
FROM Orders
GROUP BY OrderID



-- ********************************* INTERSECT, EXCEPT

CREATE TABLE #a (id INT)

CREATE TABLE #b (id INT)


INSERT INTO #a VALUES (1), (NULL), (2), (1)

INSERT INTO #b VALUES (1), (NULL), (3), (1)


-- UNION
SELECT id
FROM #a
UNION
SELECT id
FROM #b
-- NULL, 1, 2, 3


-- INTERSECT
SELECT id
FROM #a
INTERSECT
SELECT id
FROM #b
-- NULL, 1


-- EXCEPT
SELECT id
FROM #a
EXCEPT
SELECT id
FROM #b
-- das, was in der a Tabelle, aber nicht in der b Tabelle vorkommt
-- 2


SELECT id
FROM #b
EXCEPT
SELECT id
FROM #a
-- das, was in der b Tabelle vorkommt, aber nicht in der a Tabelle
-- 3


SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id
-- 1 1 1 1

SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id


