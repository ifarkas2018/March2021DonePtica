<%-- 
    Dokument   : azur_obr_knj koji se poziva iz azur_preth.jsp, obr_knjigu.jsp
    Formiran   : 14-Mar-2019, 04:27:45
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<!-- azur_obr_knj.jsp - prikazuje obrazac za unošenje naslova, autora, Isbn-a knjige čiji se podaci ažuriraju (ili brišu) -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="javascript/validacija.js"></script>
        
        <script>
            BR_POLJA = 3; // broj polja na obrazacu 
            
            // napraviKolacic: kreira kolaċić inputI = vrednost u input polju; (I - broj 0..2)
            function napraviKolacic() {           
                var i;
                var inp_imena = new Array('preth_naslov', 'preth_autor', 'preth_isbn'); // imena input polja
                
                for (i = 0; i < BR_POLJA; i++) {
                    // encodeURIComponent: enkodiranje - koristi se zbog srpskih slova
                    document.cookie = "input" + i + "=" + encodeURIComponent(document.getElementById(inp_imena[i]).value) + ";"; // kreiranje kolaċića
                } 
            }
            
            /*
            function getcookie(cookiename) {
                var results = document.cookie.match ( '(^|;) ?' + cookiename + '=([^;]*)(;|$)' );
                if ( results )
                    return ( decodeURIComponent(results[2] ) );
                else
                    return null;
            }
            */
           
            // postaviVr: postavlja vrednosti kolaċića (sa imenima input0, input1, input2) na inicijalnu vrednost i
            // piše sadržaj svakog input polja u kolaċić
            function postaviVr() {
                var i;
                for (i = 0; i < BR_POLJA; i++) {
                    document.cookie = "input" + i + "= "; // postavljanje VREDNOSTI kolaċića na PRAZNO
                }
                napraviKolacic(); // za svako input polje zapisuje vrednost sadržaja tog polja u kolaċić
            } 
        </script>
        
        <%
            HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);            
            String izvor = (String)hSesija2.getAttribute("ime_izvora"); // stranica na kojoj sam sada
        %>
        
        <title>Ptica - <%= izvor %></title>
    </head>
  
    <body onload="postaviVr()">
        <%
            final String IME_STRANICE = "azur_preth.jsp"; // stranica na kojoj sam sada
            // ime_vebstr: ime stranice kojoj se treba vratiti ako je korisnik uneo email (Newsletter) 
            if (izvor.equals("Ažuriraj knjigu")) {
                hSesija2.setAttribute("ime_vebstr", "azur_preth.jsp");
            } else if (izvor.equals("Brisanje knjige")) {
                hSesija2.setAttribute("ime_vebstr", "obr_knjigu.jsp");
            }
            // ako je korisnik sada završio prijavu na Newsletter, obrazac na sledećoj veb stranici NE TREBA da prikaže prethdne vrednosti
            hSesija2.setAttribute("newsletter", "false");
        %>
        
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belo -->
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
                                <br/>
                                <% 
                                    out.print("<h3 class=\"text-info\">" + izvor + "</h3>"); // izvor je Ažuriraj knjigu (za Ažuriranje), ili Brisanje knjige (za Brisanje)                                  
                                %>
                               
                                <br />
                                
                                <form id="az_obr_knj" name="az_obr_knj" action="azur_obr_str.jsp" onsubmit="return proveriF();" method="post">
                                    <%           
                                        String input0 = ""; // pročitaj vrednost koja je prethodno bila u input polju preth_naslov da bi ponovo bila prikazana
                                        String input1 = ""; // pročitaj vrednost koja je prethodno bila u input polju preth_autor da bi ponovo bila prikazana
                                        String input2 = ""; // pročitaj vrednost koja je prethodno bila u input polju preth_isbn da bi ponovo bila prikazana      
                                        
                                        // IDEJA: popunjeno je postavljena u NewsletterServl.java - true ako su neke od varijabli sesije (u input polju) 
                                        // bile postavljene i one treba da se dodaju ovde obrazcu - ovo je taċno ako je korisnik PRE PRIKAZAO OVU STRANICU
                                        // i posle toga je uneo email u prijavi za Newsletter (u footer-u) i na sledećoj stranici je kliknuo na Zatvori
                                        if (PticaMetodi.varSesijePostoji(hSesija2, "popunjeno")) { 
                                            String popunjeno = String.valueOf(hSesija2.getAttribute("popunjeno")); 
                                            // Postavljanje vrednosti varijable sesije ime_stranice. Ako je korisnik kliknuo dugme Prijavite se i posle toga ako je na veb
                                            // stranici newsletter_info.jsp kliknuo na Zatvori dugme, onda se ova veb stranica ponovo prikazuje
                                            if (PticaMetodi.varSesijePostoji(hSesija2, "ime_stranice")) { 
                                                String ime_stranice = String.valueOf(hSesija2.getAttribute("ime_stranice"));
                                                // Ako je korisnik kliknuo na Zatvori dugme na veb stranici newsletter_info.jsp i ako je ova stranica bila prikazana 
                                                // pre (ime_stranice) i ako su neke vrednosti saċuvane u varijablama sesije input tada proċitaj varijablu sesije 
                                                // input0 (da bi se prikazala u prvom polju) 
                                                if ((ime_stranice.equalsIgnoreCase(IME_STRANICE)) && (popunjeno.equalsIgnoreCase("true"))) {
                                                    if (PticaMetodi.varSesijePostoji(hSesija2, "input0")) {
                                                        input0 = String.valueOf(hSesija2.getAttribute("input0")); // vrednost koja je bila u PRVOM polju
                                                        input0 = URLDecoder.decode(new String(input0.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                    } 
                                                    if (PticaMetodi.varSesijePostoji(hSesija2, "input1")) {
                                                        input1 = String.valueOf(hSesija2.getAttribute("input1")); // vrednost koja je bila u DRUGOM polju
                                                        input1 = URLDecoder.decode(new String(input1.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                    } 
                                                    if (PticaMetodi.varSesijePostoji(hSesija2, "input2")) {
                                                        input2 = String.valueOf(hSesija2.getAttribute("input2")); // vrednost koja je bila u TREĆEM polju
                                                    } 
                                                } 
                                            }
                                            hSesija2.setAttribute("popunjeno", "false"); // input polja ne treba da budu ispunjena
                                        } 

                                        // saċuvaj ime stranice gde sam sada u sluċaju da korisnik klikne na Prijavite se dugme u footer-u
                                        hSesija2.setAttribute("ime_stranice", IME_STRANICE);
                                        PticaMetodi.postaviNaPrazno(hSesija2); // postaviNaPrazno: postavlja vrednosti varijabla sesije na "" za varijable input0, input1, ...
                                    %>


                                    <!-- input kontrola za naslov -->
                                    <div class="form-group">
                                        <label for="preth_naslov">Naslov  <span class="vel_teksta text-danger">*</span></label> <!-- title label -->
                                        <!-- unošenje naslova je obavezno -->
                                        <input type="text" class="form-control form-control-sm" name="preth_naslov" id="preth_naslov" onchange="napraviKolacic()" required value="<%= input0 %>" > 
                                    </div>

                                    <!-- input kontrola za autora -->
                                    <div class="form-group">
                                        <label for="preth_autor">Autor</label> 
                                        <input type="text" class="form-control form-control-sm" name="preth_autor" id="preth_autor" onfocusout="napraviKolacic(); slova(document.az_obr_knj.preth_autor, aut_poruka, 'celoime', false, 'false');" value="<%= input1 %>">  
                                        <span id="aut_poruka" class="vel_teksta text-danger"></span>
                                    </div>

                                    <!-- input kontrola za Isbn -->
                                    <div class="form-group"> 
                                        <label for="preth_isbn">Isbn</label> 
                                        <input type="text" class="form-control form-control-sm" name="preth_isbn" id="preth_isbn" onchange="napraviKolacic()" onfocusout='broj("az_obr_knj", "preth_isbn", "je_isbn", "isbn_poruka", false, false)' value="<%= input2 %>"> 
                                        <span id="isbn_poruka" class="vel_teksta text-danger"></span>
                                    </div>    

                                    <!-- dodavanje novog kontejnera -->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>

                                    <button type="submit" id="btnDodaj" class="btn btn-info btn-sm">Pošalji</button>

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