-- WH 2

-- Syntax von JOINS

--SELECT	  Spalte
--		, Tabelle1.SpalteA
--		, ...
--FROM Tabelle1 INNER JOIN Tabelle2 ON Tabelle1.SpalteA = Tabelle2.SpalteA
--WHERE Bedingung
--ORDER BY Spalte, Spalte,...



SELECT	  OrderID
		, c.CustomerID
		, CompanyName
		, City
		, Country
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Austria'
ORDER BY City


-- mehrere Tabellen miteinander verknüpfen

SELECT *
FROM Employees e INNER JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
				 INNER JOIN Territories t ON et.TerritoryID = t.TerritoryID
				 INNER JOIN Region r ON r.RegionID = t.RegionID