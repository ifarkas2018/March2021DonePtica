<%-- 
    Document   : searchDB.jsp called from search_form.jsp
    Created on : 18-Sep-2018, 00:54:05
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="connection.ConnectionManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.CharSequence"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/templatecss.css" type="text/css" rel="stylesheet"/>
        <title>Lesen - Suchen</title>
        <%@ include file="header.jsp"%>
    </head>
    
    <body>
        <%!
            // cont_wildcard returns true if the string contains one of wildcards % or _. Otherwise it returns false.
            boolean cont_wildcard(String str) {
            CharSequence undersc = "_";
            CharSequence percentage = "%";
            // does the string contain _ or %
            if ((str.contains(undersc)) || (str.contains(percentage)))
                return true;
            else
                return false;
            }
        %>
        <div class="whitebckgr">
            <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="Foto von Büchern" title="Foto von Büchern"> 
                    </div>
                </div>
                       
                <div class="col-lg-5 col-md-5"> 
                    <div class="container">
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Suchen</h3><br/>
                                
                                <%
                                    boolean booksReturned = false; // are there books returned as the result of the search
                                    boolean subscr = false; // whether the user is coming from the subscribe
                                    HttpSession hSession = LesenMethoden.returnSession(request);
                                    // sess. var. is set to true in the subscrres_content.jsp (if the user subscribed)
                                    if (LesenMethoden.sessVarExists(hSession, "subscribe")) {
                                        // name of the page loaded before this page
                                        subscr = Boolean.valueOf(String.valueOf(hSession.getAttribute("subscribe")));
                                        hSession.setAttribute("subscribe", "false"); // reseting the sess. var to the default
                                    } 
                                    hSession.setAttribute("webpg_name", "searchDB.jsp");
                                
                                    try { 
                                        String form_title = "";
                                        String form_auth = "";
                                        String form_isbn = "";
                                        String form_price = "";
                                        String form_sortby = "";
                                        String form_categ = "";
                                        String form_publyear = ""; 
                                
                                        if (subscr) { // the user just subscribed - I need to read the values from the forms
                                            form_title = LesenMethoden.readSetSessV(hSession, "input0"); // read and reset the sess. var. (title)
                                            form_auth = LesenMethoden.readSetSessV(hSession, "input1"); // read and reset the sess. var. (auth)
                                            form_isbn = LesenMethoden.readSetSessV(hSession, "input2"); // read and reset the sess. var. (isbn)
                                            form_price = LesenMethoden.readSetSessV(hSession, "input3"); // read and reset the sess. var. (price)
                                            form_sortby = LesenMethoden.readSetSessV(hSession, "input4"); // read and reset the sess. var. (sortby)
                                            form_categ = LesenMethoden.readSetSessV(hSession, "input5"); // read and reset the sess. var. (categ)             
                                            form_publyear = LesenMethoden.readSetSessV(hSession, "input6"); // read and reset the sess. var. (publyear)

                                            // sets all the sess. var. (with names that start with input) to ""
                                            LesenMethoden.setToEmptyInput(hSession);
                                        }
                                    
                                        if (!subscr) { // the user is loading this page WITHOUT subscribing
                                            form_title = request.getParameter("title"); // the text entered as the title
                                            form_title = LesenMethoden.decoder(form_title); // decoding of the title (could contain äÄöÖüÜß)
                                            // if the lengh of the form_title is longer then the size of the column title (the table book)
                                            if (form_title.length() > LesenMethoden.TITLE_LEN) {  
                                                form_title = form_title.substring(0, LesenMethoden.TITLE_LEN); // in the DB is written only first TITLE_LEN characters
                                            }
                                            
                                            form_auth = request.getParameter("author"); 
                                            form_auth = LesenMethoden.decoder(form_auth); // decoding of the author (could contain äÄöÖüÜß)
                                            // if the lengh of the form_auth is longer then the size of the column au_name (the table author)
                                            if (form_auth.length() > LesenMethoden.AUTHOR_LEN) {  
                                                form_auth = form_auth.substring(0, LesenMethoden.AUTHOR_LEN); // in the DB is written only first AUTHOR_LEN characters
                                            }
                                            
                                            form_isbn = request.getParameter("isbn"); 
                                            // if the lengh of the form_isbn is longer then the size of the column isbn (the table book)
                                            if (form_isbn.length() > LesenMethoden.ISBN_LEN) {  
                                                form_isbn = form_isbn.substring(0, LesenMethoden.ISBN_LEN); // in the DB is written only first ISBN_LEN characters
                                            }
                                            
                                            form_sortby = request.getParameter("sortby"); 
                                            form_categ = request.getParameter("categ"); // the option chosen in the drop-down list - category
                                            form_price = request.getParameter("price_range"); // the option chosen in the drop-down list - price range
                                            form_publyear = request.getParameter("publ_year"); // the text entered as the publ_year
                                            // if the lengh of the form_publyear is longer then the size of the column publ_year (the table book)
                                            if (form_publyear.length() > LesenMethoden.PUBLYR_LEN) {  
                                                form_publyear = form_publyear.substring(0, LesenMethoden.PUBLYR_LEN); // in the DB is written only first PUBLYR_LEN characters
                                            }
                                            
                                            // sets all the sess. var. (with names that start with input) to ""
                                            LesenMethoden.setToEmptyInput(hSession);
                                        }
                                    
                                        // deleteSpaces: removes space characters from the begining and end of the string, and replaces 2 or more white spaces with single space
                                        // inside of the string
                                        form_title = LesenMethoden.deleteSpaces(form_title);
                                        form_auth = LesenMethoden.deleteSpaces(form_auth);
                                        form_isbn = LesenMethoden.deleteSpaces(form_isbn);
                                        form_publyear = LesenMethoden.deleteSpaces(form_publyear);
                                    %>  
                                    <%
                                        Connection con = ConnectionManager.getConnection(); //connecting to the database 
                                        Statement stmt = con.createStatement();
                                    
                                        String sQuery = "select b.title, b.price, b.isbn, b.publ_year, b.descr, a.au_name from book b, author a where (b.au_id = a.au_id)";
                                    
                                        // if there is anything entered in input field with the label Title
                                        if (!(form_title.equalsIgnoreCase(""))) {
                                            // addBacksl replaces every occurence of \ with \\\\ and replaces every occurence of ' with \\'
                                            form_title = LesenMethoden.addBacksl(form_title);
                                            // if the title contains ? or _ then add the Like 
                                            if (cont_wildcard(form_title)){
                                                sQuery += " AND (LOWER(b.title) LIKE '" + form_title.toLowerCase() + "')";
                                            } else 
                                                sQuery += " AND (LOWER(b.title)='" + form_title.toLowerCase() + "')";
                                        }     
                                    
                                        // if there is anything entered in the input field with the label Author's Name
                                        if (!(form_auth.equalsIgnoreCase(""))) {
                                            // addBacksl replaces every occurence of \ with \\\\ and replaces every occurence of ' with \\'
                                            form_auth = LesenMethoden.addBacksl(form_auth);
                                            // if the title contains ? or _ then add the Like 
                                            if (cont_wildcard(form_auth))
                                                sQuery += " AND (LOWER(a.au_name) LIKE '" + form_auth.toLowerCase() + "')";
                                            else
                                                sQuery += " AND (LOWER(a.au_name)='" + form_auth.toLowerCase() + "')";
                                        }
                                    
                                        // if there is anything entered in the input field with the label ISBN
                                        if (!(form_isbn.equalsIgnoreCase(""))) {
                                            // if the title contains ? or _ then add the Like 
                                            if (cont_wildcard(form_isbn))
                                                sQuery += " AND (b.isbn LIKE '" + form_isbn + "')";
                                            else
                                                sQuery += " AND (b.isbn='" + form_isbn + "')";
                                        }
                                    
                                        String tempStr; // used for building of the query 
                                        if (form_categ.equalsIgnoreCase("all"))
                                            tempStr="";
                                        else {
                                            tempStr = form_categ;
                                        }
                                    
                                        // build the query by adding whether the category is tempStr
                                        if (!(tempStr.equalsIgnoreCase(""))) 
                                            sQuery += " AND (b.category='" + tempStr + "')";
                                    
                                        tempStr="";
                                        // if the user chose for the the price range <50 Euros
                                        if (form_price.equalsIgnoreCase("less50"))
                                            tempStr = "< 50"; 
                                        // if the user chose for the the price range between 50 Euros and 100 Euros
                                        else if (form_price.equalsIgnoreCase("betw50-100"))
                                            tempStr = "BETWEEN 50 AND 100";
                                        // if the user chose for the the price range between 100 Euros and 200 Euros
                                        else if (form_price.equalsIgnoreCase("betw100-200"))
                                            tempStr = "BETWEEN 100 AND 200";
                                        // if the user chose for the the price range between 200 Euros and 500 Euros
                                        else if (form_price.equalsIgnoreCase("betw200-500"))
                                            tempStr = "BETWEEN 200 AND 500";
                                        // if the user chose for the the price range above 500 Euros
                                        if (form_price.equalsIgnoreCase("above500"))
                                            tempStr = "> 500";
                                    
                                        // build the query by adding whether the price is in required range
                                        if (!(tempStr.equalsIgnoreCase(""))) 
                                            sQuery += " AND (b.price " + tempStr + " )";

                                        // if there is anything entered in the input field with the label Publication Year
                                        if (!(form_publyear.equalsIgnoreCase(""))) {
                                            // if the title contains ? or _ then add the Like 
                                            if (cont_wildcard(form_publyear))
                                                sQuery += " AND (b.publ_year LIKE '" + form_publyear + "')";
                                            else
                                                sQuery += " AND (b.publ_year='" + form_publyear + "')";
                                        }
                                    
                                        // add whether the query results should be sorted ASC or DESC based on the user's choice
                                        sQuery += " ORDER BY b.price "; 

                                        if (form_sortby.equalsIgnoreCase("low")) 
                                            sQuery += "ASC";
                                        else
                                            sQuery += "DESC";
                                        sQuery += ";";
                                    
                                        // execute the query - the result will be in the rs
                                        ResultSet rs = stmt.executeQuery(sQuery); 

                                        // after clicking on the button search_page.jsp is shown
                                        out.println("<form action=\"search_page.jsp\" method=\"post\">");
                                    
                                        if (!(rs.next())) { // there are no books that meet the search criteria
                                            out.println("<br /><br /><br />");
                                            out.println("Für ihre Suchanfrage wurden<span class=\"text-warning\"> keine Bücher </span>gefunden!");
                                            out.println("<br /><br /><br /><br /><br />");
                                        } else {
                                            booksReturned = true;
                                            out.println("Für ihre Suchanfrage wurden die folgenden Bücher gefunden: ");
                                            out.println("<br /><br />");
                                            // show the result in an unordered list
                                            out.print("<ul>");
                                            // if in the result set there is the next row
                                            do {
                                                // read the title 
                                                String sTitle = rs.getString("title");
                                                // read the name of the author
                                                String sAuthor = rs.getString("au_name");
                                                // read the price
                                                String sPrice = rs.getString("price");
                                                // read the ISBN
                                                String sISBN = rs.getString("isbn");
                                                // show the value for the title, author and price
                                                String descr = rs.getString("descr");
                                                out.print("<li><b>" + sTitle + "</b> von (Autor) " + sAuthor ); 
                                                // if there is value for the price : show it
                                                if ((sPrice != null) && (!sPrice.equalsIgnoreCase("0.00"))) {
                                                    // in the database the price is in form 9999.99; in the form the price should be shown in form 9.999,99
                                                    sPrice = sPrice.replace('.',','); // replace the decimal . with ,
                                                    sPrice = LesenMethoden.addPoint(sPrice); // dodajem tačku u cenu iza hiljadu dinara 
                                                    out.print(" (<b>Preis: </b>&euro;" + " " + sPrice + ")");
                                                }
                                                
                                                // if there is an ISBN : show it
                                                if (sISBN != null) {
                                                    out.print("<br /><b>" + "ISBN: </b>" + sISBN );
                                                }
                                                
                                                // if there is a book description : show it
                                                if (descr != null) {
                                                    out.print("<br /><b>" + "Beschreibung : </b>" + descr );
                                                }
                                                
                                                out.print("</li>");
                                            } while(rs.next());

                                            out.print("</ul>");
                                        }
                                        out.print("<br />");
                                        // adding the Search button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                        out.print("<button type=\"submit\" class=\"btn btn-info btn-sm\">Suchen</button>");
                                        out.println("</form>");
                                    } catch(Exception e) {
                                        String sMessage = "ERR_SEARCH";
                                        String sTitle = "Suchen"; // used for passing the title from one JSP script to the other
                                        hSession.setAttribute("source_name", "Suchen"); // on which page I am now
                                        hSession.setAttribute("title", sTitle); // setting the attribute message to the value sTitle
                                        hSession.setAttribute("message", sMessage); // setting the attribute message to the value sMessage
                                        response.sendRedirect("error_succ.jsp"); // redirects the response to error_succ.jsp
                                    }
                                %>

                            </div> <!-- end of class="col" -->
                        </div> <!-- end of class="row" --> 
                    </div> <!-- end of class="container" -->
                </div> <!-- end of class="col-lg-5 col-md-5" -->
            </div> <!-- end of class="row" -->
        </div> <!-- end of class="whitebckgr" -->
         
        <% if (booksReturned) { // if there were books returned as the result of the search query
        %>
        
            <div class="whitebckgr">
                <div class="col">
                    &nbsp; &nbsp;
                </div>
            </div> 
    
        <%
           }
        %>
        
        <!-- adding a new row; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
          
        <%@ include file="footer.jsp"%>
    </body>
</html>
