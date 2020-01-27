-- NULL

-- = NULL - funktioniert NICHT!
-- mathematische Operationen mit NULL funktionieren NICHT

-- NEIN: <, >, =, ...

-- JA: IS NULL, IS NOT NULL
-- "ist das Feld leer?", "ist das Feld nicht leer?"


-- NEIN:
SELECT *
FROM Customers
WHERE Region = NULL
-- keine Fehlermeldung, nur leere Ausgabe... 

-- JA:
SELECT *
FROM Customers
WHERE Region IS NULL


-- ISNULL- Funktion

SELECT	  OrderID
		, CustomerID
		, ISNULL(ShipRegion, '')
FROM Orders
