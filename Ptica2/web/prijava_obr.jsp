<%-- 
    Dokumenat   : prijava_str.jsp
    Formiran    : 31-Mar-2019, 21:19:51
    Autor       : Ingrid Farkaš
    Projekat    : Ptica
--%>

<%@ page import="java.util.Enumeration" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page import="java.net.URLDecoder" %>

<!-- prijava_obr.jsp - prikazuje obrazac za unos korisničkog imena i lozinku -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        
        <script>
            BR_POLJA = 3; // broj polja na obrazacu  
            
            // napraviKolacic: kreira kolaċić input0 = vrednost u input polju; 
            function napraviKolacic() {           
                var i;
                document.cookie = "input0=" + encodeURIComponent(document.getElementById("kor_ime").value) + ";"; // kreiranje kolaċića
            }
            
            // postaviVr: postavlja vrednosti kolaċića (sa imenom input0, input1,.., input12) na inicijalnu vrednost i
            // piše sadržaj svakog input polja u kolaċić
            function postaviVr() {
                var i;
                for (i = 0; i < BR_POLJA; i++) {
                    document.cookie = "input" + i + "= "; // postavljanje VREDNOSTI kolaċića na PRAZNO
                }
                napraviKolacic(); // zapisuje vrednost sadržaja polja sa korisničkim imenom u kolaċić
            } 
        </script>    
    </head>
    
    <title>Ptica - Prijava</title>
    <body onload="postaviVr()">
        
        <%
            final String IME_STRANICE = "prijava_str.jsp"; // stranica na kojoj sam sada
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            // ime veb stranice koja treba da se prikaže ako korisnik unese email (Newsletter - prijava) 
            hSesija.setAttribute("ime_vebstr", "prijava_str.jsp");
            // postavljanje vrednosti varijabli sesije na inicijalnu vrednost: ako je korisnik sada završio prijavu na Newsletter,
            // obrazac na sledećoj veb stranici ne treba da prikaže prethdne vrednosti
            hSesija.setAttribute("newsletter", "false");
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
                </div>
                
                <!-- Bootstrap kolona zauzima 5 kolona na velikim desktopovima i 5 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- dodavanje kontejnera u Bootstrap grid -->
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                                <h3  class="text-info">Prijava</h3> 
                                <br /> 
                                
                                <form id="prijava" name="prijava" action="PrijavaServlet" method="post">
                                <!-- labela i input kontrola za korisničko ime -->
                                    <div class="form-group">
                                        <%  
                                            String input0 = ""; // proċitaj vrednost koja je bila pre u input polju korisničko ime i ponovo je prikaži
                                            
                                            // IDEJA : popunjeno je postavljena u NewsletterServl.java - true ako su neke od varijabli sesije (u input polju) 
                                            // bile postavljene i one treba da se dodaju ovde obrazcu - ovo je taċno ako je korisnik PRE PRIKAZAO OVU STRANICU
                                            // i posle toga je uneo email u prijavi za Newsletter (u footer-u) i na sledećoj stranici je kliknuo na Zatvori
                                            if (PticaMetodi.varSesijePostoji(hSesija, "popunjeno")) { 
                                                String popunjeno = String.valueOf(hSesija.getAttribute("popunjeno")); 
                                                // postavljanje vrednosti varijable sesije ime_stranice. Ako je korisnik kliknuo na dugme Prijavite se 
                                                // i posle toga ako je na veb stranici newsletter_info.jsp kliknuo na Zatvori dugme, onda se ova veb 
                                                // stranica ponovo prikazuje
                                                if (PticaMetodi.varSesijePostoji(hSesija, "ime_stranice")) { 
                                                    String ime_stranice = String.valueOf(hSesija.getAttribute("ime_stranice"));
                                                    // Ako je korisnik kliknuo na Zatvori dugme na veb stranici newsletter_info.jsp i ako je 
                                                    // ova stranica bila prikazana pre (ime_stranice) i ako su neke vrednosti saċuvane u varijablama
                                                    // sesije input tada proċitaj varijablu sesije input0 da bi se prikazala u input polju za korisničko ime
                                                    if ((ime_stranice.equalsIgnoreCase(IME_STRANICE)) && (popunjeno.equalsIgnoreCase("true"))) {
                                                        if (PticaMetodi.varSesijePostoji(hSesija, "input0")) {
                                                            input0 = String.valueOf(hSesija.getAttribute("input0")); // vrednost koja je bila u ovom polju
                                                            input0 = URLDecoder.decode(new String(input0.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova;
                                                        } 
                                                        PticaMetodi.postaviNaPrazno(hSesija); // postaviNaPrazno: postavlja vrednosti varijabli sesije na "" za varijable input0, input1, ... 
                                                    }
                                                }
                                                hSesija.setAttribute("popunjeno", "false"); // input polja ne treba da budu popunjena
                                            } 
                                            
                                            // saċuvaj ime stranice gde sam sada u sluċaju da korisnik klikne na Prijavite se dugme u footer-u
                                            hSesija.setAttribute("ime_stranice", IME_STRANICE);
                                        %>
                                        <label for="kor_ime">Korisničko ime <span class="vel_teksta text-danger">*</span></label> 
                                        <!-- input kontrola za korisničko ime -->
                                        <input type="text" class="form-control form-control-sm" name="kor_ime" id="kor_ime" onchange="napraviKolacic()" required value="<%= input0 %>"> 
                                    </div>
                                        
                                    <div class="form-group">
                                        <label for="lozinka">Lozinka <span class="vel_teksta text-danger">*</span></label> 
                                        <!-- input kontrola za lozinku (obavezno polje) -->
                                        <input type="password" class="form-control form-control-sm" name="lozinka" id="lozinka" required> 
                                    </div>
                                    
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>
                                        
                                    <!-- btn-sm se koristi za manju (užu) veličinu kontrole -->
                                    <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Prijava</button>
                                    <!-- dodavanje novog kontejnera -->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>

                                    <!-- dodavanje novog kontejnera -->
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
    </body>
</html>
