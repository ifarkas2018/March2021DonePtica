<%-- 
    Dokument   : prijava_str.jsp
    Formiran   : 31-Mar-2019, 21:15:08
    Autor      : Ingrid Farkaš
    Project    : Ptica
--%>

<!-- prijava_str.jsp - ova veb stranica se prikazuje kada korisnik klikne na link Prijava (u navigaciji) -->

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Ptica - Prijava</title>
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
    </head>
    
    <body>  
        <!-- ukljuċivanje fajla header.jsp -->
        <!-- header.jsp sadrži : logo, ime kompanije i navigaciju -->
        <%@ include file="header.jsp" %>
        <%@ include file="prijava_obr.jsp" %> 
        <!-- ukljuċivanje fajla footer.jsp -->
        <%@ include file="footer.jsp" %> 
    </body>
</html>