/* Project : Lesen
 * Author  : Ingrid Farkas
 * validationJS.js : functions used for validation
 */

NAME_VAL = 'true'; // does the full name input field contain only letters (and apostrophe)
FNAME_VAL = 'true'; // does the first name input field contain only letters (and apostrophe)
LNAME_VAL = 'true'; // does the last name input field contain only letters (and apostrophe)
ISBN_VAL = 'true'; // does the ISBN input field contain only digits
PRICE_VAL = 'true'; // does the Price input field contain only digits
PG_VAL = 'true'; // does the Pages input field contain only digits
YRPUBL_VAL = 'true'; // does the Publication Year input field contain only digits
EQUAL_PASSW = 'true'; // are the passwords of the requested format and are they equal

EMAIL_SHORTER = 'true'; // is the email length less than the maximum (EMAIL_MAX)
EMAIL_MAX = 40; // max length of the email     

// setVal: depending on the num_type, sets one of the variables to the value
function setVal(num_type, value) {
    if (num_type == 'is_isbn') {
        ISBN_VAL  = value;
    } else if (num_type == 'is_pages') {
        PG_VAL = value;
    } else if (num_type == 'is_price') {
        PRICE_VAL = value;
    } else if (num_type == 'is_yrpubl') {
        YRPUBL_VAL = value;
    }
}

// isNumber: shows a message (in the msg_field) if the user entered a value that is a non numeric value (in the input field named input_field)
// if characters is true, the number can contain a % or _
// if dec_point is true, the number can contain .
// num_type - is the input in the field an isbn, price, pages or a year
// formid: id of the form
function isNumber(formid, input_field, num_type, msg_field, characters, dec_point) {
    var number;
    var regex;
    
    number = document.getElementById(input_field).value;
    if (characters && dec_point) { // %, _ or . can be entered in the input field (beside digits)
        regex = /^[0-9\x25\x5F\x2E]+$/;
    } else if (dec_point) {
        regex = /^[0-9\x2E]+$/;
    } else if (characters) { // % or _ can be entered in the input field (beside digits)
        regex = /^[0-9\x25\x5F]+$/;
    } else {
        regex = /^[0-9]+$/;
    }
    if (number != '') {
        // if the value entered in a isbn is not a nuumber (if characters is true, number can contain a %, _)
        if (!regex.test(number)) {
            if (characters && dec_point) { // %, _, . can be entered in the input field (beside digits)
                document.getElementById(msg_field).innerHTML = "* Erlaubte Zeichen sind: Zahlen % _ ."; // show the message
            } else if (dec_point) { 
                document.getElementById(msg_field).innerHTML = "* Erlaubte Zeichen sind Zahlen und ."; 
            } else if (characters) {
                document.getElementById(msg_field).innerHTML = "* Erlaubte Zeichen sind Zahlen % _"; 
            } else {
                document.getElementById(msg_field).innerHTML = "* Erlaubte Zeichen sind Zahlen"; // show the message
            }
            setVal( num_type, 'false' );
        } else {
            setVal( num_type, 'true' );
            document.getElementById(msg_field).innerHTML = ""; // show the message 
        }
    } else {
        setVal( num_type, 'true' );
        document.getElementById(msg_field).innerHTML = ""; // show the message 
    }
}

// lengthLessMax: shows the message in the msg_span if the user entered in the input_field a string whose length is longer than the EMAIL_MAX
function lengthLessMax(input_field, msg_span) {
    var str_field;
    
    str_field = document.getElementById(input_field).value; 
    
    if (str_field.length > EMAIL_MAX) {
        document.getElementById(msg_span).innerHTML = "* Can contain a maximum of " + EMAIL_MAX + " characters";
        EMAIL_SHORTER = 'false'; // entered email is not shorter than EMAIL_MAX
    } else {
        document.getElementById(msg_span).innerHTML = "";
        EMAIL_SHORTER = 'true'; 
    }    
}

