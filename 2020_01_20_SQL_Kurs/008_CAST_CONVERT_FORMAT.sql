-- CAST, CONVERT und FORMAT
-- wie konvertiere ich Datentypen, wie gebe ich etwas in einem bestimmten Format aus?


-- ********************************* CAST: Umwandeln von Datentypen ********************
USE Northwind

-- funktioniert (ist aber nicht schlau):
SELECT '123' + 2


-- funktioniert NICHT:
SELECT '123.3' + 2
-- Conversion failed when converting the varchar value '123.3' to data type int.

/*
	
	implizite und explizite Konvertierung in der Microsoft-Dokumentation:

		https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15


*/


-- muss in entsprechenden Datentyp konvertiert (umgewandelt) werden:
-- funktioniert (ist aber auch nicht besonders schlau):
SELECT CAST('123.3' AS float) + 2

-- +12/34 567-890
-- 1080 PLZ auch als String-Datentyp

-- geht theoretisch auch mit Datum: Vorsicht: kein Einfluss aufs Format
SELECT CAST(SYSDATETIME() AS varchar)

-- Datum konvertieren: Vorsicht!! Idealerweise nie händisch eingeben.
-- dafür muss ich wissen, wie es in meinem System abgespeichert wird:
SELECT CAST('2020-01-21' AS datetime)


SELECT CAST('21.01.2020' AS datetime)
-- VORSICHT: The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.

SELECT CAST(SYSDATETIME() AS varchar(3)) -- VORSICHT: geht sich das mit der Zeichenanzahl aus??



SELECT CAST(SYSDATETIME() AS varchar(10)) -- nicht schön, aber so KÖNNTE man das Datum ausschneiden


-- aus DB:
SELECT CAST(HireDate AS varchar) AS HireDate
FROM Employees
-- KEIN EINFLUSS auf das Format



-- ********************************** CONVERT ****************************************
-- auch eine Konvertierung, aber mit mehr Möglichkeiten
-- auch fürs Datum geeignet

-- Syntax:
-- CONVERT(data_type[(length)]), expression[, style])
-- CONVERT(1 in welchen Datentyp soll konvertiert werden, 2 was soll konvertiert werden, 3 Style-Parameter)

-- geht, SINN? Vorsicht bei String/number-Datentypen
SELECT CONVERT(varchar(10), 123456.5)


-- geht auch mit Datum
SELECT CONVERT(varchar, SYSDATETIME()) -- funktioniert, Sinn?


SELECT CONVERT(varchar(3), SYSDATETIME()) -- Länge!! Vorsicht!!


-- Vorteil: Style-Parameter:

SELECT CONVERT(varchar, SYSDATETIME(), 104) -- Jahreszahl vierstellig



SELECT CONVERT(varchar, SYSDATETIME(), 4) -- without Century (nur die letzten zwei Stellen der Jahreszahl)


-- 101 für US-amerikanische Schreibweise mm/dd/yyyy
-- 103 für GB dd/mm/yyyy
-- 104 für DE-Schreibweise dd.mm.yyyy


/*

   Date- und Time Style-Parameter in der Microsoft-Dokumentation:

	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles


*/




SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB



-- *********************************** FORMAT ***************************************
-- Formatierung - wie möchte ich meine Daten ausgegeben bekommen?


SELECT FORMAT(1234567890, '###-###/##-##') -- 123-456/78-90

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###')


-- FORMAT funktioniert gut mit Datum:

SELECT FORMAT(SYSDATETIME(), 'dd.MM.yyyy') -- ACHTUNG, SONDERFALL: MM groß schreiben, mm gibt die Minute zurück

SELECT FORMAT(SYSDATETIME(), 'd.M.yyyy') -- führende 0 beim Monat weglassen: 21.1.2020

SELECT FORMAT(SYSDATETIME(), 'yyyy-MM-dd')


SELECT FORMAT(SYSDATETIME(), 'dd***MM***yyyy') -- geht, aber Sinn?


-- Fehlermeldung:
-- geht nicht - was ist Monat? Tag? Jahr?
SELECT FORMAT('2020-01-21', 'dd.MM.yyyy')



-- Information aus DB:

SELECT FORMAT(HireDate, 'dd.MM.yyyy') -- VORSICHT!!! MM groß schreiben, sonst Minute!!
FROM Employees


-- FORMAT hat einen Culture-Parameter:

SELECT	  FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-gb') AS GB
	--	, FORMAT(SYSDATETIME(), 'd', 'sv') AS Schweden


-- d kleingeschrieben: 21.01.2020
-- D großgeschrieben: Wochentag und Monat ausgeschrieben Dienstag, 21.Januar 2020

SELECT	  FORMAT(SYSDATETIME(), 'D', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'D', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'D', 'en-gb') AS GB


/*

	-- Microsoft-Dokumentation für Culture-Codes:
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes


*/
