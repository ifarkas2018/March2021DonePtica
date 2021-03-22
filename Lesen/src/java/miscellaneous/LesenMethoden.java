/*
 * author : Ingrid Farkas
 * project : Lesen
 * LesenMethoden.java : methods used more then once
 */
package miscellaneous;

import java.net.URLDecoder;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LesenMethoden {
    
    public static final int TITLE_LEN = 90; // number of characters in the column title (table book)
    public static final int AUTHOR_LEN = 100; // number of characters in the column au_name (table author)
    public static final int ISBN_LEN = 13; // number of characters in the column isbn (table book)
    public static final int PRICE_LEN = 8; // number of characters in the column price (table book)
    public static final int PG_LEN = 4; // number of characters in the column pages (table book)
    public static final int PUBL_LEN = 50; // number of characters in the column publ_name (table publisher)
    public static final int PUBLYR_LEN = 4; // number of characters in the column publ_year (table book)
    
    public static final int NAME_LEN = 51; // number of characters in the column name (table login)
    public static final int USR_NAME_LEN = 25; // number of characters in the column username (table login)
    public static final int PASSW_LEN = 25; // number of characters in the column passw (table login)
    
    public static HttpSession returnSession(HttpServletRequest request) {
        HttpSession hSession = request.getSession(); // retrieve the session (to which I am going to add and read variables)
        return hSession;
    }
    
    // sessVarExists: returns whether the session var. named name exists in the hSession
    public static boolean sessVarExists(HttpSession hSession, String name) { 
        boolean attr_found = false; // is the atribute named name one of variables in the session
        String attrName = ""; // the name of the attribute in the session
        Enumeration enumAttr; // enumeration of variable names added to the session
        enumAttr = hSession.getAttributeNames(); // the names of the session variables 
        while ((enumAttr.hasMoreElements()) && (!attr_found)) { // while the Enumeration has more el.
            attrName = String.valueOf(enumAttr.nextElement()); // read the next element
            if (attrName.equals(name)) {
                attr_found = true; // attribute with the name name was found
            }
        }
        return attr_found;
    }
    
    // readSetSessV: reads and returns the session variable named sessVar
    // sessVar: name of the session variable
    public static String readSetSessV(HttpSession hSession, String sessVar) {
        String readVal = "";
        
        // if the user entered the email (Subscribe) then read the session var. sessVar
        if (LesenMethoden.sessVarExists(hSession, sessVar)) { 
            readVal = String.valueOf(hSession.getAttribute(sessVar));
            if (!readVal.equalsIgnoreCase("")) { 
                hSession.setAttribute(sessVar, ""); // the next time the page is loaded the sessVar is ""  
            }
        } 
        return readVal;
    }
    
    // setToEmptyInput: set the session variable values to "" for the variables named input0, input1, ...
    public static void setToEmptyInput(HttpSession hSession) {
        String attrName = ""; // the name of the attribute in the session
        Enumeration enumAttr; // enumeration of variable names added to the session
        enumAttr = hSession.getAttributeNames(); // the names of the session variables 
        while ((enumAttr.hasMoreElements())) { // while the Enumeration has more el.
            attrName = String.valueOf(enumAttr.nextElement()); // read the next element
            if (attrName.startsWith("input")) {
                hSession.removeAttribute(attrName);
            }
        }
    }
    
    // setToEmpty: set the session variable values to "" 
    public static void setToEmpty(HttpSession hSession) {
        String attrName = ""; // the name of the attribute in the session
        Enumeration enumAttr; // enumeration of variable names added to the session 
        enumAttr = hSession.getAttributeNames(); // the names of the session variables 
        while ((enumAttr.hasMoreElements())) { // while the Enumeration has more el.
            attrName = String.valueOf(enumAttr.nextElement()); // read the next element
            hSession.removeAttribute(attrName); 
        }
    }
    
    // addBackslash: adds 2 back slashes (if isApostrophy = true)  before the ' 
    // or 3 back slashes (if isApostrophy = false)  before the \ before EVERY appearance of that character
    // used to add the description (or some other string) to the database
    public static String addBackslash(String descr, boolean isApostrophy){
        
        String newDescription = ""; // the description where I add \ before the '
        String strToChar; // the substring of the description to the \ or '
        String strCharacter; // the string to be added instead of the ' ( or \ )
        String strAfterChar; // the substring of the description after the ' ( or \ )
        int prev_pos = -1; // position of the prevoius ' or \
        int pos = 1; // position of the ' or \
        int stringLen = descr.length();
        
        if (isApostrophy) { 
            strCharacter = "\\'";
        } else {
            strCharacter = "\\\\";
        }
        
        if (!isApostrophy) {
            pos = descr.indexOf("\\", 0); // finds the position of the \ starting from the position = prev_pos+3
        } else { 
            pos = descr.indexOf("'", 0); // finds the position of the ' starting from the position = prev_pos+3
        }
        
        if (pos<0)
            newDescription = descr;
        
        // while the next \ is found in the string substitute it with \\\\ (or while the next ' is found in the string substitute it with \\') 
        while (pos >= 0) {
            newDescription = "";
            prev_pos = pos-1;
            
            if (pos >= 0) {
                strToChar = descr.substring(0, pos);
                strAfterChar = descr.substring(pos+1, stringLen);
                newDescription = newDescription.concat(strToChar);
                newDescription = newDescription.concat(strCharacter);
                newDescription = newDescription.concat(strAfterChar);
                descr = newDescription;
                
                stringLen++; // I've added to the string \
                
                if (!isApostrophy) {
                    pos = descr.indexOf("\\", prev_pos+3); // finds the position of the \ starting from the position = prev_pos+3
                } else { 
                    pos = descr.indexOf("'", prev_pos+3); // finds the position of the ' starting from the position = prev_pos+3
                }
            }
        }
        return newDescription;
    }
    
    // addBacksl: calls the method that replaces every occurence of \ with \\\\ and replaces every occurence of ' with \\'
    public static String addBacksl(String descr) {
        boolean isApostrophy = false; // is the character before which I need to add \\ a ' ( or a \ )
                
        // replacing every occurence of \ with \\\\
        descr = addBackslash(descr, isApostrophy);
        isApostrophy = true;
        // replacing every occurence of ' with \\'
        descr = addBackslash(descr, isApostrophy);
       
        return descr;
    }
    
    // deleteSpaces: removes space characters from the begining and end of the string, and replaces 2 or more white spaces with single space
    // inside of the string
    public static String deleteSpaces(String str) {
        String newString = str.trim(); // removing leading and trailing white space
        newString = newString.replaceAll("\\s+", " "); // replace 2 or more white spaces with single space
        return newString;
    }
    
    // addPoint: adds the point to the price after thousand euros
    public static String addPoint(String price) {
        if (price.length() > 6) {
            String substrLevi = ""; // part of the string from the left until the .
            String substrDesni = ""; // string from the right hand side of the .
            if (price.length() == 7) {
                substrLevi = price.substring(0,1);
                substrDesni = price.substring(1);
            } 
            price = "";
            price = price.concat(substrLevi); 
            price = price.concat(".");
            price = price.concat(substrDesni);
        }
        return price;
    }
    
    // decoder: when the user enters one of letters äÄöÖüÜß I have to decode, otherwise these letters are substituted with latinic letters
    // str: string to be decoded
    public static String decoder(String str) throws Exception {
        String lString, rString; // lString is the string left from % (or +) and rString is the string on the right hand side from % (or +)
        int indexProc = -1; // index of the procentage
        int indexPlus = -1; // index of the + 
        int lenStr = -1; // length of the string str
        
        indexProc = str.indexOf('%');
        indexPlus = str.indexOf('+'); 
        lenStr = str.length();
        
        if (lenStr == 1) {
            if (!(str.equalsIgnoreCase("%")) && !(str.equalsIgnoreCase("+"))) { // if the length of the string is 1, and the string isn't % (or +)
                str = URLDecoder.decode(new String(str.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8");
            }
        } else if (lenStr != 0) {
            if (indexProc != -1) { // if the string contains % 
                lString = str.substring(0, indexProc); // the substring of the string to the % (on the left)
                rString = str.substring(indexProc+1, lenStr); // the substring of the string from the % (on the right)
                lString = decoder(lString); // decoding of the lString
                rString = decoder(rString);
                str = lString + "%" + rString;
            } else if (indexPlus != -1) { // if the string contains +
                lString = str.substring(0, indexPlus); // the substring of the string to the + (on the left)
                rString = str.substring(indexPlus+1, lenStr); // the substring of the string from the + (on the right)
                lString = decoder(lString); // dekodiranje lString-a
                rString = decoder(rString);
                str = lString + "+" + rString;
            } else {
                str = URLDecoder.decode(new String(str.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8");    
            }
        }
        return str;
    }
}


