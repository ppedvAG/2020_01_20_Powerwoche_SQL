-- häufig verwendete Serverfunktionen

-- ***************************** TRIM, LEN, DATALENGTH **********************


SELECT 'Test     '

SELECT LEN('Test     ') -- "Länge" abfragen: wieviele Zeichen sind da drin?

SELECT LEN('Test Text    ') -- LEN zählt Leerzeichen in der Mitte mit

SELECT LEN('     Test     ') -- LEN zählt Leerzeichen am Anfang mit



SELECT DATALENGTH('Test     ') -- Datalength zählt Leerzeichen mit
SELECT DATALENGTH('Test Text    ')



SELECT DATALENGTH('    Test     ')
SELECT TRIM('    Test     ')


SELECT DATALENGTH(TRIM('    Test     '))

SELECT RTRIM('Test     ') -- schneidet Leerzeichen rechts weg
SELECT LTRIM('     Test') -- schneidet Leerzeichen links weg


-- *********************************** REVERSE ******************************

-- in umgekehrter Reihenfolge ausgeben

SELECT REVERSE('REITTIER')
SELECT REVERSE('Trug Tim eine so helle Hose nie mit Gurt?')


-- **************************** LEFT, RIGHT, SUBSTRING ************************

-- Zeichen ausschneiden

-- schneidet die ersten Zeichen aus
SELECT LEFT('Testtext', 4)

-- schneidet die letzten Zeichen aus
SELECT RIGHT('Testext', 4)


-- Textausschnitt erstellen
SELECT SUBSTRING('Testtext', 4, 2)  -- ab welcher Stelle möchte ich ausschneiden (4), wieviele möchte ich ausschneiden (2)


-- ************************************* STUFF ********************************

-- Zeichen einfügen ("reinstopfen") STUFF

SELECT STUFF('Testtext', 5, 0, '_Hallo_')
-- wo soll eingefügt werden? (ab Stelle 5)
-- wieviel soll weggelöscht werden (0 wenn nichts gelöscht werden soll)
-- was soll eingefügt werden? (_Hallo_)


SELECT  DATALENGTH('     Test     ') AS Vorher
	   ,DATALENGTH(TRIM('     Test     ')) AS Nachher



-- ************************* Übung
-- Die letzten drei Stellen der Telefonnummer sollen durch xxx ersetzt werden: +49 86779889 - xxx

-- Möglichkeit 1

SELECT STUFF('1234567890', 8, 3, 'xxx')


-- Möglichkeit 2
SELECT REVERSE('1234567890')

SELECT STUFF(REVERSE('1234567890'), 1, 3, 'xxx')

SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))


-- Möglichkeit 3
SELECT LEFT('1234567890', 7) + 'xxx' -- wieder nicht unabhängig von Länge!


-- Möglichkeit 4
SELECT LEN('1234567890')-3

SELECT LEFT('1234567890', (LEN('1234567890')-3)) + 'xxx'

-- aus einer Datenbank: auch für Spalten möglich
SELECT LEFT(Phone, (LEN(Phone)-3)) + 'xxx'



-- ******************************* CONCAT ***********************************
-- String


SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts weiß.') AS Zitat

SELECT CONCAT('James', ' ', 'Bond')
SELECT CONCAT(FirstName, ' ', LastName) AS FullName

SELECT CONCAT(TRIM(FirstName), ' ', TRIM(LastName)) AS FullName


-- mögliche Lösung
-- Korrigiere die Fehler im Namen: Wilham Shakesbeer --> William Shakespeare
-- Dabei sollen Buchstaben, die schon stimmen, beibehalten werden.
SELECT CONCAT(
SUBSTRING(STUFF('Wilham Shakesbeer', 4, 1, 'li'), 1, 14),
SUBSTRING(STUFF('Wilham Shakesbeer', 14, 4, 'pe'), 14, 5),
SUBSTRING(STUFF('Wilham Shakesbeer', 17, 0, 'a'), 17, 2),
'e'
)



-- *************************** REPLICATE **********************************+
-- Zeichen oder Zeichenfolge mehrfach ausgeben

SELECT REPLICATE('?', 5) -- ?????
SELECT REPLICATE('abc', 3) -- abcabcabc


-- **************************** Groß- und Kleinbuchstaben ausgeben ***************
-- alles in Großbuchstaben ausgeben:
SELECT UPPER('abc')
SELECT UPPER(Spaltenname)


-- alles in Kleinbuchstaben ausgeben:
SELECT LOWER('ABC')
SELECT LOWER(Spaltenname)


-- ******************************* CHARINDEX ***********************************

-- an welcher Stelle befindet sich ein gesuchtes Zeichen?

SELECT CHARINDEX('a', 'Leo') -- 0 - gibt es nicht

SELECT CHARINDEX('l', 'Leo') -- 1 

SELECT CHARINDEX(' ', 'James Bond') -- 6

-- Zeichenfolgen suchen
SELECT CHARINDEX('schnecke', 'Zuckerschnecke') -- 7 (wo startet das erste Zeichen aus der gesuchten Zeichenfolge)


SELECT CHARINDEX(' ', 'Wolfgang Amadeus Mozart') -- 9

-- an welcher Stelle befindet sich das letzte Leerzeichen?

-- langsam aufgeschlüsselt:

SELECT REVERSE('Wolfgang Amadeus Mozart')  -- trazoM suedamA gnagfloW
SELECT CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 7
SELECT DATALENGTH('Wolfgang Amadeus Mozart') -- 23 

SELECT 23-7 -- 16
SELECT 23-7+1 -- 17

SELECT DATALENGTH('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'trazoM suedamA gnagfloW') +1



SELECT DATALENGTH('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart')) +1



SELECT DATALENGTH('Johann Sebastian Bach') - CHARINDEX(' ', REVERSE('Johann Sebastian Bach')) +1



SELECT DATALENGTH(Spaltenname) - CHARINDEX(' ', REVERSE(Spaltenname)) +1


-- man kann auch nach Sonderzeichen suchen

SELECT CHARINDEX('$', '430$')
SELECT CHARINDEX('%', '50%')



-- ******************************* REPLACE ********************

-- Zeichen ersetzen

SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!

-- 1: Ausdruck, den wir bearbeiten wollen
-- 2: WAS wollen wir ersetzen?
-- 3: WOMIT wollen wir es ersetzen?


SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?') -- Hello?

SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'h', 'B') -- Bello?


-- SELECT REPLACE(REPLACE(REPLACE()))
