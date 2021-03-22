<%-- 
    Document   : login_page.jsp
    Created on : 31-Mar-2019, 21:15:08
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<!-- login_page.jsp - when the user clicks on the Login link (the navigation bar) this web page is shown -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.LesenMethoden"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Lesen - Anmelden</title>
        <!-- link to the external style sheet -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
    </head>
    
    <body>  
        <!-- including the file header.jsp in this file -->
        <!-- header.jsp contains - company logo, company name and the navigation bar -->
        <%@ include file="header.jsp"%>
        
        <!-- including the file login_form.jsp into this file -->
        <%@ include file="login_form.jsp"%> 
        
        <!-- including the file footer.jsp into this file -->
        <!-- footer.jsp contains the footer of the web page --> 
        <%@ include file="footer.jsp"%> 
    </body>
</html>