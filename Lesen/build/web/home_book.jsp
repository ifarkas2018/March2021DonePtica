<%-- 
    Document   : home_1_book is called when the user clicks on one of the books on the home page
    Created on : 21-Sep-2019, 20:48:11
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<%@page import="java.sql.Connection"%>
<%@page import="connection.ConnectionManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="miscellaneous.LesenMethoden"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/templatecss.css" type="text/css" rel="stylesheet"/>
        <title>Lesen</title>
        <%@ include file="header.jsp"%>
        <script>
            function deleteCookie() {
                document.cookie = "book_index= ; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
            }  
        </script>
    </head>
    
    <body onload="deleteCookie()">
        <%! 
            // retrieveBookDescr: retrievs the title, author name, price, isbn, description of the book
            // when the user clicks on one of the links on the home page for the book with index index
            public static ResultSet retrieveBookDescr(int index) throws SQLException {
                Connection con = ConnectionManager.getConnection(); //connecting to the database 
                Statement stmt = con.createStatement();
                                    
                String sQuery = "SELECT h.title, a.au_name, h.price, h.isbn, h.descr from homepg_books h, author a where a.au_id = h.au_id and book_id='" + index + "';";
                                    
                // execute the query - the result will be in the rs
                ResultSet rs = stmt.executeQuery(sQuery);
                return rs;
            }
            
        %>
        <div class="whitebckgr">
            <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="Foto mit Büchern" title="Foto mit Büchern"> 
                    </div>
                </div>
                       
                <div class="col-lg-5 col-md-5"> 
                    <div class="container">
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Das Buch</h3><br/>
                                <%
                                    HttpSession hSession = LesenMethoden.returnSession(request);
                                    hSession.setAttribute("webpg_name", "home_book.jsp");
                                    // reseting the sess. var to the default: if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED 
                                    // to show the previous values 
                                    hSession.setAttribute("subscribe", "false");
                                    Integer index = 0;
                                    
                                    Object indexObj = hSession.getAttribute("book_index");
                                    index = Integer.parseInt(String.valueOf(indexObj));
                                    
                                    boolean sessionvarex = LesenMethoden.sessVarExists(hSession, "book_index");
                                    sessionvarex = !sessionvarex;
                                    try {                                      
                                %>  
                                    <%
                                         // retrieve the book information and store it in result set rs
                                        ResultSet rs = retrieveBookDescr(index);

                                        // after clicking on the button index.jsp is shown
                                        out.println("<form action=\"index.jsp\" method=\"post\">");
                                    
                                        if (!(rs.next())) { // there is no information for that book
                                            out.println("<br /><br /><br />");
                                            out.println("Wir haben leider <span class=\"text-warning\">keine Treffer zu Ihrer Suche gefunden.!</span>");
                                            out.println("<br />");
                                            out.println("Überprüfen Sie die Rechtschreibung oder versuchen Sie es mit einem ähnlichen Suchbegriff.");
                                            out.println("<br /><br /><br /><br /><br />");
                                        } else {
                                            // show the result in an unordered list
                                            out.print("<ul>");
                                            
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
                                            out.print("<li><b>" + sTitle + "</b> von (<b>Autor</b>) " + sAuthor ); 
                                            
                                            // if there is value for the price : show it
                                            if (sPrice != null && !sPrice.equalsIgnoreCase("")){
                                                sPrice = sPrice.replace(".", ","); // the price is in the DB stored as a float
                                                sPrice = LesenMethoden.addPoint(sPrice); // adding the comma after 1000 euros 
                                                out.print(" (<b>Preis: </b>&euro;" + sPrice + ")" + "<br/>");
                                            }
                                                
                                            // if there is an ISBN : show it
                                            if (sISBN != null && !sISBN.equalsIgnoreCase("")) {
                                                out.print("<br /><b>" + "ISBN: </b>" + sISBN + "<br/>" );
                                            }
                                                
                                            // if there is a book description : show it
                                            if (descr != null && !descr.equalsIgnoreCase("")) {
                                                out.print("<br /><b>" + "Beschreibung: </b>" + descr );
                                            }
                                                
                                            out.print("</li>");
                                            out.print("</ul>");
                                        }
                                        out.print("<br />");
                                        // adding the Lesen button to the form; btn-sm is used for smaller ( narrower ) size of the control -->
                                        out.print("<button type=\"submit\" class=\"btn btn-info btn-sm\">Lesen</button>");
                                        out.println("</form>");
                                    } catch(Exception e) {
                                        String sMessage = "ERR_DB";
                                        String sTitle = "Das Buch"; // used for passing the title from one JSP script to the other
                                        hSession.setAttribute("source_name", "Das Buch"); // on which page I am now
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
            
        <!-- adding a new row; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
        
        <!-- adding a new row; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div>  
        <%@ include file="footer.jsp"%>
    </body>
</html>