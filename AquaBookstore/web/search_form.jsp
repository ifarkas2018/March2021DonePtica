<%-- 
    Document   : search_form.jsp
    Created on : 18-Sep-2018, 01:33:11
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<!-- search_form.jsp - the form on the page Search Book -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.AquaMethods"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aqua Books - Search Book</title>
        
        <script src="JavaScript/ValidationJS.js"></script>
        
        <script>
            NUM_FIELDS = 7; // number of the input fields on the form
            INPUT_FIELDS = 12;  
        
            // setCookie: creates cookie inputI = value in the input field ; (I - number 0..2)
            function setCookie() {           
                var i;
                var inp_names = new Array('title', 'author', 'isbn', 'price_range', 'sortby', 'categ', 'publ_year'); // names of the input fields
                
                for (i = 0; i < NUM_FIELDS; i++) {
                    document.cookie = "input" + i + "=" + document.getElementById(inp_names[i]).value + ";"; // creating a cookie
                } 
            }
            
            // setDefaults: sets the values of the cookies (input0, input1, input12) to the default and
            // writes the content of every input field to the cookie
            function setDefaults() {   
                var i;
                for (i = 0; i < INPUT_FIELDS; i++) {
                    document.cookie = "input" + i + "= "; // setting the VALUE of the cookie to EMPTY
                }
                setCookie(); // go through every input field and write its content to the cookie
            } 
            
            // on the load show the modal (id: centeredModal)
            $(window).on('load',function(){
                $('#centeredModal').modal('show');
            });
        </script>    
    </head>
    
    <body onload="setDefaults()">
        
        <%
            final String PAGE_NAME = "search_page.jsp"; // page which is loaded now
            HttpSession hSession = AquaMethods.returnSession(request);
            hSession.setAttribute("webpg_name", "search_page.jsp");
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
                    <div> <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="picture of books" title="picture of books"> 
                    </div>
                    <br /><br />
                    <div> <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="picture of books" title="picture of books"> 
                    </div>
                </div>
                       
                <!-- the Bootstrap column takes 5 columns on the large desktops and 5 columns on the medium sized desktops -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container">
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col"> <!-- adding a new column to the Bootstrap grid -->
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Search</h3>
                                <br/> 
                                Wildcards  
                                <!-- adding an unordered list with two list items -->
                                <ul>
                                    <li>_ - represents a single character</li>
                                    <li>% - represents a zero, single or multiple characters</li>
                                </ul>
                                
                                <%  
                                    HttpSession hSession2 = AquaMethods.returnSession(request);
                                    String input0 = ""; // read the value which was before in the 1st input field and show it again
                                    String input1 = ""; // read the value  in the 2nd input field and show it again
                                    String input2 = ""; // read the value which was before in the 3rd input field and show it again        
                                    String input3 = ""; // read the value which was before in the 1st drop down list and show it again        
                                    String input4 = ""; // read the value which was before in the 2nd drop down list and show it again        
                                    String input5 = ""; // read the value which was before in the 3rd drop down list and show it again        
                                    String input6 = ""; // read the value which was before in the 4th input field and show it again        
                                    
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
                                                if (AquaMethods.sessVarExists(hSession2, "input3")) {
                                                    input3 = String.valueOf(hSession2.getAttribute("input3")); // the value that was in the 1st drop down list
                                                } 
                                                if (AquaMethods.sessVarExists(hSession2, "input4")) {
                                                    input4 = String.valueOf(hSession2.getAttribute("input4")); // the value that was in the 2nd drop down list
                                                } 
                                                if (AquaMethods.sessVarExists(hSession2, "input5")) {
                                                    input5 = String.valueOf(hSession2.getAttribute("input5")); // the value that was in the 3rd drop down list
                                                } 
                                                if (AquaMethods.sessVarExists(hSession2, "input6")) {
                                                    input6 = String.valueOf(hSession2.getAttribute("input6")); // the value that was in the 3rd drop down list
                                                } 
                                            } 
                                        }
                                        hSession2.setAttribute("fill_in", "false"); // the input fields don't need to be filled in
                                    } 
                                    
                                    // store on which page I am now in case the user clicks on subscribe button in the footer
                                    hSession2.setAttribute("page_name", PAGE_NAME);
                                    AquaMethods.setToEmptyInput(hSession2 ); // setToEmpty: set the session variable values to "" for the variables named input0, input1, ...
                                %>
                                
                                <!-- after clicking on the button searchDB.jsp is shown -->
                                <form action="searchDB.jsp" name="search_book" id="search_book" method="post" onsubmit="return checkForm();">
                                    <div class="form-group"> 
                                        <label for="title">Title</label> <!-- title label -->
                                        <!-- filling in the title is required  -->
                                        <input type="text" class="form-control form-control-sm" name="title" id="title" onchange="setCookie()" onfocusout='setFocus("search_book", "title")' required value="<%= input0 %>"> 
                                        <label class="text_size text-danger">* Required Field</label>
                                    </div>
                                    <div class="form-group"> 
                                        <label for="author">Author's Name</label> <!-- author's name label -->
                                        <input type="text" class="form-control form-control-sm" name="author" id="author" onchange="setCookie()" onfocusout="valLetters(document.search_book.author, author_message, 'fullname', true, 'false');" value="<%= input1 %>"> <!-- the input element for author -->
                                        <span id="author_message" class="text_size text-danger"></span>
                                    </div>
                
                                    <div class="form-group">
                                        <label for="isbn">ISBN</label> <!-- ISBN label -->
                                        <input type="text" class="form-control form-control-sm" name="isbn" id="isbn" onchange="setCookie();" onfocusout='isNumber("search_book", "isbn", "is_isbn", "isbn_message", true, false)' value="<%= input2 %>"> <!-- the input element for ISBN -->
                                        <span id="isbn_message" class="text_size text-danger"></span>
                                    </div>
                
                                    <div class="form-group">
                                        <label for="price_range">Price Range</label> <!-- price range label -->
                                        <!-- creating a drop down list; form-control-sm is used for smaller control -->
                                        <select class="form-control form-control-sm" name="price_range" id="price_range" onchange="setCookie()"> 
                                            <% if (input3.equalsIgnoreCase("all")){ %>
                                                <option value="all" selected>All Prices</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                <option value="all">All Prices</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("less50")){ %>
                                                <option value="less50" selected>Prices under &pound;50</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                <option value="less50">Prices Under &pound;50</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("betw50-100")){ %>
                                                <option value="betw50-100" selected>Prices &pound;50 - &pound;100</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                <option value="betw50-100">Prices &pound;50 - &pound;100</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("betw100-200")){ %>
                                                <option value="betw100-200" selected>Prices &pound;100 - &pound;200</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                <option value="betw100-200">Prices &pound;100 - &pound;200</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("betw200-500")){ %>
                                                <option value="betw200-500" selected>Prices &pound;200 - &pound;500</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                <option value="betw200-500">Prices &pound;200 - &pound;500</option>
                                            <% } %>
                                            
                                            <% if (input3.equalsIgnoreCase("above500")){ %>
                                                <option value="above500" selected>Prices Above &pound;500</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                <option value="above500">Prices Above &pound;500</option>
                                            <% } %>
                                            
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="sortby">Sort By</label>
                                        <!-- creating a drop down list; form-control-sm is used for smaller control -->
                                        <select class="form-control form-control-sm" name="sortby" id="sortby" onchange="setCookie()"> 
                                            <% if (input4.equalsIgnoreCase("low")){ %>
                                                 <option value="low" selected>Price (Low - High)</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                 <option value="low">Price (Low - High)</option>
                                            <% } %>
                                            
                                            <% if (input4.equalsIgnoreCase("high")){ %>
                                                 <option value="high" selected>Price (High - Low)</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                 <option value="high">Price (High - Low)</option>
                                            <% } %>
                                        </select>
                                    </div>
                
                                    <div class="form-group"> 
                                        <label for="categ">Category</label> <!-- category label -->
                                        <!-- creating a drop down list; form-control-sm is used for narrower control -->
                                        <select class="form-control form-control-sm" name="categ" id="categ" onchange="setCookie()">
                                            <% if (input5.equalsIgnoreCase("all")){ %>
                                                 <option value="all" selected>All Categories</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                 <option value="all">All Categories</option>
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("fict")){ %>
                                                 <option value="fict" selected>Fiction &amp; Poetry</option> 
                                            <% } else { %>
                                                 <option value="fict">Fiction &amp; Poetry</option>   
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("bus")){ %>
                                                 <option value="bus" selected>Business</option> 
                                            <% } else { %>
                                                 <option value="bus">Business</option>      
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("comp")){ %>
                                                 <option value="comp" selected>Computing &amp; IT</option> 
                                            <% } else { %>
                                                 <option value="comp">Computing &amp; IT</option>  
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("edu")){ %>
                                                 <option value="edu" selected>Education</option> 
                                            <% } else { %>
                                                 <option value="edu">Education</option>   
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("child")){ %>
                                                 <option value="child" selected>Children's</option> 
                                            <% } else { %>
                                                 <option value="child">Children's</option>  
                                            <% } %>
                                        </select>
                                    </div>
                                        
                                    <div class="form-group">
                                        <label for="publ_year">Publication Year</label> <!-- publication year label -->
                                        <input type="text" class="form-control form-control-sm" id="publ_year" name="publ_year" onchange="setCookie()" onfocusout='isNumber("search_book", "publ_year", "is_yrpubl", "year_message", true, false)' value="<%= input6 %>"> <!-- the input element for the publication year -->
                                        <span id="year_message" class="text_size text-danger"></span>
                                    </div>

                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- adding some empty space -->
                                            </div>
                                        </div>    
                                    </div>

                                    <!-- adding the Search button to the form -->
                                    <button type="submit" class="btn btn-info btn-sm">Search</button>

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
