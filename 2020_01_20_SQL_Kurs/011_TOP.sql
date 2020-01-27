-- TOP - Abfragen

-- ORDER BY notwendig!!!

USE Northwind

SELECT *
FROM Customers


-- nur die 1. Zeile

SELECT TOP 1 *
FROM Customers

-- einschränken:
SELECT TOP 1  CustomerID
			, CompanyName
			, ContactName
			, Phone
		--  , ...
FROM Customers

-- FRAGE: WAS ist die 1. Zeile????
SELECT TOP 1  CustomerID
			, CompanyName
			, ContactName
			, Phone
		--  , ...
FROM Customers
ORDER BY CustomerID


-- % abfragen ist auch möglich
SELECT TOP 10 PERCENT CustomerID
					, CompanyName
			--		,...
FROM Customers
ORDER BY CustomerID

-- Syntax:
-- SELECT TOP # [PERCENT] * | Spalte[, Spalte, ...]
-- FROM Tabelle
-- [WHERE Bedingung]
-- ORDER BY Spalte[, Spalte]

SELECT TOP 5 PERCENT  CustomerID
					, CompanyName
					, ContactName
					, Phone
FROM Customers
ORDER BY City -- wir können auch nach Spalten ordnen, die gar nicht im SELECT stehen


-- wie bekomme ich jetzt die 10% der höchsten Frachtkosten?
SELECT TOP 10 PERCENT Freight
FROM Orders
ORDER BY Freight DESC


-- letzten 3 Kunden CompanyName?
SELECT TOP 3 CompanyName
FROM Customers
ORDER BY CompanyName DESC

-- aus dem Englischen: 'they TIED for third place' = die haben sich den 3. Platz geteilt
-- TOP 1 PERCENT WITH TIES
-- alle, die den gleichen Wert haben wie der letzte Treffer in den TOP 1% 

SELECT TOP 1 PERCENT WITH TIES *
FROM [Order Details]
ORDER BY UnitPrice DESC
-- 24 Treffer

-- ohne WITH TIES 2 mehr:
SELECT TOP 1 PERCENT *
FROM [Order Details]
ORDER BY UnitPrice DESC


-- alle:
SELECT *
FROM [Order Details]
ORDER BY UnitPrice DESC


-- Gib das teuerste Produkt aus.
SELECT TOP 1 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC


--2)	Suche die Top 10% der Produkte mit den größten Einkaufsmengen (ProductName, Quantity).
--a.	Optional: Einschließlich Produkte mit der gleichen Einkaufsmenge wie das letzte in der ursprünglichen Ausgabe.

SELECT TOP 10 PERCENT ProductName, Quantity
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY Quantity DESC
-- 216


SELECT TOP 10 PERCENT WITH TIES ProductName, Quantity
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY Quantity DESC
-- 234


-- Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind).
SELECT TOP 3  HireDate
		--	, FirstName
		--	, LastName
			, CONCAT(FirstName, ' ', LastName) AS FullName
			, Title
FROM Employees
ORDER BY HireDate


-- ohne TOP-Befehl
SELECT        EmployeeID
			,	HireDate
			, FirstName
			, LastName
	--		, CONCAT(FirstName, ' ', LastName) AS FullName
			, Title
FROM Employees