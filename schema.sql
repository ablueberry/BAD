-- ==========================
--    SCHEMAT SKRYPTU
-- =========================

-- -------------------------
-- Tworzenie bazy danych
-- -------------------------
USE master
GO

IF DB_ID('MojaBaza') IS NOT NULL
CREATE DATABASE MojaBaza
GO

USE MojaBaza

-- ------------------------------------------------------
-- Usuwanie tabel (w odwrotnej kolejności do tworzenia!)
-- ------------------------------------------------------
IF OBJECT_ID('Tabela7','U') IS NOT NULL
DROP TABLE Tabela3

IF OBJECT_ID('Tabela6','U') IS NOT NULL
DROP TABLE Tabela4

.....

IF OBJECT_ID('Tabela1','U') IS NOT NULL
DROP TABLE Tabela1
GO

-- --------------------------------
-- Tworzenie tabel
-- --------------------------------
IF OBJECT_ID('Tabela1','U') IS NULL
CREATE TABLE Tabela1 (
-- ...
-- ...
)

IF OBJECT_ID('Tabela2','U') IS NULL
CREATE TABLE Tabela2 (
-- ...
-- ...
)

...

IF OBJECT_ID('Tabela3','U') IS NULL
CREATE TABLE Tabela7 (
-- ...
-- ...
)
GO

-- ---------------------------------
-- Wstawianie wartości do tabel
-- ---------------------------------
INSERT INTO Tabela1 (kol1, kol2,...) VALUES (wart1, wart2, ...)
INSERT INTO Tabela1 (kol1, kol2,...) VALUES (wart1, wart2, ...)
...
GO

INSERT INTO Tabela2 (kol1, kol2,...) VALUES (wart1, wart2, ...)
INSERT INTO Tabela2 (kol1, kol2,...) VALUES (wart1, wart2, ...)
...
GO

.........

INSERT INTO Tabela7 (kol1, kol2,...) VALUES (wart1, wart2, ...)
INSERT INTO Tabela7 (kol1, kol2,...) VALUES (wart1, wart2, ...)
...
GO

-- ---------------------------------
-- Usuwanie i tworzenie widoków
-- ---------------------------------
IF OBJECT_ID('Widok1','V') IS NOT NULL
DROP VIEW Widok1
GO

CREATE VIEW Widok1 AS (

)
GO

IF OBJECT_ID('Widok2','V') IS NOT NULL
DROP VIEW Widok2
GO

CREATE VIEW Widok2 AS (

)
GO

IF OBJECT_ID('Widok3','V') IS NOT NULL
DROP VIEW Widok3
GO

CREATE VIEW Widok3 AS (

)
GO


-- ---------------------------------
-- Tworzenie procedur
-- ---------------------------------
IF OBJECT_ID('Proc1','P') IS NOT NULL
DROP PROCEDURE Proc1
GO

CREATE PROCEDURE Proc1 AS ( @param1 ...

)
GO

IF OBJECT_ID('Proc2','P') IS NOT NULL
DROP PROCEDURE Proc2
GO

CREATE PROCEDURE Proc2 AS ( @param1 ...

)
GO

-- ---------------------------------------------
-- Utworzenie raportów (wywołanie widoków)
-- ---------------------------------------------

-- Nazwa raportu 1
SELECT * FROM Widok1

-- Nazwa raportu 2
SELECT * FROM Widok2

-- Nazwa raportu 3
SELECT * FROM Widok3

-- Nazwa raportu 4
EXEC Proc1 ...

-- Nazwa raportu 5
EXEC Proc2 ...


-- ---------------------------------------------
-- Usunięcie bazy
-- ---------------------------------------------
USE master
GO

IF DB_ID('MojaBaza') IS NOT NULL
DROP DATABASE MojaBaza
GO
