-- CASE

USE Northwind

SELECT OrderID, Quantity,

	CASE
		WHEN Quantity > 10 THEN 'größer 10'
		WHEN Quantity = 10 THEN 'genau 10'
		-- ....
		ELSE 'unbekannt'
	END AS Anzahl

FROM [Order Details]


-- von Customers
-- CustomerID, Country... 
-- wenn EU Mitglied, dann 'EU'
-- wenn nicht EU Mitglied, dann 'nicht EU'
-- wenn nicht bekannt, dann 'keine Ahnung'


SELECT DISTINCT Country
FROM Customers
-- 21 Länder (es müssen für diese Übung nicht alle Fälle abgedeckt werden)

SELECT CustomerID, Country, 
	CASE
		WHEN Country IN('Germany', 'France', 'Italy') THEN 'EU'
		WHEN Country IN('USA', 'Brazil', 'Canada') THEN 'not EU'
		WHEN Country = 'UK' THEN 'Brexit'
		ELSE 'unbekannt'
	END AS C_Bewertung

FROM Customers



UPDATE TestEmployees
SET Salary = 
			CASE
				WHEN EmployeeID = 1 THEN 2500
				WHEN EmployeeID = 2 THEN 8000
				WHEN EmployeeID = 3 THEN 1800
				WHEN EmployeeID = 4 THEN 5000
				WHEN EmployeeID = 5 THEN 3200
				WHEN EmployeeID = 6 THEN 3100
				WHEN EmployeeID = 7 THEN 2300
				WHEN EmployeeID = 8 THEN 2800
				WHEN EmployeeID = 9 THEN 3000
				ELSE Salary
			END