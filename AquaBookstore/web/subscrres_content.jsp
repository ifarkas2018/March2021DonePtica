<%-- 
    Document   : subscrres_content
    Created on : 16-Apr-2019, 16:28:06
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.AquaMethods"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aqua Books - Subscription</title>
        
        <script>
            function setFillIn() {
                document.cookie = "fill_in=true;"; // should the user return to the form he was on before subscribing the fill_in should be true
            }
        </script>
    </head>
    
    <body onload="setFillIn()">
        <!-- adding a new row to the Bootstrap grid; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                <!-- the Bootstrap column takes 6 columns on the large desktops and 6 columns on the medium sized desktops -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="picture of books" title="picture of books"> 
                    </div>
                </div>
                
                <!-- the Bootstrap column takes 5 columns on the large desktops and 5 columns on the medium sized desktops -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- adding the container to the Bootstrap grid -->
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br /><br /><br /><br /><br />
                                <h3 class="text-info">Subscribe</h3>
                                <br /><br /> 
                                <%  HttpSession hSession = AquaMethods.returnSession(request);
                                    hSession.setAttribute("subscribe", "true");
                                    String validEmail = String.valueOf(hSession.getAttribute("valid_email"));
                                    String exOccurred = "false"; // whether an exception occured 
                                    String page_name = "";
                                    if (page_name.equalsIgnoreCase("")) // if page_name wasn't set above read it from webpg_name
                                        page_name = String.valueOf(hSession.getAttribute("webpg_name")); // name of the page where the user was before clicking on the Subscribe button
                                    exOccurred = String.valueOf(hSession.getAttribute("db_exoccurred"));
                                    
                                    if (validEmail.equalsIgnoreCase("false"))
                                        out.print("<span class=\"text-warning\">You entered an invalid email address!</span>");
                                    else if (exOccurred.equalsIgnoreCase("exists"))
                                        out.print("<span class=\"text-warning\">The email you entered already exists in the database!</span>");
                                    else if (exOccurred.equalsIgnoreCase("true"))
                                        out.print("<span class=\"text-warning\">An error occurred while accessing the database!</span>"); 
                                    else {
                                        out.print("Your email was added successfully to the database.<br />Thank you for subscribing to our newsletter!");
                                    } 

                                    if ((page_name.equalsIgnoreCase("null")) || (page_name.equalsIgnoreCase("")) || (page_name == null)) 
                                        page_name = "index.jsp";
                                %>
                                
                                <!-- after clicking on the button the web page is loaded where the user was before clicking on the Subscribe button -->
                                <form action=<%= page_name %> method="post" > 
                                    <br /><br /><br />
                                    <!-- adding the button Subscribe, btn-info is used for defining the color of the button,
                                         form-control-sm is used for smaller size of the button -->
                                    <button type="submit" class="btn btn-info btn-sm" id="btnClose">Close</button>
                                </form>    
                            </div> <!-- end of class="col" -->
                            
                        </div> <!-- end of class="row" --> 
                    </div> <!-- end of class="container" -->
                </div> <!-- end of class="col-lg-5 col-md-5" -->
            </div> <!-- end of class="row" -->
        </div> <!-- end of class="whitebckgr" -->
            
        <!-- adding a new row; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>