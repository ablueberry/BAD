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
  ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Firma VARCHAR(30) NOT NULL DEFAULT '',
  Sponsorowana_kwota DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  Rozpoczecie_wspolpracy DATE,
  PRIMARY KEY (ID)
);

CREATE TABLE Oddzialy(
  ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Miejscowosc VARCHAR(30) NOT NULL DEFAULT '',
  Istnieje_od DATE,
  Ilosc_pracownikow int(10) unsigned  NOT NULL DEFAULT '0',
  PRIMARY KEY (ID)
);

CREATE TABLE Pracownicy(
  ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Imie VARCHAR(30) NOT NULL DEFAULT '',
  Nazwisko VARCHAR(30) NOT NULL DEFAULT '',
  Stanowisko VARCHAR(30) NOT NULL DEFAULT '',
  Placa_miesieczna DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  Placa_dodatkowa DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  Umowa VARCHAR(30) NOT NULL DEFAULT '',
  OddzialID INT UNSIGNED NOT NULL,
  Pracuje_od DATE,
  Liczba_godzin int(10) unsigned  NOT NULL DEFAULT '0',
  PRIMARY KEY (ID),
  FOREIGN KEY (OddzialID) REFERENCES Oddzialy(ID)
);

CREATE TABLE Oprogramowanie(
  ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nazwa VARCHAR(30) NOT NULL DEFAULT '',
  Wersja VARCHAR(5) NOT NULL DEFAULT '1.0.0',
  Data_wydania DATE,
  AutorID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (AutorID) REFERENCES Pracownicy(ID)
);

CREATE TABLE Mentorzy(
  ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
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
  ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  MentorID INT UNSIGNED NOT NULL,
  Data DATE,
  Tytul VARCHAR(30) NOT NULL DEFAULT '',
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Miejscowosc VARCHAR(30) NOT NULL DEFAULT '',
  Oplata_za_wstep DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  SponsorID INT UNSIGNED NOT NULL,
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


-- ---------------------------------
-- Wstawianie wartości do tabel
-- ---------------------------------


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
