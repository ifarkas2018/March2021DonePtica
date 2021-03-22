<%-- 
    Document   : footer
    Created on : 02-Sep-2018, 01:51:27
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<!-- footer.jsp builds the footer of the web page --> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.LesenMethoden"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="javascript/validationJS.js"></script>
        
        <script>
            
            // isEmail: returns true if the email address is valid (otherwise it returns false)
            function isEmail(email) {
                // regex pattern is used for validating email 
                var regex = /^([a-zA-ZäÄöÖüÜß0-9_\.\-\+])+\@(([a-zA-ZäÄöÖüÜß0-9\-])+\.)+([a-zA-ZäÄöÖüÜß0-9]{2,4})+$/;
                if(!regex.test(email)) {
                    return false;
                } else {
                    return true;
                }
            }

            // createCookie: creates a cookie named valid_email with value that was entered as an email 
            function createCookie() {
                var email = document.getElementById("subscr_email").value;
                var cookie_str = "valid_email=";
                // if the email is valid the value is true
                if (isEmail(email)) {
                   cookie_str += "true;";
                } else {
                    cookie_str += "false;"; 
                }
                document.cookie = cookie_str; // creating a cookie named valid_email
            }
        </script>
    </head>
    <body> 
        <%
            boolean is_attr_found;
            String isErrPage = "false"; // did an error occur
            HttpSession hSess = LesenMethoden.returnSession(request);
            // is the error page shown 
            is_attr_found = LesenMethoden.sessVarExists(hSess, "is_error"); // sessVarExists: returns whether the session var. is_error exists in the session
            if (is_attr_found) { // if the attribute named is_error was found
                isErrPage = String.valueOf(hSess.getAttribute("is_error"));
            }
        %>
        
        <footer>
            <!-- footer is a class (in templatecss.css) defining the style of this div element -->
            <div class="footer" align="center" id="footer">
                <div class="container"> 
                    <div class="row"> 
                        <!-- the Bootstrap column takes 2 columns on the large screen, 2 columns on the medium sized screens,
                             4 columns on the small sized screens, 6 columns on the extra small screens -->
                        <div  class="col-lg-2  col-md-2 col-sm-4 col-xs-6">
                            &nbsp; &nbsp; <!-- adding some empty space -->
                        </div>
                        <!-- the Bootstrap column takes 2 columns on the large screen, 2 columns on the medium sized screens,
                             4 columns on the small sized screens, 6 columns on the extra small screens -->
                        <div class="col-lg-2  col-md-2 col-sm-4 col-xs-6">
                            <h3> Über Uns </h3> <!-- title of the column -->
                            <!-- smaller-text is a class used to declare the size of the text -->
                            <ul class="smaller-text" >
                                <li> <a href="AddSessVar" onclick = "cookieFillIn('about_page.jsp')"> Über Uns </a> </li>
                            </ul>
                        </div>
                        
                        <!-- the Bootstrap column takes 2 columns on the large screen, 2 columns on the medium sized screens -->
                        <div class="col-lg-2  col-md-2"> 
                            &nbsp; &nbsp; <!-- adding some empty space -->
                        </div>
    
                        <!-- the Bootstrap column takes 1 column on the large screens, 1 columns on the medium sized screens -->
                        <div class="col-lg-1  col-md-1"> 
                            &nbsp; &nbsp; 
                        </div>
    
                        <!-- the Bootstrap column takes 3 column on the large screens, 3 columns on the medium sized screens -->
                        <div class="col-lg-3  col-md-3"> 
                            <h3> Newsletter </h3> <!-- title of the column -->
                            <ul>
                                <li> 
                                    <div class="container"> 
                                        <!-- after clicking on the button the SubscrServl servlet is called -->
                                        <form action="SubscrServl" method="post"> 
                                            <div class="row"> <!-- adding a new row the grid -->
                                                <div class="col">
                                                    <%
                                                        if (isErrPage.equals("false")) { // an error didn't occur
                                                    %>
                                                            <!-- input element used for entering the email; form-control-sm is used for smaller size of the input element -->
                                                            <input class="form-control form-control-sm" name="subscr_email" id="subscr_email" id="subscr_email" type="text" placeholder="E-Mail" onfocusout='lengthLessMax("subscr_email", "email_msg")' required>
                                                            <span id="email_msg" class="text_size text-danger"></span>
                                                    <%
                                                        } else {
                                                    %>
                                                            <!-- input element used for entering the email; form-control-sm is used for smaller size of the input element -->
                                                            <input class="form-control form-control-sm" name="subscr_email" id="subscr_email" id="subscr_email" type="text" placeholder="E-Mail" required disabled>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                            
                                            <div class="row"> <!-- adding a new row the grid -->
                                                <div class="col">
                                                    &nbsp; &nbsp;
                                                </div>
                                            </div>
                                                   
                                            
                                            <div class="row"> <!-- adding a new row the grid -->
                                                <div class="col">
                                                    <%
                                                        if (isErrPage.equals("false")) { // an error didn't occur
                                                    %>
                                                         <!-- adding the button Subscribe, btn-info is used for defining the color of the button,
                                                             form-control-sm is used for smaller size of the button -->
                                                         <button type="submit" class="btn btn-info btn-sm" id="btnSubscr" onclick="createCookie()">Abonnieren</button>
                                                    <%
                                                        } else { // if an error occured then show the DISABLED button
                                                    %>
                                                         <button type="submit" class="btn btn-info btn-sm" id="btnSubscr" onclick="createCookie()" disabled>Abonnieren</button>
                                                    <%
                                                        } 
                                                    %>
                                                </div>
                                            </div>
                                        </form>
                                    </div> <!-- end of class="container" -->
                                </li>
                            </ul> 
                        </div> <!-- end of class="col-lg-3  col-md-3" -->
                    </div> <!-- end of class="row" -->
                    
                    <div class="row">
                        <!-- the Bootstrap column takes 12 columns on the large screens, 12 columns on the medium sized screens -->
                        <div class="col-lg-12 col-md-12">
                            &nbsp; &nbsp; <!-- adding some empty space -->
                        </div>
                    </div>
                </div> <!-- end of class="container" -->
            </div> <!-- end of class="footer" --> 
                    
            <div class="footer"> <!-- this is the bottom part of the footer -->
                <div class="container">
                    <div class="row">
                        <!-- the Bootstrap column takes 12 columns on the large screens, 12 columns on the medium sized screens, 
                             12 columns on the extra small sized screens  -->
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            &nbsp; &nbsp; <!-- adding some empty space -->
                        </div>
                    </div>
                    <div class="container text-center">
                        <!-- the Bootstrap column takes 12 columns on the large screens, 12 columns on the medium sized screens, 
                             12 columns on the extra small sized screens  -->
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <!-- adding the copyright information at the bottom of the footer -->
                            <div class="copyright smaller-text"> &copy; Copyright 2018 - Lesen GmbH - Bruckbauerstraße 25, 10115 Berlin</div>
                        </div>
                    </div>
                </div> <!-- end of the class="container" -->
            </div> <!-- end of class="footer" -->
        </footer> 
    </body>
</html>
