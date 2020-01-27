-- Aggregatfunktionen
-- aggregate functions

-- COUNT, MIN, MAX, AVG, SUM

USE Northwind

SELECT UnitPrice
FROM Products
ORDER BY UnitPrice


-- wieviele Produkte gibts insgesamt?
SELECT COUNT(ProductID) AS [Anzahl Produkte]
FROM Products
-- 77


-- durchschnittlicher UnitPrice
SELECT AVG(UnitPrice) -- AVG kurz für average
FROM Products
-- 28,8663


-- Minimalwert: z.B.: niedrigster Stückpreis
SELECT MIN(UnitPrice)
FROM Products
-- 2.50

-- Maximalwert: z.B.: höchsten Stückpreis
SELECT MAX(UnitPrice)
FROM Products
-- 263,50


-- Summe berechnen:
SELECT SUM(Freight)
FROM Orders
-- 64942,69
-- Summe aller Frachtkosten von ALLEN unseren Bestellungen


-- alle Frachtkosten von allen Bestellungen
SELECT Freight
FROM Orders


-- Summe der Frachtkosten PRO Kunde
SELECT SUM(Freight), CustomerID
FROM Orders
GROUP BY CustomerID


SELECT SUM(Freight), CustomerID, ShipCountry
FROM Orders
GROUP BY CustomerID, ShipCountry


-- wieviele Kunden haben wir?
SELECT CustomerID
FROM Customers
-- 91 Zeilen Ausgabe, also habe ich 91 Kunden

SELECT COUNT(CustomerID) AS [Anzahl Kunden]
FROM Customers
-- 91

-- wieviele Kunden gibts PRO Stadt im jeweiligen Land?
SELECT COUNT(CustomerID) AS [Anzahl Kunden], Country, City
FROM Customers
GROUP BY Country, City
ORDER BY Country

-- wieviele habe ich PRO Land?
SELECT COUNT(CustomerID) AS [Anzahl Kunden], Country
FROM Customers
GROUP BY Country



SELECT	  OrderID
		, ProductID
		, Quantity
		, UnitPrice*Quantity AS Price
FROM [Order Details]


-- wie bekomme ich eine RechnungsSUMME?

SELECT	 OrderID
		--, ProductID
		-- , Quantity
		, SUM(UnitPrice*Quantity) AS Rechnungssumme
FROM [Order Details]
GROUP BY OrderID --, Quantity
ORDER BY OrderID
