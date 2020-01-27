-- Untergruppierungen
-- OVER PARTITION BY


-- Mittelwert der Frachtkosten
SELECT AVG(Freight) AS AverageFreight
FROM Orders


-- Mittelwert pro ... z.B. pro Frächter (ShipVia)
SELECT ShipVia, AVG(Freight) AS AvgFreight
FROM Orders
GROUP BY ShipVia


-- wenn mehrere Spalten...
-- mittlere Frachtkosten pro Kunde und Frächter
SELECT CustomerID, ShipVia, AVG(Freight) AS AvgFreight
FROM Orders
GROUP BY CustomerID, ShipVia
-- 239 Ausgabezeilen


-- Problem: wenn mehr Spalten - AVG(Freight) pro OrderID = Freight, kein Mittelwert mehr!
SELECT OrderID, CustomerID, ShipVia, AVG(Freight) AS AvgFreight
FROM Orders
GROUP BY OrderID, CustomerID, ShipVia



-- mit OVER PARTITION BY
-- trotz OrderID mittlere Frachtkosten pro Frächter angeben
SELECT    OrderID
		, CustomerID
		, ShipVia
		, Freight
		, AVG(Freight)
				OVER( PARTITION BY ShipVia ) AS AvgFreight
FROM Orders
ORDER BY CustomerID



-- mehrere Angaben im OVER PARTITION BY
-- mittleren Frachtkosten pro Kunde und Frächter
SELECT    OrderID
		, CustomerID
		, ShipVia
		, Freight
		, AVG(Freight)
				OVER( PARTITION BY CustomerID, ShipVia ) AS AvgFreight
FROM Orders
ORDER BY CustomerID