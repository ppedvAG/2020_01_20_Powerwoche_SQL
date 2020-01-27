-- DISTINCT

USE Northwind


-- wie bekomme ich eine Liste von allen Ländern, in die wir liefern?

SELECT Country
FROM Customers
ORDER BY Country
-- bringt nix, ich bekomme alle Customers, also Länder doppelt und dreifach

-- Lösung:
SELECT DISTINCT Country
FROM Customers
-- 21 Treffer, jedes Land kommt nur noch 1x vor


SELECT DISTINCT Country, CustomerID
FROM Customers
-- bringt nix, weil dann wieder alle Customers ausgegeben werden!


-- Liste von allen Städten, wo wir Kunden haben?
SELECT DISTINCT City
FROM Customers
-- 69 Städte



SELECT DISTINCT City, Country
FROM Customers
-- 69 Treffer; Country wieder mehrfach, weil es mehrere Städte pro Land gibt

-- Liste von allen Ländern, in denen wir Angestellte (Employees) haben
SELECT DISTINCT Country
FROM Employees
-- UK, USA


-- überprüfen:
SELECT *
FROM Employees
-- passt