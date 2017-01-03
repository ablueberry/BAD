-- ==================================
--    SKRYPT GENERUJĄCY BAZĘ "FIRMA"
-- ==================================

-- --------------------------------
--     to run mysql
--  $ mysql -u jagoda -p
--  > source /home/jagoda/BAD/database.sql
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
  PRIMARY KEY (ID)
);

CREATE TABLE Pracownicy(
  ID CHAR(3) NOT NULL,
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
  ID CHAR(3) NOT NULL,
  Nazwa VARCHAR(30) NOT NULL DEFAULT '',
  Wersja VARCHAR(5) NOT NULL DEFAULT '1.0.0',
  Data_wydania DATE,
  AutorID CHAR(3) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (AutorID) REFERENCES Pracownicy(ID)
);

CREATE TABLE Mentorzy(
  ID CHAR(3) NOT NULL,
  Imie VARCHAR(30) NOT NULL DEFAULT '',
  Nazwisko VARCHAR(30) NOT NULL DEFAULT '',
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Technologia VARCHAR(30) NOT NULL DEFAULT '',
  Wynagrodzenie DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  OpiekunID CHAR(3) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (OpiekunID) REFERENCES Pracownicy(ID)
);

CREATE TABLE Warsztaty(
  ID CHAR(3) NOT NULL,
  MentorID CHAR(3) NOT NULL,
  Data DATE,
  Tytul VARCHAR(30) NOT NULL DEFAULT '',
  Kraj VARCHAR(30) NOT NULL DEFAULT '',
  Miejscowosc VARCHAR(30) NOT NULL DEFAULT '',
  SponsorID CHAR(3) NOT NULL,
  OprogramowanieID CHAR(3) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (MentorID) REFERENCES Mentorzy(ID),
  FOREIGN KEY (SponsorID) REFERENCES Sponsorzy(ID),
  FOREIGN KEY (OprogramowanieID) REFERENCES Oprogramowanie(ID)
);

CREATE TABLE Uczestnicy(
  ID CHAR(3) NOT NULL,
  Imie VARCHAR(30) NOT NULL DEFAULT '',
  Nazwisko VARCHAR(30) NOT NULL DEFAULT '',
  WarsztatID CHAR(3) NOT NULL,
  Kraj VARCHAR(30) NOT NULL DEFAULT 'Polska',
  Miejscowosc VARCHAR(30) NOT NULL DEFAULT '',
  Oplata DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  FOREIGN KEY (WarsztatID) REFERENCES Warsztaty(ID)
);


-- SHOW TABLES;
--
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
('SMG', 'Samsung', 15000, '2014-05-15'),
('NXT', 'NEXT', 10000, '2014-10-01'),
('DMK', 'DigitMonkeys', 20000, '2015-02-01'),
('BOT', 'Bootstrap Inc.', 16500, '2015-04-14'),
('VUE', 'Vue Inc.', 10500, '2016-04-14');

-- SELECT * FROM Sponsorzy;
-- ---------------------------------
--            Oddzialy
-- ---------------------------------
INSERT INTO Oddzialy (ID, Kraj, Miejscowosc, Istnieje_od) VALUES
('WRCPL', 'Polska', 'Wroclaw', '2014-02-01'),
('POZPL', 'Polska', 'Poznan', '2014-10-01'),
('WARPL', 'Polska', 'Warszawa', '2015-01-01');

-- SELECT * FROM Oddzialy;

