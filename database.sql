-- ==================================
--    SKRYPT GENERUJĄCY BAZĘ "FIRMA"
-- ==================================

-- --------------------------------
--     to run mysql
--  $ mysql -u jagoda -p
--  > source <path to this script>
-- ---------------------------------

-- -------------------------
-- Tworzenie bazy danych
-- -------------------------

DROP DATABASE IF EXISTS Firma;
CREATE DATABASE Firma;

USE Firma;

-- ------------------------------------------------------
-- Usuwanie tabel (w odwrotnej kolejności do tworzenia!)
-- ------------------------------------------------------

DROP TABLE IF EXISTS Uczestnicy;
DROP TABLE IF EXISTS Warsztaty;
DROP TABLE IF EXISTS Mentorzy;
DROP TABLE IF EXISTS Oprogramowanie;
DROP TABLE IF EXISTS Pracownicy;
DROP TABLE IF EXISTS Oddzialy;
DROP TABLE IF EXISTS Sponsorzy;

-- --------------------------------
-- Tworzenie tabel
-- --------------------------------

CREATE TABLE Sponsorzy(
  ID CHAR(3) NOT NULL,
  Firma VARCHAR(30) NOT NULL DEFAULT '',
  Sponsorowana_kwota DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  Rozpoczecie_wspolpracy DATE,
  PRIMARY KEY (ID)
);

CREATE TABLE Oddzialy(
  ID CHAR(5) NOT NULL,
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Miejscowosc VARCHAR(30) NOT NULL DEFAULT '',
  Istnieje_od DATE,
  Ilosc_pracownikow int(10) unsigned  NOT NULL DEFAULT '0',
  PRIMARY KEY (ID)
);

CREATE TABLE Pracownicy(
  ID INT UNSIGNED NOT NULL,
  Imie VARCHAR(30) NOT NULL DEFAULT '',
  Nazwisko VARCHAR(30) NOT NULL DEFAULT '',
  Stanowisko VARCHAR(30) NOT NULL DEFAULT '',
  Placa_miesieczna DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  Placa_dodatkowa DECIMAL(10,2) DEFAULT '0.00',
  Umowa VARCHAR(30) NOT NULL DEFAULT '',
  OddzialID CHAR(5) NOT NULL,
  Pracuje_od DATE,
  Liczba_godzin int(10) unsigned  NOT NULL DEFAULT '0',
  PRIMARY KEY (ID),
  FOREIGN KEY (OddzialID) REFERENCES Oddzialy(ID)
);

CREATE TABLE Oprogramowanie(
  ID INT UNSIGNED NOT NULL,
  Nazwa VARCHAR(30) NOT NULL DEFAULT '',
  Wersja VARCHAR(5) NOT NULL DEFAULT '1.0.0',
  Data_wydania DATE,
  AutorID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (AutorID) REFERENCES Pracownicy(ID)
);

CREATE TABLE Mentorzy(
  ID INT UNSIGNED NOT NULL,
  Imie VARCHAR(30) NOT NULL DEFAULT '',
  Nazwisko VARCHAR(30) NOT NULL DEFAULT '',
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Technologia VARCHAR(30) NOT NULL DEFAULT '',
  Wynagrodzenie DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  OpiekunID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (OpiekunID) REFERENCES Pracownicy(ID)
);

CREATE TABLE Warsztaty(
  ID INT UNSIGNED NOT NULL,
  MentorID INT UNSIGNED NOT NULL,
  Data DATE,
  Tytul VARCHAR(30) NOT NULL DEFAULT '',
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Miejscowosc VARCHAR(30) NOT NULL DEFAULT '',
  Oplata_za_wstep DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  SponsorID CHAR(3) NOT NULL,
  OprogramowanieID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (MentorID) REFERENCES Mentorzy(ID),
  FOREIGN KEY (SponsorID) REFERENCES Sponsorzy(ID),
  FOREIGN KEY (OprogramowanieID) REFERENCES Oprogramowanie(ID)
);

CREATE TABLE Uczestnicy(
  ID INT UNSIGNED NOT NULL,
  Imie VARCHAR(30) NOT NULL DEFAULT '',
  Nazwisko VARCHAR(30) NOT NULL DEFAULT '',
  WarsztatID INT UNSIGNED NOT NULL ,
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Miejscowosc VARCHAR(30) NOT NULL DEFAULT '',
  Oplata DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  FOREIGN KEY (WarsztatID) REFERENCES Warsztaty(ID)
);


