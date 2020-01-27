SELECT *
INTO TestEmployees
FROM Northwind.dbo.Employees



SELECT *
FROM TestEmployees

-- ALTER TABLE Tabellenname
-- ADD neuer Spaltenname Datentyp

ALTER TABLE TestEmployees
ADD Salary money


ALTER TABLE TestEmployees
ADD Haarfarbe varchar(20)
-- ups, die Spalte brauchen wir doch nicht: 
-- löschen (unwiderruflich!!!! inklusive Inhalt) mit DROP
ALTER TABLE TestEmployees
DROP COLUMN Haarfarbe

-- geht nicht! würde neue Zeile erzeugen, nicht Wert zuweisen!!
INSERT INTO TestEmployees (Salary)
VALUES (2500)


UPDATE TestEmployees
SET Salary = 2500
WHERE EmployeeID = 1

-- UPDATE mit CASE

UPDATE TestEmployees
SET Salary = (CASE
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
			  END)



-- 1)	(Employees in der MyFirstDB): Gib die EmployeeID, den Vor- und Nachnamen und das Gehalt aller Mitarbeiter aus, die ein höheres Gehalt beziehen als der Mitarbeiter mit der EmployeeID 8.

SELECT	  EmployeeID
		, FirstName
		, LastName
		, Salary
FROM TestEmployees
WHERE Salary > (SELECT Salary FROM TestEmployees WHERE EmployeeID = 8)


-- 2)	Northwind-DB: Gib die SupplierID, den CompanyName, die Kontaktinformation und das Land aller Supplier aus, die aus dem gleichen Land sind wie der Supplier mit der ID 2.
USE Northwind
SELECT	  SupplierID
		, CompanyName
		, ContactName
		, Country
FROM Suppliers
WHERE Country = (SELECT Country FROM Suppliers WHERE SupplierID = 2)

-- 3)	MyFirstDB: Gib die EmployeeID, Name, Gehalt und Land der Mitarbeiter aus, die das niedrigste Gehalt in ihrem Land beziehen.

-- kleinster Gehalt pro Land:
USE MyTestDB01
SELECT MIN(Salary) FROM TestEmployees GROUP BY Country

SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, Salary
		, Country
FROM TestEmployees
WHERE Salary IN (SELECT MIN(Salary) FROM TestEmployees GROUP BY Country)


-- 4)	MyFirstDB: Gib die Namen der Employees aus, deren Gehalt zwischen dem niedrigsten Gehalt und 3000 liegt.
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, Salary
		, Country
FROM TestEmployees
WHERE Salary BETWEEN (SELECT MIN(Salary) FROM TestEmployees) AND 3000
ORDER BY Salary


-- 5)	NW oder MyFirstDB: Gib die Namen und das EinstellungsJAHR der Mitarbeiter aus, die im selben Jahr eingestellt wurden wie Mr. Robert King.

SELECT    CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS FullName
		, HireDate
FROM TestEmployees
WHERE DATEPART(year, HireDate) = (SELECT DATEPART(year, HireDate) FROM TestEmployees
									WHERE CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) = 'Mr. Robert King')


-- 6)	MyFirstDB: Gib die EmployeeID, den Namen, das Gehalt und die Region der Mitarbeiter aus, deren Gehalt über 2500 liegt und deren Region nicht NULL ist.

SELECT	  EmployeeID
		, CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS FullName
		, Region
		, Salary
FROM TestEmployees
WHERE Region IS NOT NULL
		AND Salary > 2500



-- Experten JOINS: 
-- SELF JOIN

-- Customer1, City1, Customer2, City2
-- Alle Kunden (CompanyName), die in der gleichen Stadt wohnen wie ein anderer Kunde
-- die nicht sie selber sind
-- also NICHT: ALFKI Berlin ALFKI Berlin
USE Northwind


SELECT c1.CustomerID, c1.CompanyName, c1.City, '<->' AS '<->', c2.CustomerID, c2.CompanyName, c2.City
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
			AND c1.CustomerID != c2.CustomerID



SELECT c1.CustomerID, c1.CompanyName, c1.City, '<->' AS '<->', c2.CustomerID, c2.CompanyName, c2.City
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
WHERE c1.CustomerID != c2.CustomerID
ORDER BY c1.City, c1.CustomerID



-- Wer ist der Chef von wem?
-- Name Angesteller, ID Angestellter, Name Chef, ID vom Chef
SELECT    CONCAT(Angestellter.FirstName, ' ', Angestellter.LastName) AS Angestellter
		, Angestellter.EmployeeID
		, '<->' AS '<->'
		, TRIM(CONCAT(ISNULL(Chef.FirstName, 'ist Chef'), ' ', Chef.LastName)) AS ChefNachname
		, ISNULL(CAST(Chef.EmployeeID AS varchar), 'ist Chef') AS ChefID
FROM Employees Angestellter LEFT JOIN Employees Chef ON Angestellter.ReportsTo = Chef.EmployeeID
ORDER BY Chef.EmployeeID