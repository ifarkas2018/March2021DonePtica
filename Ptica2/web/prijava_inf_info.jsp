<%-- 
    Dokument   : prijava_inf_info.jsp
    Formiran   : 06-Oct-2019, 20:16:17
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    
    <body>
        <%
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            hSesija.setAttribute("ime_vebstr", "prijava_inf_str.jsp"); 
            // postavljanje varijable sesije na inicijalnu vrednost: ako se korisnik prethodno prijavio na Newsletter,
            // tada formular na SLEDEĆOJ veb stranici ne treba da prikaže prethodne vrednosti
            hSesija.setAttribute("newsletter", "false"); 
        %>
        
        <!-- dodavanje novog reda u Bootstrprijava_inf_strap grid: klasa belapoz postavlja pozadinu u belo -->
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
                        <div class="row"> <!-- dodavanje reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                                <span>
                                    <h3 class="text-info">Prijava</h3>
                                </span>
                                <br />
                                <form id="prijava_inf" name="prijava_inf" action="prijava_str.jsp" method="post">
                                    Molimo Vas koristite sledeće podatke za prijavu:
                                    <br /> 
                                    <br />
                                    <!-- prikazivanje korisničkog imena i lozinke (administrator) -->
                                    <span class="text-info">
                                        <font size="+1">Administrator</font>
                                    </span>
                                    <br />
                                    <ul>
                                        <li>korisničko ime: admin</li>
                                        <li>lozinka: admin</li>    
                                    </ul>

                                    <!-- prikazivanje korisničkog imena i lozinke (zaposleni) -->
                                    <span class="text-info">
                                        <font size="+1">Zaposleni</font>
                                    </span>
                                    <ul>
                                        <li>korisničko ime: ifarkas</li>
                                        <li>lozinka: Bird2018</li>    
                                    </ul>
                                    
                                    <ul>
                                        <li class="text-warning">korisničko ime: @@@@@@@@@@@</li>
                                        <li class="text-warning">lozinka: @@@@@@@@@@@@</li>    
                                    </ul>
                                    
                                    <ul>
                                        <li class="text-warning">korisničko ime: @@@@@@@@@@@@</li>
                                        <li class="text-warning">lozinka: @@@@@@@@@@@@</li>    
                                    </ul>
                                    
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>
                                    
                                    <!-- btn-sm se koristi za manju (užu) veličinu kontrole -->
                                    <button type="submit" id="btnPrijava" class="btn btn-info btn-sm">Prijava</button>
                                </form>
                            </div> <!-- završetak class="col" -->
                        </div> <!-- završetak class="row" --> 
                    </div> <!-- završetak class="container" -->
                </div> <!-- završetak class="col-lg-5 col-md-5" -->
            </div> <!-- završetak class="row" -->
        </div> <!-- završetak class="belapoz" -->
            
        <!-- dodajem novi red u Bootstrap grid; klasa belapoz: za postavljanje pozadine u belo -->
        <div class = "belapoz">
            <div class = "col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>

