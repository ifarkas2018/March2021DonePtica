<%-- 
    Document   : err_header.jsp
    Created on : 16-Feb-2020, 14:54:11
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="miscellaneous.LesenMethoden"%>

<!-- err_header.jsp creates - company logo, company name and the navigation bar -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>           
        <!-- meta elements -->
        <!-- character set used on the web page -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- specifying the keywords used for Internet search --> 
        <meta name="keywords" content="Lesen, Bookstore in London, Online Bookstore">
        <!-- meta tag used for specifying the description and the purpose of the web site -->
        <meta name="description" content="Browse and Shop From the Wide Selection of Books">
        <meta name="author" content="Ingrid Farkas"> 
        <!-- used for making responsive web pages on devices with different screen sizes -->
        <meta name="viewport" content="width=device-width, initial-scale=1"> 

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        
        <!-- a link to the Bootstrap CDN -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> 
        <link rel="stylesheet" href="css/templatecss.css">
        
        <script>
            // setCookie: creates 2 cookies 
            // 1. cookie : fill_in = false 
            // 2. cookie : webpg_name = webPageVal
            function cookieFillIn( webPageVal ) {                
                document.cookie = "fill_in=false;"; // creating a cookie
                document.cookie = "webpg_name=" + webPageVal;
            }
        </script>
    </head>

    <body class="greybckgr"> <!-- greybckgr - class which defines grey background (templatecss.css) -->
        <div class="container">
            <div class="whitebckgr"> <!-- new row - white background -->
            <div class="whitebckgr"> 
                <!-- the Bootstrap column takes 12 columns on the large screens, 12 columns on the medium sized screens,
                     12 columns on the small sized screens, 12 columns on the extra small screens -->
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <p>&nbsp; &nbsp;</p> <!-- adding some empty space -->
                </div>
              
                <div class="row"> <!-- adding a new row to the grid -->
                    <!-- the Bootstrap column takes 5 columns on the large screens, 5 columns on the medium sized screens -->
                    <div class="col-lg-5 col-md-5"> 
                        &nbsp; &nbsp; <!-- adding some empty space -->
                    </div>
                    <!-- the Bootstrap column takes 4 columns on the large screens, 4 columns on the medium sized screens -->
                    <div class="col-lg-4 col-md-4"> 
                        &nbsp;  
                        <!-- image that is the logo of the Lesen; alt - the text that is shown if the image can't be loaded (alternate text)
                             title - the text that is shown when the user points at the image -->
                        <img class="img-logo" src="images/bookshelf.png" alt="Lesen Logo" title="Lesen Logo">  
                                    
                        <span class="title-text">Lesen</span> <!-- the title of the bookstore -->
                    </div>
                    
                    <!-- the Bootstrap column takes 7 columns on the large screens, 7 columns on the medium sized screens,
                         12 columns on the small screens, 12 columns on the extra small sized screens -->
                    <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 "> 
                        &nbsp; &nbsp; <!-- adding some empty space -->
                    </div>
                </div> 
            </div>          
                
            <% 
                 HttpSession hSession1 = LesenMethoden.returnSession(request);
                 hSession1.setAttribute("is_error", "true"); // used in About Us, Contact so that the Search is not shown(navigation)            
            %>
            
            <div class="whitebckgr"> <!-- new row - white background -->
                <div class="col">
                    &nbsp; &nbsp; <!-- adding some empty space -->
                </div>
            </div>
            
            <div class="row">
            <!-- the Bootstrap column takes 12 columns on the large screens, 12 columns on the medium sized screens,
                12 columns on the small screens, 12 columns on the extra small sized screens -->
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"> 
                    <!-- navigation bar -->
                    <!-- navbar-expand-md : the navbar collapses at medium breakpoint -->
                    <nav class="navbar navbar-expand-md navbar-light bg-light">
                        <a class="navbar-brand"><img src="images/bookshelf.png"></a> <!-- company logo -->
                        <a class="navbar-brand" href="AddSessVar" onclick = "cookieFillIn('index.jsp')">Lesen</a> <!-- name of the company -->
                        <!-- the toggler icon used to toggle the navigation -->
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-    
                            expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <!-- mr-auto : this part of the links on the navabar is on the LEFT hand side -->
                            <ul class="navbar-nav mr-auto">
                                <!-- About link on the navbar -->
                                <li class="nav-item">
                                    <a class="nav-link" href="AddSessVar" onclick="cookieFillIn('about_page.jsp')">Über Uns</a>
                                </li>
                                <!-- Contact link on the navbar -->
                                <li class="nav-item">
                                    <a class="nav-link" href="AddSessVar" onclick="cookieFillIn('contact_page.jsp')">Kontakt</a>
                                </li>
                            </ul>
                                                            
                        </div>
                    </nav>
                </div> <!-- class="col-lg-12 col-md-12 col-sm-12 col-xs-12 -->
            </div> <!-- end of class="row" --> 
        
            <div class="whitebckgr">
                <div class="col-lg-12 col-md-12">
                    &nbsp; &nbsp; <!-- adding some empty space -->
                </div>
            </div>