<%-- 
    Document   : about_page
    Created on : 12-May-2019, 05:26:56
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<!-- about_page.jsp - when the user clicks on the About link (the navigation bar) this web page is shown -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aqua Books - About Us</title>
        <!-- link to the external style sheet -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!-- including the file header.jsp into this file -->
        <!-- header.jsp contains - company logo, company name and the navigation bar -->
        <%@ include file="header.jsp"%>
        <!-- including the file about_info into this file -->
        <%@ include file="about_info.jsp"%> 
        <!-- including the file footer.jsp into this file -->
        <!-- footer.jsp contains the footer of the web page --> 
        <%@ include file="footer.jsp"%> 
    </body>
</html>