<%-- 
    Dokument   : ptica_knj se poziva kada korisnik klikne na jednu od knjiga na starnici index_knjige
    Formiran   : 21-Sep-2019, 20:48:11
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="konekcija.ConnectionManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/css_pravila.css" type="text/css" rel="stylesheet"/>
        <title>Ptica - Novi naslovi</title>
        <%@ include file="header.jsp" %>
        <script>
            function obrisiKolacic() {
                document.cookie = "indeks_knjige= ; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
            }  
        </script>
    </head>
    
    <body onload="obrisiKolacic()">
        <%! 
            // citajOpisKnjige: čita naslov, ime autora, cenu, isbn, opis knjige
            // kada korisnik klikne na jednu od knjiga na starnici index_knige sa indeksom index
            public static ResultSet citajOpisKnjige(int index) throws SQLException {
                Connection con = ConnectionManager.getConnection(); // povezivanje sa bazom 
                Statement stmt = con.createStatement();
                                    
                String upit = "SELECT p.naslov, a.ime_autora, p.cena, p.isbn, p.opis from ptica_knjiga p, autor a where a.br_autora = p.br_autora and br_knjige = '" + index + "';";                    
                
                // izvrši upit - rezultat će biti u rs
                ResultSet rs = stmt.executeQuery(upit);
                return rs;
            }
        %>
        
        <div class="belapoz">
            <div class="row"> 
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responzivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                </div>
                       
                <div class="col-lg-5 col-md-5"> 
                    <div class="container">
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Novi naslovi</h3><br/>
                                <%
                                    HttpSession hSesija = PticaMetodi.vratiSesiju(request);
                                    hSesija.setAttribute("ime_vebstr", "ptica_knj.jsp");
                                    // postavljanje vrednosti varijabli sesije na inicijalnu vrednost: ako je korisnik završio prijavu na Newsletter,
                                    // obrazac na sledećoj veb stranici ne treba da prikaže prethdne vrednosti
                                    hSesija.setAttribute("newsletter", "false");
                                    Integer index = 0;
                                    
                                    Object indexObj = hSesija.getAttribute("indeks_knjige");
                                    index = Integer.parseInt(String.valueOf(indexObj));
                                    
                                    boolean postoji_varses = PticaMetodi.varSesijePostoji(hSesija, "indeks_knjige");
                                    postoji_varses = !postoji_varses;
                                    try {                                      
                                %>  
                                    <%
                                         // čitanje podataka o knjizi i čuva ih u rs
                                        ResultSet rs = citajOpisKnjige(index);

                                        // posle klika na dugme prikazuje se index.jsp
                                        out.println("<form action=\"index.jsp\" method=\"post\">");
                                    
                                        if (!(rs.next())) { // nema podataka o knjizi
                                            out.println("<br /><br /><br />");
                                            out.println("<span class=\"text-warning\">Podaci o ovoj knjizi ne postoje!</span>");
                                            out.println("<br /><br /><br /><br /><br />");
                                        } else {
                                            // prikaži rezultat u neuređenoj listi
                                            out.print("<ul>");
                                            
                                            // čitanje naslova
                                            String naslov = rs.getString("naslov");
                                            // čitanje imena autora
                                            String autor = rs.getString("ime_autora");
                                            // čitanje cene
                                            String cena = rs.getString("cena");
                                            // čitanje ISBN
                                            String isbn = rs.getString("isbn");
                                            // prikaži naslov i autor
                                            String opis = rs.getString("opis");
                                            out.print("<li><b>" + naslov + "</b> od (<b>autora</b>) " + autor ); 
                                            
                                            // ako cena postoji prikaži je 
                                            if (cena != null && !cena.equalsIgnoreCase("")){
                                                // u bazi cena je u obliku 99999.99; na obrazcu cena se prikazuje u obliku 99.999,99
                                                cena = cena.replace('.', ','); // zamenjujem decimalnu . sa ,
                                                cena = PticaMetodi.dodajTacku(cena); // dodajem tačku u cenu iza hiljadu dinara 
                                                out.print(" (<b>cena: </b>" + cena + " RSD)" + "<br/>");
                                            }
                                                
                                            // ako ISBN postoji: prikaži ga
                                            if (isbn != null && !isbn.equalsIgnoreCase("")) {
                                                out.print("<br /><b>" + "Isbn: </b>" + isbn + "<br/>" );
                                            }
                                                
                                            // ako opis knjige postoji: prikaži ga
                                            if (opis != null && !opis.equalsIgnoreCase("")) {
                                                out.print("<br /><b>" + "Opis: </b>" + opis );
                                            }
                                                
                                            out.print("</li>");
                                            out.print("</ul>");
                                        }
                                        out.print("<br />");
                                        // btn-sm se koristi za manju (užu) veličinu kontrole
                                        out.print("<button type=\"submit\" class=\"btn btn-info btn-sm\">Ptica</button>");
                                        out.println("</form>");
                                    } catch(Exception e) {
                                        String sPoruka = "GR_BAZA";
                                        String sNaslov = "Greška"; // koristi se za prosleđivanje naslova
                                        hSesija.setAttribute("ime_izvora", "Novi naslovi"); // naziv veb strane na kojoj sam sada
                                        hSesija.setAttribute("naslov", sNaslov); 
                                        hSesija.setAttribute("poruka", sPoruka); 
                                        response.sendRedirect("gr_uspeh.jsp"); // preusmeravanje na gr_uspeh.jsp   
                                    }
                                %>

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
        
        
        <!-- dodavanje novog reda u Bootstrap grid; klasa belapoz: postavljanje pozadine u belu boju -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div>  
        <%@ include file="footer.jsp" %>
    </body>
</html>