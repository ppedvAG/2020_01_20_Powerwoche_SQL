-- STORED PROCEDURES

-- Syntax
-- CREATE PROC pName | spName | sp_Name
-- AS
-- SELECT .....
-- SELECT .....



-- Bsp.:
CREATE PROC Demo05
AS
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
FROM Orders
ORDER BY Freight ASC;
SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Wert
FROM Orders
ORDER BY Freight DESC;



-- aufrufen/ausführen der Procedure mit EXEC (execute)

EXEC Demo05


-- Procedure mit Variablen

CREATE PROC sp_allCustomers @City varchar(30)
AS
SELECT CustomerID, CompanyName, Country, City FROM Customers WHERE City = @City



EXEC sp_allCustomers @City = 'Buenos Aires'



-- mit mehreren Variablen

CREATE PROC sp_CustomerInfoCountry @City varchar(30), @Country varchar(30)
AS
SELECT CustomerID, CompanyName, Country, City, ContactName, Phone 
FROM Customers 
WHERE City = @City AND Country = @Country


EXEC sp_CustomerInfoCountry @City = 'Salzburg', @Country = 'Austria'


-- SP/CASE/UPDATE-Beispiel

USE MyTestDB01
CREATE PROC sp_Gehaltserhoehung
AS
UPDATE TestEmployees
SET Salary =
			CASE
				WHEN Salary > 10000 THEN Salary
				WHEN Salary > (SELECT AVG(Salary) fROM TestEmployees) THEN Salary * 1.1
				WHEN Salary < (SELECT AVG(Salary) fROM TestEmployees) THEN Salary * 1.2
				ELSE Salary

			END

EXEC sp_Gehaltserhoehung

SELECT EmployeeID, LastName, Salary FROM TestEmployees