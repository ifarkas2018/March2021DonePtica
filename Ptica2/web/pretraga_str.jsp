<%-- 
    Dokument   : pretraga_str
    Formiran   : 18-Sep-2018, 01:38:47
    Autor      : Ingrid Farkaš
    Projekat   : Ptica      
--%>

<!-- pretraga_str.jsp - kada korisnik klikne na Pretraga knjiga (u navigaciji) prikazuje se ova veb stranica -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ptica - Pretraga knjiga</title>
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
    </head>

    <body>       
        <!-- ukljuċivanje fajla header.jsp -->
        <!-- header.jsp sadrži : logo, ime kompanije i navigaciju -->
        <%@ include file="header.jsp" %>
        <%@ include file="pretraga_obr.jsp" %> 
        <!-- ukljuċivanje fajla footer.jsp -->
        <%@ include file="footer.jsp" %> 
    </body>
</html>

