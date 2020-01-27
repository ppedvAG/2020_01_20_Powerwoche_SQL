-- VIEW WITH CHECK OPTION

USE MyTestDB01

CREATE TABLE Helden(

						firstname varchar(30),
						lastname varchar(30),
						age int
					)

INSERT INTO Helden (firstname, lastname, age)
		VALUES ('James', 'Bond', 40),
			   ('Bruce', 'Wayne', 35),
			   ('Peter', 'Parker', 23)


SELECT * FROM Helden


CREATE VIEW v_TestHelden
AS
SELECT firstname, lastname, age
FROM Helden
WHERE age IS NOT NULL


SELECT *
FROM v_TestHelden


INSERT INTO Helden (firstname, lastname, age)
		VALUES ('Clark', 'Kent', NULL)


SELECT *
FROM Helden



INSERT INTO v_TestHelden (firstname, lastname, age)
	VALUES	('Luke', 'Skywalker', 18),
			('Obi Wan', 'Kenobi', NULL)


SELECT *
FROM Helden

SELECT *
FROM v_TestHelden


DROP VIEW v_TestHelden



CREATE VIEW v_TestHelden
AS
SELECT firstname, lastname, age
FROM Helden
WHERE age IS NOT NULL
WITH CHECK OPTION


INSERT INTO v_TestHelden (firstname, lastname, age)
		VALUES ('Mickey', 'Mouse', 42)


SELECT *
FROM Helden

SELECT *
FROM v_TestHelden

INSERT INTO v_TestHelden (firstname, lastname, age)
		VALUES ('Donald', 'Duck', NULL)


INSERT INTO Helden (firstname, lastname, age)
		VALUES ('Saphira', NULL, NULL)


SELECT *
FROM Helden


SELECT *
FROM v_TestHelden


USE Northwind
CREATE VIEW v_Customer_Orders_Products
AS
SELECT	  o.OrderID
		, CompanyName
		, ProductName
		, Quantity
		, (od.UnitPrice*od.Quantity) AS SumPrice
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				INNER JOIN Products p ON p.ProductID = od.ProductID

		
		
