<%-- 
    Dokument   : footer
    Formiran   : 02-Sep-2018, 01:51:27
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<!-- footer.jsp formira footer na veb stranici --> 
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="javascript/validacija.js"></script>
        
        <script>
            
            // jeEmail: vraća true ako je email važeći (inače vraća false)
            function jeEmail(email) {
                // regex pattern se koristi za validaciju email-a
                // var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                var regex = /^([a-zA-ZćĆčČšŠžŽđĐ\u0400-\u04FF0-9_\.\-\+])+\@(([a-zA-ZćĆčČšŠžŽđĐ\u0400-\u04FF0-9\-])+\.)+([a-zA-ZćĆčČšŠžŽđĐ\u0400-\u04FF0-9]{2,4})+$/;
                if (!regex.test(email)) {
                    return false;
                } else {
                    return true;
                }
            }

            // formKolacic: formira kolačić sa nazivom valid_email (vrednost je uneseni email)
            function formKolacic() {
                var email = document.getElementById("newsl_email").value;
                var kolacic_str = "valid_email=";
                // ako je email važeći vrednost je true
                if (jeEmail(email)) {
                   kolacic_str += "true;";
                } else {
                    kolacic_str += "false;"; 
                }
                document.cookie = kolacic_str; // formiranje kolačića sa nazivom valid_email
            }
        </script>
    </head>
    <body> 
        <%
            boolean atr_nadjen;
            String jeStrGr = "false"; // da li je došlo do greške 
            HttpSession hSes = PticaMetodi.vratiSesiju(request);
            // da li se prikazuje stranica za grešku (error page) 
            atr_nadjen = PticaMetodi.varSesijePostoji(hSes, "je_greska"); // varSesijePostoji: vraća da li varijabla sesije je_greska postoji u sesiji
            if (atr_nadjen) { // da li je varijabla sesije sa imenom je_greska pronađena 
                jeStrGr = String.valueOf(hSes.getAttribute("je_greska"));
            }
        %>
        
        <footer>
            <!-- footer je klasa (u css_pravila.css) -->
            <div class="footer" align="center" id="footer">
                <div class="container"> 
                    <div class="row"> 
                        <!-- Bootstrap kolona zauzima 2 kolone na velikim desktopovima, 2 kolone na desktopovima srednje veliċine,
                             4 kolone na small ekranima, 6 kolona na extra small ekranima -->
                        <div  class="col-lg-2  col-md-2 col-sm-4 col-xs-6">
                            &nbsp; &nbsp; <!-- prazan prostor -->
                        </div>
                        <!-- Bootstrap kolona zauzima 2 kolone na velikim desktopovima, 2 kolone na desktopovima srednje veliċine,
                             4 kolone na small ekranima, 6 kolona na extra small ekranima -->
                        <div class="col-lg-2  col-md-2 col-sm-4 col-xs-6">
                            <h3> O nama </h3> <!-- naslov kolone -->
                            <!-- smaller-text je klasa koja određuje veličinu teksta -->
                            <ul class="smaller-text">
                                <li> <a href="#"> Our Company </a> </li> <!-- link u footer-u -->
                                <li> <a href="DodajVarSesije" onclick="kolacPopunj('onama_str.jsp')"> O nama </a> </li>
                                <li> <a href="#"> Terms of Services </a> </li>
                                <li> <a href="#"> Our Team </a> </li>
                            </ul>
                        </div>
                       
                        <!-- Bootstrap kolona zauzima 2 kolone na velikim desktopovima, 2 kolone na desktopovima srednje veliċine -->
                        <div class="col-lg-2  col-md-2"> 
                            &nbsp; &nbsp; <!-- prazan prostor -->
                        </div>
    
                        <!-- Bootstrap kolona zauzima 1 kolonu na velikim desktopovima, 1 kolonu na desktopovima srednje veliċine -->
                        <div class="col-lg-1  col-md-1"> 
                            &nbsp; &nbsp; 
                        </div>
    
                        <!-- Bootstrap kolona zauzima 3 kolone na velikim desktopovima, 3 kolone na desktopovima srednje veliċine -->
                        <div class="col-lg-3  col-md-3"> 
                            <h3> Newsletter </h3> <!-- naslov kolone -->
                            <ul>
                                <li> 
                                    <div class="container"> 
                                        <!-- posle klika na dugme se poziva NewsletterServl servlet -->
                                        <form action="NewsletterServl" method="post" onsubmit="return proveriF();"> 
                                            <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                                                <div class="col">
                                                    <%
                                                        if (jeStrGr.equals("false")) { // nije došlo do greške
                                                    %>
                                                            <!-- input element za unošenje email-a; form-control-sm se koristi za užu kontrolu --> 
                                                            <input class="form-control form-control-sm" name="newsl_email" id="newsl_email" id="newsl_email" type="text" placeholder="Email" onfocusout='duzinaManja("newsl_email", "email_poruka")' required>
                                                            <span id="email_poruka" class="vel_teksta text-danger"></span>
                                                    <%
                                                        } else {
                                                    %>
                                          
                                                            <!-- input element za unošenje email-a; form-control-sm se koristi za užu kontrolu --> 
                                                            <input class="form-control form-control-sm" name="newsl_email" id="newsl_email" id="newsl_email" type="text" placeholder="Email" required disabled>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                            
                                            <div class="row"> 
                                                <div class="col">
                                                    &nbsp; &nbsp;
                                                </div>
                                            </div>
                                            
                                            <div class="row"> <!-- novi red u Bootstrap grid-u -->
                                                <div class="col">
                                                    <%
                                                        if (jeStrGr.equals("false")) { // nije došlo do greške
                                                    %>
                                                    
                                                         <!-- dodavanje dugmeta Prijavite se, btn-info je boja dugmeta, form-control-sm se koristi za užu kontrolu -->
                                                         <button type="submit" class="btn btn-info btn-sm" id="btnNewsl" onclick="formKolacic()">Prijavite se</button>
                                                    <%
                                                        } else { // ako je  došlo do greške tada se prikazuje DISABLED dugme
                                                    %>
                                                         <button type="submit" class="btn btn-info btn-sm" id="btnNewsl" onclick="formKolacic()" disabled>Prijavite se</button>
                                                    <%
                                                        } 
                                                    %>
                                                </div>
                                            </div>
                                        </form>
                                    </div> <!-- završetak class="container" -->
                                </li>
                            </ul> 
                        </div> <!-- završetak class="col-lg-3 col-md-3" -->
                    </div> <!-- završetak class="row" -->
                    
                    <div class="row">
                        <!-- Bootstrap kolona zauzima 12 kolona na velikim desktopovima, 12 kolone na desktopovima srednje veliċine -->
                        <div class="col-lg-12 col-md-12">
                            &nbsp; &nbsp; <!-- przan prostor -->
                        </div>
                    </div>
                </div> <!-- završetak class="container" -->
            </div> <!-- završetak class="footer" --> 
                    
            <div class="footer"> <!-- donji deo footer-a -->
                <div class="container">
                    <div class="row">
                        <!-- Bootstrap kolona zauzima 12 kolone na velikim desktopovima, 12 kolona na desktopovima srednje veliċine,
                             12 kolone na small ekranima, 12 kolona na extra small ekranima -->
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            &nbsp; &nbsp; <!-- prazan prostor -->
                        </div>
                    </div>
                    <div class="container text-center">
                        <!-- Bootstrap kolona zauzima 12 kolone na velikim desktopovima, 12 kolona na desktopovima srednje veliċine,
                             12 kolone na small ekranima, 12 kolona na extra small ekranima -->
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="smaller-text"> Ptica d.o.o. Resavska 58, Beograd Matični broj: 28945197 </div>
                            <!-- dodavanje copyright informacije na dnu footer-a -->
                            <div class="smaller-text"> Copyright &copy; Ptica 2018 </div>
                        </div>
                    </div>
                </div> <!-- završetak the class="container" -->
            </div> <!-- završetak class="footer" -->
        </footer> 
    </body>
</html>
