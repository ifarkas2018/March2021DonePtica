<%-- 
    Dokument   : newsletter_info
    Formiran   : 16-Apr-2019, 16:28:06
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ptica - Newsletter</title>
        <script>
            function postaviPopunj() {
                // ako se korisnik vrati na prethodnu veb stranicu (sa formularom) gde je bio pre prijave na Newsletter popunjeno treba da bude true 
                document.cookie = "popunjeno=true;"; 
            }
        </script>
    </head>
    
    <body onload="postaviPopunj()">
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
                                <br /><br /><br /><br /><br />
                                <h3 class="text-info">Newsletter</h3>
                                <br /><br /> 
                                <%  HttpSession hSesija = PticaMetodi.vratiSesiju(request);
                                    hSesija.setAttribute("newsletter", "true");
                                    String validEmail = String.valueOf(hSesija.getAttribute("valid_email"));
                                    String izuzetak = "false"; // da li je došlo do izuzetka 
                                    String ime_stranice = "";
                                    if (ime_stranice.equalsIgnoreCase("")) // ako ime_stranice nije postavljen u ovom skriptu čitam ga iz ime_vebstr 
                                        ime_stranice = String.valueOf(hSesija.getAttribute("ime_vebstr")); // ime veb stranice gde je korisnik bio pre prijave na Newsletter
                                    izuzetak = String.valueOf(hSesija.getAttribute("baza_izuzetak"));
                                    
                                    if (validEmail.equalsIgnoreCase("false"))
                                        out.print("<span class=\"text-warning\">Uneta email adresa nije validna!</span>");
                                    else if (izuzetak.equalsIgnoreCase("postoji"))
                                        out.print("<span class=\"text-warning\">Uneta email adresa se već koristi!</span>");
                                    else if (izuzetak.equalsIgnoreCase("true"))
                                        out.print("<span class=\"text-warning\">Došlo je do greške prilikom pristupa bazi podataka!</span>"); 
                                    else {
                                        out.print("Poštovani, uspešno ste se prijavili na našu mejling listu!");
                                    } 

                                    if ((ime_stranice.equalsIgnoreCase("null")) || (ime_stranice.equalsIgnoreCase("")) || (ime_stranice == null)) 
                                        ime_stranice = "index.jsp";
                                %>
                                
                                <!-- posle klika na dugme prikazuje se veb stranica na kojoj je korisnik bio pre prijave na Newsletter --> 
                                <form action=<%= ime_stranice %> method="post"> 
                                    <br /><br /><br />
                                    <!-- adding the button Zatvori, btn-info is used for defining the color of the button,
                                         form-control-sm is used for smaller size of the button -->
                                    <!-- btn-info je boja dugmeta -->
                                    <button type="submit" class="btn btn-info btn-sm" id="zatvori">Zatvori</button>
                                </form>    
                            </div> <!-- završetak class="col" -->
                            
                        </div> <!-- završetak class="row" --> 
                    </div> <!-- završetak class="container" -->
                </div> <!-- završetak class="col-lg-5 col-md-5" -->
            </div> <!-- završetak class="row" -->
        </div> <!-- završetak class="belapoz" -->
            
        <!-- dodavanje novog reda u Bootstrap grid; belapoz: postavljanje pozadine na belu boju -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>