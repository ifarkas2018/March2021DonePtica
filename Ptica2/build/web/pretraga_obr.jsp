<%-- 
    Dokument  : pretraga_obr.jsp
    Formiran  : 18-Sep-2018, 01:33:11
    Autor     : Ingrid Farkaš
    Projekat  : Ptica
--%>

<!-- pretraga_obr.jsp - obrazac na veb stranici Pretraga knjiga -->

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ptica - Pretraga knjiga</title>
        
        <script src="javascript/validacija.js"></script>
        
        <script>
            BR_POLJA = 7; // broj input kontrola na obrazcu
            INPUT_POLJA = 12;  
        
            // napraviKolacic: kreira kolaċić inputI = vrednost u input polju ; (I - broj 0..6)
            function napraviKolacic() {           
                var i;
                var inp_names = new Array('naslov', 'autor', 'isbn', 'raspon_cena', 'sortirajpo', 'zanr', 'god_izdavanja'); // imena input kontrola
                
                for (i = 0; i < BR_POLJA; i++) {
                    if (i == 0 || i == 1) // tekst - treba da se enkodira (može da sadrži š,č,ć, ...)
                        document.cookie = "input" + i + "=" + encodeURIComponent(document.getElementById(inp_names[i]).value) + ";"; // kreiranje kolaċića
                    else // broj - ne treba da se enkodira
                        document.cookie = "input" + i + "=" + document.getElementById(inp_names[i]).value + ";"; // kreiranje kolaċića
                }
            }
            
            // postaviVr: postavlja vrednosti kolaċića (sa imenima input0, input1,.. input11) na inicijalnu vrednost i zapisuje 
            // sadržaj svakog input polja u kolaċić
            function postaviVr() {   
                var i;
                for (i = 0; i < INPUT_POLJA; i++) {
                    document.cookie = "input" + i + "= "; // postavljanje VREDNOSTI kolaċića na PRAZNO
                }
                napraviKolacic(); // za svako input polje zapisuje vrednost sadržaja tog polja u kolaċić
            } 
            
            // prilikom prikazivanja veb stranice prikaži modal (id: centriraniModal)
            $(window).on('load', function() {
                $('#centriraniModal').modal('show');
            });
        </script>    
    </head>
    
    <body onload="postaviVr()">
        
        <%
            final String IME_STRANICE = "pretraga_str.jsp"; // stranica koja je prikazana
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            hSesija.setAttribute("ime_vebstr", "pretraga_str.jsp");
            // ako je korisnik sada završio prijavu za Newsletter, obrazac na sledećoj veb stranici ne treba da prikaže prethdne vrednosti
            hSesija.setAttribute("newsletter", "false");
        %>
        
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belo -->
        <div class="belapoz">
            <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                <!-- Bootstrap kolona zauzima 6 kolona na velikim desktopovima i 6 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                    <br /><br />
                    <div> <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigam" title="slika sa knjigama"> 
                    </div>
                </div>
                      
                <!-- Bootstrap kolona zauzima 5 kolona na velikim desktopovima i 5 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- dodavanje kontejnera u Bootstrap grid -->
                        <div class="row">  <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col">  <!-- dodavanje nove kolone u Bootstrap grid -->
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Pretraga knjiga</h3>
                                <br/> 
                                Džoker znakovi  
                                <!-- neuređena lista sa dve stavke -->
                                <ul>
                                    <li>_ - zamenjuje jedan znak</li>
                                    <li>% - zamenjuje nijedan, jedan ili više znakova</li>
                                </ul>
                                
                                <%  
                                    HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);
                                    String input0 = ""; // sačuvaj vrednost koja je prethodno bila u input polju naslov da bi ponovo bila prikazana
                                    String input1 = ""; 
                                    String input2 = "";       
                                    String input3 = "";         
                                    String input4 = "";         
                                    String input5 = "";         
                                    String input6 = "";       
                                    
                                    // IDEJA : popunjeno je postavljena u NewsletterServl.java - true ako su neke od varijabli sesije (unos u input polju) 
                                    // bile postavljene i one treba da se dodaju ovde obrazcu - ovo je taċno ako je korisnik PRE PRIKAZAO OVU STRANICU
                                    // i posle toga je uneo email u prijavi za Newsletter (u footer-u) i na sledećoj stranici je kliknuo na Zatvori
                                    if (PticaMetodi.varSesijePostoji(hSesija2, "popunjeno")) { 
                                        String popunjeno = String.valueOf(hSesija2.getAttribute("popunjeno")); 
                                        
                                        // postavljanje vrednosti varijable sesije ime_stranice. Ako je korisnik kliknuo dugme Prijavite se i posle toga 
                                        // ako je na veb stranici newsletter_info.jsp kliknuo na Zatvori dugme, onda se ova veb stranica ponovo prikazuje
                                        if (PticaMetodi.varSesijePostoji(hSesija2, "ime_stranice")) { 
                                            String ime_stranice = String.valueOf(hSesija2.getAttribute("ime_stranice"));
       
                                            // Ako je korisnik kliknuo na Zatvori dugme na veb stranici newsletter_info.jsp i ako je ova  
                                            // stranica bila  pre prikazana (ime_stranice) i ako su neke vrednosti saċuvane u varijablama
                                            // sesije input tada proċitaj varijablu sesije input0 da bi se prikazala u prvoj input kontroli
                                            if ((ime_stranice.equalsIgnoreCase(IME_STRANICE)) && (popunjeno.equalsIgnoreCase("true"))) {
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input0")) {
                                                    input0 = String.valueOf(hSesija2.getAttribute("input0")); // vrednost koja je bila u ovom polju
                                                    input0 = URLDecoder.decode(new String(input0.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input1")) {
                                                    input1 = String.valueOf(hSesija2.getAttribute("input1")); 
                                                    input1 = URLDecoder.decode(new String(input1.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input2")) {
                                                    input2 = String.valueOf(hSesija2.getAttribute("input2")); 
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input3")) {
                                                    input3 = String.valueOf(hSesija2.getAttribute("input3")); // vrednost koja je bila selektovana u ovoj padajućoj listi
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input4")) {
                                                    input4 = String.valueOf(hSesija2.getAttribute("input4")); // vrednost koja je bila selektovana u ovoj padajućoj listi
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input5")) {
                                                    input5 = String.valueOf(hSesija2.getAttribute("input5")); // vrednost koja je bila selektovana u ovoj padajućoj listi
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input6")) {
                                                    input6 = String.valueOf(hSesija2.getAttribute("input6")); // vrednost koja je bila selektovana u ovoj padajućoj listi
                                                } 
                                            } 
                                        }
                                        hSesija2.setAttribute("popunjeno", "false"); // input polja ne treba da budu ispunjena
                                    } 
                                    
                                    // sačuvaj ime veb stranice na kojoj sam sada u slučaju da korisnik klikne na Prijavite se dugme u footer-u  
                                    hSesija2.setAttribute("ime_stranice", IME_STRANICE);
                                    // postaviNaPrazno: postavlja vrednosti varijabla sesije na "" za varijable input0, input1, ...
                                    PticaMetodi.postaviNaPrazno(hSesija2); 
                                %>
                                
                                <form action="pretragaDB.jsp" name="pretr_knjige" id="pretr_knjige" method="post" onsubmit="return proveriF();">
                                    <div class="form-group"> 
                                        <label for="naslov">Naslov <span class="vel_teksta text-danger">*</span></label> 
                                        <!-- ispunjavanje naslova je obavezno  -->
                                        <input type="text" class="form-control form-control-sm" name="naslov" id="naslov" onchange="napraviKolacic()" required value="<%= input0 %>"> 
                                    </div>
                                    
                                    <div class="form-group"> 
                                        <label for="autor">Autor</label> 
                                        <input type="text" class="form-control form-control-sm" name="autor" id="autor" onchange="napraviKolacic()" onfocusout="slova(document.pretr_knjige.autor, autor_poruka, 'celoime', true, 'false');" value="<%= input1 %>"> 
                                        <span id="autor_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                
                                    <div class="form-group">
                                        <label for="isbn">Isbn</label> 
                                        <input type="text" class="form-control form-control-sm" name="isbn" id="isbn" onchange="napraviKolacic();" onfocusout='broj("pretr_knjige", "isbn", "je_isbn", "isbn_poruka", true, false)' value="<%= input2 %>"> 
                                        <span id="isbn_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                
                                    <div class="form-group">
                                        <label for="raspon_cena">Cena</label> 
                                        <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                        <select class="form-control form-control-sm" name="raspon_cena" id="raspon_cena" onchange="napraviKolacic()"> 
                                            <% if (input3.equalsIgnoreCase("sve")) { %>
                                                <option value="sve" selected>Sve cene</option> <!-- opcija prikazana u padajućoj listi -->
                                            <% } else { %>
                                                <option value="sve">Sve cene</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("manje500")) { %>
                                                <option value="manje500" selected>Cena manja od 500 RSD</option> 
                                            <% } else { %>
                                                <option value="manje500">Cena manja od 500 RSD</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("izm500-1000")) { %>
                                                <option value="izm500-1000" selected>Od 500 do 1000 RSD</option> <!-- opcija prikazana u padajućoj listi -->
                                            <% } else { %>
                                                <option value="izm500-1000">Od 500 do 1000 RSD</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("izm1001-2000")) { %>
                                                <option value="izm1001-2000" selected>Od 1001 do 2000 RSD</option> 
                                            <% } else { %>
                                                <option value="izm1001-2000">Od 1001 do 2000 RSD</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("izm2001-5000")) { %>
                                                <option value="izm2001-5000" selected>Od 2001 do 5000 RSD</option> 
                                            <% } else { %>
                                                <option value="izm2001-5000">Od 2001 do 5000 RSDD</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("iznad5000")) { %>
                                                <option value="iznad5000" selected>Cena veća od 5000 RSD</option> <!-- opcija prikazana u padajućoj listi -->
                                            <% } else { %>
                                                <option value="iznad5000">Cena veća od 5000 RSD</option>
                                            <% } %>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="sortirajpo">Sortiraj</label>
                                        <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                        <select class="form-control form-control-sm" name="sortirajpo" id="sortirajpo" onchange="napraviKolacic()"> 
                                            <% if (input4.equalsIgnoreCase("nisko")) { %>
                                                 <option value="nisko" selected>Po ceni - rastuća</option> <!-- opcija prikazana u padajućoj listi -->
                                            <% } else { %>
                                                 <option value="nisko">Po ceni - rastuća</option>
                                            <% } %>
                                            
                                            <% if (input4.equalsIgnoreCase("visoko")) { %>
                                                 <option value="visoko" selected>Po ceni - opadajuća</option> 
                                            <% } else { %>
                                                 <option value="visoko">Po ceni - opadajuća</option>
                                            <% } %>
                                        </select>
                                    </div>
                
                                    <div class="form-group"> 
                                        <label for="zanr">Žanrovi</label> 
                                        <!-- kreiranje padajuće liste; form-control-sm se koristi za užu kontrolu -->
                                        <select class="form-control form-control-sm" name="zanr" id="zanr" onchange="napraviKolacic()">
                                            <% if (input5.equalsIgnoreCase("svi")) { %>
                                                 <option value="svi" selected>Svi žanrovi</option> <!-- opcija prikazana u padajućoj listi -->
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
                                                 <option value="komp" selected>Internet i računari</option> <!-- opcija prikazana u padajućoj listi -->
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
                                        
                                    <div class="form-group">
                                        <label for="god_izdavanja">Godina izdavanja</label>
                                        <input type="text" class="form-control form-control-sm" id="god_izdavanja" name="god_izdavanja" onchange="napraviKolacic()" onfocusout='broj("pretr_knjige", "god_izdavanja", "je_godizd", "god_poruka", true, false)' value="<%= input6 %>"> 
                                        <span id="god_poruka" class="vel_teksta text-danger"></span>
                                    </div>

                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>

                                    <!-- dodavanje dugmets formularu; btn-sm se koristi za manju (užu) veličinu kontrole -->
                                    <button type="submit" class="btn btn-info btn-sm">Pretraga knjiga</button>

                                    <!-- adding a new container -->
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
            
        <!-- dodavanje novog reda u Bootstrap grid; klasa belapoz: postavljanje pozadine u belu boju -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
        
        <%
            // ako zap_adm verijabla sesije postoji prikaži je
            if (PticaMetodi.varSesijePostoji(hSesija2, "zap_adm")) {
                String empadmS = (String)(hSesija2.getAttribute("zap_adm"));
                Boolean zaposleni = Boolean.valueOf(empadmS); 
                if (zaposleni != true) { // prikaži modal ako korisnik koristi veb sajtu bez prijavljivanja
        %>
                    <!-- bootstrap modal -->
                    <div class="modal fade" id="centriraniModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalCenterTitle">Ptica</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    ********************/ptica/zaposleni je veb sajta za zaposlene i administratore
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </body>
</html>
