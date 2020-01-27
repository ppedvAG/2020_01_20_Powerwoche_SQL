-- WHERE clause, WHERE-Klausel, WHERE-Bedingung

-- wenn man nur bestimmte Ergebnisse ausgeben möchte

/*
WHERE Operatoren:

			 =, <, >, <=, >=
			 !=, <>  -- NICHT irgendeinem Wert entspricht

			 LIKE, IN, BETWEEN

			 IS, IS NOT


			 -- nicht besonders gut für Performance:
			 NOT IN, NOT LIKE, NOT BETWEEN



			 AND, OR

*/

SELECT	  CustomerID
		, CompanyName
		, Phone
		, Country
FROM Customers
WHERE Country = 'Germany'
ORDER BY City -- man darf auch nach Spalten ordnen, die gar nicht im SELECT stehen
-- SINN??


-- beim WHERE auch mehrere Bedingungen abfragen:
SELECT	  CustomerID
		, CompanyName
		, Phone
		, Country
FROM Customers
WHERE Country = 'Germany'
		AND City = 'Berlin'

-- alle Kunden aus Deutschland und Österreich?
SELECT	  CustomerID
		, CompanyName
		, Phone
		, Country
FROM Customers
WHERE Country = 'Germany' OR Country = 'Austria'


SELECT	  CustomerID
		, CompanyName
		, Phone
		, Country
FROM Customers
WHERE (Country = 'Germany' AND City = 'Berlin') OR Country = 'Austria'


-- ************************************* Übungen
-- 1) Gib nur die Kunden aus, die in Frankreich wohnen.
SELECT	  CustomerID
		, CompanyName
		, Phone
		, Country
		, City
FROM Customers
WHERE Country = 'France'
-- ORDER BY City

SELECT *
FROM Customers
ORDER BY Country


-- 2) Gib alle Kunden aus, die in Buenos Aires in Argentinien wohnen.
SELECT	  CustomerID
		, CompanyName
		, Phone
		, Country
		, City
FROM Customers
WHERE Country = 'Argentina' AND City = 'Buenos Aires'


--3) Gib alle portugiesischen und spanischen Kunden aus.
SELECT	  CustomerID
		, CompanyName
		, Phone
		, Country
		, City
FROM Customers
WHERE Country = 'Spain' OR Country = 'Portugal'

-- 4) Gib alle Produkte aus, von denen mehr als 100 vorhanden sind.
SELECT	  ProductID
		, ProductName
		, UnitsInStock
FROM Products
WHERE UnitsInStock > 100



-- alle Bestellungen, wo Frachtkosten > 100
-- höchste Frachtkosten zuerst
SELECT	  OrderID
		, Freight
FROM Orders
WHERE Freight > 100
ORDER BY Freight DESC

-- alle Frachtkosten, außer die mit einem bestimmten Wert? (400,81)
SELECT	  OrderID
		, Freight
FROM Orders
WHERE Freight != 400.81
ORDER BY Freight DESC


-- ********************************* BETWEEN, IN *********************

SELECT	  OrderID
		, Freight
FROM Orders
WHERE Freight >= 100 AND Freight <= 200


-- ODER:
SELECT	  OrderID
		, Freight
FROM Orders
WHERE Freight BETWEEN 100 AND 200


-- alle Bestellungen, die von Employee Nr 3, 4, 7 bearbeitet worden sind

SELECT	  OrderID
		, EmployeeID
		, OrderDate
		, ShipCountry
		, ShipAddress
FROM Orders
WHERE EmployeeID = 3 OR EmployeeID = 4 OR EmployeeID = 7


-- ODER:
SELECT	  OrderID
		, EmployeeID
		, OrderDate
		, ShipCountry
		, ShipAddress
FROM Orders
WHERE EmployeeID IN(3, 4, 7)


-- 5) Gib alle Produkte aus, deren ProduktID zwischen 10 und 15 (inklusive) liegt.
SELECT	  ProductID
		, ProductName
		, UnitPrice
	--  , ...
FROM Products
WHERE ProductID BETWEEN 10 AND 15


-- 6) Gib alle Produkte aus, die vom Anbieter (SupplierID) 2, 7 oder 15 geliefert werden.
SELECT	  ProductID
		, ProductName
		, UnitPrice
		, SupplierID
	--  , ...
FROM Products
WHERE SupplierID IN(2, 7, 15)