-- ---------------------------------
--           Pracownicy
-- ---------------------------------
INSERT INTO Pracownicy (
  ID,
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
('MO1', 'Michal', 'Okolski', 'Wlasciciel', 10000, 0.00, '', 'WRCPL', '2014-02-01', 150),
('TW1', 'Tomasz', 'Witka', 'Programista', 8000, 2000.00, 'O prace', 'WRCPL', '2014-02-01', 150),
('AW1', 'Ala', 'Witka', 'Programista', 8000, 2000.00, 'O prace', 'WRCPL', '2014-10-01', 150),
('PR1', 'Patricia', 'Ruegga', 'Konsultant', 2500, 500.00, 'Zlecenie', 'WRCPL', '2014-10-01', 150),
('AR1', 'Amelia', 'Rus', 'Opiekun', 2400, 500.00, 'Zlecenie', 'POZPL', '2014-10-01', 100),
('MK1', 'Mikolaj', 'Kles', 'Opiekun', 2400, 500.00, 'Zlecenie', 'POZPL', '2014-10-01', 100),
('AR2', 'Aleksander', 'Robak', 'Konsultant', 2000, 500.00, 'Zlecenie', 'WARPL', '2015-01-01', 100),
('JW1', 'Jacek', 'Wozny', 'Opiekun', 2400, 500.00, 'Zlecenie', 'WARPL', '2015-01-01', 100);

-- SELECT * FROM Pracownicy;

-- ---------------------------------
--         Oprogramowanie
-- ---------------------------------
INSERT INTO Oprogramowanie (ID, Nazwa, Wersja, Data_wydania, AutorID) VALUES
('GA1', 'Generator Angular', '1.0.0', '2014-05-01', 'TW1'),
('GA2', 'Generator Angular', '1.5.0', '2014-06-01', 'TW1'),
('GA3', 'Generator Angular', '2.0.0', '2014-09-01', 'TW1'),
('GA4', 'Generator Angular', '2.3.0', '2015-02-01', 'TW1'),
('GR1', 'Generator React', '1.0.0', '2016-01-01', 'AW1'),
('GR2', 'Generator React', '1.4.0', '2016-05-01', 'AW1'),
('GR3', 'Generator React', '1.5.0', '2016-06-01', 'AW1'),
('GR4', 'Generator React', '2.0.0', '2016-08-01', 'AW1');

-- SELECT * FROM Oprogramowanie;
-- ---------------------------------
--            Mentorzy
-- ---------------------------------
INSERT INTO Mentorzy (
  ID,
  Imie,
  Nazwisko,
  Kraj,
  Technologia,
  Wynagrodzenie,
  OpiekunID
) VALUES
('LS1', 'Loren', 'Stewart', 'Wielka Brytania', 'React', 500, 'AR1'),
('DL1', 'David', 'Leon', 'Wielka Brytania', 'React', 500, 'JW1'),
('MM1', 'Max', 'Musk', 'Wielka Brytania', 'Angular', 650, 'AR1'),
('JA1', 'Jorge', 'Aguirre', 'Hiszpania', 'Angular', 400, 'JW1'),
('MG1', 'Mario', 'Gonzalez', 'Hiszpania', 'Angular', 350, 'MK1'),
('MC1', 'Martinez', 'Calves', 'Hiszpania', 'React', 790, 'MK1');

-- SELECT * FROM Mentorzy;
-- ---------------------------------
--            Warsztaty
-- ---------------------------------
INSERT INTO Warsztaty (
  ID,
  MentorID,
  Data,
  Tytul,
  Kraj,
  Miejscowosc,
  SponsorID,
  OprogramowanieID
) VALUES
('001', 'MM1', '2014-06-01', 'Angular', 'Polska', 'Warszawa', 'SMG', 'GA1'),
('002', 'MM1', '2014-07-14', 'Angular', 'Polska', 'Warszawa', 'SMG', 'GA1'),
('003', 'JA1', '2014-07-15', 'Angular', 'Polska', 'Wroclaw', 'SMG', 'GA2'),
('004', 'JA1', '2014-08-10', 'Angular', 'Polska', 'Wroclaw', 'SMG', 'GA2'),
('005', 'JA1', '2014-08-11', 'Angular', 'Polska', 'Wroclaw', 'SMG', 'GA2'),
('006', 'MM1', '2014-08-14', 'Angular', 'Polska', 'Warszawa', 'SMG', 'GA2'),
('007', 'MM1', '2014-10-16', 'Angular', 'Hiszpania', 'Barcelona', 'NXT', 'GA3'),
('008', 'MM1', '2014-11-23', 'Angular', 'Hiszpania', 'Barcelona', 'NXT', 'GA3'),
('009', 'MM1', '2014-12-14', 'Angular', 'Hiszpania', 'Barcelona', 'NXT', 'GA3'),
('010', 'JA1', '2014-12-20', 'Angular', 'Polska', 'Wroclaw', 'SMG', 'GA3'),
('011', 'MM1', '2015-01-10', 'Angular', 'Hiszpania', 'Barcelona', 'NXT', 'GA3'),
('012', 'LS1', '2016-02-01', 'React', 'Polska', 'Gdansk', 'BOT', 'GR1'),
('013', 'LS1', '2016-02-10', 'React', 'Polska', 'Warszawa', 'BOT', 'GR1'),
('014', 'LS1', '2016-03-03', 'React', 'Polska', 'Warszawa', 'NXT', 'GR1'),
('015', 'LS1', '2016-03-17', 'React', 'Polska', 'Poznan', 'BOT', 'GR1'),
('016', 'LS1', '2016-03-15', 'React', 'Polska', 'Poznan', 'BOT', 'GR1'),
('017', 'LS1', '2016-03-28', 'React', 'Polska', 'Krakow', 'DMK', 'GR1'),
('018', 'LS1', '2016-04-15', 'React', 'Polska', 'Poznan', 'DMK', 'GR1'),
('019', 'DL1', '2016-06-15', 'React', 'Hiszpania', 'Barcelona', 'DMK', 'GR2'),
('020', 'DL1', '2016-06-30', 'React', 'Hiszpania', 'Allicante', 'VUE', 'GR2'),
('021', 'DL1', '2016-07-15', 'React', 'Polska', 'Gdynia', 'VUE', 'GR2'),
('022', 'DL1', '2016-07-20', 'React', 'Polska', 'Torun', 'VUE', 'GR3'),
('023', 'DL1', '2016-07-25', 'React', 'Polska', 'Torun', 'DMK', 'GR3'),
('024', 'MM1', '2015-03-01', 'Angular', 'Polska', 'Warszawa', 'NXT', 'GA4'),
('025', 'MM1', '2015-03-03', 'Angular', 'Polska', 'Warszawa', 'NXT', 'GA4'),
('026', 'MM1', '2015-03-10', 'Angular', 'Polska', 'Gdynia', 'VUE', 'GA4'),
('027', 'MM1', '2015-04-01', 'Angular', 'Polska', 'Krakow', 'VUE', 'GA4'),
('028', 'MM1', '2015-04-15', 'Angular', 'Polska', 'Torun', 'SMG', 'GA4'),
('029', 'MM1', '2015-05-01', 'Angular', 'Wielka Brytania', 'Londyn', 'SMG', 'GA4'),
('030', 'MM1', '2015-05-02', 'Angular', 'Wielka Brytania', 'Londyn', 'DMK', 'GA4'),
('031', 'MM1', '2015-05-03', 'Angular', 'Wielka Brytania', 'Londyn', 'SMG', 'GA4'),
('032', 'MM1', '2015-05-04', 'Angular', 'Wielka Brytania', 'Londyn', 'VUE', 'GA4'),
('033', 'MM1', '2015-05-04', 'Angular', 'Wielka Brytania', 'Londyn', 'VUE', 'GA4'),
('034', 'MG1', '2015-04-20', 'Angular', 'Polska', 'Szczecin', 'VUE', 'GA4'),
('035', 'MG1', '2015-04-30', 'Angular', 'Polska', 'Szczecin', 'DMK', 'GA4'),
('036', 'MG1', '2015-05-05', 'Angular', 'Polska', 'Bydgoszcz', 'DMK', 'GA4'),
('037', 'MG1', '2015-05-06', 'Angular', 'Polska', 'Bydgoszcz', 'NXT', 'GA4'),
('038', 'MG1', '2015-05-20', 'Angular', 'Polska', 'Torun', 'NXT', 'GA4'),
('039', 'MG1', '2015-05-21', 'Angular', 'Polska', 'Torun', 'SMG', 'GA4'),
('040', 'MG1', '2015-05-30', 'Angular', 'Polska', 'Sopot', 'SMG', 'GA4'),
('041', 'MG1', '2015-06-01', 'Angular', 'Polska', 'Sopot', 'NXT', 'GA4'),
('042', 'MC1', '2016-08-10', 'React', 'Polska', 'Warszawa', 'NXT', 'GR4'),
('043', 'MC1', '2016-09-20', 'React', 'Niemcy', 'Berlin', 'DMK', 'GR4'),
('044', 'MC1', '2016-09-21', 'React', 'Niemcy', 'Berlin', 'DMK', 'GR4');

-- SELECT * FROM Warsztaty;

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
('GM1', 'Grzegorz', 'Michalak', '001', 'Polska', 'Warszawa', 10),
('AC1', 'Anna', 'Chochla', '006', 'Polska', 'Poznan', 20),
('DB1', 'Dominika', 'Bulczynska', '006', 'Polska', 'Poznan', 20),
('PT1', 'Patryk', 'Tepper', '001', 'Polska', 'Wroclaw', 40),
('AJ1', 'Aleksander', 'Jaki', '001', 'Polska', 'Wroclaw', 20),
('KN1', 'Katarzyna', 'Narciarz', '010', 'Polska', 'Warszawa', 20),
('AK1', 'Adriana', 'Król', '010', 'Polska', 'Gdansk', 50),
('JK1', 'Jagoda', 'Kaczka', '001', 'Polska', 'Gdansk', 40),
('EG1', 'Ewa', 'Ges', '006', 'Polska', 'Poznan', 45),
('MR1', 'Marek', 'Ryba', '012', 'Polska', 'Warszawa', 60),
('AR1', 'Anna', 'Ryba', '001', 'Polska', 'Warszawa', 50),
('DB2', 'Dominik', 'Bak', '012', 'Polska', 'Poznan', 20),
('KC1', 'Karina', 'Caber', '010', 'Polska', 'Poznan', 25),
('IP1', 'Iga', 'Polka', '012', 'Polska', 'Gdansk', 55),
('AG1', 'Ada', 'Gruszka', '012', 'Polska', 'Wroclaw', 15),
('DK1', 'Daniel', 'Kos', '001', 'Polska', 'Wroclaw', 10),
('MS1', 'Marcel', 'Szpak', '006', 'Polska', 'Poznan', 10),
('JK2', 'Jaroslaw', 'Kretowski', '015', 'Polska', 'Gdynia', 70),
('KS1', 'Klaudia', 'Szyna', '015', 'Polska', 'Krakow', 80),
('MS2', 'Maciej', 'Szymbark', '015', 'Polska', 'Krakow', 30),
('MC1', 'Marian', 'Cien', '001', 'Polska', 'Gdynia', 55),
('TK1', 'Tadeusz', 'Kowalski', '017', 'Polska', 'Warszawa', 35),
('MK1', 'Monika', 'Kowalska', '006', 'Polska', 'Warszawa', 35),
('AK2', 'Ala', 'Koc', '017', 'Polska', 'Poznan', 45),
('KK1', 'Klaudia', 'Koc', '006', 'Polska', 'Poznan', 75),
('BK1', 'Braian', 'Kowalski', '015', 'Polska', 'Poznan', 30),
('AB1', 'Alina', 'Bulka', '001', 'Polska', 'Krakow', 30),
('GM1', 'Grzegorz', 'Michalak', '021', 'Polska', 'Warszawa', 10),
('AC1', 'Anna', 'Chochla', '021', 'Polska', 'Poznan', 20),
('DB1', 'Dominika', 'Bulczynska', '022', 'Polska', 'Poznan', 20),
('PT1', 'Patryk', 'Tepper', '022', 'Polska', 'Wroclaw', 40),
('AJ1', 'Aleksander', 'Jaki', '022', 'Polska', 'Wroclaw', 20),
('KN1', 'Katarzyna', 'Narciarz', '021', 'Polska', 'Warszawa', 20),
('AK1', 'Adriana', 'Król', '024', 'Polska', 'Gdansk', 50),
('JK1', 'Jagoda', 'Kaczka', '024', 'Polska', 'Gdansk', 40),
('EG1', 'Ewa', 'Ges', '025', 'Polska', 'Poznan', 45),
('MR1', 'Marek', 'Ryba', '025', 'Polska', 'Warszawa', 60),
('AR1', 'Anna', 'Ryba', '021', 'Polska', 'Warszawa', 50),
('DB2', 'Dominik', 'Bak', '025', 'Polska', 'Poznan', 20),
('KC1', 'Karina', 'Caber', '024', 'Polska', 'Poznan', 25),
('IP1', 'Iga', 'Polka', '021', 'Polska', 'Gdansk', 55),
('AG1', 'Ada', 'Gruszka', '025', 'Polska', 'Wroclaw', 15),
('DK1', 'Daniel', 'Kos', '026', 'Polska', 'Wroclaw', 10),
('MS1', 'Marcel', 'Szpak', '026', 'Polska', 'Poznan', 10),
('JK2', 'Jaroslaw', 'Kretowski', '025', 'Polska', 'Gdynia', 70),
('KS1', 'Klaudia', 'Szyna', '025', 'Polska', 'Krakow', 80),
('MS2', 'Maciej', 'Szymbark', '026', 'Polska', 'Krakow', 30),
('MC1', 'Marian', 'Cien', '026', 'Polska', 'Gdynia', 55),
('TK1', 'Tadeusz', 'Kowalski', '026', 'Polska', 'Warszawa', 35),
('MK1', 'Monika', 'Kowalska', '028', 'Polska', 'Warszawa', 35),
('AK2', 'Ala', 'Koc', '028', 'Polska', 'Poznan', 45),
('KK1', 'Klaudia', 'Koc', '028', 'Polska', 'Poznan', 75),
('BK1', 'Braian', 'Kowalski', '028', 'Polska', 'Poznan', 30),
('AB1', 'Alina', 'Bulka', '028', 'Polska', 'Krakow', 30),
('GM1', 'Grzegorz', 'Michalak', '034', 'Polska', 'Warszawa', 10),
('AC1', 'Anna', 'Chochla', '034', 'Polska', 'Poznan', 20),
('DB1', 'Dominika', 'Bulczynska', '035', 'Polska', 'Poznan', 20),
('PT1', 'Patryk', 'Tepper', '035', 'Polska', 'Wroclaw', 40),
('AJ1', 'Aleksander', 'Jaki', '035', 'Polska', 'Wroclaw', 20),
('KN1', 'Katarzyna', 'Narciarz', '036', 'Polska', 'Warszawa', 20),
('AK1', 'Adriana', 'Król', '034', 'Polska', 'Gdansk', 50),
('JK1', 'Jagoda', 'Kaczka', '034', 'Polska', 'Gdansk', 40),
('EG1', 'Ewa', 'Ges', '034', 'Polska', 'Poznan', 45),
('MR1', 'Marek', 'Ryba', '036', 'Polska', 'Warszawa', 60),
('AR1', 'Anna', 'Ryba', '036', 'Polska', 'Warszawa', 50),
('DB2', 'Dominik', 'Bak', '038', 'Polska', 'Poznan', 20),
('KC1', 'Karina', 'Caber', '038', 'Polska', 'Poznan', 25),
('IP1', 'Iga', 'Polka', '036', 'Polska', 'Gdansk', 55),
('AG1', 'Ada', 'Gruszka', '038', 'Polska', 'Wroclaw', 15),
('DK1', 'Daniel', 'Kos', '038', 'Polska', 'Wroclaw', 10),
('MS1', 'Marcel', 'Szpak', '038', 'Polska', 'Poznan', 10),
('JK2', 'Jaroslaw', 'Kretowski', '038', 'Polska', 'Gdynia', 70),
('KS1', 'Klaudia', 'Szyna', '038', 'Polska', 'Krakow', 80),
('MS2', 'Maciej', 'Szymbark', '038', 'Polska', 'Krakow', 30),
('MC1', 'Marian', 'Cien', '038', 'Polska', 'Gdynia', 55),
('TK1', 'Tadeusz', 'Kowalski', '038', 'Polska', 'Warszawa', 35),
('MK1', 'Monika', 'Kowalska', '041', 'Polska', 'Warszawa', 35),
('AK2', 'Ala', 'Koc', '041', 'Polska', 'Poznan', 45),
('KK1', 'Klaudia', 'Koc', '041', 'Polska', 'Poznan', 75),
('BK1', 'Braian', 'Kowalski', '041', 'Polska', 'Poznan', 30),
('AB1', 'Alina', 'Bulka', '041', 'Polska', 'Krakow', 30),
('GM1', 'Grzegorz', 'Michalak', '042', 'Polska', 'Warszawa', 10),
('AC1', 'Anna', 'Chochla', '042', 'Polska', 'Poznan', 20),
('DB1', 'Dominika', 'Bulczynska', '042', 'Polska', 'Poznan', 20),
('PT1', 'Patryk', 'Tepper', '042', 'Polska', 'Wroclaw', 40);

-- SELECT * FROM Uczestnicy;

-- -- ---------------------------------
-- Usuwanie i tworzenie widoków
-- ---------------------------------

-- Ilość warsztatów które przeprowadził dany mentor w danym mieście

DROP VIEW IF EXISTS Najczestsze_miasto;

CREATE VIEW Najczestsze_miasto AS
SELECT  Warsztaty.Miejscowosc AS Miejscowosc,
        Mentorzy.Imie AS Imie,
        Mentorzy.Nazwisko AS Nazwisko,
        COUNT(Warsztaty.Miejscowosc) AS Ilosc_warsztatow
FROM Mentorzy JOIN Warsztaty ON Warsztaty.MentorID = Mentorzy.ID
GROUP BY Miejscowosc, Nazwisko
ORDER BY Ilosc_warsztatow DESC;

-- Kwota jaką każdy sponsor przeznaczył w sumie na sponsorowane warsztaty
DROP VIEW IF EXISTS Sponsorowana_kwota;

CREATE VIEW Sponsorowana_kwota AS
SELECT  Sponsorzy.Firma AS Sponsor,
        COUNT(Warsztaty.ID) AS Ilosc_warsztatow,
        COUNT(Warsztaty.ID) * Sponsorzy.Sponsorowana_kwota AS Kwota
FROM Sponsorzy JOIN Warsztaty ON Warsztaty.SponsorID = Sponsorzy.ID
GROUP BY Sponsor;

-- Dziesięć warsztatów których uczestnicy wpłacili najwięcej za wstęp
DROP VIEW IF EXISTS Oplaty_za_wstep;

CREATE VIEW Oplaty_za_wstep AS
SELECT  Warsztaty.ID AS Warsztat,
        Warsztaty.Tytul AS Tytul,
        Warsztaty.Data AS Data,
        Warsztaty.Miejscowosc AS Miejscowosc,
        SUM(Uczestnicy.Oplata) AS Suma_oplat,
        COUNT(Uczestnicy.ID) AS Ilosc_uczest
FROM Uczestnicy JOIN Warsztaty ON Uczestnicy.WarsztatID = Warsztaty.ID
GROUP BY Warsztat
ORDER BY Suma_oplat DESC
LIMIT 10;

-- ---------------------------------
-- Tworzenie procedur
-- ---------------------------------


-- Ilość warsztatów jaka odbyła sie w danym mieście sponsorowanych przez daną firmę

DROP PROCEDURE IF EXISTS Sponsorzy_wedlug_miast;

//
CREATE PROCEDURE Sponsorzy_wedlug_miast (IN nazwa_firmy VARCHAR(30), IN miasto VARCHAR(30))
BEGIN
  SELECT Warsztaty.Miejscowosc AS Miejscowosc,
  Sponsorzy.Firma AS Firma,
  COUNT(Warsztaty.ID) AS Ilosc_warsztatow
  FROM Sponsorzy JOIN Warsztaty ON Warsztaty.SponsorID = Sponsorzy.ID
  WHERE Firma = nazwa_firmy AND Miejscowosc = miasto
  GROUP BY Firma
  ORDER BY Ilosc_warsztatow DESC;
END//



-- Suma otrzymanego przez mentora wynagrodzenia za przeprowadzone warsztaty

DROP PROCEDURE IF EXISTS Wynagrodzenie_mentora;

//
CREATE PROCEDURE Wynagrodzenie_mentora (IN mentorID VARCHAR(30))
BEGIN
  SELECT  Mentorzy.Imie AS Imie,
          Mentorzy.Nazwisko AS Nazwisko,
          COUNT(Warsztaty.ID) * Mentorzy.Wynagrodzenie AS Wynagrodzenie
  FROM Mentorzy JOIN Warsztaty ON Warsztaty.MentorID = Mentorzy.ID
  WHERE Mentorzy.ID = mentorID
  GROUP BY Nazwisko;
END//


-- ---------------------------------------------
-- Utworzenie raportów (wywołanie widoków)
-- ---------------------------------------------

SELECT * FROM Najczestsze_miasto;

SELECT * FROM Sponsorowana_kwota;

SELECT * FROM Oplaty_za_wstep;

CALL Sponsorzy_wedlug_miast('Samsung', 'Warszawa');

CALL Wynagrodzenie_mentora('MM1');

-- ---------------------------------------------
-- Usunięcie bazy
-- ---------------------------------------------

DROP DATABASE Firma;
