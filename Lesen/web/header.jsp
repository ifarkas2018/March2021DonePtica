<%-- 
    Document   : header
    Created on : 29-Mar-2019, 22:46:27
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="miscellaneous.LesenMethoden"%>


<!-- author: Ingrid Farkas -->
<!-- header.jsp creates - company logo, company name and the navigation bar -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%  final String URL_EMP_ADM = "Lesen/Mitarbeiter"; // the URL for employees and administrators
    final String URL_CUST = "Lesen"; // the URL for customers
%>

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

            <div class="whitebckgr"> <!-- new row - white background -->
                <div class="col">
                    &nbsp; &nbsp; <!-- adding some empty space -->
                </div>
            </div>
            
            <%
                String emp_adm = ""; // is the user using the website for employees and administrators (and not for customers) 
                String logged_in = ""; // is the user logged in
                String userType = ""; // type of the user: admin, emp, customer (the possible values)
                String attrName = ""; // variable name in the session
                boolean attr_found = false; // is the emp_adm one of variables in the session
                String errPage = "false"; // is the error page shown
                
                HttpSession hSession1 = LesenMethoden.returnSession(request);
                
                // sessVarExists: returns whether the session var. user_type exists in the session
                // user_type: admin, emp, customer (the possible values) (exists after the user tried to log in)
                attr_found = LesenMethoden.sessVarExists(hSession1, "user_type"); 
                if (attr_found) // if the attribute named user_type was found
                    userType = String.valueOf(hSession1.getAttribute("user_type")); // admin, emp, customer (the possible values)
                
                String URL_String = (request.getRequestURL()).toString(); // the URL of the website loaded before this one
                
                // is the error page shown 
                attr_found = LesenMethoden.sessVarExists(hSession1, "is_error"); // sessVarExists: returns whether the session var. is_error exists in the session
                if (attr_found) { // if the attribute named is_error was found
                    errPage = String.valueOf(hSession1.getAttribute("is_error"));
                }
                
                // is the user using the website for employees and administrators (and not for customers) 
                attr_found = LesenMethoden.sessVarExists(hSession1, "emp_adm"); // sessVarExists: returns whether the session var. emp_adm exists in the session
                if (attr_found) // if the attribute named emp_adm was found
                    emp_adm = String.valueOf(hSession1.getAttribute("emp_adm")); // read the value of  the attribute
                
                if (emp_adm.equals("")) { // if the attribute named emp_adm was not found
                    if (URL_String.contains(URL_EMP_ADM)) { // if the user is using the website for employees or administrators
                        emp_adm = "true";
                        hSession1.setAttribute("emp_adm1", emp_adm); // add the attribute to the session (value : true)                        
                    } else if (URL_String.contains(URL_CUST)) { // if the user is using the website for customers 
                        emp_adm = "false";
                        hSession1.setAttribute("emp_adm", emp_adm); // add the attribute to the session ( value : false )
                    }
                }
                
                // sessVarExists: returns whether the session var. logged_in exists in the session
                // logged_in is TRUE if the user is logged in (as employee or as administrator) 
                attr_found = LesenMethoden.sessVarExists(hSession1, "logged_in"); 
                if (attr_found) // if the attribute named logged_in was found
                    logged_in = String.valueOf(hSession1.getAttribute("logged_in")); // read the value of  the attribute
            %>
            
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
                                <%
                                    // do not show the Search on the error page
                                    if ((!(userType.equals("admin"))) && (!(userType.equals("emp"))) && (errPage.equals("false"))) {
                                %>
                                        <!-- Search link on the navbar -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="AddSessVar" onclick="cookieFillIn('search_page.jsp')">Suchen</a>
                                        </li>
                                <%
                                    }
                                %>
                                
                                <%
                                    if (((userType.equals("admin")) || (userType.equals("emp"))) && (errPage.equals("false"))) {
                                %>
                                        <!-- Books link on the navbar -->
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Bücher
                                            </a>
                                            <!-- the dropdown submenu -->
                                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                                <a class="dropdown-item" href="AddSessVar" onclick="cookieFillIn('index.jsp')">Buch - Bestseller</a> <!-- Buch-Bestseller link on the submenu -->
                                                <a class="dropdown-item" href="AddSessVar" onclick="cookieFillIn('search_page.jsp')">Buch suchen</a> <!-- Search Book link on the submenu --> 
                                                <div class="dropdown-divider"></div> <!-- the divider on the drop down menu -->
                                                <a class="dropdown-item" href="AddSessVar" onclick="cookieFillIn('add_page.jsp')">Neues Buch</a> <!-- Add Book link on the submenu --> 
                                                <a class="dropdown-item" href="AddSessVar" onclick="cookieFillIn('update_prev.jsp')">Buch ändern</a> <!-- Update Book link on the submenu --> 
                                                <a class="dropdown-item" href="AddSessVar" onclick="cookieFillIn('delete_title.jsp')">Buch löschen</a> <!-- Delete Book link on the submenu --> 
                                            </div>
                                        </li>
                                <%
                                    }
                                %>
                                <!-- About link on the navbar -->
                                <li class="nav-item">
                                    <a class="nav-link" href="AddSessVar" onclick="cookieFillIn('about_page.jsp')">Über Uns</a>
                                </li>
                                <!-- Contact link on the navbar -->
                                <li class="nav-item">
                                    <a class="nav-link" href="AddSessVar" onclick="cookieFillIn('contact_page.jsp')">Kontakt</a>
                                </li>
                            </ul>
                                                            
                            <!-- ml-auto : this part of the links on the navabar is on the RIGHT hand side -->
                            <ul class="navbar-nav ml-auto">
                                <%
                                    if ((userType.equals("admin")) && (errPage.equals("false"))) {
                                %>    
                                        <!-- Sign Up link on the navbar -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="AddSessVar" onclick="cookieFillIn('SignUp')">Registrieren</a>
                                        </li>
                                <% 
                                    }
                                %>
                                
                                <%
                                    // if the user is logged in show the Log Out link
                                    if ((logged_in.equals("true")) && (errPage.equals("false"))) {
                                %>    
                                        <!-- link on the navbar -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="LogOutServlet">Ausmelden</a>
                                        </li>                               
                                <%
                                    // if the user is logged in as administrator("admin") or employee("emp") or the user accessed the website for 
                                    // employees or administrators
                                    } else if (((userType.equals("admin")) || (userType.equals("emp")) || (emp_adm.equals("true"))) && (errPage.equals("false"))) {
                                %>    
                                        <!-- Login link on the navbar -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="AddSessVar" onclick="cookieFillIn('login_inf_page.jsp')">Anmelden</a>
                                        </li>
                                <%
                                    }
                                %>
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