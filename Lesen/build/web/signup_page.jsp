<%-- 
    Document   : signup_page.jsp
    Created on : 06-Apr-2019, 00:42:10
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<!-- signup_page.jsp - when the user clicks on the Sign Up link (on the navigation bar) this web page is shown -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lesen - Registrieren</title>
        <!-- link to the external style sheet -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
    </head>
    
    <body>       
        <!-- header.jsp contains - company logo, company name and the navigation bar -->
        <%@ include file="header.jsp"%>        
        <%@ include file="signup_form.jsp"%> 
        <!-- footer.jsp contains the footer of the web page --> 
        <%@ include file="footer.jsp"%> 
    </body>
</html>



