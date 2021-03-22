<%-- 
    Document   : contact_info
    Created on : 10-Apr-2019, 19:49:41
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.LesenMethoden"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/templatecss.css">
        <title>Lesen - Kontakt</title>
      
        <!-- internal style sheet -->
        <style>
      
            /* color of the email link after the link was clicked on */
            .email a:visited {
                color: rgb(180, 187, 184) !important;  /* lighter grey */ 
            } 
            
            /* color of the email link when the user hovers on it */
            .email a:hover, a:active {
                color: #7F8C8D !important;    
            } 
            
            /* color of the email link */ 
            .email a {
                color: #17A2B8 !important;  
            }
      
        </style>
        
    </head>
        <%
            HttpSession hSession = LesenMethoden.returnSession(request);
            hSession.setAttribute("webpg_name", "contact_page.jsp");
            // reseting the sess. var to the default: if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED 
            // to show the previous values 
            hSession.setAttribute("subscribe", "false"); 
        %>
            <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                <!-- the Bootstrap column takes 6 columns on the large desktops and 6 columns on the medium sized desktops -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="Foto mit Büchern" title="Foto mit Büchern"> 
                    </div>
                </div>
                
                <!-- the Bootstrap column takes 5 columns on the large desktops and 5 columns on the medium sized desktops -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- adding the container to the Bootstrap grid -->
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br />
                                <h3  class="text-info">Kontakt</h3>
                                <br/>
                                <!-- information about the store - London -->
                                <span class="text-warning">
                                    <font size="+2">Berlin</font>
                                </span>
                                <br />
                                Bruckbauerstraße 25, 10115 Berlin<br/>
                                E-Mail: 
                                <span class="email">
                                    <a href="mailto:lesen.berlin@lesen.de?">lesen.berlin@lesen.de</a>
                                </span>
                                <br />
                                <br />
                                <!-- opening hours (in a table) -->
                                <table class="table table-bordered table-sm">
                                    <thead>
                                        <tr class="table-active">
                                          <th scope="col" colspan="2">Öffnungszeiten</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="table-light">
                                          <th scope="row">Montag - Freitag</th>
                                          <td>10:00 - 21:30</td>
                                        </tr>
                                        <tr class="table-light">
                                          <th scope="row">Samstag</th>
                                          <td>10:00 - 21:00</td>
                                        </tr>
                                        <tr class="table-light"> 
                                          <th scope="row">Sonntag</th>
                                          <td>10:00 - 18:00</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <br />
                                <!-- information about the store - Norwich -->
                                <span class="text-warning">
                                    <font size="+2">Hamburg</font><br />
                                </span>
                                Ottostraße 78, 20251 Hamburg <br />   
                                E-Mail: 
                                <span class="email">
                                    <a href="mailto:lesen.hamburg@lesen.de?">lesen.hamburg@lesen.de</a>
                                </span>
                                    
                                <br />
                                <br />
                                
                                <!-- opening hours (in a table) -->
                                <table class="table table-bordered table-sm">
                                    <thead >
                                        <tr class="table-active">
                                            <th scope="col" colspan="2">Öffnungszeiten</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="table-light">
                                            <th scope="row">Montag - Freitag</th>
                                            <td>7:00 - 21:30</td>
                                        </tr>
                                        <tr class="table-light">
                                            <th scope="row">Samstag</th>
                                            <td>9:00 - 17:00</td>
                                        </tr>
                                        <tr class="table-light">
                                            <th scope="row">Sonntag</th>
                                            <td>9:00 - 17:00</td>
                                        </tr>
                                    </tbody>
                                 </table>
                            </div> <!-- end of class = "col" -->
                        </div> <!-- end of class = "row" --> 
                    </div> <!-- end of class = "container" -->
                </div> <!-- end of class = "col-lg-5 col-md-5" -->
            </div> <!-- end of class = "row" -->
        </div> <!-- end of class = "whitebckgr" -->
            
        <!-- adding a new row; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>