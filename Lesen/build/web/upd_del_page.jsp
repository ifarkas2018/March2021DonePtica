<%-- 
    Document   : upd_del_page
    Created on : 12-March-2019, 16:15:01
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="connection.ConnectionManager"%>
<%@ page import="miscellaneous.LesenMethoden"%>

<!-- update_page.jsp - when the user clicks on the Next button on the page upd_del_title.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <%
            HttpSession hSession = LesenMethoden.returnSession(request);    
            String source1 = (String)hSession.getAttribute("source_name"); // on which page I am now
        %>
        
        <title>Lesen - <%= source1 %></title>
        <!-- link to the external style sheet -->
        <link href="css/templatecss.css" rel="stylesheet" type="text/css">
    </head>

    <body>
        <%
            String fillIn = "false"; // whether some of the session variables have values of the fields in the form update_form.jsp
            String rs_query = ""; 
            String prev_title = "";
            String prev_auth = "";
            String prev_isbn = "";
            ResultSet rs; // object where the query's results are stored
            
            try {
                
                Connection con = ConnectionManager.getConnection(); //connecting to the database 
                Statement stmt = con.createStatement();

                // if the session variable fill_in exists then retrieve it
                if (LesenMethoden.sessVarExists(hSession, "fill_in")) {
                    fillIn = String.valueOf(hSession.getAttribute("fill_in"));
                } 
                
                // if the user didn't just before load this page and entered the email (the subscribe) then he just before loaded the 
                // upd_del_title.jsp with the title, author, isbn (otherwise he entered the email address and not the title, author, 
                // isbn) read those
                if (fillIn.equalsIgnoreCase("false")) { 
                    prev_title = request.getParameter("prev_title"); // the text entered as the title
                    prev_title = LesenMethoden.decoder(prev_title); // decoding because of äÄöÖüÜß
                    // if the lengh of the prev_title is longer then the size of the column title (the table book)
                    if (prev_title.length() > LesenMethoden.TITLE_LEN) {  
                        prev_title = prev_title.substring(0, LesenMethoden.TITLE_LEN); // in the DB is written only first TITLE_LEN characters
                    }
                    
                    prev_auth = request.getParameter("prev_author"); // the text entered as the author
                    prev_auth = LesenMethoden.decoder(prev_auth); // decoding because of äÄöÖüÜß
                    // if the lengh of the prev_auth is longer then the size of the column au_name (the table author)
                    if (prev_auth.length() > LesenMethoden.AUTHOR_LEN) {  
                        prev_auth = prev_auth.substring(0, LesenMethoden.AUTHOR_LEN); // in the DB is written only first AUTHOR_LEN characters
                    }
                    
                    prev_isbn = request.getParameter("prev_isbn"); // the text entered as the isbn
                    // if the lengh of the prev_isbn is longer then the size of the column isbn (the table book)
                    if (prev_isbn.length() > LesenMethoden.ISBN_LEN) {  
                        prev_isbn = prev_isbn.substring(0, LesenMethoden.ISBN_LEN); // in the DB is written only first ISBN_LEN characters
                    }
                    
                    // deleteSpaces: removes space characters from the begining and end of the string, and replaces 2 or more white spaces with single space
                    // inside of the string
                    prev_title = LesenMethoden.deleteSpaces(prev_title);
                    prev_auth = LesenMethoden.deleteSpaces(prev_auth);
                    prev_isbn = LesenMethoden.deleteSpaces(prev_isbn);
                    
                    // addBacksl replaces every occurence of \ with \\\\ and replaces every occurence of ' with \\'
                    prev_title = LesenMethoden.addBacksl(prev_title);
                    prev_auth = LesenMethoden.addBacksl(prev_auth);
                    
                    // add to the session prev_title, prev_auth, prev_isbn
                    hSession.setAttribute("prev_title", prev_title); // the PREVIOUS title of the book
                    hSession.setAttribute("prev_auth", prev_auth); // the previous author
                    hSession.setAttribute("prev_isbn", prev_isbn); // the previous isbn
                } else {
                    // if fillIn is true that means the user loaded this page before (the session variables were set), 
                    // after that he entered the email address (subscription). Now I have to retrieve the session variables  
                    prev_title = String.valueOf(hSession.getAttribute("prev_title")); // the PREVIOUS title of the book
                    prev_auth = String.valueOf(hSession.getAttribute("prev_auth")); // read the author 
                    prev_isbn = String.valueOf(hSession.getAttribute("prev_isbn")); // read the isbn
                }
                
                String bookid = ""; // book id

                // finding the book_id for title prev_title, author prev_auth, isbn prev_isbn
                // creating the query string : 
                // SELECT b.book_id,
                // FROM book b, author a
                // WHERE b.au_id = a.au_id AND b.isbn = 'prev_isbn' AND b.title = 'prev_title' AND a.au_name = 'prev_auth';
                rs_query = "SELECT b.book_id FROM book b, author a WHERE b.au_id = a.au_id";
                
                // add the author to the query string
                if ((!((prev_auth.equalsIgnoreCase("")))) && (!((prev_auth.equalsIgnoreCase("null")))) && (prev_auth != null)) {
                    rs_query += " AND LOWER(a.au_name) = "; 
                    rs_query += "'" + prev_auth.toLowerCase() + "'";
                }
                
                // add the title to the query string
                if ((!((prev_title.equalsIgnoreCase("")))) && (!((prev_title.equalsIgnoreCase("null")))) && (prev_title != null)) {
                    rs_query +=" AND LOWER(b.title) = ";
                    rs_query += "'" + prev_title.toLowerCase() + "'";
                }
                
                // add the isbn to the query string
                if ((!((prev_isbn.equalsIgnoreCase("")))) && (!((prev_isbn.equalsIgnoreCase("null")))) && (prev_isbn != null)) {
                    rs_query += " AND b.isbn ='" + prev_isbn + "'";
                }
                
                rs_query += ";";
                rs = stmt.executeQuery(rs_query);
                
                // if the result of the query has at least one row
                if (rs.next()) {
                    // find the book_id for the entered title, author and/or ISBN
                    bookid = rs.getString("book_id");
                    hSession.setAttribute("bookid", bookid); // store the book id in the session var. bookid
                } else {
                    String sTitle = "";
                    bookid = "";
                    // Show the page with the message that the book can't be found in the database
                    
                    if (source1.equalsIgnoreCase("Buch Löschen")) {
                        hSession.setAttribute("source_name", "Buch Löschen"); // the web page name
                        sTitle = "Buch Löschen"; // used for passing the title from one JSP script to the other
                    } if (source1.equalsIgnoreCase("Buch Ändern")) {
                        hSession.setAttribute("source_name", "Buch Ändern"); // the web page name
                        sTitle = "Buch Ändern"; // used for passing the title from one JSP script to the other
                    }
                    String sMessage = "ERR_NO_BOOKID"; // used for passing the message from one JSP script to the other
                    hSession.setAttribute("message", sMessage);
                    hSession.setAttribute("title", sTitle);
                    response.sendRedirect("error_succ.jsp"); // redirects the response to error_succ.jsp    
                }
            } catch (Exception e) {
                String sTitle = source1; // used for passing the title from one JSP script to the other
                String sMessage = "ERR_DB"; // used for passing the message from one JSP script to the other
                hSession.setAttribute("message", sMessage); // setting the attribute message to the value sMessage
                hSession.setAttribute("title", sTitle); // setting the attribute message to the value sTitle
                response.sendRedirect("error_succ.jsp"); // redirects the response to error_succ.jsp 
            }
        %>
        <!-- header.jsp contains - company logo, company name and the navigation bar -->
        <%@ include file="header.jsp"%>
        <%@ include file="upd_del_form.jsp"%> 
        <!-- footer.jsp contains the footer of the web page --> 
        <%@ include file="footer.jsp"%>
    </body>
</html>
