<%-- 
    Dokument   : rukov_greska.jsp
    Formiran   : 20-Feb-2020, 11:59:05
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
        
        <style>
            
            h3, p { 
                text-align: center; 
            }
                                   
        </style>
        
        <title>Ptica</title>
    </head>
    
    <body>
        <% 
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            
            if (PticaMetodi.varSesijePostoji(hSesija, "popunjeno")) {  
                // postavljanje vrednosti popunjeno na inicijalnu vrednost (da li postoje varijable sesije koje sadrže vrednosti input 
                // kontrola koje kasnije treba da se popune)
                hSesija.setAttribute("popunjeno", "false");  
            }
            
            if (PticaMetodi.varSesijePostoji(hSesija, "ime_stranice")) { 
                // postavljam vrednost ime_stranice na inicijalnu vrednost
                // ime_stranice - ime veb stranice gde je korisnik bio kada je uneo email
                hSesija.setAttribute("ime_stranice", ""); 
            }
            
        %>
        <!-- ukljuċivanje fajla zaglav_greska.jsp -->
        <!-- zaglav_greska.jsp sadrži : logo, ime kompanije i navigaciju -->
        <%@ include file="zaglav_greska.jsp" %> 
        
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belo -->
        <div class="belapoz">
            <div class="row"> 
                <!-- Bootstrap kolona zauzima 6 kolona na velikim desktopovima i 6 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- slika-centar postavlja sliku u sredinu ( horizontalno ), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                </div>
                
                <!-- Bootstrap kolona zauzima 5 kolona na velikim desktopovima i 5 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- dodavanje kontejnera u Bootstrap grid -->
                        <div class="row"> <!-- dodavanje reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                                <br />
                                <br />
                                <h3 class="text-info">Ptica</h3> 
                                <br />
                                <p>Sada menjamo veb sajtu.</p>
                                <br />
                                <br />
                                <p>Molimo Vas <span class="text-warning">posetite nas kasnije!</span></p>
                                <br />
                                <br />
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- dodavanje novog reda; klasa belapoz je za postavljanje pozadine u belu boju -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
        <!-- ukljuċivanje fajla footer.jsp --> 
        <%@ include file="../footer.jsp" %>
    </body>
</html>
