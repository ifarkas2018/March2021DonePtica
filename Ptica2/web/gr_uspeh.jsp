<%-- 
    Dokument   : gr_uspeh.jsp
    Formiran   : 19-Nov-2018, 02:31:59
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<!-- gr_uspeh.jsp prikazuje poruku o grešci ili uspešno izvršenoj operaciji -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            // ime veb stranice koja treba da se prikaže ako korisnik unese email (prijava na Newsletter)
            hSesija.setAttribute("ime_vebstr", "gr_uspeh.jsp");
            // ako je korisnik sada završio prijavu za Newsletter, obrazac na sledećoj veb stranici ne treba da prikaže prethdne vrednosti
            hSesija.setAttribute("newsletter", "false");
            
            // naslov - prosleđuje se od jedne veb stranice do druge
            String sNaslov = (String)hSesija.getAttribute("naslov");
             
            String sIzvor = (String)hSesija.getAttribute("ime_izvora");
            // postavi naslov ove veb stranice zavisno od opearcije koja se izvršava
            if (sIzvor.equalsIgnoreCase("Nova knjiga")) {
                out.print("<title>Ptica - Nova knjiga</title>"); 
            } else if (sIzvor.equalsIgnoreCase("Novi naslovi")) {
                out.print("<title>Ptica - Novi naslovi</title>"); 
            } else if (sIzvor.equalsIgnoreCase("Pretraga knjiga")) {
                out.print("<title>Ptica - Pretraga knjiga</title>"); 
            } else if (sIzvor.equalsIgnoreCase("Ažuriranje knjige")) {
                out.print("<title>Ptica - Ažuriranje knjige</title>"); 
            } else if (sIzvor.equalsIgnoreCase("Brisanje knjige")) {
                out.print("<title>Ptica - Brisanje knjige</title>"); 
            } else if (sIzvor.equalsIgnoreCase("Prijava")) {
                out.print("<title>Ptica - Prijava</title>");
            } else if (sIzvor.equalsIgnoreCase("Odjava")) {
                out.print("<title>Ptica - Odjava</title>");    
            } else if (sIzvor.equalsIgnoreCase("Novi nalog")) {
                out.print("<title>Ptica - Novi nalog</title>");
            }
        %>    
        
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
        
        <!-- header.jsp sadrži - logo i ime kompanije i navigaciju -->
        <%@ include file="header.jsp" %>
    </head>
    
    <body>
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
                    <div class="container">
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                                <br /><br /><br />
                                <%  
                                    // naslov, ime_izvora, poruka - podaci prosleđeni sa druge veb stranice (pretragaDB.jsp ili azurDB.jsp)
                                    // sIzvor - tekst na dugmetu i koristi se za postavljanje action atributa u form tag-u
                                    
                                    // poruka - poruka koja se prikazuje (varijabla koja je prosleđena sa prethodne veb stranice) 
                                    String sPoruka = (String)hSesija.getAttribute("poruka");
                                    
                                    // promena boje poruke u text-warning
                                    String grPoc = "<span class=\"text-warning\">";
                                    String grKraj = "</span>";
                                    
                                    out.print("<br />");
                                    out.print("<h3 class=\"text-info\">" + sNaslov + "</h3><br /><br />");
                                    // zavisno od sPoruka-e prikazujem poruku o grešci
                                    if (sPoruka.equalsIgnoreCase("GR_BAZA")) {
                                        out.print(grPoc + "Došlo je do greške" + grKraj + " prilikom pristupa bazi podataka!"); 
                                    } else if (sPoruka.equalsIgnoreCase("GR_PRIJAVA")) {   
                                        out.print("Korisničko ime ili lozinka " + grPoc + "ne postoje!" + grKraj);
                                    } else if (sPoruka.equalsIgnoreCase("GR_KOR_POSTOJI")) {
                                        out.print("Uneto korisničko ime " + grPoc + "već postoji i korisnik nije unesen" + grKraj + " u bazu podataka!");
                                    } else if (sPoruka.equalsIgnoreCase("GR_NOVI_KOR")) {
                                        out.print(grPoc + "Došlo je do greške " + grKraj + "prilikom dodavanja novog korisnika i korisnik nije dodat u bazu podataka!"); 
                                    } else if (sPoruka.equalsIgnoreCase("GR_PRETR")) {
                                        out.print(grPoc + "Došlo je do greške" + grKraj + " prilikom pretraživanja!"); 
                                    } else if (sPoruka.equalsIgnoreCase("GR_NE_POST_KNJ")) {
                                        out.print("Knjiga sa tim naslovom, autorom i Isbn-om " + grPoc + "ne postoji!" + grKraj); 
                                    } else if (sPoruka.equalsIgnoreCase("GR_NEMA_BR_AUT")) {
                                        out.print("Knjiga od tog autora " + grPoc + "ne postoji!" + grKraj); 
                                    } else if (sPoruka.equalsIgnoreCase("GR_DODAJ")) {
                                        out.print(grPoc + "Došlo je do greške" + grKraj + " prilikom dodavanja knjige i knjiga nije uspešno dodata u bazu podataka!"); 
                                    } else if (sPoruka.equalsIgnoreCase("GR_AZUR")) {
                                        out.print(grPoc + "Došlo je do greške" + grKraj + " prilikom ažuriranja podataka o knjizi!"); 
                                    } else if (sPoruka.equalsIgnoreCase("GR_BRISANJE")) {
                                        out.print(grPoc + "Došlo je do greške" + grKraj + " prilikom brisanja knjige!");
                                    } else if (sPoruka.equalsIgnoreCase("BRIS_NEMA_KNJ")) {
                                        out.print("Knjiga ne postoji i zbog toga" + grPoc + " nije obrisana iz baze podataka!" + grKraj);
                                    } else if (sPoruka.equalsIgnoreCase("GR_NOVA_POST")) {
                                        out.print("Knjiga sa tim Isbn-om već postoji i" + grPoc + " knjiga nije dodata u bazu podataka!" + grKraj);  
                                    } else if (sPoruka.equalsIgnoreCase("USPEH_DOD")) {
                                        out.print("Podaci o knjizi su uspešno uneti u bazu podataka!");       
                                    } else if (sPoruka.equalsIgnoreCase("USPEH_AZUR")) {
                                        out.print("Podaci o knjizi su uspešno promenjeni u bazi podataka!");  
                                    } else if (sPoruka.equalsIgnoreCase("USPEH_BRIS")) {
                                        out.print("Knjiga je uspešno obrisana iz baze podataka!");  
                                    } else if (sPoruka.equalsIgnoreCase("USPEH_REGIST")) {
                                        out.print("Novi korisnik je uspešno registrovan!"); 
                                    } else if (sPoruka.equalsIgnoreCase("USPEH_ODJAVA")) {
                                        out.print("Uspešno ste se odjavili!");
                                    }
                                    
                                    // sIzvor - za postavljanje atributa action u form tag-u
                                    if (sIzvor.equalsIgnoreCase("Nova knjiga")) {
                                %>
                                        <form action="dodaj_stranicu.jsp" method="post">
                                <%
                                    } else if (sIzvor.equalsIgnoreCase("Novi naslovi")) {
                                %>
                                        <form action="index.jsp" method="post">
                                <%
                                    } else if (sIzvor.equalsIgnoreCase("Pretraga knjiga")) {
                                %>
                                        <form action="pretraga_str.jsp" method="post">  
                                <%
                                    } else if (sIzvor.equalsIgnoreCase("Ažuriranje knjige")) {                            
                                %>
                                        <form action="azur_preth.jsp" method="post"> 
                                <%
                                    } else if (sIzvor.equalsIgnoreCase("Brisanje knjige")) { 
                                %>
                                        <form action="obr_knjigu.jsp" method="post">
                                <%
                                    } else if (sIzvor.equalsIgnoreCase("Prijava")) {
                                %>
                                        <form action="prijava_str.jsp" method="post">
                                <%
                                    } else if (sIzvor.equalsIgnoreCase("Odjava")) {
                                %>
                                        <form action="index.jsp" method="post">
                                <%
                                    } else if (sIzvor.equalsIgnoreCase("Novi nalog")) {
                                %>
                                        <form action="novinal_str.jsp" method="post">
                                <%
                                    }
                                %>
                                <% if (sIzvor.equals("Odjava")) {
                                       sIzvor = "Ptica"; // tekst na dugmetu
                                   }
                                %>
                                    <br /><br /><br />
                                    <!-- btn-sm se koristi za manju (užu) veličinu kontrole -->
                                    <button type="submit" class="btn btn-info btn-sm"><%= sIzvor %></button>
                                </form>
                                
                            </div> <!-- završetak class = "col" -->
                        </div> <!-- završetak class = "row" --> 
                    </div> <!-- završetak class = "container" -->
                </div> <!-- završetak class = "col-lg-5 col-md-5" -->
            </div> <!-- završetak class = "row" -->
        </div> <!-- završetak class = "belapoz" -->
            
        <!-- dodajem novi red u Bootstrap grid; klasa belapoz: za postavljanje pozadine u belo -->
        <div class="belapoz">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
        <!-- footer.jsp sadrži footer --> 
        <%@ include file="footer.jsp"%> 
    </body>
</html>
