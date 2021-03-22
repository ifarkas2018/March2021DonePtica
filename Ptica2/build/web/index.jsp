<%-- 
    Dokument   : index
    Formiran   : 02-Sep-2018, 01:41:44
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- povezivanje sa eksternom listom stilova -->
        <link href="css/css_pravila.css" rel="stylesheet" type="text/css">
        
        <title>Ptica</title>
    </head>
    <body>
        <% 
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            
            if (PticaMetodi.varSesijePostoji(hSesija, "popunjeno")) {  
                // postavljanje vrednosti popunjeno na inicijalnu vrednost (da li postoje varijable sesije koje sadrže vrednosti input 
                // kontrola koje kasnije treba da se popune)
                hSesija.setAttribute("popunjeno", "false");  
            }
            
            if (PticaMetodi.varSesijePostoji(hSesija, "ime_stranice")) { 
                // postavljam vrednost ime_stranice na inicijalnu vrednost
                // ime_stranice - ime veb stranice gde je korisnik bio kada je uneo email
                hSesija.setAttribute("ime_stranice", ""); 
            }
            
        %>
        
        <!-- ukljuċivanje fajla header.jsp -->
        <!-- header.jsp sadrži : logo, ime kompanije i navigaciju -->
        <%@ include file="header.jsp" %>
        <!-- dodajem sadržaj veb stranice -->
        <%@ include file="index_knjige.jsp" %>
        <!-- ukljuċivanje fajla footer.jsp -->
        <%@ include file="footer.jsp" %> 
    </body>
</html>
