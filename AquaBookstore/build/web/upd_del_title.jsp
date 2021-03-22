<%-- 
    Document   : upd_del_title called from update_prev.jsp, delete_title.jsp
    Created on : 14-Mar-2019, 04:27:45
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<!-- upd_del_title.jsp - shows the form for entering the title, author, ISBN of the book whose inform. is updated (or deleted) -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.AquaMethods"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="JavaScript/ValidationJS.js"></script>
        
        <script>
            NUM_FIELDS = 3; // number of the input fields on the form  
            NAME_VALIDATION  = 'true'; // does the Author's Name input field contain only letters (and apostrophe)
            NUM_VALIDATION  = 'true'; // does the ISBN input field contain only digits
            
            // setCookie: creates cookie inputI = value in the input field ; (I - number 0..2)
            function setCookie() {           
                var i;
                var inp_names = new Array('prev_title', 'prev_author', 'prev_isbn'); // names of the input fields
                
                for ( i = 0; i < NUM_FIELDS; i++ ) {
                    document.cookie = "input" + i + "=" + document.getElementById(inp_names[i]).value + ";"; // creating a cookie
                } 
            }
            
            // setDefaults: sets the values of the cookies (input0, input1, input12) to the default and
            // writes the content of every input field to the cookie
            function setDefaults() {
                var i;
                for (i = 0; i < NUM_FIELDS; i++) {
                    document.cookie = "input" + i + "= "; // setting the VALUE of the cookie to EMPTY
                }
                setCookie(); // go through every input field and write its content to the cookie
            } 
        </script>
        
        <%
            HttpSession hSession2 = AquaMethods.returnSession(request);            
            String source = (String)hSession2.getAttribute("source_name"); // on which page I am now
        %>
        
        <title> Aqua Books - <%= source %> </title>
    </head>
  
    <body onload="setDefaults()">
        <%
            final String PAGE_NAME = "update_prev.jsp"; // page which is loaded now 
            // webpg_name: the name of the page to return to if the user enters the email (subscribe) 
            if (source.equals("Update Book")) {
                hSession2.setAttribute("webpg_name", "update_prev.jsp");
            } else if (source.equals("Delete Book")) {
                hSession2.setAttribute("webpg_name", "delete_title.jsp");
            }
            // if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED to show the previous values
            hSession2.setAttribute("subscribe", "false");
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
                                <% 
                                    out.print("<h3 class=\"text-info\">" + source + "</h3>"); // source is Update Book (for the Update), or Delete Book (for the Delete)                                  
                                %>
                               
                                <br />
                                
                                <form id="upd_del_book" name="upd_del_book" action="upd_del_page.jsp" onsubmit="return checkForm();" method="post">
                                <%           
                                    String input0 = ""; // read the value which was before in the input field prev_title and show it again
                                    String input1 = ""; // read the value  in the input field prev_author and show it again
                                    String input2 = ""; // read the value which was before in the input field prev_isbn and show it again        
                                    
                                    // IDEA : fill_in variable is set in SubscrServl.java - true if some of the input session variables were set,
                                    // and they need to be added to the form here - this is true if the user BEFORE LOADED THIS PAGE and after that he entered
                                    // the email to subscribe (in the footer) and on the next page he clicked on Close
                                    if (AquaMethods.sessVarExists(hSession2, "fill_in")) { 
                                        String fill_in = String.valueOf(hSession2.getAttribute("fill_in")); 
                                        // session variable page_name is set below. It is used if the user clicks on the Subscribe button and after that on
                                        // the page subscrres_content if the user clicks on the Close button. then this page will be shown again
                                        if (AquaMethods.sessVarExists(hSession2, "page_name")) { 
                                            String page_name = String.valueOf(hSession2.getAttribute("page_name"));
                                            // if the user clicked on the Close button on the page subscrres_content and this page was shown before (page_name)
                                            // and if something is stored in session variables input 
                                            // then retrieve the session variable input0 (to show it in the 1st input field) 
                                            if ((page_name.equalsIgnoreCase(PAGE_NAME)) && (fill_in.equalsIgnoreCase("true"))) {
                                                if (AquaMethods.sessVarExists(hSession2, "input0")) {
                                                    input0 = String.valueOf(hSession2.getAttribute("input0")); // the value that was in the 1st input field
                                                } 
                                                if (AquaMethods.sessVarExists(hSession2, "input1")) {
                                                    input1 = String.valueOf(hSession2.getAttribute("input1")); // the value that was in the 2nd input field
                                                } 
                                                if (AquaMethods.sessVarExists(hSession2, "input2")) {
                                                    input2 = String.valueOf(hSession2.getAttribute("input2")); // the value that was in the 3rd input field
                                                } 
                                            } 
                                        }
                                        hSession2.setAttribute("fill_in", "false"); // the input fields don't need to be filled in
                                    } 
                                    
                                    // store on which page I am now in case the user clicks on subscribe button in the footer
                                    hSession2.setAttribute("page_name", PAGE_NAME);
                                    AquaMethods.setToEmptyInput(hSession2); // setToEmpty: set the session variable values to "" for the variables named input0, input1, ...
                                %>
                                
                                    <!-- creating the input element for the title -->
                                    <div class="form-group">
                                        <label for="prev_title">Title</label> <!-- title label -->
                                        <!-- filling in the title: required -->
                                        <input type="text" class="form-control form-control-sm" name="prev_title" id="prev_title" onchange="setCookie()" onfocusout='setFocus("upd_del_book", "prev_title")' required value="<%= input0 %>" > 
                                        <span class="text_size text-danger">* Required Field</span>
                                    </div>
                                        
                                    <!-- creating the input element for the author -->
                                    <div class="form-group">
                                        <label for="prev_author">Author's Name</label> <!-- author's name label -->
                                        <input type="text" class="form-control form-control-sm" name="prev_author" id="prev_author" onfocusout="setCookie();valLetters(document.upd_del_book.prev_author, author_message, 'fullname', false, 'false');" value="<%= input1 %>" >  
                                        <span id="author_message" class="text_size text-danger"></span>
                                    </div>
                                    
                                    <!-- creating the input element for the ISBN -->
                                    <div class="form-group"> 
                                        <label for="prev_isbn">ISBN</label> <!-- ISBN label -->
                                        <!-- input field for the ISBN: maximum 13 characters -->
                                        <input type="text" class="form-control form-control-sm" name="prev_isbn" id="prev_isbn" onchange="setCookie()" onfocusout='isNumber("upd_del_book", "prev_isbn", "is_isbn", "isbn_message", false, false)' value="<%= input2 %>" > 
                                        <span id="isbn_message" class="text_size text-danger"></span>
                                    </div>
                                    
                                    <!-- adding a new container -->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- adding some empty space -->
                                            </div>
                                        </div>    
                                    </div>
            
                                    <%
                                        if (source.equals("Delete Book")) {
                                    %>
                                            <!-- adding the button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                            <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Submit</button>
                                    <%  } else {
                                    %>
                                            <!-- adding the Next button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                            <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Next</button>
                                    <% }
                                    %>
                                    
                                    <!-- adding a new container -->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- adding some empty space -->
                                            </div>
                                        </div>    
                                    </div>
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