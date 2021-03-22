<%-- 
    Dokument   : dodaj_obrazac.jsp
    Formiran   : 08-Nov-2018, 13:02:11
    Autor      : Ingrid Farkaš
    Projekt    : Ptica
--%>

<!-- dodaj_obrazac.jsp - dodaje obrazac na stranicu Nova knjiga -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ptica - Nova knjiga</title>
        
        <script src="javascript/validacija.js"></script>
        
        <script>
            BR_POLJA = 9; // broj polja na obrazacu  
            INPUT_POLJA = 11;
            
            // napraviKolacic: kreira kolaċić inputI = vrednost u input polju ; (I - broj 0..9)
            function napraviKolacic() {           
                var i;
                // niz sadrži imena input polja
                var inp_imena = new Array('naslov', 'autor', 'isbn', 'cena', 'strane', 'zanr', 'opis', 'izdavac', 'gd_izdav'); 
                
                for (i = 0; i < BR_POLJA; i++) {
                    if (i === 3) { // kreiranje kolaċića koji sadrži cenu
                        strTacka = document.getElementById(inp_imena[i]).value; 
                        strTacka = strTacka.replace('.', '!');
                        strTacka = strTacka.replace(',', '.');
                        document.cookie = "input" + i + "=" + encodeURIComponent(strTacka) + ";"; // kreiranje kolaċića
                    } else {
                        document.cookie = "input" + i + "=" + encodeURIComponent(document.getElementById(inp_imena[i]).value) + ";"; // kreiranje kolaċića
                    }    
                } 
            }
            
            // postaviVr : postavlja vrednosti kolaċića (sa imenima input0, input1,.., input12) na inicijalnu vrednost i
            // piše sadržaj svakog input polja u kolaċić
            function postaviVr() { 
                var i;
                for (i = 0; i < INPUT_POLJA; i++) {
                    document.cookie = "input" + i + "= "; // postavljanje VREDNOSTI kolaċića na PRAZNO
                }
                napraviKolacic(); // za svako input polje zapisuje vrednost sadržaja tog polja u kolaċić
            } 
            
        </script>
    </head>
   
    <body onload="postaviVr()">
        <%
            final String IME_STRANICE = "dodaj_stranicu.jsp"; // stranica koja se sada prikazuje
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            hSesija.setAttribute("ime_vebstr", "dodaj_stranicu.jsp"); 
            // postavljanje vrednosti varijabli sesije na inicijalnu vrednost: ako je korisnik završio prijavu na Newsletter,
            // obrazac na sledećoj veb stranici ne treba da prikaže prethdne vrednosti
            hSesija.setAttribute("newsletter", "false");
        %>
        
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belo -->
        <div class="belapoz">
            <div class="row"> 
                <!-- Bootstrap kolona zauzima 6 kolona na velikim desktopovima i 6 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                    <br /><br />
                    <div> 
                        <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responzivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                </div>
               
                <!-- Bootstrap kolona zauzima 5 kolona na velikim desktopovima i 5 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> 
                        <div class="row"> 
                            <div class="col">
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Nova knjiga</h3>
                                <br/> 
                                <%  
                                    HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);
                                    
                                    String input0 = ""; // proċitaj vrednost koja je bila pre u input polju i ponovo je prikaži
                                    String input1 = ""; 
                                    String input2 = ""; 
                                    String input3 = "";
                                    String input4 = "";
                                    String input5 = "";
                                    String input6 = ""; // proċitaj vrednost koja je bila pre selektovana u listi i ponovo je prikaži
                                    String input7 = ""; // proċitaj vrednost koja je bila u polju za unos teksta i ponovo je prikaži
                                    String input8 = "";
                                                                        
                                    // IDEJA : popunjeno je postavljena u NewsletterServl.java - true ako su neke od varijabli sesije (input) bile postavljene,
                                    // i one treba da se dodaju ovde obrazcu - ovo je taċno ako je korisnik PRE PRIKAZAO OVU STRANICU i posle toga je uneo
                                    // email u prijavi za Newsletter (u footer-u) i na sledećoj stranici je kliknuo na Zatvori
                                    if (PticaMetodi.varSesijePostoji(hSesija2, "popunjeno")) { 
                                        String popunjeno = String.valueOf(hSesija2.getAttribute("popunjeno")); 
                                        // Postavljanje vrednosti varijable sesije ime_stranice. Ako je korisnik kliknuo dugme Prijavite se i posle toga ako je na veb
                                        // stranici newsletter_info.jsp kliknuo na Zatvori dugme, onda se ova veb stranica ponovo prikazuje
                                        if (PticaMetodi.varSesijePostoji(hSesija2, "ime_stranice")) { 
                                            String ime_stranice = String.valueOf(hSesija2.getAttribute("ime_stranice"));
                                            // Ako je korisnik kliknuo na Zatvori dugme na veb stranici newsletter_info.jsp i ako je 
                                            // ova stranica bila prikazana pre (ime_stranice) i ako su neke vrednosti saċuvane u varijablama 
                                            // sesije input tada proċitaj varijablu sesije input0 (da bi se prikazala u prvom polju) 
                                            if ((ime_stranice.equalsIgnoreCase(IME_STRANICE)) && (popunjeno.equalsIgnoreCase("true"))) {
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input0")) {
                                                    input0 = String.valueOf(hSesija2.getAttribute("input0")); // vrednost koja je bila u prvom polju
                                                    input0 = URLDecoder.decode(new String(input0.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input1")) {
                                                    input1 = String.valueOf(hSesija2.getAttribute("input1")); // vrednost koja je bila u drugom polju
                                                    input1 = URLDecoder.decode(new String(input1.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input2")) {
                                                    input2 = String.valueOf(hSesija2.getAttribute("input2")); // vrednost koja je bila u trećem polju
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input3")) {
                                                    input3 = String.valueOf(hSesija2.getAttribute("input3")); 
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input4")) {
                                                    input4 = String.valueOf(hSesija2.getAttribute("input4")); 
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input5")) {
                                                    input5 = String.valueOf(hSesija2.getAttribute("input5")); 
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input6")) {
                                                    input6 = String.valueOf(hSesija2.getAttribute("input6"));
                                                    input6 = URLDecoder.decode(new String(input6.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input7")) {
                                                    input7 = String.valueOf(hSesija2.getAttribute("input7"));
                                                    input7 = URLDecoder.decode(new String(input7.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input8")) {
                                                    input8 = String.valueOf(hSesija2.getAttribute("input8")); 
                                                } 
                                            } 
                                        }
                                        hSesija2.setAttribute("popunjeno", "false"); // input polja ne treba da budu ispunjena
                                    } 
                                    
                                    // saċuvaj ime stranice gde sam sada u sluċaju korisnik klikne na Prijavite se dugme u footer-u
                                    hSesija2.setAttribute("ime_stranice", IME_STRANICE);
                                    PticaMetodi.postaviNaPrazno(hSesija2); // postaviNaPrazno: postavlja vrednosti varijabli sesije na "" za varijable input0, input1, ...
                                %>
                                
                                <!-- posle klika na dugme DodajServlet se izvršava -->
                                <form id="dod_knjigu" name="dod_knjigu" action="DodajServlet" method="post" onsubmit="return proveriF();">
                                    <!-- input kontrola za naslov -->
                                    <div class="form-group">
                                        <label for="naslov">Naslov <span class="vel_teksta text-danger">*</span></label> 
                                        <!-- unošenje naslova je obavezno -->
                                        <input type="text" class="form-control form-control-sm" name="naslov" id="naslov" onchange="napraviKolacic()" required value="<%= input0 %>"> 
                                    </div>
                                        
                                    <!-- input kontrola za ime autora -->
                                    <div class="form-group">
                                        <label for="autor">Autor <span class="vel_teksta text-danger">*</span></label> 
                                        <!-- unošenje naslova je obavezno -->
                                        <input type="text" class="form-control form-control-sm" name="autor" id="autor" onchange="napraviKolacic()" onfocusout="slova(document.dod_knjigu.autor, aut_poruka, 'celoime', false, 'true');" required value="<%= input1 %>"> 
                                        <span id="aut_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                
                                    <!-- input kontrola za Isbn -->
                                    <div class="form-group">
                                        <label for="isbn">Isbn</label> 
                                        <input type="text" class="form-control form-control-sm" name="isbn" id="isbn" onchange="napraviKolacic()" onfocusout='broj("dod_knjigu", "isbn", "je_isbn", "isbn_poruka", false, false)' value="<%= input2 %>"> 
                                        <span id="isbn_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <!-- input kontrola za Isbn -->
                                    <div class="form-group">
                                        <% if (!input3.equalsIgnoreCase("")) {
                                            input3 = input3.replace('.', ','); // u kolaċiću umesto , se pojavljuje .
                                            input3 = input3.replace('!', '.');
                                           }
                                        %>
                                        <label for="cena">Cena</label> 
                                        <input type="text" class="form-control form-control-sm" name="cena" id="cena" onchange="napraviKolacic()" onfocusout='daLiJeCena("dod_knjigu", "cena", "je_cena", "cena_poruka")' value="<%= input3 %>"> 
                                        <span id="cena_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <!-- input kontrola za broj stranica -->
                                    <div class="form-group">
                                        <label for="strane">Broj strana</label> 
                                        <input type="text" class="form-control form-control-sm" name="strane" id="strane" onchange="napraviKolacic()" onfocusout='broj("dod_knjigu", "strane", "je_brstr", "str_poruka", false, false)' value="<%= input4 %>"> 
                                        <span id="str_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <!-- padajuća lista za žanrove -->
                                    <div class="form-group"> 
                                        <label for="zanr">Žanrovi</label> 
                                        <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                        <select class="form-control form-control-sm" name="zanr" id="zanr" onchange="napraviKolacic()">
                                            <% if (input5.equalsIgnoreCase("svi")) { %>
                                                   <option value="svi" selected>Svi žanrovi</option> <!-- opcija u padajućoj listi -->
                                            <% } else { %>
                                                   <option value="svi">Svi žanrovi</option>
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("romani")) { %>
                                                   <option value="romani" selected>Romani</option> 
                                            <% } else { %>
                                                   <option value="romani">Romani</option>   
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("biznis")) { %>
                                                   <option value="biznis" selected>Biznis i ekonomija</option> 
                                            <% } else { %>
                                                   <option value="biznis">Biznis i ekonomija</option>      
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("komp")) { %>
                                                   <option value="komp" selected>Internet i računari</option> 
                                            <% } else { %>
                                                   <option value="komp">Internet i računari</option>  
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("eduk")) { %>
                                                   <option value="eduk" selected>Edukativni</option> 
                                            <% } else { %>
                                                   <option value="eduk">Edukativni</option>   
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("dečije")) { %>
                                                   <option value="dečije" selected>Knjige za decu</option> 
                                            <% } else { %>
                                                   <option value="dečije">Knjige za decu</option>  
                                            <% } %>
                                            
                                        </select>
                                    </div>
                                        
                                    <!-- kreiranje oblasti za tekst za opis knjige -->
                                    <div class="form-group">
                                        <label for="opis">Opis</label>
                                        <textarea class="form-control form-control-sm" name="opis" id="opis" rows="7" onchange="napraviKolacic()"><%= input6 %></textarea>
                                    </div>
                                        
                                    <!-- input kontrola za izdavača -->
                                    <div class="form-group">
                                        <label for="izdavac">Izdavač <span class="vel_teksta text-danger">*</span></label> 
                                        <!-- ispunjavanje kontrole za izdavača je obavezno -->
                                        <input type="text" class="form-control form-control-sm" name="izdavac" id="izdavac" onchange="napraviKolacic()" required value="<%= input7 %>"> 
                                    </div>
                                        
                                    <!-- input kontrola za godinu izdavanja -->
                                    <div class="form-group">
                                        <label for="gd_izdav">Godina izdavanja</label> 
                                        <!-- ispunjavanje kontrole za godinu izadanja je obavezno -->
                                        <input type="text" class="form-control form-control-sm" name="gd_izdav" id="gd_izdav" onchange="napraviKolacic()" onfocusout='broj("dod_knjigu", "gd_izdav", "je_godizd", "gizdav_poruka", false, false)' value="<%= input8 %>"> 
                                        <span id="gizdav_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>
                                        
                                    <!-- btn-sm se koristi za manju (užu) veličinu kontrole -->
                                    <button type="submit" id="btnDodaj" class="btn btn-info btn-sm">Dodajte knjigu</button>
                                    <!-- dodavanje novog kontejnera -->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>
                                </form>  
                            </div> <!-- završetak class = "col" -->
                        </div> <!-- završetak class = "row" --> 
                    </div> <!-- završetak class = "container" -->
                </div> <!-- završetak class = "col-lg-5 col-md-5" -->
            </div> <!-- završetak class = "row" -->
        </div> <!-- završetak class = "belapoz" -->
            
        <!-- dodavanje novog reda u Bootstrap grid; klasa belapoz: postavljanje pozadine u belo -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>