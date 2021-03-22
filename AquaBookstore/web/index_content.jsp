<%-- 
    Document   : index_content
    Created on : 16-Apr-2019, 17:46:49
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.AquaMethods"%>
<%@page import="java.sql.Connection"%>
<%@page import="connection.ConnectionManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script  type="text/javascript">
            // createCookieIndex: creates a cookie named book_index with value index 
            function createCookieIndex(index) {
                var cookie_str = "book_index=";
                cookie_str += index + ";";
                document.cookie = cookie_str; // creating a cookie named book_index
            }
        
            // on the load show the modal (id: centeredModal)
            $(window).on('load',function(){
                $('#centeredModal').modal('show');
            });
        </script>
        
        <style>
            /* styles for browsers smaller than 350px; */
            /* doesn't show (or still shows) the text next to the picture based on the width of the browser */
            @media screen and (max-width: 350px) {
                span.pic_text {
                    display: none;
                }
            }
            
            /* styles for browsers smaller than 767px do not show the space left to the pictures in the left column */
            @media screen and (max-width: 767px) {
                div.book_L {
                    display: none;
                }
            }
             
            /* styles for mobile browsers larger than 350px; (iPhone) */
            /* doesn't show (or still shows) the text below the picture based on the width of the browser */
            @media screen and (min-width: 350px) {
                div.pic_text_below {
                    display: none;
                }
            }
                                   
        </style>
        <title>Aqua Books</title>
    </head>
    
    <body>    
        <%! String sTitle = "";
            String sAuthor = "";
            String sPrice = "";
            
            // retrieveBookInf: retrieves the title, author name, price of the book
            // when the user clicks on one of the links on the home page for the book with index index
            public static ResultSet retrieveBookInf(int index) throws SQLException {
                Connection con = ConnectionManager.getConnection(); //connecting to the database 
                Statement stmt = con.createStatement();
                                    
                String sQuery = "SELECT h.title, a.au_name, h.price from homepg_books h, author a where a.au_id = h.au_id and book_id='" + index + "';";
                                    
                // execute the query - the result will be in the rs
                ResultSet rs = stmt.executeQuery(sQuery);
                return rs;
            }

            // bookInformation: reads from the result set the title, author name, price, ISBN and book description
            private void bookInformation(ResultSet rs) throws SQLException {
                sTitle = "";
                sAuthor = "";
                sPrice = "";
                
                try {
                    if (rs.next()) {
                        // read the title 
                        sTitle = rs.getString("title");
                        // read the name of the author
                        sAuthor = rs.getString("au_name");
                        // read the price
                        sPrice = rs.getString("price");
                        sPrice = AquaMethods.addComma(sPrice); // adding the comma after 1000 pounds
                    }
                } catch ( SQLException ex ) {
                    System.out.println("An exception occured: " + ex.getMessage());
                }
            }
        %>  
        <%
            HttpSession hSession2 = AquaMethods.returnSession(request);
            hSession2.setAttribute("webpg_name", "index.jsp");
            // reseting the sess. var to the default: if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED 
            // to show the previous values 
            hSession2.setAttribute("subscribe", "false"); 
            hSession2.setAttribute("is_error", "false"); // there is no error
        %>
        <!-- adding a new row to the Bootstrap grid; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr minwidth">
            <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                <!-- the Bootstrap column takes 6 columns on the large desktops and 6 columns on the medium sized desktops -->
                <div class="col-lg-6 col-md-6"> 
                    <div class="container"> <!-- adding the container to the Bootstrap grid -->
                        <br />
                     
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(1);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp; 
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT ( in the img tag ) to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_1.jpg" class="img-fluid  float-left pull-left mr-2" onclick="createCookieIndex(1)" alt="picture of a book" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {    
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                        </div> 
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(2);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp;
                            </div>
                            
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT (in the img tag) to the title of the book -->
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/bk_2.jpg" class="img-fluid  float-left pull-left mr-2" onclick="createCookieIndex(2)" alt="picture of a book" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                        </div> 
                            
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>

                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(3);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp;
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT (in the img tag) to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_3.jpg" class="img-fluid  float-left pull-left mr-2" onclick="createCookieIndex(3)" alt="picture of a book" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                        </div> 
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(4);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp;
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT ( in the img tag ) to the title of the book -->
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_4.jpg" class="img-fluid  float-left pull-left mr-2" onclick="createCookieIndex(4)" alt="picture of a book" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                        </div> 
                            
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(5);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp;
                            </div>
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT ( in the img tag ) to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_5.jpg" class="img-fluid  float-left pull-left mr-2" onclick="createCookieIndex(5)" alt="picture of a book" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                        </div> 
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>
                    </div>
                </div>
                
                <!-- the Bootstrap column takes 5 columns on the large desktops and 5 columns on the medium sized desktops -->
                <div class="col-lg-6 col-md-6"> 
                    <div class="container"> <!-- adding the container to the Bootstrap grid -->
                        <br/>
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(6);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT ( in the img tag ) to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_6.jpg" class="img-fluid  float-left pull-left mr-2" onclick="createCookieIndex(6)" alt="picture of a book" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle %></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp; 
                            </div>
                        </div>            
                        
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>
                            
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(7);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT (in the img tag) to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_7.jpg" class="img-fluid  float-left pull-left mr-2" alt="picture of a book" onclick="createCookieIndex(7)" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% }
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp; 
                            </div>
                        </div> 
                       
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% }
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% }
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %> 
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(8);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_8.jpg" class="img-fluid  float-left pull-left mr-2" alt="picture of a book" onclick="createCookieIndex(8)" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp; 
                            </div>
                        </div> 
                            
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>    
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(9);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_9.jpg" class="img-fluid  float-left pull-left mr-2" alt="picture of a book" onclick="createCookieIndex(9)" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% } 
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp; 
                            </div>
                        </div>  
                        
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) { 
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% }
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        <%
                            try {    
                                // retrieve the book information and store it in result set rs
                                ResultSet rs = retrieveBookInf(10);
                                // assign title, author name, price, isbn and description to the variables
                                bookInformation(rs);
                            } catch (SQLException e) {
                                System.out.println("An exception occured: " + e.getMessage());
                            }
                        %>
                        &nbsp;
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-11 col-md-11 col-sm-11">
                                <!-- @@@@@@@@@@@ DO IT -- change the TITLE and ALT ( in the img tag ) to the title of the book -->
                                
                                <!-- pull-left mr-2 is used for spacing between the image and the text -->
                                <a href="ShowBook"><img src="images/book_10.jpg" class="img-fluid  float-left pull-left mr-2" alt="picture of a book" onclick="createCookieIndex(10)" title="picture of a book"></a>
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <span class="pic_text"><%= sAuthor%></span><br/>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text"><b><%= sTitle%></b></span><br/>
                                <% }
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <span class="pic_text">&pound;<%= sPrice %></span><br/>
                                <% } %>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-1 book_L">
                                &nbsp; 
                            </div>
                        </div>
                            
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <% if (!sAuthor.equalsIgnoreCase("")) { %>
                                    <div class="pic_text_below"><%= sAuthor%></div>
                                <% } 
                                   if (!sTitle.equalsIgnoreCase("")) {
                                %>
                                    <div class="pic_text_below"><b><%= sTitle%></b></div>
                                <% }
                                   if (!sPrice.equalsIgnoreCase("")) {
                                %>
                                    <div class="pic_text_below">&pound;<%= sPrice %></div>
                                <% } %>
                            </div>
                        </div>
                        <br/>
                        
                        
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
        
        <%
            // if the emp_adm session attribute exists retrieve it
            if (AquaMethods.sessVarExists( hSession2, "emp_adm")) {
                String empadmS = (String)(hSession2.getAttribute("emp_adm"));
                Boolean emp = Boolean.valueOf(empadmS); 
                if (emp != true) { // show the modal if the user is loading the web site for the regular user
        %>
                    <!-- bootstrap modal -->
                    <div class="modal fade" id="centeredModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalCenterTitle">Aqua Bookstore</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    ********************/AquaBookstore/Aqua is the web site for employees and administrators
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </body>
</html>