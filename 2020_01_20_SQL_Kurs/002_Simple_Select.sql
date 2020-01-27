-- SIMPLE SELECT
-- einfache Abfragen

/*



*/

-- Zahl ausgeben lassen

SELECT 100


-- Text ausgeben

SELECT 'Testtext'


-- Berechnungen ausgeben

SELECT 100*3


-- wird als Text angezeigt
SELECT '100*3'



SELECT 100, 'Testtext'



SELECT 100 AS Zahl


SELECT 100 Zahl, 'Testtext' -- geht auch ohne, aber besser für Übersicht, wenn AS dabeisteht


SELECT	100,
		'Testtext', -- Fehlermeldung, weil nach letzter Zeile kein Komma steht 
	--	100*3 -- aufpassen beim Auskommentieren


SELECT	 100
		,'Testtext'
	--	,100*3