// returns true if the price is less than 10000 otherwise it returns false
function priceLess10000(number) {
    isLess = false; // is the number < 10000;
   
    if ((number.indexOf('.') != -1) && (number.indexOf(',') != -1)) { // if the number contains the decimal dot(.) and the comma(,)
        if (number.length <= 8) { // the number has to be less than 10000
            isLess = true;
        } else {
            isLess = false;
        }
    } else { 
        if ((number.indexOf('.') != -1) || (number.indexOf(',') != -1)) { // if the number contains the decimal dot(.) or the comma(,)
            if (number.length <= 7) { // the number has to be less than 10000 and can contain . or ,
                isLess = true;
            } else {
                isLess = false; 
            }
        } else { // doesn't contain neither the dot(.) nor the comma(,)
            if (number.length <= 4) {
                isLess = true;
            } else {
                isLess = false; 
            }
        }
    }
    return isLess;
}

// isPrice: shows a message (in the msg_field) if the user entered a value that is not a price (in the input field named input_field)
// num_type - is the input in the field an isbn, price, pages or a year
// formid: id of the form
function isPrice(formid, input_field, num_type, msg_field) {
    var number; // the number in the input_field
    var regex;
    
    number = document.getElementById(input_field).value;
    regex = /^[0-9\x2C\x2E]+$/; // can contain digits, the decimal point and the comma
    
    // is number < 10000
    if (!priceLess10000(number)) {
        document.getElementById(msg_field).innerHTML = "Der Preis soll weniger als &euro; 10.000,00 sein"; 
        setVal(num_type, 'false');
    } else {
        if (number != '') {
            // if the value entered as a price is not a nuumber (can contain . ,)
            if (!regex.test(number)) { 
                document.getElementById(msg_field).innerHTML = "* Erlaubte Zeichen sind Zahlen . ,"; 
                setVal(num_type, 'false');
            } else { // number is a number which can contain dot and comma 
                dot_pos = number.toString().indexOf('.');
                comma_pos = number.toString().indexOf(',');
                if (dot_pos != -1) { // if the number contains a dot
                    if (comma_pos != -1) { // if the number contains a comma
                        if (comma_pos - dot_pos == 4) { // the comma and dot exist and there are at the right position
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // don't show the message (if there was one before)
                        } else { // the comma and dot exist and there are NOT at the right position
                            setVal(num_type, 'false');
                            document.getElementById(msg_field).innerHTML = "Der Preis soll weniger als &euro; 10.000,00 sein"; // show the message
                        }
                    } else { // the dot exists and the comma doesn't exist
                        if (number.length - dot_pos == 4) {
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // show the message
                        } else {
                            setVal(num_type, 'false');
                            document.getElementById(msg_field).innerHTML = "Der Preis soll weniger als &euro; 10.000,00 sein"; // show the message
                        }
                    }
                } else { // the dot(.) doesn't exist, however the comma(,) could exist 
                    if (comma_pos == -1) { // if the comma doesn't exist (either)
                        if (number.length <= 4) { // the number has to be less than 10000
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // show no message
                        } else {
                            setVal(num_type, 'false');
                            document.getElementById(polje_poruka).innerHTML = "Der Preis soll weniger als &euro; 10.000,00 sein"; // show the message
                        }
                    } else { // the comma does exist
                        if (number.length - comma_pos == 3) {
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // show no message
                        } else {
                            setVal(num_type, 'false');
                            document.getElementById(msg_field).innerHTML = "Der Preis soll weniger als &euro; 10.000,00 sein"; // show the message
                        }
                    }
                }
            }
        } else { // the number is not entered
            setVal(num_type, 'true');
            document.getElementById(msg_field).innerHTML = ""; // don't show the message (if there was one before)  
        }
    }
}



