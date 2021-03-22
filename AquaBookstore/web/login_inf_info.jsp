<%-- 
    Document   : login_inf_info.jsp
    Created on : 06-Oct-2019, 20:16:17
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<%@page contentType = "text/html" pageEncoding = "UTF-8"%>
<%@page import = "miscellaneous.AquaMethods"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    
    <body>
        <%
            HttpSession hSession = AquaMethods.returnSession( request );
            hSession.setAttribute("webpg_name", "login_inf_page.jsp");
            // reseting the sess. var to the default: if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED 
            // to show the previous values 
            hSession.setAttribute("subscribe", "false"); 
        %>
        
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
                                <br/>
                                <span>
                                    <h3 class="text-info">Login</h3>
                                </span>
                                <br/>
                                <form id="login_inf" name="login_inf" action="login_page.jsp" method="post">
                                    Please use the following information to log in
                                    <br/> 
                                    <br/>
                                    <!-- showing administrator's username and password -->
                                    <span class="text-info">
                                        <font size="+1">Administrator</font>
                                    </span>
                                    <br />
                                    <ul>
                                        <li>username: admin</li>
                                        <li>password: admin</li>    
                                    </ul>

                                    <!-- showing employee's username and password -->
                                    <span class="text-info">
                                        <font size="+1">Employee</font>
                                    </span>
                                    <ul>
                                        <li>username: ifarkas</li>
                                        <li>password: Bird2018</li>    
                                    </ul>
                                    
                                    <ul>
                                        <li class="text-warning">username: @@@@@@@@@@@</li>
                                        <li class="text-warning">password: @@@@@@@@@@@@</li>    
                                    </ul>
                                    
                                    <ul>
                                        <li class="text-warning">username: @@@@@@@@@@@@</li>
                                        <li class="text-warning">password: @@@@@@@@@@@@</li>    
                                    </ul>
                                    
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- adding some empty space -->
                                            </div>
                                        </div>    
                                    </div>
                                    
                                    <!-- adding the Submit button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                    <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Login</button>
                                </form>
                            </div> <!-- end of class="col" -->
                        </div> <!-- end of class="row" --> 
                    </div> <!-- end of class="container" -->
                </div> <!-- end of class="col-lg-5 col-md-5" -->
            </div> <!-- end of class="row" -->
        </div> <!-- end of class="whitebckgr" -->
            
        <!-- adding a new row; class whitebckgr is for setting the background to white -->
        <div class = "whitebckgr">
            <div class = "col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>

