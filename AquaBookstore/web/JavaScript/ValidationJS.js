/* Project : Aqua Bookstore
 * Author : Ingrid Farkas
 * ValidationJS.js : functions used for validation
 */

NAME_VAL = 'true'; // does the full name input field contain only letters (and apostrophe)
FNAME_VAL = 'true'; // does the first name input field contain only letters (and apostrophe)
LNAME_VAL = 'true'; // does the last name input field contain only letters (and apostrophe)
ISBN_VAL = 'true'; // does the ISBN input field contain only digits
PRICE_VAL = 'true'; // does the Price input field contain only digits
PG_VAL = 'true'; // does the Pages input field contain only digits
YRPUBL_VAL = 'true'; // does the Publication Year input field contain only digits

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
// if wildcards is true, the number can contain a % or _
// if dec_point is true, the number can contain .
// num_type - is the input in the field an isbn, price, pages or a year
// formid: id of the form
function isNumber(formid, input_field, num_type, msg_field, wildcards, dec_point) {
    var number;
    var regex;
    
    number = document.getElementById(input_field).value;
    if (wildcards && dec_point) { // %, _ or . can be entered in the input field (beside digits)
        regex = /^[0-9\x25\x5F\x2E]+$/;
    } else if (dec_point) {
        regex = /^[0-9\x2E]+$/;
    } else if (wildcards) { // % or _ can be entered in the input field (beside digits)
        regex = /^[0-9\x25\x5F]+$/;
    } else {
        regex = /^[0-9]+$/;
    }
    if (number != '') {
        // if the value entered in a isbn is not a nuumber (if wildcards is true, number can contain a %, _)
        if (!regex.test(number)) {
            if (wildcards && dec_point) { // %, _, . can be entered in the input field (beside digits)
                document.getElementById(msg_field).innerHTML = "* Can contain only digits (wildcards and decimal point)"; // show the message
            } else if (dec_point) { 
                document.getElementById(msg_field).innerHTML = "* Can contain only digits (and decimal point)"; 
            } else if (wildcards) {
                document.getElementById(msg_field).innerHTML = "* Can contain only digits (and wildcards)"; 
            } else {
                document.getElementById(msg_field).innerHTML = "* Can contain only digits"; // show the message
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
    regex = /^[0-9\x2C\x2E]+$/; // can contain digits, comma and the decimal point 
    
    // is number < 10000
    if (!priceLess10000(number)) {
        document.getElementById(msg_field).innerHTML = "* Can contain price less or equal to 9,999.99"; 
        setVal(num_type, 'false');
    } else {
        if (number != '') { 
            // if the value entered as a price is not a nuumber (if wildcards is true, number can contain a %, _)
            if (!regex.test(number)) { 
                document.getElementById(msg_field).innerHTML = "* Can contain only digits (and decimal point and comma)"; 
                setVal(num_type, 'false');
            } else { // number is a number which can contain comma and dot
                comma_pos = number.toString().indexOf(',');
                dot_pos = number.toString().indexOf('.');
                if (comma_pos != -1) { // if the number contains a comma
                    if (dot_pos != -1) { // if the number contains a dot
                        if (dot_pos - comma_pos == 4) { // the comma and dot exist and there are at the right position
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // don't show the message (if there was one before)
                        } else { // the comma and dot exist and there are NOT at the right position
                            setVal(num_type, 'false');
                            document.getElementById(msg_field).innerHTML = "* Can contain price less or equal to 9,999.99"; // show the message
                        }
                    } else { // the comma exists and the dot doesn't exist
                        if (number.length - comma_pos == 4) {
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // show the message
                        } else {
                            setVal(num_type, 'false');
                            document.getElementById(msg_field).innerHTML = "* Can contain price less or equal to 9,999.99"; // show the message
                        }
                    }
                } else { // comma doesn't exist in the number ( however the dot(.) could exist)
                    if (dot_pos == -1) { // if the dot doesn't exist (either)
                        if (number.length <= 4) { // the number has to be less than 10000
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // show no message
                        } else {
                            setVal(num_type, 'false');
                            document.getElementById(msg_field).innerHTML = "* Can contain price less or equal to 9,999.99"; // show the message
                        }
                    } else { // the dot does exist
                        if (number.length - dot_pos == 3) {
                            setVal(num_type, 'true');
                            document.getElementById(msg_field).innerHTML = ""; // show no message
                        } else {
                            setVal(num_type, 'false');
                            document.getElementById(msg_field).innerHTML = "* Can contain price less or equal to 9,999.99"; // show the message
                        }
                    }
                }
            }
        } else { // the number is not entered
            setVal( num_type, 'true' );
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
            regex = /^[a-zA-ZćĆčČšŠžŽđĐ\x27\x20\x2C\x2D\x25\x5F]+$/;
        } else { // can't contain more names separated by comma (only one name) - Sign Up
            if (name_type == "firstname") { // besides the comma (\x2C) can't contain '(\x27)
                regex = /^[a-zA-ZćĆčČšŠžŽđĐ\x20\x2D\x25\x5F]+$/; // can contain space - % _ (and letters) 
            } else { // last name
                regex = /^[a-zA-ZćĆčČšŠžŽđĐ\x27\x20\x2D\x25\x5F]+$/; // can contain ' space - % _ (and letters)
            }
        }
    } else {
        if (name_type == "fullname") { // can contain full names separated with comma (Search Book, Add Book, Update Book, Delete Book)
            regex = /^[a-zA-ZćĆčČšŠžŽđĐ\x27\x20\x2C\x2D]+$/; // can contain ' space , -  (and letters)
        } else { // can't contain more names separated by comma (only one name) - Sign Up
            if (name_type == "firstname") { // besides the comma (\x2C) can't contain '(\x27)  
                regex = /^[a-zA-ZćĆčČšŠžŽđĐ\x20\x2D]+$/; // can contain space - (and letters) 
            } else { // last name
                regex = /^[a-zA-ZćĆčČšŠžŽđĐ\x27\x20\x2D]+$/; // can contain ' space - % _ (and letters)
            }
        }
    }
    
    if (!input_field.value == '') {
        if (!regex.test(input_field.value)) { // some not allowed characters were entered in the input field
           if (wildcards) { // if the user entered some wildcards which are not letters (in the input_field)
                if (name_type == "fullname") { // can contain full names separated with comma (Search Book, Add Book, Update Book, Delete Book)
                    message_span.innerHTML = "* Can contain letters, commas, apostrophies, hyphen, space, wildcards";
                } else { // can't contain more names separated by comma (only one name) - Sign Up  
                    if (name_type == "firstname") {
                        message_span.innerHTML = "* Can contain letters, hyphen, space, wildcards";
                    } else { // last name
                        message_span.innerHTML = "* Can contain letters, apostrophies, hyphen, space, wildcards";
                    }
                }   
            } else {
                if (name_type == "fullname") { // can contain full names separated with comma (Search Book, Add Book, Update Book, Delete Book)
                    message_span.innerHTML = "* Can contain letters, commas, apostrophies, hyphen, space";
                } else { // can't contain more names separated by comma (only one name) - Sign Up    
                    if (name_type == "firstname") {
                        message_span.innerHTML = "* Can contain letters, hyphen, space";
                    } else { // last name
                        message_span.innerHTML = "* Can contain letters, apostrophies, hyphen, space";
                    }
                }
            }
            setNameVal(name_type, 'false');
        } else { // the user entered letters and allowed characters (in the input_field)
            setNameVal(name_type, 'true'); // sets name_type to true
            if (required == 'true') { // if it is a required field show below the message
                message_span.innerHTML = "* Required Field";
            } else { // if it isn't a required field don't show below any message
                message_span.innerHTML = "";
            }
        }
    } else { // nothing is entered into the input field 
        if (required == 'true') { // if it is a required field show below the message
            setNameVal(name_type, 'false'); // sets name_type to false
            message_span.innerHTML = "* Required Field";
        } else { // if it isn't a required field don't show below any message
            setNameVal(name_type, 'true'); // sets name_type to true
            message_span.innerHTML = "";
        }
    }
}

// checkForm: if the validation was successful then return TRUE otherwise return FALSE
function checkForm(){
    if ((NAME_VAL === 'true') && (FNAME_VAL === 'true') && (LNAME_VAL === 'true') && (ISBN_VAL === 'true') && (PRICE_VAL === 'true') && (PG_VAL === 'true') && (YRPUBL_VAL === 'true') && (EMAIL_SHORTER === 'true')) { 
        return true;
    } else {
        return false;
    }
}