// setNameVal - depending on whether the user entered full name, first name or last name set the corresponding variable value
// name_type: 'fullname' (the user filled in a full name), 'firstname', 'lastname'
// value: 'true' or 'false'
function setNameVal(name_type, value) {
    switch (name_type) { // depending on whether the user entered full name, first name or last name set the corresponding variable value
        case 'fullname':
            NAME_VAL = value;
            break;
        case 'firstname':
            FNAME_VAL = value;
            break;
        case 'lastname':
            LNAME_VAL = value;
            break;
        default:
    }
}

// valLetters: checks whether in the control input_field there are only letters (or apostrophes, commas, -, space, %, _). If not in the message_span the message is shown.
// required - if the input field was required to be filled in before showing the message, when the user corrects the mistake, below
// is shown again that the input field is required (to be filled in)
// name_type - 'fullname' (the user filled in a full name), 'firstname', 'lastname'
// wildcards - whether wildcards are allowed in the input field
function valLetters(input_field, message_span, name_type, wildcards, required) {
    var regex;
    
    if (wildcards) { // % or _ can be entered in the input field (beside letters, apostrophes, commas, -, space)
        if (name_type == "fullname") { // can contain full names separated with comma (Search Book, Add Book, Update Book, Delete Book)  
            regex = /^[a-zA-ZäÄöÖüÜßćĆčČšŠžŽđĐ\x27\x20\x2C\x2D\x25\x5F]+$/;
        } else { // can't contain more names separated by comma (only one name) - Sign Up
            if (name_type == "firstname") { // besides the comma (\x2C) can't contain '(\x27)
                regex = /^[a-zA-ZäÄöÖüÜßćĆčČšŠžŽđĐ\x20\x2D\x25\x5F]+$/; // can contain space - % _ (and letters) 
            } else { // last name
                regex = /^[a-zA-ZäÄöÖüÜßćĆčČšŠžŽđĐ\x27\x20\x2D\x25\x5F]+$/; // can contain ' space - % _ (and letters)
            }
        }
    } else {
        if (name_type == "fullname") { // can contain full names separated with comma (Search Book, Add Book, Update Book, Delete Book)
            regex = /^[a-zA-ZäÄöÖüÜßćĆčČšŠžŽđĐ\x27\x20\x2C\x2D]+$/; // can contain ' space , -  (and letters)
        } else { // can't contain more names separated by comma (only one name) - Sign Up
            if (name_type == "firstname") { // besides the comma (\x2C) can't contain '(\x27)  
                regex = /^[a-zA-ZäÄöÖüÜßćĆčČšŠžŽđĐ\x20\x2D]+$/; // can contain space - (and letters) 
            } else { // last name
                regex = /^[a-zA-ZäÄöÖüÜßćĆčČšŠžŽđĐ\x27\x20\x2D]+$/; // can contain ' space - % _ (and letters)
            }
        }
    }
    
    if (!input_field.value == '') {
        if (!regex.test(input_field.value)) { // if the user entered some characters which are not letters (in the input_field)
            //setNameVal(name_type, 'false');
            /*
            if (wildcards)
                message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt ' , - % _";
            else
                message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt ' , -";
            */
     
            if (wildcards) { // if the user entered some wildcards which are not letters (in the input_field)
                if (name_type == "fullname") { // can contain full names separated with comma (Search Book, Add Book, Update Book, Delete Book)
                    // message_span.innerHTML = "* Can contain letters, commas, apostrophies, hyphen, space, wildcards";
                    message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt ' , - % _";
                } else { // can't contain more names separated by comma (only one name) - Sign Up  
                    if (name_type == "firstname") {
                        // message_span.innerHTML = "* Can contain letters, hyphen, space, wildcards";
                        message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt - % _";
                    } else { // last name
                        // message_span.innerHTML = "* Can contain letters, apostrophies, hyphen, space, wildcards";
                        message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt ' - % _";
                    }
                }   
            } else {
                if (name_type == "fullname") { // can contain full names separated with comma (Search Book, Add Book, Update Book, Delete Book)
                    // message_span.innerHTML = "* Can contain letters, commas, apostrophies, hyphen, space";
                    message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt ' , -";
                } else { // can't contain more names separated by comma (only one name) - Sign Up    
                    if (name_type == "firstname") {
                        //message_span.innerHTML = "* Can contain letters, hyphen, space";
                        message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt -";
                    } else { // last name
                        //message_span.innerHTML = "* Can contain letters, apostrophies, hyphen, space";
                        message_span.innerHTML = "* Erlaubte Zeichen sind Buchstaben Leerschritt ' -";
                    }
                }
            }
            setNameVal(name_type, 'false');
        } else { // the user entered characters which are letters and other allowed char. (in the input_field)
            setNameVal(name_type, 'true');
            if (required == 'true') {
                message_span.innerHTML = "* Pflichtfeld";
            } else {
                message_span.innerHTML = "";
            }
        }
    } else {
        if (required == 'true') {
            setNameVal(name_type, 'false');
            // NAME_VALIDATION = 'false';
            message_span.innerHTML = "* Pflichtfeld";
        } else {
            setNameVal(name_type, 'true');
            // NAME_VALIDATION = 'true';
            message_span.innerHTML = "";
        }
    }
}

