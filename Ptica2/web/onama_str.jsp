<%-- 
    Dokument   : onama_str.jsp
    Formiran   : 12-May-2019, 05:26:56
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<!-- onama_str.jsp - ova veb stranica se prikazuje kada korisnik klikne na link O nama ( u navigaciji ) -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ptica - O nama</title>
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!-- ukljuċivanje fajla header.jsp -->
        <!-- header.jsp sadrži - logo i ime kompanije i navigaciju -->
        <%@ include file="header.jsp" %>
        <!-- ukljuċivanje fajla onama_inf -->
        <%@ include file="onama_inf.jsp" %> 
        <!-- ukljuċivanje fajla footer.jsp -->
        <!-- footer.jsp sadrži footer -->
        <%@ include file="footer.jsp" %> 
    </body>
</html>