-- SHOW TABLES;

-- DESCRIBE Mentorzy;
-- DESCRIBE Oddzialy;
-- DESCRIBE Oprogramowanie;
-- DESCRIBE Pracownicy;
-- DESCRIBE Sponsorzy;
-- DESCRIBE Uczestnicy;
-- DESCRIBE Warsztaty;

-- ---------------------------------
-- Wstawianie wartości do tabel
-- ---------------------------------

-- ---------------------------------
--            Sponsorzy
-- ---------------------------------
INSERT INTO Sponsorzy (ID, Firma, Sponsorowana_kwota, Rozpoczecie_wspolpracy) VALUES
('SMG', 'Samsung', 15000, '2010-05-15'),
('NXT', 'NEXT', 10000, '2010-10-01'),
('DMK', 'DigitMonkeys', 20000, '2012-01-01'),
('BOT', 'Bootstrap Inc.', 16500, '2014-04-14'),
('VUE', 'Vue Inc.', 10500, '2016-04-14');
-- ---------------------------------
--            Oddzialy
-- ---------------------------------
INSERT INTO Oddzialy (Kraj, Miejscowosc, Istnieje_od, Ilosc_pracownikow) VALUES
('WRCPL', 'Polska', 'Wroclaw', '2010-02-01', 4),
('POZPL', 'Polska', 'Poznan', '2010-10-01', 2),
('BARSP', 'Hiszpania', 'Barcelona', '2011-01-01', 2);

-- ---------------------------------
--           Pracownicy
-- ---------------------------------
INSERT INTO Pracownicy (
  Imie,
  Nazwisko,
  Stanowisko,
  Placa_miesieczna,
  Placa_dodatkowa,
  Umowa,
  OddzialID,
  Pracuje_od,
  Liczba_godzin
) VALUES
('Michal', 'Okolski', 'Wlasciciel', 10000, 0.00, '', 'WRCPL', '2010-02-01', 150),
('Tomasz', 'Witka', 'Programista', 8000, 2000.00, 'O prace', 'WRCPL', '2010-02-01', 150),
('Ala', 'Witka', 'Programista', 8000, 2000.00, 'O prace', 'WRCPL', '2005-10-01', 150),
('Patricia', 'Ruegga', 'Konsultant', 2500, 500.00, 'Zlecenie', 'WRCPL', '2011-01-01', 150),
('Amelia', 'Rus', 'Opiekun', 2400, 500.00, 'Zlecenie', 'POZPL', '2010-10-01', 100),
('Mikolaj', 'Kles', 'Opiekun', 2400, 500.00, 'Zlecenie', 'POZPL', '2010-10-01', 100),
('Alex', 'Rovee', 'Konsultant', 2000, 500.00, 'Zlecenie', 'BARSP', '2011-01-01', 100),
('Jorge', 'Ingrid', 'Opiekun', 2400, 500.00, 'Zlecenie', 'BARSP', '2011-01-01', 100);

-- ---------------------------------
--         Oprogramowanie
-- ---------------------------------
INSERT INTO Oprogramowanie (Nazwa, Wersja, Data_wydania, AutorID) VALUES
(),
();
-- ---------------------------------
--            Mentorzy
-- ---------------------------------
INSERT INTO Mentorzy (
  Imie,
  Nazwisko,
  Kraj,
  Technologia,
  Wynagrodzenie,
  OpiekunID
) VALUES
(),
();
-- ---------------------------------
--            Warsztaty
-- ---------------------------------
INSERT INTO Warsztaty (
  MentorID,
  Data,
  Tytul,
  Kraj,
  Miejscowosc,
  Oplata_za_wstep,
  SponsorID,
  OprogramowanieID
) VALUES
(),
();
-- ---------------------------------
--           Uczestnicy
-- ---------------------------------
INSERT INTO Uczestnicy (
  ID,
  Imie,
  Nazwisko,
  WarsztatID,
  Kraj,
  Miejscowosc,
  Oplata
) VALUES
(),
();


-- ---------------------------------
-- Usuwanie i tworzenie widoków
-- ---------------------------------


-- ---------------------------------
-- Tworzenie procedur
-- ---------------------------------


-- ---------------------------------------------
-- Utworzenie raportów (wywołanie widoków)
-- ---------------------------------------------


-- ---------------------------------------------
-- Usunięcie bazy
-- ---------------------------------------------