// length8: returns whether the length of the password is at least 8 
function length8(passw) {
    return (passw.length >= 8);
}

// passwordFormat: checks whether the password has a certain format (length is at least 8 chracters and contains at least one lower 
// and and at least one upper case letter and at least one digit)
// returns true if the password has the certain format, otherwise it returns false 
function passwordFormat(password) {
    // does the password contain at least one digit, one upper case letter, one lower case letter
    regex = /^(?=.*[0-9])(?=.*[a-zäöüßščćđž])(?=.*[A-ZÄÖÜŠČĆĐŽ])[a-zA-Z0-9äÄöÖüÜßšŠčČćĆđĐžŽ]+$/;
    if (password.length == 0) { // the password is empty
        return true;
    } else {
        if (!length8(password)) // the password length has to be at least 8 
            return false;
        else {
            if (regex.test(password)) { // does the password contain at least one digit, one lower case letter and one upper case letter
                return true;
            } else {
                return false;
            }
        }
    }
}
    
// checkFormPassw: if both passwords are of a certain format and the validation was successful then return TRUE otherwise returns FALSE
// passw_equal: are the passwords of the requested format and are they equal
// message_span: the message is shown here
function checkFormPassw(passw1, passw2, passw_equal, message_span) {
    returnVal = false;
    
    EQUAL_PASSW = passw_equal;
    if (EQUAL_PASSW === 'true') { // if the passwords of the requested format and equal
        // if the password has a certain pattern (length is at least 8 chracters and contains lower and upper case letters and a digit)
        if ((passwordFormat(passw1)) && (passwordFormat(passw2))) {
            if ((NAME_VAL === 'true') && (FNAME_VAL === 'true') && (LNAME_VAL === 'true') && (ISBN_VAL === 'true') && (PRICE_VAL === 'true') && (PG_VAL === 'true') && (YRPUBL_VAL === 'true')) { 
                returnVal = true;
            } else {
                returnVal = false;
            }
        } else {
            returnVal = false;
        }
    } else {
        returnVal = false;
    }
    
    if (returnVal === false) {
        document.getElementById(message_span).innerHTML ="* Bitte überprüfen Sie Ihre Passwortangabe <br />"; 
    }
    return returnVal;
}

// checkForm: if the validation was successful then return TRUE otherwise return FALSE
function checkForm(){
    if ((NAME_VAL === 'true') && (FNAME_VAL === 'true') && (LNAME_VAL === 'true') && (ISBN_VAL === 'true') && (PRICE_VAL === 'true') && (PG_VAL === 'true') && (YRPUBL_VAL === 'true')) { 
        return true;
    } else {
        return false;
    }
}

