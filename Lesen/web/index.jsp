<%-- 
    Document   : index
    Created on : 02-Sep-2018, 01:41:44
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<!-- author: Ingrid Farkas -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.LesenMethoden"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- link to the external stylesheet -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
        
        <title>Lesen</title>
    </head>
    <body>
        <% 
            HttpSession hSession = LesenMethoden.returnSession(request);
            
            if (LesenMethoden.sessVarExists(hSession, "fill_in")) {  
                // set the value of fill_in to default (whether there are some session var. which contain values of the input fields
                // that need later to be filled in)
                hSession.setAttribute("fill_in","false");  
            }
            
            if (LesenMethoden.sessVarExists(hSession, "page_name")) { 
                // set the value of the page_name to default
                // page_name - name of the page where the user was just before he entered the email. 
                hSession.setAttribute("page_name", ""); 
            }
            
        %>
        <!-- including the file header.jsp into this file -->
        <!-- header.jsp contains - company logo, company name and the navigation bar -->
        <%@ include file="header.jsp"%> 
        <!-- including the content -->
        <%@ include file="index_content.jsp"%>
        <!-- including the file footer.jsp into this file -->
        <!-- footer.jsp contains the footer of the web page --> 
        <%@ include file="footer.jsp"%> 
    </body>
</html>
