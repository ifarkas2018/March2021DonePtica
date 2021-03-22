<%-- 
    Document   : signup_form (included in signup_page.jsp)
    Created on : 06-Apr-2019, 00:14:14
    Author     : Ingrid Farkas
    Project    : Aqua Bookstore
--%>

<!-- signup_form.jsp - shows the form for entering the username, password, first name, last name, whether the user is an administrator  -->
<!--                 - included in signup_page.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="miscellaneous.AquaMethods"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <script src="JavaScript/ValidationJS.js"></script> 
        
        <script>
            NUM_FIELDS = 5; // number of the input fields on the form 
            INPUT_FIELDS = 12; // number of the max number of input fields (on all forms) 
            EQUAL_PASSW = 'true'; // are the entered passwords the same
           
            // matchPass: compares the two entered passwords and sets the variable EQUAL_PASSW (whether the entered passwords are equal)
            function matchPass(){  
                var passwd1 = document.signup.passw1.value;  
                var passwd2 = document.signup.passw2.value;  

                if (passwd1 == passwd2) {  
                    EQUAL_PASSW= 'true';
                    // remove the message below the password input field
                    passw1_message.innerHTML = "* Required Field";
                    passw2_message.innerHTML = "* Required Field";
                }  else {  
                    EQUAL_PASSW = 'false'; 
                    // show the message below the password input field
                    passw1_message.innerHTML = "* Passwords must match";
                    passw2_message.innerHTML = "* Passwords must match";
                }  
            }  
           
            // setCookie: creates cookie inputI = value in the input field ; (I - number 0..5)
            function setCookie() {           
                var i;
                var inp_names = new Array('username', 'first_name', 'last_name', 'adm_yes', 'adm_no'); // names of the input fields
                
                // for the radio buttons set the cookie to the default
                document.cookie = "input3" + "=;";
                document.cookie = "input4" + "=;";
                for (i = 0; i < NUM_FIELDS; i++) {
                    if ((i==0) || (i==1) || (i==2)) {
                        document.cookie = "input" + i + "=" + document.getElementById(inp_names[i]).value + ";"; // creating a cookie
                    } else if ((i==3) || (i==4)) {
                        if (document.getElementById(inp_names[i]).checked){
                            document.cookie = "input" + i + "=" + document.getElementById(inp_names[i]).value + ";"; // creating a cookie
                        }
                    }
                }
            }
            
            // getCookie: returns the value of the cookie named cname
            function getCookie(cname) {
                var name = cname + "=";
                var decodedCookie = decodeURIComponent(document.cookie);
                var cookieArr = decodedCookie.split(';'); // splitting the cookie into "cookie_name = cookie_value;"
                for( var i = 0; i < cookieArr.length; i++ ) {
                  var c = cookieArr[i];
                  while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                  }
                  if (c.indexOf(name) == 0) { // if the cookie starts with cname + "=" 
                    return c.substring(name.length, c.length); // return the value of the cookie
                  }
                }
                return "";
            }
            
            // setDefaults: sets the values of the cookies (input0, input1, input12) to the default and
            // writes the content of every input field to the cookie
            function setDefaults() {   
                var i;
                for (i = 0; i < INPUT_FIELDS; i++) {
                    cValue = getCookie("fill_in");
                    if ((i===0) && (cValue==="false" )){ // if it doesn't need to be filled in set the radio buttons to the default
                        document.getElementById("adm_yes").checked = true; // default setting for the checked Yes 
                    }
                    document.cookie = "input" + i + "= "; // setting the VALUE of the cookie to EMPTY
                }
                document.cookie = "fill_in=false;"; // setting the fill_in to the default
                setCookie(); // go through every input field and write its content to the cookie
            } 
          
        </script>
    </head>
    
    <title>Aqua Books - Sign Up</title>
    <body onload="setDefaults()">
        <%
            final String PAGE_NAME = "signup_page.jsp"; // page which is loaded now 
            HttpSession hSession = AquaMethods.returnSession(request);
            hSession.setAttribute("webpg_name", "signup_page.jsp");
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
                                <h3 class="text-info">Sign Up</h3> <!-- title on the web page -->
                                <br/> 
                                <%  
                                    HttpSession hSession2 = AquaMethods.returnSession(request);
                                    
                                    String input0 = ""; // read the value which was before in the 1st input field and show it again
                                    String input1 = ""; // read the value which was before in the 2nd input field and show it again
                                    String input2 = ""; // read the value which was before in the 3rd input field and show it again                
                                    String input3 = ""; // was the yes radio button checked 
                                    String input4 = ""; // was the no radio button checked 
                                    
                                    // IDEA : fill_in variable is set in SubscrServl.java - true if some of the input session variables were set,
                                    // and they need to be added to the form here - this true if the user BEFORE LOADED THIS PAGE and after that he entered
                                    // the email to subscribe (in the footer) and on the next page he clicked on Close
                                    if (AquaMethods.sessVarExists(hSession2, "fill_in")) { 
                                        String fill_in = String.valueOf(hSession2.getAttribute("fill_in")); 
                                        // session variable page_name is set below. It is used if the user clicks on the Subscribe button and after that on
                                        // the page subscrres_content if the user clicks on the Close button. then this page will be shown again
                                        if (AquaMethods.sessVarExists(hSession2, "page_name")) { 
                                            String page_name = String.valueOf(hSession2.getAttribute("page_name"));
                                            // if the user clicked on the Close button on the page subscrres_content and this page was shown before (page_name)
                                            // and if something is stored in session variables input 
                                            // then retrieve the session variable input0 ( to show it in the 1st input field )
                                            if ((page_name.equalsIgnoreCase(PAGE_NAME)) && (fill_in.equalsIgnoreCase("true"))) {
                                                if (AquaMethods.sessVarExists(hSession2, "input0")) {
                                                    input0 = String.valueOf(hSession2.getAttribute("input0")); // value that was in the 1st input field
                                                } 
                                                if (AquaMethods.sessVarExists(hSession2, "input1")) {
                                                    input1 = String.valueOf(hSession2.getAttribute("input1")); // value that was in the 2nd input field
                                                } 
                                                if (AquaMethods.sessVarExists(hSession2, "input2")) {
                                                    input2 = String.valueOf(hSession2.getAttribute("input2")); // value that was in the 3rd input field
                                                }   
                                                if (AquaMethods.sessVarExists(hSession2, "input3")) {
                                                    input3 = String.valueOf(hSession2.getAttribute("input3")); // was the yes radion button checked
                                                }   
                                                if (AquaMethods.sessVarExists(hSession2, "input4")) {
                                                    input4 = String.valueOf(hSession2.getAttribute("input4")); // was the yes radion button checked
                                                }   
                                            } 
                                        }
                                        hSession2.setAttribute("fill_in", "false"); // the input fields don't need to be filled in
                                    }                                    
                                    hSession2.setAttribute("page_name", PAGE_NAME);
                                    AquaMethods.setToEmptyInput(hSession2); // setToEmpty: set the session variable values to "" for the variables named input0, input1, ...
                                %>

                                <form name="signup" id="signup" action="SignUpServlet" onsubmit="return checkForm();" method="post">                                   
                                    <!-- creating the input element for the first name -->
                                    <div class="form-group">
                                        <label for="first_name">First Name</label> <!-- first name label -->
                                        <input type="text" class="form-control form-control-sm" name="first_name" id="first_name" onfocusout="setCookie();valLetters(document.signup.first_name, fname_message, 'firstname', false, 'false');" value="<%= input1 %>"> 
                                        <span id="fname_message" class="text_size text-danger"></span>
                                    </div>

                                    <!-- creating the input element for the last name -->
                                    <div class="form-group">
                                        <label for="last_name">Last Name</label> <!-- last name label -->
                                        <input type="text" class="form-control form-control-sm" name="last_name" id="last_name" onfocusout="setCookie();valLetters(document.signup.last_name, lname_message, 'lastname', false, 'false');" value="<%= input2 %>"> 
                                        <span id="lname_message" class="text_size text-danger"></span>
                                    </div>
                                        
                                    <!-- creating the input element for the username -->
                                    <div class="form-group">
                                        <label for="username">Username</label> <!-- username label -->
                                        <!-- filling in the username: required -->
                                        <input type="text" class="form-control form-control-sm" name="username" id="username" onchange="setCookie()" onfocusout='setFocus("signup", "username")'  required value="<%= input0 %>"> 
                                        <label class="text_size text-danger">* Required Field</label>
                                    </div>
                                        
                                    <!-- creating the input element for the password -->
                                    <div class="form-group">
                                        <label for="passw1">Password</label> <!-- password name label -->
                                        <!-- filling in the password: required -->
                                        <input type="password" class="form-control form-control-sm" name="passw1" id="passw1" 
                                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter and at least 8 or more characters" 
                                               onfocusout='matchPass()' required> 
                                        <span id="passw1_message" class="text_size text-danger">* Required Field</span>
                                    </div>
                                    
                                    <!-- creating the input element for re-entering the password -->
                                    <div class="form-group">
                                        <label for="passw2">Re-enter Password</label> <!-- password name label -->
                                        
                                        <input type="password" class="form-control form-control-sm" name="passw2" id="passw2" 
                                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter and at least 8 or more characters" 
                                               onfocusout='matchPass()' required> 
                                        <span id="passw2_message" class="text_size text-danger">* Required Field</span>
                                    </div>
                                    
                                    <!-- creating the input element for the administrator -->
                                    <div class="form-group">
                                        <label for="admin">Administrator</label> <!-- administrator label -->
                                        <div class="form-check">
                                            <!-- Yes radio button -->
                                            <% if (input3.equalsIgnoreCase("adm_yes")){ %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_yes" value="adm_yes" onchange="setCookie()" checked>
                                            <% } else { %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_yes" value="adm_yes" onchange="setCookie()">
                                            <% } %> 
                                            <label class="form-check-label" for="admin_yes">
                                                Yes
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <!-- No radio button -->
                                            <% if (input4.equalsIgnoreCase("adm_no")){ %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_no" value="adm_no" onclick="setCookie()" checked>
                                            <% } else { %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_no" value="adm_no" onclick="setCookie()">
                                            <% } %> 
                                            <label class="form-check-label" for="admin_no">
                                                No
                                            </label>
                                        </div>
                                    </div>
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- adding some empty space -->
                                            </div>
                                        </div>    
                                    </div>
                                        
                                    <!-- adding the Submit button to the form; btn-sm is used for smaller (narrower) size of the control -->
                                    <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Submit</button>
                                    
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

