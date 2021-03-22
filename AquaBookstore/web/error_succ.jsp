<%-- 
    Document   : error_succ.jsp
    Created on : 19-Nov-2018, 02:31:59
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<!-- error_succ.jsp shows the error or the success message -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            HttpSession hSession = AquaMethods.returnSession(request);
            // the name of the page to return to if the user enters the email (subscribe) 
            hSession.setAttribute("webpg_name", "error_succ.jsp");
            // reseting the sess. var to the default: if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED 
            // to show the previous values 
            hSession.setAttribute("subscribe", "false");
            
            // title - the title passed from one web page to the other
            String sTitle = (String)hSession.getAttribute("title");
             
            String sSource = (String)hSession.getAttribute("source_name");
            // set the title of this web page depending on the task the user is doing
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
        %>    
        
        <!-- link to the external stylesheet -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
        <title>Aqua Books - <%= sTitle %></title>
        
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
                        <img src="images/books.png" class="img-fluid center-image" alt="picture of books" title="picture of books"> 
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
                                        out.print(errStart + "An error occurred" + errEnd + " while accessing the database!"); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_LOGIN")) {   
                                        out.print("The username or password " + errStart + "doesn't exist!" + errEnd );
                                    } else if (sMessage.equalsIgnoreCase("ERR_USER_EXISTS")) {
                                        out.print("The username entered " + errStart + "already exists and the user wasn't added" + errEnd + " to the database!");
                                    } else if (sMessage.equalsIgnoreCase("ERR_SIGN_UP")) {
                                        out.print(errStart + "An error occurred " + errEnd + "while adding the new user to the database and the user wasn't added!"); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_SEARCH")) {
                                        out.print(errStart + "An error occurred" + errEnd + " during the search!"); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_NO_BOOKID")) {
                                        out.print("The book with that title, author and isbn " + errStart + "doesn't exist!" + errEnd); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_NO_AUTHID")) {
                                        out.print("The book from that author " + errStart + "doesn't exist!" + errEnd); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_ADD")) {
                                        out.print(errStart + "An error occurred" + errEnd + " while adding the book to the database and the book wasn't successfully added to the database!"); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_UPDATE")) {
                                        out.print(errStart + "An error occurred" + errEnd + " while updating the book!"); 
                                    } else if (sMessage.equalsIgnoreCase("ERR_DELETE")) {
                                        out.print(errStart + "An error occurred" + errEnd + " while deleting the book!");
                                    } else if (sMessage.equalsIgnoreCase("DEL_NO_BOOK")) {
                                        out.print("The book doesn't exist and " + errStart + "it couldn't deleted!" + errEnd);
                                    } else if (sMessage.equalsIgnoreCase("ERR_ADD_EXISTS")) {
                                        out.print("The book with that ISBN already exists and " + errStart + "the book wasn't added to the database!" + errEnd);  
                                    } else if (sMessage.equalsIgnoreCase("SUCC_ADD")) {
                                        out.print("The book was successfully added to the database!");       
                                    } else if (sMessage.equalsIgnoreCase("SUCC_UPDATE")) {
                                        out.print("The book was successfully updated in the database!");  
                                    } else if (sMessage.equalsIgnoreCase("SUCC_DELETE")) {
                                        out.print("The book was successfully deleted from the database!");  
                                    } else if (sMessage.equalsIgnoreCase("SUCC_SIGN_UP")) {
                                        out.print("The new user was successfully added to the database!"); 
                                    } else if (sMessage.equalsIgnoreCase("SUCC_LOGOUT")) {
                                        out.print("You logged out successfully!");
                                    }
                                    
                                    // sSource - for setting the action attribute in the form tag 
                                    if (sSource.equalsIgnoreCase("Add Book")) {
                                %>
                                        <form action="add_page.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Search")) {
                                %>
                                        <form action="search_page.jsp" method="post">  
                                <%
                                    } else if (sSource.equalsIgnoreCase("Update Book")) {                            
                                %>
                                        <form action="update_prev.jsp" method="post"> 
                                <%
                                    } else if (sSource.equalsIgnoreCase("Delete Book")) { 
                                %>
                                        <form action="delete_title.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Login")) {
                                %>
                                        <form action="login_page.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Log Out")) {
                                %>
                                        <form action="index.jsp" method="post">
                                <%
                                    } else if (sSource.equalsIgnoreCase("Sign Up")) {
                                %>
                                        <form action="SignUp" method="post">
                                <%
                                    }
                                %>
                                <% if (sSource.equals("Log Out")) {
                                       sSource = "Aqua"; // the text on the button
                                   }
                                %>
                                    <br /><br /><br />
                                    <!-- btn-sm is used for smaller (narrower) size of the control -->
                                    <button type="submit" class="btn btn-info btn-sm"> <%= sSource %></button>
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
