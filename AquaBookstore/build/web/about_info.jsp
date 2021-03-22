<%-- 
    Document   : about_info
    Created on : 12-May-2019, 05:30:48
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
            HttpSession hSession = AquaMethods.returnSession(request);
            hSession.setAttribute("webpg_name", "about_page.jsp");
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
                                <span class="text-info">
                                    <h3>About Us</h3>
                                </span>
                                <br/>
                                <p> 
                                    Located in the city centre Aqua Books offers a very warm and friendly atmosphere for the book lovers to
                                    meet, browse, enjoy a cup of tea or some other beverage and to enjoy the books. 
                                </p>
                                <p>
                                    Opened in 2010 by James Bishop, the bookstore has a very wide variety of books including Fiction &amp; Poetry, 
                                    Business, Education, Computing &amp; IT, Children's, ...
                                </p>
                                <p>
                                    It is a lovely place where in their free time many people like to meet to explore the books and to share their ideas and thoughts. 
                                    Our friendly staff is always there to answer your questions and to find the books that interest you.
                                </p>
                                <p> 
                                    If you don't have time to visit us in person please check out our web site, browse the books of our wide selection 
                                    of books, order online or by the phone. 
                                </p>
                                <p>
                                    If you are able to visit us please come and enjoy the store which is very unique and 
                                    which is a very nice place to find the books you need and which you don't need but would like to read.
                                </p>
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

