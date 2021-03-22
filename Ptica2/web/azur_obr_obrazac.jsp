<%-- 
    Dokument  : azur_obr_obrazac
    Formiran  : 13-Mar-2019, 11:36:48
    Autor     : Ingrid Farkaš
    Projekat  : Ptica    
--%>

<!-- azur_obr_obrazac.jsp - dodaje formular veb stranici Ažuriranje knjige -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="konekcija.ConnectionManager" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <script src="javascript/validacija.js"></script>
        
        <style>            
            input:disabled, textarea:disabled, select:disabled {
                background-color: white !important;
            }
        </style>
        
        <script>
            
            BR_POLJA = 11; // maksimum broj polja na ovom i prethodnim formularima             
            POC = 3; 
           
            // napraviKolacic: kreira kolaċić inputI = vrednost u input polju ; (I - broj 3..11)
            function napraviKolacic() {
                var i;
                var inp_imena = new Array('naslov', 'autor', 'isbn', 'cena', 'strane', 'zanr', 'opis', 'izdavac', 'gd_izdav'); // names of the input fields
                // kolaċići sa imenima input0, input1, input2 sam kreirala u azur_obr_knj.jsp
                for (i = POC; i <= BR_POLJA; i++) {
                    if (i === 6) { // kreiranje kolaċića koji sadrži cenu
                        strTacka = document.getElementById(inp_imena[i-3]).value; 
                        strTacka = strTacka.replace('.', '!');
                        strTacka = strTacka.replace(',', '.');
                        document.cookie = "input" + i + "=" + encodeURIComponent(strTacka) + ";"; // kreiranje kolaċića
                    } else {
                        document.cookie = "input" + i + "=" + encodeURIComponent(document.getElementById(inp_imena[i-3]).value) + ";"; // kreiranje kolaċića
                    }    
                } 
            }
            
            // postaviVr: postavlja vrednosti kolaċića (sa imenima input0, input1, input2) na inicijalnu vrednost i
            // zapisuje sadržaj svakog input polja u kolaċić
            function postaviVr() {              
                var i;
                
                for (i = POC; i <= BR_POLJA; i++) {
                    document.cookie = "input" + i + "= "; // postavljanje VREDNOSTI kolaċića na PRAZNO
                }
                napraviKolacic(); // za svako input polje zapisuje vrednost sadržaja tog polja u kolaċić
            }
            
        </script>
        
        <%
            HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);    
            String izvor = (String)hSesija2.getAttribute("ime_izvora"); // stranica na kojoj sam sada
        %>
        
        <title>Ptica - <%= izvor %> </title>
    </head>
    
    <body onload="postaviVr()">
        <%
            final String IME_STRANICE = "azur_obr_str.jsp"; // stranica na kojoj sam sada
        %>
        <%                                  
            String input3 = ""; // vrednost koja je prethodno bila u input polju naslov da bi ponovo bila prikazana
            String input4 = "";
            String input5 = "";
            String input6 = "";
            String input7 = "";
            String input8 = "";
            String input9 = "";
            String input10 = "";
            String input11 = "";
            
            String naslov = ""; // za prikazivanje sloga koji se ažurira
            String ime_aut = "";
            String isbn = "";
            String cena = "";
            String strane = "";
            String opis = "";
            String ime_izd = ""; 
            String god_izdavanja = "";
            String zanr = "";
            
            // IDEJA: popunj je postavljena u NewsletterServl.java - true ako su neke od varijabli sesije (u input polju) 
            // bile postavljene i one treba da se dodaju ovde obrazcu - ovo je taċno ako je korisnik PRE PRIKAZAO OVU STRANICU
            // i posle toga je uneo email u prijavi za Newsletter (u footer-u) i na sledećoj stranici je kliknuo na Zatvori
            if (PticaMetodi.varSesijePostoji(hSesija2, "popunjeno")) { 
                String popunj = String.valueOf(hSesija2.getAttribute("popunjeno")); 
                
                // postavljanje vrednosti varijable sesije ime_stranice. Ako je korisnik kliknuo na dugme Prijavite se i posle toga ako je na veb
                // stranici newsletter_info.jsp kliknuo na Zatvori dugme, onda se ova veb stranica ponovo prikazuje
                if (PticaMetodi.varSesijePostoji(hSesija2, "ime_stranice")) { 
                    String ime_stranice = String.valueOf(hSesija2.getAttribute("ime_stranice"));
                    
                    // Ako je korisnik kliknuo na Zatvori dugme na veb stranici newsletter_info.jsp i ako je ova stranica bila prikazana 
                    // pre (ime_stranice) i ako su neke vrednosti saċuvane u varijablama sesije input tada proċitaj varijablu sesije
                    // input3..input11 da bi se prikazala u input polju naslov (i drugim poljima)
                    if ((ime_stranice.equalsIgnoreCase(IME_STRANICE)) && (popunj.equalsIgnoreCase("true"))) {
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input3")) {
                            input3 = String.valueOf(hSesija2.getAttribute("input3")); // vrednost koja je bila u ovom polju
                            input3 = URLDecoder.decode(new String(input3.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                        } 
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input4")) {
                            input4 = String.valueOf(hSesija2.getAttribute("input4"));
                            input4 = URLDecoder.decode(new String(input4.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                        } 
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input5")) {
                            input5 = String.valueOf(hSesija2.getAttribute("input5"));
                        }
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input6")) {
                            input6 = String.valueOf(hSesija2.getAttribute("input6")); // vrednost koja je bila u ovom polju
                        } 
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input7")) {
                            input7 = String.valueOf(hSesija2.getAttribute("input7"));
                        } 
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input8")) {
                            input8 = String.valueOf(hSesija2.getAttribute("input8"));
                        } 
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input9")) {
                            input9 = String.valueOf(hSesija2.getAttribute("input9")); // vrednost koja je bila u ovom polju
                            input9 = URLDecoder.decode(new String(input9.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                        } 
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input10")) {
                            input10 = String.valueOf(hSesija2.getAttribute("input10"));
                            input10 = URLDecoder.decode(new String(input10.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                        } 
                        if (PticaMetodi.varSesijePostoji(hSesija2, "input11")) {
                            input11 = String.valueOf(hSesija2.getAttribute("input11"));
                        } 
                        PticaMetodi.postaviNaPrazno(hSesija2); // postaviNaPrazno: postavlja vrednosti varijabli sesije na "" za varijable input0, input1, ...
                    }
                }
                hSesija2.setAttribute("popunjeno", "false"); // input polja ne treba da budu popunjena
            }
            PticaMetodi.postaviNaPrazno(hSesija2); // postaviNaPrazno: postavlja vrednosti varijabla sesije na "" za varijable input0, input1, ...
            hSesija2.setAttribute("ime_stranice", IME_STRANICE);
        %>
        
        <%
            hSesija2.setAttribute("ime_vebstr", "azur_obr_str.jsp");
            // ako je korisnik sada završio prijavu za Newsletter, obrazac na sledećoj veb stranici ne treba da prikaže prethdne vrednosti
            hSesija2.setAttribute("newsletter", "false");
            
            Connection con = ConnectionManager.getConnection(); // povezivanje sa bazom 
            Statement stmt = con.createStatement();
            
            String sUpit = "select k.naslov, k.cena, k.isbn, k.br_strana, k.god_izdavanja, k.opis, k.žanr, a.ime_autora, i.ime_izdavača from knjiga k, autor a, izdavač i where k.br_autora = a.br_autora and k.br_izdavača = i.br_izdavača";
            // prethod_nasl: da li naslov knjige već postiji u bazi
            String prethod_nasl = (String)hSesija2.getAttribute("preth_naslov"); // čitanje naslova iz varijable sesije (azur_obr_knj.jsp)
            // prethod_aut: da li autor knjige već postiji u bazi
            String prethod_aut = (String)hSesija2.getAttribute("preth_autor"); // čitanje autora (iz varijable sesije)
            // prethod_isbn: da li isbn knjige već postiji u bazi
            String prethod_isbn = (String)hSesija2.getAttribute("preth_isbn"); // čitanje Isbn (iz varijable sesije)
            
            if (!((prethod_nasl.equalsIgnoreCase("")))) {
                sUpit += " and LOWER(k.naslov)='" + prethod_nasl.toLowerCase() + "'";
            }
            
            if (!((prethod_aut.equalsIgnoreCase("")))) {
                sUpit += " and LOWER(a.ime_autora)='" + prethod_aut.toLowerCase() + "'";
            }
            
            if (!((prethod_isbn.equalsIgnoreCase("")))) {
                sUpit += " and k.isbn='" + prethod_isbn + "'";
            }
            
            sUpit += ";";
            
            // izvršavanje upita
            ResultSet rset = stmt.executeQuery(sUpit); 

             // ako sledeći slog postoji
            if (rset.next()) {
                naslov = rset.getString("naslov"); // pročitaj naslov iz rset-a
                if (naslov == null) {
                    naslov = "";
                }
                
                ime_aut = rset.getString("ime_autora"); // pročitaj ime_autora iz rset-a
                if (ime_aut == null) {
                    ime_aut = "";
                }
                
                isbn = rset.getString("isbn"); // pročitaj isbn iz rset-a
                if (isbn == null) {
                    isbn = "";
                }
                
                cena = rset.getString("cena"); // pročitaj cenu iz rset-a
                if (cena == null) {
                    cena = "";
                } else {
                    // u bazi cena je prikazana u obliku 99999.99; u formularu cena treba da bude prikazana u obliku 99.999,99
                    cena = cena.replace('.', ','); // zameni . sa ,
                    cena = PticaMetodi.dodajTacku(cena); // dodajem tačku u cenu iza hiljadu dinara 
                }
                
                strane = rset.getString("br_strana"); // pročitaj broj strana iz rset-a
                if (strane == null) {
                    strane = "";
                }
                
                zanr = rset.getString("žanr"); // pročitaj žanr iz rset-a
                if (zanr == null) {
                    zanr = "";
                }
                
                opis = rset.getString("opis"); // pročitaj opis iz rset-a
                if (opis == null) {
                    opis = "";
                }
                
                ime_izd = rset.getString("ime_izdavača"); // pročitaj ime izdavača iz rset-a
                if (ime_izd == null) {
                    ime_izd = "";
                }
                
                god_izdavanja = rset.getString("god_izdavanja"); // pročitaj godinu izdavanja iz rset-a
                if (god_izdavanja == null) {
                    god_izdavanja = "";
                }
            }
        %>   
            
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belu boju -->
        <div class="belapoz">
            <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                <!-- Bootstrap kolona zauzima 6 kolona na velikim desktopovima i 6 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div>
                        <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                    <br /><br />
                    <div> 
                        <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                </div>
                
                <!-- Bootstrap kolona zauzima 5 kolona na velikim desktopovima i 5 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- dodavanje kontejnera u Bootstrap grid -->
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                               
                                <!-- Update -->
                                <% if (izvor.equals("Ažuriranje knjige")) {
                                %>
                                    <h3 class="text-info">Ažuriranje knjige</h3>
                                <%
                                   } else if (izvor.equals("Brisanje knjige")) {
                                %>
                                    <!-- Brisanje knjige -->
                                    <h3 class="text-info">Brisanje knjige</h3>
                                <%
                                   }
                                %>
                                
                                <br />
                             
                                <% if (izvor.equals("Ažuriranje knjige")) {
                                %>
                                    <!-- posle klika na dugme prikazuje se azurDB.jsp -->
                                    <form id="az_obr_knj" name="az_obr_knj" action="azurDB.jsp" onsubmit="return proveriF();" method="post">
                                <%
                                    } else if (izvor.equals("Brisanje knjige")) {
                                %>
                                     <!-- posle klika na dugme prikazuje se ObrServlet -->
                                     <form id="az_obr_knj" name="az_obr_knj" action="ObrServlet" onsubmit="return proveriF();" method="post">
                                <%
                                    }
                                %>
                                    <!-- input kontrola za naslov -->
                                    <div class="form-group"> 
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <label for="naslov">Naslov <span class="vel_teksta text-danger">*</span></label>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input3.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" name="naslov" id="naslov" onchange="napraviKolacic()" required value="<%= input3 %>"> 
                                                <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" name="naslov" id="naslov" onchange="napraviKolacic()" required value="<%= naslov %>"> 
                                            <% } 
                                            %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <label for="naslov">Naslov</label>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input3.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="naslov" id="naslov" onchange="napraviKolacic()" value="<%= input3 %>"> 
                                                <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="naslov" id="naslov" onchange="napraviKolacic()" value="<%= naslov %>"> 
                                            <% } 
                                            %>
                                        <%
                                           }
                                        %>
                                    </div>
                                    
                                    <!-- input kontrola za autora -->
                                    <div class="form-group">
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <label for="autor">Autor <span class="vel_teksta text-danger">*</span></label>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input4.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" name="autor" id="autor" onchange="napraviKolacic()" onfocusout="slova(document.az_obr_knj.autor, aut_poruka, 'celoime', false, 'false');" required value="<%= input4 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" name="autor" id="autor" onchange="napraviKolacic()" onfocusout="slova(document.az_obr_knj.autor, aut_poruka, 'celoime', false, 'false');" required value="<%= ime_aut %>"> 
                                            <% }
                                            %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <label for="autor">Autor</label>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input4.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="autor" id="autor" value="<%= input4 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="autor" id="autor" value="<%= ime_aut %>"> 
                                            <% }
                                            %>
                                        <% 
                                           } 
                                        %>
                                        <span id="aut_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                
                                    <!-- input kontrola za Isbn -->
                                    <div class="form-group">
                                        <label for="isbn">Isbn</label> 
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input5.equalsIgnoreCase("")) { %>
                                                <!-- isbn input kontrola : može se uneti do 13 karaktera -->
                                                <input type="text" class="form-control form-control-sm" name="isbn" id="isbn" onchange="napraviKolacic()" onfocusout='broj("az_obr_knj", "isbn", "je_isbn", "isbn_poruka", false, false)' value="<%= input5 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" name="isbn" id="isbn" onchange="napraviKolacic()" onfocusout='broj("az_obr_knj", "isbn", "je_isbn", "isbn_poruka", false, false)' value="<%= isbn %>"> 
                                            <% } %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input5.equalsIgnoreCase("")) { %>
                                                <!-- isbn input kontrola: može se uneti do 13 karaktera -->
                                                <input type="text" class="form-control form-control-sm" disabled name="isbn" id="isbn" value="<%= input5 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="isbn" id="isbn" value="<%= isbn %>"> 
                                            <% } %>
                                        <% 
                                           } 
                                        %>
                                        <span id="isbn_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <!-- input kontrola za cenu -->
                                    <div class="form-group">
                                        <label for="cena">Cena</label> 
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input6.equalsIgnoreCase("")) {
                                                input6 = input6.replace('.', ','); // u kolačiću se umesto , pojavljuje .
                                                input6 = input6.replace('!', '.');
                                            %>
                                                <input type="text" class="form-control form-control-sm" name="cena" id="cena" onchange="napraviKolacic()" onfocusout='daLiJeCena("az_obr_knj", "cena", "je_cena", "cena_poruka")' value="<%= input6 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" name="cena" id="cena" onchange="napraviKolacic()" onfocusout='daLiJeCena("az_obr_knj", "cena", "je_cena", "cena_poruka")' value="<%= cena %>"> 
                                            <% } %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input6.equalsIgnoreCase("")) { 
                                                input6 = input6.replace('.', ','); // u kolačiću se umesto , pojavljuje .
                                                input6 = input6.replace('!','.');
                                            %>
                                                <input type="text" class="form-control form-control-sm" disabled name="cena" id="cena" value="<%= input6 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="cena" id="cena" value="<%= cena %>"> 
                                            <% } %>
                                        <% 
                                           } 
                                        %>
                                        <span id="cena_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <!-- input kontrola za broj strana -->
                                    <div class="form-group">
                                        <label for="strane">Broj strana</label>
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input7.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" name="strane" id="strane" onchange="napraviKolacic()" onfocusout='broj("az_obr_knj", "strane", "je_brstr", "str_poruka", false, false)' value="<%= input7 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" name="strane" id="strane" onchange="napraviKolacic()" onfocusout='broj("az_obr_knj", "strane", "je_brstr", "str_poruka", false, false)' value="<%= strane %>"> 
                                            <% } %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input7.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="strane" id="strane" value="<%= input7 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="strane" id="strane" value="<%= strane %>"> 
                                            <% } %>
                                        <% 
                                           } 
                                        %>
                                        <span id="str_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <!-- padajuća lista za žanrove -->
                                    <div class="form-group"> 
                                        <label for="zanr">Žanrovi</label> 
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input8.equalsIgnoreCase("")) { %>
                                                <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                                <select  class="form-control form-control-sm" name="zanr" id="zanr" onchange="napraviKolacic()">
                                                    <% if (input8.equalsIgnoreCase("svi")) { %>
                                                        <option value="svi" selected>Svi žanrovi</option> <!-- opcije prikazana u padajućoj listi -->
                                                    <% } else { %>
                                                        <option value="svi">Svi žanrovi</option>
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("romani")) { %>
                                                        <option value="romani" selected>Romani</option> 
                                                    <% } else { %>
                                                        <option value="romani">Romani</option>   
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("biznis")) { %>
                                                        <option value="biznis" selected>Biznis i ekonomija</option> 
                                                    <% } else { %>
                                                        <option value="biznis">Biznis i ekonomija</option>      
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("komp")) { %>
                                                        <option value="komp" selected>Internet i računari</option> 
                                                    <% } else { %>
                                                        <option value="komp">Internet i računari</option>  
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("eduk")) { %>
                                                        <option value="eduk" selected>Edukativni</option> 
                                                    <% } else { %>
                                                        <option value="eduk">Edukativni</option>   
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("dečije")) { %>
                                                        <option value="dečije" selected>Knjige za decu</option> 
                                                    <% } else { %>
                                                        <option value="dečije">Knjige za decu</option>  
                                                    <% } %>
                                                </select>
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                                <select class="form-control form-control-sm" name="zanr" id="zanr" onchange="napraviKolacic()">
                                                    <% if (zanr.equalsIgnoreCase("svi")) { %>
                                                        <option value="svi" selected>Svi žanrovi</option> <!-- opcije prikazana u padajućoj listi -->
                                                    <% } else { %>
                                                        <option value="svi">Svi žanrovi</option>
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("romani")) { %>
                                                        <option value="romani" selected>Romani</option> 
                                                    <% } else { %>
                                                        <option value="romani">Romani</option>   
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("biznis")) { %>
                                                        <option value="biznis" selected>Biznis i ekonomija</option> 
                                                    <% } else { %>
                                                        <option value="biznis">Biznis i ekonomija</option>      
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("komp")) { %>
                                                        <option value="komp" selected>Internet i računari</option> 
                                                    <% } else { %>
                                                        <option value="komp" >Internet i računari</option>  
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("eduk")) { %>
                                                        <option value="eduk" selected>Edukativni</option> 
                                                    <% } else { %>
                                                        <option value="eduk">Edukativni</option>   
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("dečije")) { %>
                                                        <option value="dečije" selected>Knjige za decu</option> 
                                                    <% } else { %>
                                                        <option value="dečije">Knjige za decu</option>  
                                                    <% } %>
                                                </select>
                                            <% } %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input8.equalsIgnoreCase("")) { %>
                                                <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                                <select  class="form-control form-control-sm" disabled name="zanr" id="zanr">
                                                    <% if (input8.equalsIgnoreCase("svi")){ %>
                                                        <option value="svi" selected>Svi žanrovi</option> <!-- opcije prikazana u padajućoj listi -->
                                                    <% } else { %>
                                                        <option value="svi">Svi žanrovi</option>
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("romani")) { %>
                                                        <option value="romani" selected>Romani</option> 
                                                    <% } else { %>
                                                        <option value="romani">Romani</option>   
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("biznis")) { %>
                                                        <option value="biznis" selected>Biznis i ekonomija</option> 
                                                    <% } else { %>
                                                        <option value="biznis">Biznis i ekonomija</option>      
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("komp")) { %>
                                                        <option value="komp" selected>Internet i računari</option> 
                                                    <% } else { %>
                                                        <option value="komp">Internet i računari</option>  
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("eduk")) { %>
                                                        <option value="eduk" selected>Edukativni</option> 
                                                    <% } else { %>
                                                        <option value="eduk">Edukativni</option>   
                                                    <% } %>

                                                    <% if (input8.equalsIgnoreCase("dečije")) { %>
                                                        <option value="dečije" selected>Knjige za decu</option> 
                                                    <% } else { %>
                                                        <option value="dečije">Knjige za decu</option>  
                                                    <% } %>
                                                </select>
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                                <select class="form-control form-control-sm" disabled name="zanr" id="zanr">
                                                    <% if (zanr.equalsIgnoreCase("svi")) { %>
                                                        <option value="svi" selected>Svi žanrovi</option> <!-- opcije prikazana u padajućoj listi -->
                                                    <% } else { %>
                                                        <option value="svi">Svi žanrovi</option>
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("romani")) { %>
                                                        <option value="romani" selected>Romani</option> 
                                                    <% } else { %>
                                                        <option value="romani">Romani</option>   
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("biznis")) { %>
                                                        <option value="biznis" selected>Biznis i ekonomija</option> 
                                                    <% } else { %>
                                                        <option value="biznis">Biznis i ekonomija</option>      
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("komp")) { %>
                                                        <option value="komp" selected>Internet i računari</option> 
                                                    <% } else { %>
                                                        <option value="komp" >Internet i računari</option>  
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("eduk")) { %>
                                                        <option value="eduk" selected>Edukativni</option> 
                                                    <% } else { %>
                                                        <option value="eduk">Edukativni</option>   
                                                    <% } %>

                                                    <% if (zanr.equalsIgnoreCase("dečije")) { %>
                                                        <option value="dečije" selected>Knjige za decu</option> 
                                                    <% } else { %>
                                                        <option value="dečije">Knjige za decu</option>  
                                                    <% } %>
                                                </select>

                                            <% } %>
                                        <% 
                                           } 
                                        %>    
                                    </div>
                                        
                                    <!-- kreiranje oblasti za tekst za opis knjige -->
                                    <div class="form-group">
                                        <label for="opis">Opis</label>
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input9.equalsIgnoreCase("")) { %>
                                                <textarea class="form-control form-control-sm" name="opis" id="opis" rows="4" onchange="napraviKolacic()"><%= input9 %></textarea>
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <textarea class="form-control form-control-sm" name="opis" id="opis" rows="4" onchange="napraviKolacic()"><%= opis %></textarea>
                                            <% } %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input9.equalsIgnoreCase("")) { %>
                                                <textarea class="form-control form-control-sm" disabled name="opis" id="opis" rows="4"><%= input9 %></textarea>
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <textarea class="form-control form-control-sm" disabled name="opis" id="opis" rows="4"><%= opis %></textarea>
                                            <% } %>
                                        <% 
                                           } 
                                        %>
                                    </div>
                                        
                                    <!-- kreiranje input kontrole za izdavača -->
                                    <div class="form-group">
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <label for="izdavac">Izdavač <span class="vel_teksta text-danger">*</span></label> 
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input10.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" name="izdavac" id="izdavac" onchange="napraviKolacic()" required value="<%= input10 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" name="izdavac" id="izdavac" onchange="napraviKolacic()" required value="<%= ime_izd %>"> 
                                            <% } %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <label for="izdavac">Izdavač</label> 
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input10.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="izdavac" id="izdavac" value="<%= input10 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="izdavac" id="izdavac" value="<%= ime_izd %>"> 
                                            <% } %>
                                        
                                        <% 
                                           } 
                                        %>
                                    </div>
                                    
                                    <!-- kreiranje input kontrole za godinu izdavanja -->
                                    <div class="form-group">
                                        <label for="gd_izdav">Godina izdavanja</label>
                                        <% if (izvor.equals("Ažuriranje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input11.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" name="gd_izdav" id="gd_izdav" onchange="napraviKolacic()" onfocusout='broj("az_obr_knj", "gd_izdav", "je_godizd", "gizdav_poruka", false, false)' value="<%= input11 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" name="gd_izdav" id="gd_izdav" onchange="napraviKolacic()" onfocusout='broj("az_obr_knj", "gd_izdav", "je_godizd", "gizdav_poruka", false, false)' value="<%= god_izdavanja %>"> 
                                            <% } %>
                                        <%
                                           } else if (izvor.equals("Brisanje knjige")) {
                                        %>
                                            <!-- ako se korisnik prijavio za Newsletter prikaži vrednosti sa forme pre prijavljivanja -->
                                            <% if (!input11.equalsIgnoreCase("")) { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="gd_izdav" id="gd_izdav" value="<%= input11 %>"> 
                                            <!-- inače pročitaj slog iz baze i prikaži ga -->
                                            <% } else { %>
                                                <input type="text" class="form-control form-control-sm" disabled name="gd_izdav" id="gd_izdav" value="<%= god_izdavanja %>"> 
                                            <% } %>
                                        <% 
                                           } 
                                        %>
                                        <span id="gizdav_poruka" class="vel_teksta text-danger"></span>
                                    </div> 
                                        
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>
                                    
                                    <% if (izvor.equals("Ažuriranje knjige")) {
                                    %>
                                        <!-- btn-sm se koristi za manju (užu) veličinu kontrole -->
                                        <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Ažuriranje knjige</button>
                                    <%
                                        } else if (izvor.equals("Brisanje knjige")) {
                                    %>
                                        <!-- btn-sm se koristi za manju (užu) veličinu kontrole -->
                                        <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Brisanje knjige</button>
                                    <%
                                        }
                                    %>
                                  
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div> 
                                </form>  
                            </div> <!-- završetak class="col" -->
                        </div> <!-- završetak class="row" --> 
                    </div> <!-- završetak class="container" -->
                </div> <!-- završetak class="col-lg-5 col-md-5" -->
            </div> <!-- završetak class="row" -->
        </div> <!-- završetak class="belapoz" -->
            
        <!-- dodajem novi red u Bootstrap grid; klasa belapoz: za postavljanje pozadine u belu boju -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
        </div>   
    </body>
</html>