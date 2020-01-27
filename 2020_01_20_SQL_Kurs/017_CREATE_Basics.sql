-- simple CREATE, INSERT, UPDATE, DELETE -Statements

-- Datenbank erstellen, updaten, einfügen...


-- CREATE DATABASE DBName

-- unwiderrufliches Löschen der DB!!!!!!
-- DROP DATABASE MyTestDB01
CREATE DATABASE MyTestDB01

-- Tabelle erstellen
-- CREATE TABLE Tabellenname

USE MyTestDB01

CREATE TABLE Produkte 
		(
			ProduktID int identity,
			Bezeichnung varchar(50),
			Preis money
		)

-- DROP TABLE Produkte


INSERT INTO Produkte (Bezeichnung, Preis)
VALUES('Spaghetti', 2.5)

SELECT *
FROM Produkte



INSERT INTO Produkte (Bezeichnung, Preis)
VALUES ('Pesto', 3.50)


INSERT INTO Produkte (Preis, Bezeichnung)
VALUES (3.99, 'Tiramisu')


INSERT INTO Produkte (Bezeichnung, Preis)
VALUES  ('Profiterols', 3.95),
		('Limoncello', 3.89),
		('Tartufo', 4.65)


SELECT *
FROM Produkte


DELETE FROM Produkte
WHERE ProduktID = 7


INSERT INTO Produkte (Preis, Bezeichnung)
VALUES (4.99, 'Lasagne')

UPDATE Produkte
SET Preis = 2.90
WHERE ProduktID = 1





