-- JOINS


USE Northwind


SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID




SELECT	  Customers.CustomerID -- hier muss ich dazuschreiben, aus welcher Tabelle
		, Orders.OrderID -- hier KANN/darf ich dazuschreiben, aus welcher Tabelle
		, Freight -- ich darf es aber auch weglassen, wenn Name nur in einer Tabelle vorkommt
		, Address
		, PostalCode
		, City
		, Country
	--  , ...
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- ein bisschen kürzer anschreiben:

SELECT 100 AS Zahl



-- kürzer:
SELECT	  c.CustomerID 
		, o.OrderID 
		, Freight 
		, PostalCode
		, City
		, Country
	--  , ...
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
--ORDER BY CustomerID


-- noch ein bisschen kürzer: 
SELECT	  c.CustomerID 
		, o.OrderID 
		, Freight 
		, PostalCode
		, City
		, Country
	--  , ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID

-- INNER JOIN am häufigsten verwendet 

-- wir können auch hier weiter einschränken
SELECT	  c.CustomerID 
		, o.OrderID 
		, Freight 
		, PostalCode
		, City
		, Country
	--  , ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Austria'
ORDER BY CustomerID



-- mehrere Tabellen verknüpfen
SELECT	  o.OrderID
		, p.ProductID
		, Freight
		, Quantity
		, od.UnitPrice
		, ProductName
	--  , ...
FROM Orders o INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
			  INNER JOIN Products p ON od.ProductID = p.ProductID

ORDER BY OrderID


-- ********************************** Übungen
-- Gib alle Kunden aus den USA und deren Frachtkosten aus.
-- CustomerID, CompanyName,...

SELECT	  c.CustomerID
		, CompanyName
		, Country
		, City
	--	, ...
		, Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'USA'



-- Alle Bestellungen, die von Employee Nr 3, 5 und 7 bearbeitet worden sind
-- OrderID
-- EmployeeID
-- Employee Namen (FirstName, LastName) FullName

SELECT	  OrderID
		, o.EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName -- [vollständiger Name]
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.EmployeeID IN(3, 5, 7)


-- Gib den Namen des Anbieters (Supplier), der Chai Tee verkauft, aus. (CompanyName, ProductName, Ansprechperson, Telefonnummer). Achtung: Wie heißt das Produkt? Vanilla Chai? Chai Latte? Verschiedene Möglichkeiten?

SELECT	  CompanyName
		, ProductName
		, ContactName
		, Phone
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE ProductName LIKE '%chai%'
-- 1 Treffer Exotic Liquids (Chai)



-- Welche Kunden haben Chai Tee gekauft und wieviel? (OrderID, CustomerID, CompanyName, ProductName, Quantity)

SELECT	  o.OrderID
		, c.CustomerID
		, CompanyName
		, ProductName
		, Quantity
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
			  INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
			  INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE ProductName LIKE '%chai%'
ORDER BY CustomerID, Quantity DESC



-- Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier? (Der Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.) 
--a.	Optional: Nach Menge und Kundenname geordnet.
--b.	Optional: Menge absteigend (größte zuerst), Kundenname aufsteigend (A-Z)

SELECT	  o.OrderID
		, c.CustomerID
		, CompanyName
		, ProductName
		, Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE ProductName LIKE '%bier%'
	OR ProductName LIKE '%lager%'
	OR ProductName LIKE '%ale'
ORDER BY Quantity DESC, CompanyName -- ASC


-- LEFT JOIN

SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 



-- RIGHT JOIN

SELECT *
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID 


-- welche haben noch nichts bestellt?
SELECT		OrderID
		, c.CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL