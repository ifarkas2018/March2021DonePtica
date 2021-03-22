<%-- 
    Dokument   : obr_knjigu
    Formiran   : 21-Mar-2019, 14:51:52
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<!-- obr_knjigu.jsp - kada korisnik klikne na link Brisanje knjige (u navigaciji) ova stranica se prikazuje -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ptica - Brisanje knjige</title>
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <% 
            HttpSession hSesija = PticaMetodi.vratiSesiju(request); // sesija kojoj ću dodati atribute
            hSesija.setAttribute("ime_izvora", "Brisanje knjige"); // stranica na kojoj sam sada
        %>
        <!-- ukljuċivanje fajla header.jsp -->
        <!-- header.jsp sadrži: logo, ime kompanije i navigaciju -->
        <%@ include file="header.jsp"%>
        <!-- ukljuċivanje fajla azur_obr_knj.jsp -->
        <%@ include file="azur_obr_knj.jsp" %>   
        <!-- ukljuċivanje fajla footer.jsp -->
        <!-- footer.jsp sadrži footer --> 
        <%@ include file="footer.jsp" %> 
    </body>
</html>
