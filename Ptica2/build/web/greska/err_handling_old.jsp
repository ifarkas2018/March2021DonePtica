<%-- 
    Dokument   : err_handling
    Formiran   : 20-Feb-2020, 11:59:05
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="razno.PticaMetodi"%>
<%@page isErrorPage="true"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
        
        <style>
            /* stilovi za pretraživače manje od 350px; */
            /* ne prikazuje ( ili još uvek prikazuje ) tekst text pored slike zavisno od širine pretraživača */ 
            @media screen and (max-width: 150px) {
                span.slika_tekst {
                    display: none;
                }
            }
            
            /* stilovi za pretraživače manje od 767px: ne prikazuju prostor levo od slike u levoj koloni */
            @media screen and (max-width: 767px) {
                div.book_L {
                    display: none;
                }
            }
             
            /* stilovi za pretraživače ( na mobilnim uređajima ) većim od 350px; ( iPhone ) */
            /* ne prikazuje se ( ili još uvek prikazuje ) tekst ispod slike zavisno od širine pretraživača */
            @media screen and (min-width: 150px) {
                div.slika_tekst_ispod {
                    display: none;
                }
            }
                                   
        </style>
        
        <title>Ptica</title>
    </head>
    
    <body>
        <% 
            HttpSession hSession = PticaMetodi.vratiSesiju(request);
            
            if (PticaMetodi.varSesijePostoji(hSession, "popunjeno")) {  
                // postavljanje vrednosti popunjeno na inicijalnu vrednost ( da li postoje varijable sesije koje sadrže vrednosti input 
                // kontrola koje kasnije treba da se popune )
                hSession.setAttribute("popunjeno","false");  
            }
            
            if (PticaMetodi.varSesijePostoji(hSession, "ime_stranice")) { 
                // postavljam vrednost ime_stranice na inicijalnu vrednost
                // ime_stranice - ime veb stranice gde je korisnik bio kada je uneo email
                hSession.setAttribute("ime_stranice", ""); 
            }
            
        %>
        <!-- ukljuċivanje fajla err_header.jsp -->
        <!-- err_header.jsp sadrži : logo, ime kompanije i navigaciju -->
        <%@ include file="err_header.jsp"%> 
        
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belo -->
        <div class="belapoz">
            <div class="row"> 
                <!-- Bootstrap kolona zauzima 6 kolona na velikim desktopovima i 6 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-6 col-md-6"> 
                    <br /> <br />
                    <div> 
                        <!-- slika-centar postavlja sliku u sredinu ( horizontalno ), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid float-left pull-left mr-2" alt="slika sa knjigama" title="slika sa knjigama">
                    </div>
                </div>
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- dodavanje kontejnera u Bootstrap grid -->
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                                <br /><br /><br />
                                <br /> 
                                <h3 class="text-info">Ptica</h3> 
                                <br />
                                Sada menjamo veb sajtu.
                                <br />
                                <br />
                                Molimo Vas <span class="text-warning">posetite nas kasnije!</span>
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
        <%@ include file="../footer.jsp"%>
    </body>
</html>
