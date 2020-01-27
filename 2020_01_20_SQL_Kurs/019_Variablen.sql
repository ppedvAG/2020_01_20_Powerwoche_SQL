-- Variablen

-- lokale Variablen
-- Zugriff nur in der Session, wo sie erstellt worden ist
-- @var1


-- globale Variablen
-- Zugriff auch von außerhalb der Session
-- @@var1

-- Lebenszeit: nur solange der Batch läuft (gilt für beide)


-- Variable deklarieren
-- welchen Datentyp soll diese Variable haben?

-- Syntax: 
-- DECLARE @varname AS Datentyp


-- Bsp.:
DECLARE @var1 AS int


-- Wert zuweisen
SET @var1 = 100

SELECT @var1


-- Beispiel mit FORMAT
DECLARE @myDate datetime2 = SYSDATETIME()
SELECT FORMAT(@myDate, 'dd.MM.yyyy')


-- VORSICHT:
DECLARE @myDate1 varchar(30) = '2020-01-23'
SELECT FORMAT(@myDate1, 'dd.MM.yyyy')



DECLARE @freight money = 500

SELECT *
FROM Orders
WHERE Freight > @freight
