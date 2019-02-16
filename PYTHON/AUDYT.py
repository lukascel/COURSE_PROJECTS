import pymysql

class Audyt:

    def __init__(self):
        try:
            self.conn = pymysql.connect("localhost", "root", "sqlbd", "Audyt")
            self.logowanie()

        except:
            print ("Błędne hasło")

    def logowanie(self):

        login = input ("podaj login")
        haslo = input ("podaj haslo")

        self.cursor = self.conn.cursor()
        self.cursor.execute ("SELECT * from logowanie WHERE login =%s and passwd= %s", (login, haslo))
        resultsLogs = self.cursor.fetchall()

        if(len(resultsLogs) == 1):
            print ("zalogowano w systemie")
            self.menu()
        else:
            print ("niepoprawny lognin lub hasło")
            self.logowanie()

    def menu(self):
        while (True):
            dec = input("\nWybierz, co chcesz zrobić: \n A = Wyświetl listę audytorów wraz z terminami uprawnień audytowych ISO 9001, ISO 14001, OHSAS18001,\n AT = Wyświetl audytorów, których uprawnienia upływają przed wybranym dniem,\n AI = Wyświetl informację zbiorczą o audytach,\n N = Wyświetl wszystkie niezamknięte niezgodności,\n DA = Dodaj wyniki audytu,\n Q = Wyjście \n").upper()
            if (dec == 'A'): #wyswietlanie listy audytorów
                self.audytorzy()

            elif (dec == 'AT'): #audytorzy, którym upływa termin uprawnień
                self.audytorzyTermin()

            elif (dec == 'AI'):  # wyświetlanie wszystkich informacji o aydutach
                self.audyty()

            elif (dec == 'N'):#wyswietlanie niezgodności o statusie "w trakcie"
                self.niezgodnosci()

            elif (dec == 'DA'): #dodawanie wyników audytu
                self.dodajWynik()

            elif (dec == 'Q'):
                self.wyjscie()

    def audytorzy(self):
        self.cursor.execute("SELECT * FROM audytorzy")
        audytorzy = self.cursor.fetchall()

        for row in audytorzy:
            imie = 1
            nazwisko = 2
            uprISO9001 = 3
            uprISO14001 = 4
            uprOHSAS18001 = 5
            print("%-10s %-10s %15s %15s %15s" % (row[imie], row[nazwisko], row[uprISO9001], row[uprISO14001], row[uprOHSAS18001]))

    def audytorzyTermin(self):
        termin_upr = input("podaj termin, wobec którego chcesz sprawdzić ważność uprawnień/format: YYYY-MM-DD/: ")
        self.cursor.execute("SELECT * FROM audytorzy WHERE uprISO9001 <= %s OR uprISO14001 <= %s OR uprOHSAS18001 <= %s", (termin_upr, termin_upr, termin_upr))
        audytorzyTermin = self.cursor.fetchall()

        for row in audytorzyTermin:
            imie = 1
            nazwisko = 2
            uprISO9001 = 3
            uprISO14001 = 4
            uprOHSAS18001 = 5
            print("%-10s %-10s %15s %15s %15s" % (row[imie], row[nazwisko], row[uprISO9001], row[uprISO14001], row[uprOHSAS18001]))

    def audyty(self):
        self.cursor.execute("SELECT * FROM audyty")
        audyty = self.cursor.fetchall()

        for row in audyty:
            nazwa_procesu = 1
            nr_audytu = 2
            data_audytu = 3
            audytowane_pkt_ISO9001 = 4
            audytowane_pkt_ISO14001 = 5
            audytowane_pkt_OHSAS18001 = 6
            niezgodnosc_nr = 7
            niezgodnosc_tresc = 8
            stan_niezgodnosci = 9
            termin_zamkniecia = 10
            odpowiedzialny = 11
            audytor = 12
            audytowany = 13
            print("%-35s %-10s %-10s %-15s %-15s %-15s %-10s %-90s %-10s %-10s %-30s %-30s %-50s" % (row[nazwa_procesu], row[nr_audytu], row[data_audytu], row[audytowane_pkt_ISO9001], row[audytowane_pkt_ISO14001], row[audytowane_pkt_OHSAS18001], row[niezgodnosc_nr], row[niezgodnosc_tresc], row[stan_niezgodnosci], row[termin_zamkniecia], row[odpowiedzialny], row[audytor], row[audytowany]))


    def niezgodnosci(self):
        self.cursor.execute("SELECT id_procesu, nazwa_p, niezg_tresc, stan, termin_zamkniecia, odpowiedzialny FROM audyty WHERE stan = 'W TRAKCIE' OR stan = 'OTWARTA'")
        niezgodnosci = self.cursor.fetchall()

        for row in niezgodnosci:
            id_procesu = 0
            nazwa_procesu = 1
            niezgodnosc_tresc = 2
            stan = 3
            termin_zamkniecia = 4
            odpowiedzialny = 5
            print("%-10s %-35s %-90s %-10s %-10s %-30s" % (row[id_procesu], row[nazwa_procesu], row[niezgodnosc_tresc], row[stan], row[termin_zamkniecia], row[odpowiedzialny]))

    def dodajWynik(self):
        nazwa_procesu = input ("podaj nazwę procesu: ")
        nr_audytu = input("podaj numer audytu /format: C-01/2018/: ")
        data_audytu = input("Podaj datę audytu /format: YYYY-MM-DD/: ")
        punktyISO9001 = input ("podaj audytowane punkty  ISO 9001 /np.: 4.2. 6.3 itd./: ")
        punktyISO14001 = input ("podaj audytowane punkty  ISO 14001 /np.: 4.2. 6.3 itd./: ")
        punktyOHSAS = input ("podaj audytowane punkty  OHSAS 18001 /np.: 4.2. 6.3 itd./: ")
        numer_niezgodnosci = input("podaj numer niezgodności /format: 201801-01/: ")
        tresc_niezgodnosci = input("podaj treść niezgodności: ")
        stan_niezgodnosci = input("Podaj stan niezgodności / OTWARTA/ W TRAKCIE/ ZAMKNIĘTA/: ")
        termin_zamkniecia = input("podaj termin zamknięcia /format: YYYY-MM-DD/: ")
        odpowiedzialny = input("podaj imię i nazwisko pracownika odpowiedzialnego za usunięcie niezgodności: ")
        audytor = input("podaj imię i nazwisko audytora: ")
        audytowany = input("podaj imię i nazwisko audytowanego: ")

        self.cursor.execute("INSERT INTO audyty (nazwa_p,nr_audytu,data_audytu,audytowane_pkt_ISO_9001,audytowane_pkt_ISO_14001,audytowane_pkt_OHSAS,niezgodnosc_nr,niezg_tresc,stan,termin_zamkniecia,odpowiedzialny,audytor,audytowany) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (nazwa_procesu, nr_audytu, data_audytu, punktyISO9001, punktyISO14001, punktyOHSAS, numer_niezgodnosci, tresc_niezgodnosci, stan_niezgodnosci, termin_zamkniecia, odpowiedzialny, audytor, audytowany))
        self.conn.commit()
        print("Dodałeś rekord do bazy danych. Dziękuję!")

    def wyjscie(self):
        print("wyszedłeś z programu! Zapraszamy ponownie")
        exit()

Audyt = Audyt()