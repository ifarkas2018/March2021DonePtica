<%-- 
    Document   : error_succ.jsp
    Created on : 19-Nov-2018, 02:31:59
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<!-- error_succ.jsp shows the error or the success message -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.LesenMethoden"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            HttpSession hSession = LesenMethoden.returnSession(request);
            // the name of the page to return to if the user enters the email (subscribe) 
            hSession.setAttribute("webpg_name", "error_succ.jsp");
            // reseting the sess. var to the default: if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED 
            // to show the previous values 
            hSession.setAttribute("subscribe", "false");
            
            // title - the title passed from one web page to the other
            String sTitle = (String)hSession.getAttribute("title");
             
            String sSource = (String)hSession.getAttribute("source_name");
            // set the title of this web page depending on the task the user is doing  
            // @@@@@@@@@@@@@@ DELETE THIS BEGINING I set the title just after the CSS link 
            /*
            if (sSource.equalsIgnoreCase("Add Book")) {
                out.print("<title>Add Book</title>"); 
            } else if (sSource.equalsIgnoreCase("Show Book")) {
                out.print("<title>Show Book</title>");
            } else if (sSource.equalsIgnoreCase("Search")) {
                out.print("<title>Search</title>"); 
            } else if (sSource.equalsIgnoreCase("Update Book")) {
                out.print("<title>Update Book</title>"); 
            } else if (sSource.equalsIgnoreCase("Login")){
                out.print("<title>Login</title>");
            }
            */
            // @@@@@@@@@@@@@@ DELETE THIS END
        %>    
        
        <!-- link to the external stylesheet -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
        <title>Lesen - <%= sTitle %></title>
        
        <!-- including the file header.jsp into this file -->
        <!-- header.jsp contains - company logo, company name and the navigation bar -->
        <%@ include file="header.jsp"%>
    </head>
    
    <body>
        <div class="whitebckgr">
            <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                <!-- the Bootstrap column takes 6 columns on the large desktops and 6 columns on the medium sized desktops -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="Foto mit Büchern" title="Foto mit Büchern"> 
                    </div>
                </div>
                
                <!-- the Bootstrap column takes 5 columns on the large screens and 5 columns on the medium sized screens -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container">
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                                <br /><br /><br />
                                <%
                                    // title, source_name, message - the information passed from the other JSP (searchDB.jsp or updateDB.jsp)
                                    // sSource - the text shown on the button and for setting the action in the form tag
                                    
                                    // message - the message shown on the web page ( attribute passed from the other web page )
                                    String sMessage = (String)hSession.getAttribute("message");
                                    
                                    // changing the color of error messages to text-warning
                                    String errStart = "<span class=\"text-warning\">";
                                    String errEnd = "</span>";
                                    
                                    out.print("<br />");
                                    out.print("<h3 class=\"text-info\">" + sTitle + "</h3><br /><br />");
                                    if (sMessage.equalsIgnoreCase("ERR_DB")) {
                                        out.print("Während des Datenbankzugriffs ist" + errStart + " ein Fehler aufgetreten!" + errEnd); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_LOGIN")) {   
                                        out.print("Der angegebene Benutzername oder das angegebene Passwort " + errStart + "ist falsch!" + errEnd );
                                    } else if (sMessage.equalsIgnoreCase("ERR_USER_EXISTS")) {
                                        out.print("Dieser Benutzername wurde bereits" + errStart + " von einem anderen Benutzer verwendet" + errEnd + ". Bitte nutzen Sie einen anderen Benutzername!");
                                    } else if (sMessage.equalsIgnoreCase("ERR_SIGN_UP")) {
                                        out.print("Während Ihrer Anfrage ist" + errStart + " ein Fehler aufgetreten " + errEnd + "und das Benutzerkonto wurde nicht in die Datenbank eingetragen!"); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_SEARCH")) {
                                        out.print("Während Ihrer Anfrage ist" + errStart + " ein Fehler aufgetreten!" + errEnd); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_NO_BOOKID")) {
                                        out.print("Das Buch mit diesem Titel, Autor und ISBN" + errStart + " existiert nicht!" + errEnd); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_NO_AUTHID")) {
                                        out.print("Das Buch von diesem Autor " + errStart + "existiert nicht!" + errEnd); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_ADD")) {
                                        out.print("Bei dem Hinzufügen des Buches ist " + errStart + "ein Fehler aufgetreten " + errEnd + "und deswegen wurde " + errStart + "das Buch in der Datenbank nicht eingetragen!" + errEnd); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_UPDATE")) {
                                        out.print("Bei der Speicherung die Seiteninformationen ist " + errStart + "ein Fehler aufgetreten!" + errEnd ); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_DELETE")) {
                                        out.print("Bei der Löschung des Buches" + errStart + " ist ein Fehler aufgetreten!" + errEnd);
                                    } else if (sMessage.equalsIgnoreCase("DEL_NO_BOOK")) {
                                        out.print("Das Buch befindet sich nicht in der Datenbank und " + errStart + "es konnte nicht gelöscht werden!" + errEnd);
                                    } else if (sMessage.equalsIgnoreCase("ERR_ADD_EXISTS")) {
                                        out.print("Das Buch mit dieser ISBN befindet sich bereits in der Datenbank und" + errStart + " deswegen konnte das Buch nicht in die Datenbank eingetragen werden!" + errEnd);  
                                    } else if (sMessage.equalsIgnoreCase("SUCC_ADD")) {
                                        out.print("Das Buch wurde erfolgreich in die Datenbank eingetragen!");       
                                    } else if (sMessage.equalsIgnoreCase("SUCC_UPDATE")) {
                                        out.print("Die eingegebene Informationen wurden erfolgreich verändert!");  
                                    } else if (sMessage.equalsIgnoreCase("SUCC_DELETE")) {
                                        out.print("Das Buch wurde erfolgreich gelöscht!");  
                                    } else if (sMessage.equalsIgnoreCase("SUCC_SIGN_UP")) {
                                        out.print("Der neue Benutzer wurde erfolgreich registriert. Vielen Dank für Ihre Registrierung!"); 
                                    } else if (sMessage.equalsIgnoreCase("SUCC_LOGOUT")) {
                                        out.print("Sie haben sich erfolgreich abgemeldet!");
                                    }
                                    
                                    // sSource - for setting the action attribute of the form tag
                                    if (sSource.equalsIgnoreCase("Neues Buch")) {
                                %>
                                        <form action="add_page.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Suchen")) {
                                %>
                                        <form action="search_page.jsp" method="post">  
                                <%
                                    } else if (sSource.equalsIgnoreCase("Buch Ändern")) {                            
                                %>
                                        <form action="update_prev.jsp" method="post"> 
                                <%
                                    } else if (sSource.equalsIgnoreCase("Buch Löschen")) { 
                                %>
                                        <form action="delete_title.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Anmelden")) {
                                %>
                                        <form action="login_page.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Ausmelden") || sSource.equalsIgnoreCase("Das Buch")) {
                                %>
                                        <form action="index.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Registrieren")) {
                                %>
                                        <form action="SignUp" method="post">
                                <%
                                    }
                                %>
                                <% if (sSource.equals("Ausmelden")) {
                                       sSource = "Lesen"; // the text on the button
                                   }
                                %>
                                        <br /><br /><br />
                                <% if (sSource.equalsIgnoreCase("Buch Ändern")) { 
                                %>
                                        <!-- btn-sm is used for smaller (narrower) size of the control -->
                                        <button type="submit" class="btn btn-info btn-sm">Buch ändern</button>
                                <% 
                                   } else if (sSource.equalsIgnoreCase("Buch Löschen")) {
                                %>
                                        <!-- adding the To button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                        <button type="submit" class="btn btn-info btn-sm">Buch löschen</button>
                                <% 
                                   } else if (sSource.equalsIgnoreCase("Das Buch")) {
                                %>
                                        <!-- adding the To button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                        <button type="submit" class="btn btn-info btn-sm">Lesen</button>
                                <%
                                   } else {
                                %>
                                        <!-- adding the To button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                        <button type="submit" class="btn btn-info btn-sm"> <%= sSource %></button>
                                <% }
                                %>
                                        </form>
                                
                            </div> <!-- end of class = "col" -->
                        </div> <!-- end of class = "row" --> 
                    </div> <!-- end of class = "container" -->
                </div> <!-- end of class = "col-lg-5 col-md-5" -->
            </div> <!-- end of class = "row" -->
        </div> <!-- end of class = "whitebckgr" -->
            
        <!-- adding a new row to the Bootstrap grid; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
        <!-- including the file footer.jsp into this file -->
        <!-- footer.jsp contains the footer of the web page --> 
        <%@ include file="footer.jsp"%> 
    </body>
</html>
