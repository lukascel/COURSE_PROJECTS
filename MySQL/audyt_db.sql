CREATE DATABASE Audyt;

USE Audyt;

CREATE TABLE `logowanie` (
  `id`         int(11) NOT NULL AUTO_INCREMENT,
  `login`      varchar(30) NOT NULL,
  `passwd`     varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DESCRIBE logowanie;

INSERT INTO logowanie VALUES(id, 'admin', 'admin1');

select * from logowanie;

CREATE TABLE audytorzy (
	id_audytora		INT PRIMARY  KEY AUTO_INCREMENT,
    imie_a      	TEXT NOT NULL,
    nazwisko_a  	TEXT NOT NULL,
    uprISO9001		DATE,
    uprISO14001		DATE,
    uprOHSAS18001	DATE);
    
DESCRIBE audytorzy; 

INSERT INTO audytorzy(id_audytora, imie_a, nazwisko_a, uprISO9001, uprISO14001, uprOHSAS18001) VALUES ( 1, 'Dorota' , 'Kozłowska', '2020-12-12', '2020-12-12', '2020-12-12');   
INSERT INTO audytorzy(id_audytora, imie_a, nazwisko_a, uprISO9001, uprISO14001, uprOHSAS18001) VALUES ( 2, 'Aleksandra' , 'Kędzior', '2019-12-31', '2019-12-31', '2019-12-31');
INSERT INTO audytorzy(id_audytora, imie_a, nazwisko_a, uprISO9001, uprISO14001, uprOHSAS18001) VALUES ( 3, 'Markiewicz' , 'Anna', '2021-08-01', '2021-08-01', '2021-08-01');
INSERT INTO audytorzy(id_audytora, imie_a, nazwisko_a, uprISO9001, uprISO14001, uprOHSAS18001) VALUES ( 4, 'Łukasz' , 'Celej', '2020-12-12', '2020-12-12', '2020-12-12');
INSERT INTO audytorzy(id_audytora, imie_a, nazwisko_a, uprISO9001, uprISO14001, uprOHSAS18001) VALUES ( 5, 'Michał' , 'Jońca', '2021-01-01', '2021-01-01', '2021-01-01');
INSERT INTO audytorzy(id_audytora, imie_a, nazwisko_a, uprISO9001, uprISO14001, uprOHSAS18001) VALUES ( 6, 'Przemysław' , 'Stęperski', '2019-06-12', '2019-06-12', '2019-06-12');


CREATE TABLE pracownicy (
	id_pracownika	INT PRIMARY KEY AUTO_INCREMENT,
    imie_p			VARCHAR(15) NOT NULL,
    nazwisko_p		VARCHAR(20) NOT NULL,
    stanowisko_p	TEXT,
    jednostka_p		TEXT);
    
INSERT INTO pracownicy(id_pracownika, imie_p, nazwisko_p, stanowisko_p, jednostka_p) VALUES ( 1, 'Adam' , 'Kijewski', 'Specjalista ds. Majątku', 'Departament Majątku');     
INSERT INTO pracownicy(id_pracownika, imie_p, nazwisko_p, stanowisko_p, jednostka_p) VALUES ( 2, 'Anna' , 'Nowak', 'Starszy Specjalista ds. Majątku', 'Departament Majątku');     
INSERT INTO pracownicy(id_pracownika, imie_p, nazwisko_p, stanowisko_p, jednostka_p) VALUES ( 3, 'Krzysztof' , 'Krzysztoforski', 'Specjalista Informatyk', 'Departament IT');     
INSERT INTO pracownicy(id_pracownika, imie_p, nazwisko_p, stanowisko_p, jednostka_p) VALUES ( 4, 'Agnieszka' , 'Kowalska', 'Młodszy Specjalista ds. Zakupów', 'Departament Zakupów');     
INSERT INTO pracownicy(id_pracownika, imie_p, nazwisko_p, stanowisko_p, jednostka_p) VALUES ( 5, 'Katarzyna' , 'Michalska', 'Radca Prawny', 'Departament Prawny');
INSERT INTO pracownicy(id_pracownika, imie_p, nazwisko_p, stanowisko_p, jednostka_p) VALUES ( 6, 'Anna' , 'Kowalska', 'Specjalista Geolog', 'Oddział Geologii i Eksploatacji');        

DESCRIBE pracownicy;
select * from pracownicy;

CREATE TABLE procesy (
	id_procesu					INT PRIMARY KEY AUTO_INCREMENT,
	nazwa_p						TEXT NOT NULL
    );

DESCRIBE procesy;

INSERT INTO procesy(id_procesu, nazwa_p) VALUES ( 1, 'Zarządzanie Majątkiem');
INSERT INTO procesy(id_procesu, nazwa_p) VALUES ( 2, 'Zarządzanie Zakupami');
INSERT INTO procesy(id_procesu, nazwa_p) VALUES ( 3, 'Zarządzanie IT');
INSERT INTO procesy(id_procesu, nazwa_p) VALUES ( 4, 'Poszukiwanie Węglowodorów');
INSERT INTO procesy(id_procesu, nazwa_p) VALUES ( 5, 'Sprzedarz gazu ziemnego');
     
SELECT * FROM procesy;

CREATE TABLE audyty (
	id_procesu					INT,
    nazwa_p						TEXT,
    nr_audytu					TEXT,
    data_audytu					DATE,
    audytowane_pkt_ISO_9001		TEXT,
    audytowane_pkt_ISO_14001	TEXT,
    audytowane_pkt_OHSAS		TEXT,
    niezgodnosc_nr				TEXT,
    niezg_tresc					TEXT,
    stan						ENUM('OTWARTA', 'W TRAKCIE', 'ZAMKNIETA'),
    termin_zamkniecia			DATE,
    odpowiedzialny				TEXT,
    audytor						TEXT,
    audytowany					TEXT,
	FOREIGN KEY (id_procesu) REFERENCES procesy(id_procesu)
    );
  
DESCRIBE audyty;
truncate table audyty;

INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-01/2018', 'Zarządzanie Majątkiem', '2018-03-08', '4.2, 6.3, 8.5', '4.2, 7.1, 8.2', '4.1, 6.1, 6.3', '201801-01', "brak świadomości polityki jakości i celów jakości w jednostce organizacyjnej", 'ZAMKNIETA','2018-06-08', 'Adam Kijewski', 'Łukasz Celej', 'kierownik dz. Utrzymania Nieruchomości');     
INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-02/2018', 'Zarządzanie Zakupami','2018-05-12', '4.4, 5.3, 7.3', '4.3, 6.1, 7.2', '4, 6.3, 7.3', '201802-01', "brak zdefiniowanych wskazników i mierników dla procesu" , 'ZAMKNIETA','2018-07-01', 'Agnieszka Kowalska', 'Aleksandra Kędzior', 'kierownik dz. Zakupów Specjalnych');
INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-03/2018', 'Zarządzanie Majątkiem','2018-06-17', '4.3, 5.3, 7.5', '4.3, 7.1, 8.3', '4.2, 6.0, 6.8', '201803-01', "brak zapisów potywierdzajacych realizację planów środowiskowych jednostki", 'ZAMKNIETA','2018-09-25', 'Krzysztof Krzysztoforski', 'Michał Jońca', 'kierownik dz. Zarządzania Majatkiem IT');
INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-04/2018', 'Poszukiwanie Węglowodorów','2018-07-07', '4.4, 6.3, 8.3', '4.4, 7.1, 8.1', '4.3, 5.1, 7.3', '201804-01', "organizacja nie posiada jednolitego wzoru dokumentacji projektowej", 'ZAMKNIETA','2018-10-08', 'Anna Kowalska', 'Anna Markiewicz', 'kierownik dz. Projektowego');
INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-04/2018','Poszukiwanie Węglowodorów','2018-07-07', '4.4, 6.3, 8.3', '4.4, 7.1, 8.1', '4.3, 5.1, 7.3', '201804-02', "organizacja nie nadzoruje zmian prawnych w dziedzinie BHP", 'ZAMKNIETA','2018-10-17', 'Katarzyna Michalska', 'Dorota Kozłowska', 'kierownik dz. BHP');
INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-05/2018', 'Sprzedaż gazu ziemnego','2018-09-15', '4.1, 6.3, 7.2', '4.1, 7.0, 8.1', '4.3, 6.0, 6.0', '201805-01', "brak jednolitej ścieżki rejestrowania i rozpatrzania reklamacji", 'ZAMKNIETA','2018-10-29', 'Anna Kowalska', 'Łukasz Celej', 'kierownik dz. Komunikacji');
INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-05/2018','Sprzedaż gazu ziemnego','2018-09-15', '4.1, 6.3, 7.2', '4.1, 7.0, 8.1', '4.3, 6.0, 6.0', '201805-02', "stwierdzono skargi wobec których nie podjęto zadnych działań", 'OTWARTA','2018-12-31', 'Anna Kowalska', 'Łukasz Celej', 'kierownik dz. Komunikacji');


SELECT * FROM audytorzy;

SELECT * FROM audytorzy WHERE uprISO9001 <='2019-12-31' OR uprISO14001 <='2019-12-31' OR uprOHSAS18001 <='2019-12-31';

SELECT id_procesu, nazwa_p, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny FROM audyty WHERE stan = 'W TRAKCIE' OR stan = 'OTWARTA';

INSERT INTO audyty(nr_audytu, nazwa_p, data_audytu, audytowane_pkt_ISO_9001, audytowane_pkt_ISO_14001, audytowane_pkt_OHSAS, niezgodnosc_nr, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny, audytor, audytowany)
VALUES ('C-01/2018', 'Zarządzanie Majątkiem', '2018-03-08', '4.2, 6.3, 8.5', '4.2, 7.1, 8.2', '4.1, 6.1, 6.3', '201801-01', "brak świadomości polityki jakości i celów jakości w jednostce organizacyjnej", 'ZAMKNIETA','2018-06-08', 'Łukasz Celej', 'Łukasz Celej', 'kierownik dz. Utrzymania Nieruchomości');

DELETE FROM audyty WHERE odpowiedzialny = 'Łukasz Celej';

SELECT * FROM audyty;
