-- Datumsfunktionen


-- ************************************ Datum abfragen *****************************
-- datetime Datentyp, auf mehrere Millisekunden genau, 8 byte
SELECT GETDATE()

-- datetime2 Datentyp, auf mehrere Nanosekunden genau, 6-8 byte
SELECT SYSDATETIME()


-- **************************** Datumsberechnungen: DATEADD ******************************+

SELECT DATEADD(hh, 10, '2020-01-21') -- wenn wir keine Uhrzeit angeben, wird von 0:00 Uhr ausgegangen

SELECT DATEADD(hh, 10, '21.01.2020') -- VORSICHT: Systemabhängig!


SELECT DATEADD(hh, 10, '2020-01-21 11:44:00.000') -- kann Uhrzeit auch angeben

-- DATEADD mit Information aus Datenbank:
SELECT DATEADD(hh, 10, HireDate)
FROM Employees
-- WHERE EmployeeID = 3 -- Einschränken, wo das Dateadd gemacht werden soll (nur bei Employee Nr. 3)


SELECT DATEADD(dd, 10, HireDate)
FROM Employees

-- auch miteinander verschachtelbar: 10 h zum aktuellen Datum+Uhrzeit hinzuzählen
SELECT DATEADD(hh, 10, SYSDATETIME())

-- auch negative Vorzeichen sind erlaubt:
SELECT DATEADD(hh, -10, SYSDATETIME())
-- 10 Stunden werden vom aktuellen Datum+Uhrzeit abgezogen


-- *********************************** Datumsdifferenz berechnen: DATEDIFF ***************

-- Differenz zwischen zwei Daten:

-- Tage bis zum nächsten Feiertag:
SELECT DATEDIFF(dd, '2020-01-21', '2020-02-14') -- 24

SELECT DATEDIFF(dd, '2020-02-14', '2020-01-21') -- - 24 (mit negativem Vorzeichen)

-- mit aktuellem Datum
SELECT DATEDIFF(dd, SYSDATETIME(), '2020-02-14') -- 24

-- mit Info aus Datenbank
SELECT DATEDIFF(yyyy, HireDate, SYSDATETIME()) -- wie lange arbeiten die schon im Unternehmen?
FROM Employees


-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, SYSDATETIME())

-- ***************************** DATUMSTEILE abfragen **************************

SELECT DATEPART(dd, '2020-01-21') -- 21
SELECT DATEPART(yyyy, '2020-01-21') -- 2020

-- In welchem Quartal liegt...?
SELECT DATEPART(qq, '2020-01-21')

-- auch hier darf/soll man mit SYSDATETIME(), GETDATE(),... oder Informationen aus der Datenbank kombinieren



/*
	year, yyyy, yy = Year
	quarter, qq, q = Quartal
	month, MM, M = Monat
	week, ww, wk = Woche
	day, dd, d = Tag
	hour, hh = Stunde
	minute, mi, n = Minute
	second, ss, s = Sekunde
	millisecond, ms = Millisekunde -- datetime geht auf mehrere Millisekunden genau
	nanosecond, ns = Nanosekunde -- datetime2 auf mehrere Nanosekunden genau

	weekday, dw, w = Day of Week (Wochentag)
	dayofyear, dy, y = Day of Year (der wievielte Tag des Jahres)


*/

SELECT DATEPART(y, SYSDATETIME())


SELECT DATEPART(dw, SYSDATETIME()) -- ACHTUNG: Systemabhängig!! ev. beginnt bei Sonntag mit 1 zu zählen


-- *************************************** DATENAME ****************************


SELECT DATENAME(dd, SYSDATETIME()) -- bringt nix, weil dann bekomme ich wieder den Tag als Zahl

-- hier machen nur zwei Angaben Sinn: dw (Wochentag) und month (Monat)


SELECT DATENAME(dw, SYSDATETIME()) -- Tuesday


SELECT DATENAME(month, SYSDATETIME()) -- January


--Welcher Wochentag war Dein Geburtstag?

SELECT DATENAME(dw, '1981-04-22') -- Wednesday


-- Vor wievielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )
SELECT DATEDIFF(yyyy, '1977-05-25', SYSDATETIME()) -- 43

SELECT DATEDIFF(yyyy, '1977', SYSDATETIME()) -- 43



-- In welchem Quartal liegt der österreichische Nationalfeiertag (26.10.)?
SELECT DATEPART(qq, '2020-10-26')



-- Gib Tag, Monat und Jahr Deines Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden Überschrift an
--    Tag          Monat         Jahr
--     22           04           1981


SELECT	  DATEPART(dd, '1981-04-22') AS Tag
		, DATEPART(MM, '1981-04-22') AS Monat
		, DATEPART(yyyy, '1981-04-22') AS Jahr


SELECT DATEPART(yyyy, HireDate) AS HireYear
FROM Employees


-- ************************** DAY, MONTH, YEAR ***************************
-- Tag/Monat/Jahr als Integerwert

SELECT DAY('1981-04-22')
SELECT MONTH('1981-04-22')
SELECT YEAR('1981-04-22')


SELECT	  DAY('1981-04-22') AS Tag
		, MONTH('1981-04-22') AS Monat
		, YEAR('1981-04-22') AS Jahr



-- mit aktuellem Datum
SELECT DAY(SYSDATETIME())

-- mit Information aus der Datenbank
SELECT YEAR(HireDate)
FROM Employees
-- WHERE EmployeeID = 4
ORDER BY HireDate
