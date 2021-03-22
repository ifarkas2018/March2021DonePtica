<%-- 
    Dokument   : index_knjige
    Formiran   : 16-Apr-2019, 17:46:49
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="konekcija.ConnectionManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script  type="text/javascript">
            // napraviKolIndeks: kreira kolačić sa imenom indeks_knjige i sa vrednošću index 
            function napraviKolIndeks(index) {
                var str_kolacic = "indeks_knjige=";
                str_kolacic += index + ";";
                document.cookie = str_kolacic; // kreiranje kolačića sa imenom indeks_knjige
            }
        
            // prilikom prikazvanja veb stranice prikaži modal (id: centriraniModal)
            $(window).on('load', function() {
                $('#centriraniModal').modal('show');
            });
        </script>
        
        <style>
            /* stilovi za pretraživače manje od 350px; */
            /* ne prikazuje (ili još uvek prikazuje) tekst text pored slike zavisno od širine pretraživača */  
            @media screen and (max-width: 350px) {
                span.slika_tekst {
                    display: none;
                }
            }
            
            /* stilovi za pretraživače manje od 767px: ne prikazuju prostor levo od slike u levoj koloni */
            @media screen and (max-width: 767px) {
                div.knjiga_L {
                    display: none;
                }
            }
             
            /* stilovi za pretraživače (na mobilnim uređajima) većim od 350px; (iPhone) */
            /* ne prikazuje (ili još uvek prikazuje) tekst ispod slike zavisno od širine pretraživača */
            @media screen and (min-width: 350px) {
                div.slika_tekst_ispod {
                    display: none;
                }
            }
                                   
        </style>
        
        <title>Ptica</title>
    </head>
    
    <body>    
        <%! String sNaslov = "";
            String sAutor = "";
            String sCena = "";
            
            // citajInfKnjige: čita naslov, ime autora i cenu knjige
            // kada korisnik klikne na jednu od linkova na početnoj stranici za knjigu sa indeksom index
            public static ResultSet citajInfKnjige(int index) throws SQLException {
                Connection con = ConnectionManager.getConnection(); //povezivanje sa bazom 
                Statement stmt = con.createStatement();
                                    
                String sUpit = "SELECT p.naslov, a.ime_autora, p.cena from ptica_knjiga p, autor a where a.br_autora = p.br_autora and br_knjige = '" + index + "';";
                                    
                // izvrši upit - rezultat je u rs
                ResultSet rs = stmt.executeQuery(sUpit);
                return rs;
            }

            // infKnjiga: čita iz rs naslov, ime autora, cenu, Isbn i opis knjige
            private void infKnjiga(ResultSet rs) throws SQLException {
                sNaslov = "";
                sAutor = "";
                sCena = "";
                
                try {
                    if (rs.next()) {
                        // čitaj naslov
                        sNaslov = rs.getString("naslov");
                        // čitaj ime autora
                        sAutor = rs.getString("ime_autora");
                        // čitaj cenu
                        sCena = rs.getString("cena");
                        // u bazi cena je u obliku 99999.99; na obrazcu cena treba da se prikaže u obliku 99.999,99
                        sCena = sCena.replace('.', ','); // zamni decimalnu . sa ,
                        sCena = PticaMetodi.dodajTacku(sCena); // dodajem tačku u cenu iza hiljadu dinara
                    }
                } catch (SQLException ex) {
                    System.out.println("Izuzetak: " + ex.getMessage());
                }
            }
        %>  
        <%
            HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);
            hSesija2.setAttribute("ime_vebstr", "index.jsp");
            // postavljanje vrednosti varijabli sesije na inicijalnu vrednost: ako je korisnik sada završio prijavu na Newsletter,
            // obrazac na sledećoj veb stranici NE TREBA da prikaže prethdne vrednosti
            hSesija2.setAttribute("newsletter", "false"); 
            hSesija2.setAttribute("je_greska", "false"); // nije došlo do greške
        %>
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belo -->
        <div class="belapoz minwidth">
            <div class="row"> 
                <!-- Bootstrap kolona zauzima 6 kolona na velikim desktopovima i 6 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-6 col-md-6"> 
                    <div class="container"> 
                        <br />
                     
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(1);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        <div class="row"> 
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp; 
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_1.jpg" class="img-fluid  float-left pull-left mr-2" onclick="napraviKolIndeks(1)" alt="slika sa knjigama" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                        </div> 
                        <div class="row"> 
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(2);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- dodavanje novog reda Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp;
                            </div>
                            
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/bk_2.jpg" class="img-fluid  float-left pull-left mr-2" onclick="napraviKolIndeks(2)" alt="slika sa knjigama" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                        </div> 
                            
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>

                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(3);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp;
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_3.jpg" class="img-fluid  float-left pull-left mr-2" onclick="napraviKolIndeks(3)" alt="slika sa knjigama" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                        </div> 
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {  
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(4);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp;
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_4.jpg" class="img-fluid  float-left pull-left mr-2" onclick="napraviKolIndeks(4)" alt="slika sa knjigama" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                        </div> 
                            
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(5);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp;
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_5.jpg" class="img-fluid  float-left pull-left mr-2" onclick="napraviKolIndeks(5)" alt="slika sa knjigama" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                        </div> 
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {  
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>
                    </div>
                </div>
                
                <!-- the Bootstrap kolona zauzima 5 kolona na velikim desktopovima i 5 kolona na desktopovima srednje veličine -->
                <div class="col-lg-6 col-md-6"> 
                    <div class="container"> <!-- dodavanje kontejnera u Bootstrap grid -->
                        <br/>
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(6);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_6.jpg" class="img-fluid  float-left pull-left mr-2" onclick="napraviKolIndeks(6)" alt="slika sa knjigama" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp; 
                            </div>
                        </div>            
                        
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>
                            
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(7);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_7.jpg" class="img-fluid  float-left pull-left mr-2" alt="slika sa knjigama" onclick="napraviKolIndeks(7)" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% }
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp; 
                            </div>
                        </div> 
                       
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% }
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% }
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %> 
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(8);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_8.jpg" class="img-fluid  float-left pull-left mr-2" alt="slika sa knjigama" onclick="napraviKolIndeks(8)" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp; 
                            </div>
                        </div> 
                            
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>    
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(9);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_9.jpg" class="img-fluid  float-left pull-left mr-2" alt="slika sa knjigama" onclick="napraviKolIndeks(9)" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% } 
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp; 
                            </div>
                        </div>  
                        
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) { 
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% }
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // pročitaj podatke o knjizi i sačuvaj ih u result set-u rs
                                ResultSet rs = citajInfKnjige(10);
                                // čita naslov, ime autora, cenu, Isbn i opis knjige iz baze i čuva ih u varijablama
                                infKnjiga(rs);
                            } catch (SQLException e) {
                                System.out.println("Izuzetak: " + e.getMessage());
                            }
                        %>
                        &nbsp;
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- pull-left mr-2 se koristi za razmak između slike i teksta -->
                                <a href="PrikaziKnjigu"><img src="images/book_10.jpg" class="img-fluid  float-left pull-left mr-2" alt="slika sa knjigama" onclick="napraviKolIndeks(10)" title="slika sa knjigama"></a>
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <span class="slika_tekst"><%= sAutor %></span><br/> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><b><%= sNaslov %></b></span><br/> <!-- naslov -->
                                <% }
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <span class="slika_tekst"><%= sCena %> RSD</span><br/> <!-- cena -->
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 knjiga_L">
                                &nbsp; 
                            </div>
                        </div>
                            
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAutor.equalsIgnoreCase("")) { %>
                                    <div class="slika_tekst_ispod"><%= sAutor %></div> <!-- autor -->
                                <% } 
                                   if (!sNaslov.equalsIgnoreCase("")) {
                                %>
                                    <div class="slika_tekst_ispod"><b><%= sNaslov %></b></div> <!-- naslov -->
                                <% }
                                   if (!sCena.equalsIgnoreCase("")) {
                                %>
                                    <div class="slika_tekst_ispod"><%= sCena %> RSD</div> <!-- cena -->
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        
                    </div> <!-- završetak class="container" -->
                </div> <!-- završetak class="col-lg-5 col-md-5" -->
            </div> <!-- završetak class="row" -->
        </div> <!-- završetak class="belapoz" -->
            
        <!-- dodavanje novog reda; klasa belapoz je za potavljanje pozadine u belu boju -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
        
        <%
            // ako zap_adm varijabla sesije postoji pročitaj je
            if (PticaMetodi.varSesijePostoji(hSesija2, "zap_adm")) {
                String empadmS = (String)(hSesija2.getAttribute("zap_adm"));
                Boolean zaposleni = Boolean.valueOf(empadmS); 
                if (zaposleni != true) { // prikaži modal ako korisnik prikazuje web sajtu za običnog kupca
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
                                    ********************/ptica/zaposleni je veb sajta za zaposlene i administratore.
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-info" data-dismiss="modal">Zatvori</button>
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