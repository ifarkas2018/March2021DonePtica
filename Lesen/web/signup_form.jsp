<%-- 
    Document   : signup_form (included in signup_page.jsp)
    Created on : 06-Apr-2019, 00:14:14
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<!-- signup_form.jsp - shows the form for entering the username, password, first name, last name, whether the user is an administrator  -->
<!--                 - included in signup_page.jsp -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="miscellaneous.LesenMethoden" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <script src="javascript/validationJS.js"></script> 
        
        <script>
            NUM_FIELDS = 6; // number of the input fields on the form 
            INPUT_FIELDS = 12; // number of the max number of input fields (on all forms) 
            EQUAL_PASSW = 'true'; // are the passwords of the requested format and are they equal
           
            // matchPass: compares the two entered passwords and sets the variable EQUAL_PASSW (whether the entered passwords are equal)
            function matchPass(){  
                var passwd1 = document.signup.passw1.value;  
                var passwd2 = document.signup.passw2.value;  
               
                if ((passwordFormat(passwd1)) && (passwordFormat(passwd2))) { // if both passwords are of a certain format
                    if (passwd1 == passwd2) {  
                        EQUAL_PASSW = 'true'; // the passwords are equal
                        passw_message.innerHTML = "";
                    }  else {  
                        EQUAL_PASSW = 'false'; // the passwords are not equal
                        passw_message.innerHTML = "* Bitte überprüfen Sie Ihre Passwortangabe <br />";
                    }  
                } else { // if one of the passwords is not of the certain format
                    EQUAL_PASSW = 'false'; 
                    passw_message.innerHTML = "* Bitte überprüfen Sie Ihre Passwortangabe <br />";
                }
            }  
           
            // setCookie: creates cookie inputI = value in the input field ; (I - number 0..5)
            function setCookie() {           
                var i;
                var inp_names = new Array('username', 'first_name', 'last_name', 'adm_yes', 'adm_no', 'anrede'); // names of the input fields
                
                // for the radio buttons set the cookie to the default
                document.cookie = "input3" + "=;";
                document.cookie = "input4" + "=;";
                for (i = 0; i < NUM_FIELDS; i++) {
                    // encodeURIComponent: encoding - used because of äÄöÖüÜß
                    if ((i==0) || (i==1) || (i==2) || (i==5)) {
                        document.cookie = "input" + i + "=" + encodeURIComponent(document.getElementById(inp_names[i]).value) + ";"; // creating a cookie
                    } else if ((i==3) || (i==4)) { // radio buttons
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
    
    <title>Lesen - Registrieren</title>
    <body onload="setDefaults()">
        <%
            final String PAGE_NAME = "signup_page.jsp"; // page which is loaded now 
            HttpSession hSession = LesenMethoden.returnSession(request);
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
                        <img src="images/books.png" class="img-fluid center-image" alt="Foto mit Büchern" title="Foto mit Büchern"> 
                    </div>
                </div>
                
                <!-- the Bootstrap column takes 5 columns on the large desktops and 5 columns on the medium sized desktops -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- adding the container to the Bootstrap grid -->
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Registrieren</h3> <!-- title on the web page -->
                                <br/> 
                                <%  
                                    HttpSession hSession2 = LesenMethoden.returnSession(request);
                                    
                                    String input0 = ""; // read the value which was before in the 1st input field and show it again
                                    String input1 = ""; // read the value which was before in the 2nd input field and show it again
                                    String input2 = ""; // read the value which was before in the 3rd input field and show it again                
                                    String input3 = ""; // was the yes radio button checked 
                                    String input4 = ""; // was the no radio button checked 
                                    String input5 = ""; // was the title choosen
                                    
                                    // IDEA : fill_in variable is set in SubscrServl.java - true if some of the input session variables were set,
                                    // and they need to be added to the form here - this true if the user BEFORE LOADED THIS PAGE and after that he entered
                                    // the email to subscribe (in the footer) and on the next page he clicked on Close
                                    if (LesenMethoden.sessVarExists(hSession2, "fill_in")) { 
                                        String fill_in = String.valueOf(hSession2.getAttribute("fill_in")); 
                                        // session variable page_name is set below. It is used if the user clicks on the Subscribe button and after that on
                                        // the page subscrres_content if the user clicks on the Close button. then this page will be shown again
                                        if (LesenMethoden.sessVarExists(hSession2, "page_name")) { 
                                            String page_name = String.valueOf(hSession2.getAttribute("page_name"));
                                            // if the user clicked on the Close button on the page subscrres_content and this page was shown before (page_name)
                                            // and if something is stored in session variables input 
                                            // then retrieve the session variable input0 ( to show it in the 1st input field )
                                            if ((page_name.equalsIgnoreCase(PAGE_NAME)) && (fill_in.equalsIgnoreCase("true"))) {
                                                if (LesenMethoden.sessVarExists(hSession2, "input0")) {
                                                    input0 = String.valueOf(hSession2.getAttribute("input0")); // value that was in the 1st input field
                                                    input0 = URLDecoder.decode(new String(input0.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // decoding because of äÄöÖüÜß
                                                } 
                                                if (LesenMethoden.sessVarExists(hSession2, "input1")) {
                                                    input1 = String.valueOf(hSession2.getAttribute("input1")); // value that was in the 2nd input field
                                                    input1 = URLDecoder.decode(new String(input1.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // decoding because of äÄöÖüÜß
                                                } 
                                                if (LesenMethoden.sessVarExists(hSession2, "input2")) {
                                                    input2 = String.valueOf(hSession2.getAttribute("input2")); // value that was in the 3rd input field
                                                    input2 = URLDecoder.decode(new String(input2.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // decoding because of äÄöÖüÜß
                                                }   
                                                if (LesenMethoden.sessVarExists(hSession2, "input3")) {
                                                    input3 = String.valueOf(hSession2.getAttribute("input3")); // was the yes radion button checked
                                                }   
                                                if (LesenMethoden.sessVarExists(hSession2, "input4")) {
                                                    input4 = String.valueOf(hSession2.getAttribute("input4")); // was the yes radion button checked
                                                }   
                                                if (LesenMethoden.sessVarExists(hSession2, "input5")) {
                                                    input5 = String.valueOf(hSession2.getAttribute("input5")); // was the yes radion button checked
                                                }   
                                            } 
                                        }
                                        hSession2.setAttribute("fill_in", "false"); // the input fields don't need to be filled in
                                    }                                    
                                    hSession2.setAttribute("page_name", PAGE_NAME);
                                    LesenMethoden.setToEmptyInput(hSession2); // setToEmpty: set the session variable values to "" for the variables named input0, input1, ...
                                %>

                                <form name="signup" id="signup" action="SignUpServlet" onsubmit="return checkFormPassw(document.signup.passw1.value, document.signup.passw2.value, EQUAL_PASSW, 'passw_message');" method="post"> 
                                    <div class="form-group">
                                        <label for="anrede">Anrede</label>
                                        <!-- creating a drop down list; form-control-sm is used for smaller control -->
                                        <select class="form-control form-control-sm" name="anrede" id="anrede" onchange="setCookie()">
                                            <% if (input5.equalsIgnoreCase("none")){ %>
                                                 <option value="none" selected> </option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                 <option value="none"> </option>
                                            <% } %>
                                            <% if (input5.equalsIgnoreCase("frau")){ %>
                                                 <option value="frau" selected>Frau</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                 <option value="frau">Frau</option>
                                            <% } %>
                                            
                                            <% if (input5.equalsIgnoreCase("herr")){ %>
                                                 <option value="herr" selected>Herr</option> <!-- options shown in the drop down list -->
                                            <% } else { %>
                                                 <option value="herr">Herr</option>
                                            <% } %>
                                        </select>
                                    </div>
                                        
                                    <!-- creating the input element for the first name -->
                                    <div class="form-group">
                                        <label for="first_name">Vorname</label> <!-- first name label -->
                                        <input type="text" class="form-control form-control-sm" name="first_name" id="first_name" onfocusout="setCookie();valLetters(document.signup.first_name, fname_message, 'firstname', false, 'false');" value="<%= input1 %>"> 
                                        <span id="fname_message" class="text_size text-danger"></span>
                                    </div>

                                    <!-- creating the input element for the last name -->
                                    <div class="form-group">
                                        <label for="last_name">Nachname</label> <!-- last name label -->
                                        <input type="text" class="form-control form-control-sm" name="last_name" id="last_name"  onfocusout="setCookie();valLetters(document.signup.last_name, lname_message, 'lastname', false, 'false');" value="<%= input2 %>"> 
                                        <span id="lname_message" class="text_size text-danger"></span>
                                    </div>
                                    
                                    <!-- creating the input element for the username -->
                                    <div class="form-group">
                                        <label for="username">Benutzername</label> <!-- username label -->
                                        <!-- filling in the username: required -->
                                        <input type="text" class="form-control form-control-sm" name="username" id="username" onchange="setCookie()" onfocusout='setFocus("signup", "username")'  required value="<%= input0 %>"> 
                                        <label class="text_size text-danger">* Pflichtfeld</label>
                                    </div>
                                        
                                    <!-- creating the input element for the password -->
                                    <div class="form-group">
                                        <label for="passw1">Passwort</label> <!-- password name label -->
                                        <!-- filling in the password: required -->
                                        <input type="password" class="form-control form-control-sm" name="passw1" id="passw1"
                                                onfocusout='matchPass()' required> 
                                        <span id="passw1_message" class="text_size text-danger">* Pflichtfeld</span><br />
                                    </div>
                                    
                                    <span id="passw_pattern" class="text_size text-danger">Ihr Passwort muss mindestens 8 Zeichen lang sein und es muss Groß-, Kleinbuchstaben und Zahlen enthalten</span>
                                    <br />
                                    <span id="passw_message" class="text_size text-danger"></span>
                                    <br />
                                    
                                    <!-- creating the input element for re-entering the password -->
                                    <div class="form-group">
                                        <label for="passw2">Passwort wiederholen</label> <!-- password name label -->
                                        <input type="password" class="form-control form-control-sm" name="passw2" id="passw2" 
                                                onfocusout='matchPass()' required> 
                                        <span id="passw2_message" class="text_size text-danger">* Pflichtfeld</span>
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
                                                Ja
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
                                                Nein
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
                                    <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Registrieren</button>
                                    
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

