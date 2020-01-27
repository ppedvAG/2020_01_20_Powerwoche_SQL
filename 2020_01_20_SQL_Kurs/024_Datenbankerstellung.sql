-- Datenbankerstellung
-- Schl�ssel (Keys)

-- Primary Key (Hauptschl�ssel)
-- Foreign Key (Fremdschl�ssel)

-- Primary Key
-- von dem sind alle anderen in der Tabelle abh�ngig
-- UNIQUE (eindeutig)
-- NOT NULL


-- Foreign Key
-- Schnittstelle zu anderen Tabellen



USE MyTestDB01

CREATE Table Customers (
						CustomerID int identity(100, 1) PRIMARY KEY,
						CompanyName varchar(50) NOT NULL,
						ContactName varchar(50),
						Phone varchar(50),
						City varchar(50)
						-- , ...
					)



CREATE Table [Order Details] (
						OrderID int,
						ProductID int,
						UnitPrice money,
						Quantity int,
						Discount money

						CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
					)



-- Identity:
-- identity(100, 1) f�ngt bei 100 zu z�hlen an und z�hlt jeweils 1 hoch

-- CONSTRAINT Syntax
-- CONSTRAINT PK_Name PRIMARY KEY (Spalte1[, Spalte2])



-- FOREIGN KEY Variante 1
CREATE TABLE Orders (
						OrderID int identity(10000, 1) PRIMARY KEY,
						CustomerID nvarchar(24) FOREIGN KEY REFERENCES Customers(CustomerID),
						EmployeeID int FOREIGN KEY REFERENCES Employees(EmployeeID),
						OrderDate datetime
						--, ...

					)


-- FOREIGN KEY Variante 2
CREATE TABLE Orders (
						OrderID int identity(10000, 1) PRIMARY KEY,
						CustomerID int,
						EmployeeID int,
						OrderDate datetime
						--, ...

						CONSTRAINT FK_CustomersOrders FOREIGN KEY (CustomerID)
													  REFERENCES Customers(CustomerID)

					)

--DROP TABLE Orders


-- FOREIGN KEY Variante 3
CREATE TABLE Orders (
						OrderID int identity(10000, 1) PRIMARY KEY,
						CustomerID nvarchar(24),
						EmployeeID int,
						OrderDate datetime
						--, ...
					)


ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersOrders FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)


SELECT *
FROM Helden

