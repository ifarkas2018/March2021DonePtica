<%-- 
    Dokument   : azur_preth
    Formiran   : 14-Mar-2019, 04:56:04
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<!-- azur_preth.jsp - kada korisnik klikne na Ažuriranje knjige (navigacija) prikazuje se ova veb stranica -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ptica - Ažuriranje knjige</title>
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
    </head>

    <body>
        <% 
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            hSesija.setAttribute("ime_izvora", "Ažuriranje knjige"); // stranica na kojoj sam sada
        %>
        
        <!-- ukljuċivanje fajla header.jsp -->
        <!-- header.jsp sadrži - logo i ime kompanije i navigaciju -->
        <%@ include file="header.jsp" %> 
        <%@ include file="azur_obr_knj.jsp" %>
        <!-- footer.jsp sadrži footer --> 
        <%@ include file="footer.jsp" %> 
    </body>
</html>

