-- WH/Übung Aggregatfunktionen
-- wie bekomme ich die Rechnungssumme inklusive Frachtkosten?

-- NEIN:
SELECT o.OrderID, (UnitPrice*Quantity+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
-- Rechnungsposten

-- NEIN:
SELECT o.OrderID, SUM(UnitPrice*Quantity+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.OrderID
-- da sind jetzt die Frachtkosten pro Rechnungsposten nochmals hinzuaddiert
-- 1. Wert: 537,14?

-- Ja: (Klammer korrekt setzen - Freight steht außerhalb vom SUM)
SELECT o.OrderID, (SUM(UnitPrice*Quantity)+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.OrderID, Freight

-- überprüfen:
SELECT OrderID, UnitPrice*Quantity
FROM [Order Details]
-- Summe für 1. Bestellung: 440

SELECT OrderID, Freight
FROM Orders
-- 1. Wert: 472,38?


-- nur die Bestellungen, wo die Rechnungssumme > 500 ist
SELECT o.OrderID, SUM(UnitPrice*Quantity+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.OrderID
HAVING SUM(UnitPrice*Quantity+Freight) > 500


-- alle, wo Frachtkosten > als durchschnittliche Frachtkosten
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)



-- Wieviele Kunden gibts pro Land? Nur die, wo mehr als 5 Kunden pro Land vorhanden sind
-- in absteigender Reihenfolge geordnet
-- Anzahl, Country

SELECT Count(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5

-- funktioniert NICHT!!!!!
SELECT Count(CustomerID), Country
FROM Customers
WHERE COUNT(CustomerID) > 5
GROUP BY Country



-- alle Employees, die mehr als 70 Bestellungen bearbeitet haben
-- LastName, Anzahl Bestellungen
SELECT o.EmployeeID, e.LastName, COUNT(o.EmployeeID) 
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID, e.LastName
HAVING COUNT(o.EmployeeID) > 70


-- gleiche Angabe, aber mit FirstName + LastName = FullName
SELECT o.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName), COUNT(o.EmployeeID) 
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID, e.LastName, e.FirstName
HAVING COUNT(o.EmployeeID) > 70


-- feststellen, ob meine Angestellten mit der EmployeeID 2 und 7 mehr als 100 Bestellungen bearbeitet haben
-- Name, Anzahl Bestellungen
SELECT e.LastName, COUNT(e.LastName) AS [Anzahl Bestellungen]
FROM Employees e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE e.EmployeeID IN(2, 7)
GROUP BY e.LastName
HAVING COUNT(e.LastName) > 100


-- Leverling, Peacock? Haben die mehr als 100?
SELECT e.LastName, COUNT(e.LastName) AS [Anzahl Bestellungen]
FROM Employees e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE e.LastName IN('Leverling', 'Peacock')
GROUP BY e.LastName
HAVING COUNT(e.LastName) > 100