-- einfache Tabellenabfragen
-- SELECT auf Tabellen
-- Immer überprüfen, in welcher Datenbank wir sind


USE Northwind

-- Syntax:
-- SELECT Spaltenname
-- FROM Tabellenname


-- SELECT Spalte1, Spalte2,... 'Text', Zahl, Berechnung AS Spaltenname
-- FROM Tabelle


SELECT *
FROM Customers


SELECT CompanyName
FROM Customers


SELECT 100, 'Testtext'
FROM Customers


SELECT	  CustomerID
		, CompanyName
		, City
		, Country
FROM Customers


SELECT	  CustomerID AS Kundennummer
		, CompanyName AS Firmenname
		, City AS Stadt
		, Country AS Land
FROM Customers


-- Bestellungen (Orders): Bestellnummer, welcher Kunde (CustomerID), welcher Angestellte hat Bestellung bearbeitet, in welches Land ist die Bestellung geliefert worden?


-- Datenbankdiagramm erstellen/nachschlagen hilfreich!
-- Databases -> Northwind -> Database Diagrams -> Rechtsklick -> New Database Diagram


SELECT	  OrderID AS Bestellnummer
		, CustomerID AS Kundenname
		, EmployeeID AS Angestellter
		, ShipCountry AS Lieferland
FROM Orders


-- Tipp: zuerst * FROM Tabelle, dann * ersetzen durch Vorschläge
SELECT	  CustomerID
		, CompanyName
FROM Customers


-- Übungen:
-- 1) Gib KundenID, Firmenname, Kontaktperson und Telefonnummer aller Kunden aus.

SELECT	  CustomerID AS KundenID
		, CompanyName AS Firmenname
		, ContactName AS Kontaktperson
		, Phone AS Telefonnummer
FROM Customers


-- 2) Gib die ProduktID, den Produktnamen und den Stückpreis aus.

SELECT	  ProductID AS ProduktID
		, ProductName AS Produktname
		, UnitPrice AS Stückpreis
FROM Products

SELECT CONCAT('James', ' ', 'Bond')

-- wenn Abstand im Namen, dann mit eckigen Klammern:
SELECT CONCAT(FirstName, ' ', LastName) AS [vollständiger Name]
FROM Employees


SELECT *
FROM [Order Details]


-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)

SELECT	  Phone
FROM Customers

-- langsam:
SELECT RIGHT(Phone, 3)
FROM Customers

SELECT REPLICATE('x', ?)

SELECT LEN(Phone)-3
FROM Customers

SELECT	  CONCAT(REPLICATE('x', LEN(Phone)-3), RIGHT(Phone, 3))
		, Phone
FROM Customers


SELECT	  CONCAT(REPLICATE('x', LEN(Phone)-3), SUBSTRING(Phone, LEN(Phone)-2, 3))
		, Phone
FROM Customers



SELECT	  ProductID
		, ProductName
		, UnitPrice
		, UnitPrice * 10 AS Berechnung
	--	, 100 * 3 AS Rechnung
	--	, 'Testtext'
FROM Products


-- aus Orders: Frachtkosten, Brutto-/Nettofrachtkosten? MwSt? (19%)

SELECT	  Freight AS Nettofrachtkosten
		, Freight*1.19 AS Bruttofrachtkosten
		, Freight*0.19 AS MWSt
FROM Orders

SELECT *
FROM Employees


-- Ausgabewerte anordnen: ORDER BY
SELECT *
FROM Employees
ORDER BY LastName ASC -- Default ascending (in aufsteigender Reihenfolge)


SELECT CustomerID
		, City
		, Country
FROM Customers
ORDER BY Country, City

-- vom Größten zum Kleinsten ordnen:
SELECT *
FROM Employees
ORDER BY LastName DESC -- descending (in absteigender Reihenfolge) anordnen

-- SELECT Text, Zahlen, Berechnungen, Spalten
-- FROM Tabelle, wo Info herkommt
-- ORDER BY Spalte (in welcher Reihenfolge soll es ausgegeben werden)
