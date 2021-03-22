/*
 * author : Ingrid Farkas
 * project : Aqua Bookstore
 * AddDAO.java : handles running the SQL query (used in AddServlet.java)
 */
package addservlet;

import connection.ConnectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpSession;

/**
 *
 * @author user
 */

public class AddDAO {
    static Connection con;
    static ResultSet rs = null;  // object where the query's results are stored
    
    // publExistsAdd : checks whether the record with the entered PUBLISHER NAME and CITY exists. If it doesn't then adds the new record.
    // if an exception occurred returns TRUE otherwise returns FALSE
    public static boolean publExistsAdd(String publisher) {
        boolean excOccurred = false; // did an exception occur
        Statement stmt;
        
        try {
            stmt = con.createStatement();
            rs = null;
        
            // First I check out whether in the table PUBLISHER record with the entered PUBLISHER NAME and CITY exists
            // To do that I do the select in the publisher table to check whether the record with entered publisher name and city exists.
            // If the select returns no record then I do the insert
            // 1. the select statement
            String rs_query=""; 
          
            if (!((publisher.equalsIgnoreCase("")))) {
                PreparedStatement preparedStmt;
                // check out whether in the database there could be only the name of the publisher and not the city 
                rs_query = "select publ_id from publisher where (publ_name = '" + publisher + "');";
                rs = stmt.executeQuery(rs_query);
                if (!rs.next()) {
                    // 2. the insert statement
                    String query = "insert into publisher(publ_name) values ('" + publisher + "');";
                    preparedStmt = con.prepareStatement(query);
                    preparedStmt.execute();
                }
            }
            excOccurred = false; // an axception didn't occur
        } catch (SQLException e) {
            excOccurred = true; // an axception occurred
        }
        return excOccurred; // return whether an exception occurred
    }
    
    // authExistsAdd : check whether in the table AUTHOR record with the entered AUTHOR's NAME exists. if the record doesn't exist then adds the record.
    // if an exception occurred returns TRUE otherwise returns FALSE
    public static boolean authExistsAdd(String author) {
        boolean excOccurred = false; // did an exception occur
        Statement stmt;
        
        try {
            String rs_query=""; 
            boolean empty_field = false; // is the input field empty

            // table author
            // First I check whether in the table AUTHOR record with the entered AUTHOR's NAME exists 
            // To do that I do the select in the author table to check whether the record with entered author's name exists.
            // If the select returns no record then I do the insert
            // 1. the select statement
            stmt = con.createStatement(); 
            rs_query = "";
            rs = null;
            empty_field = false; // the user entered a value in the author input field
            // if the user didn't enter anything for the author's name then nothing should be done, otherwise add the entered values to the 
            // database
            if (author.equalsIgnoreCase(""))
                empty_field = true; 
            if (!(empty_field)) {
                rs_query = "select au_name from author where (au_name = '" + author + "');";
                rs = stmt.executeQuery(rs_query);
                PreparedStatement preparedStmt;
                
                // 2. the insert statement - in case the author with that name doesn't exist in the table author
                if (!rs.next()) {
                    String query = "insert into author(au_name) values('" + author + "');";
                    preparedStmt = con.prepareStatement(query);
                    preparedStmt.execute();
                }
            }
            excOccurred = false; // an axception didn't occur
        } catch (SQLException e) {
            excOccurred = true; // an axception occurred
        }
        return excOccurred; // return whether an exception occurred
    }
    
    // method addNewBook adds a new book to the table book (returns a String based on which the error_succ.jsp shows the message)
    // called from the AddServlet.java, method doPost
    public static String addNewBook(HttpSession hSession, String title, String author, String publisher, String isbn, String price, String pages, String category, //
                                    String descr, String yrpublished) {
        String returnStr = ""; // the String returned by the method
        // preparing some objects for connection 
        Statement stmt = null;  
        PreparedStatement preparedStmt = null;
        rs = null;
        boolean excOccurred; // did an exception occure while accessing the DB
        
        try {
            con = ConnectionManager.getConnection(); //connecting to database
            stmt = con.createStatement();
        
            String rs_query=""; 
            boolean empty_field = false;
            
            // publExistsAdd : checks out whether the record with the entered PUBLISHER NAME exists. If it doesn't then adds the new record.
            // returns TRUE if an exception occurred otherwise it returns FALSE
            excOccurred = publExistsAdd(publisher);
            if (excOccurred)
                returnStr = "ERR_ADD";
            else {    
                // authExistsAdd : check whether in the table AUTHOR record with the entered AUTHOR's NAME exists. if the record doesn't exist then adds the record.
                // returns TRUE if an exception occurred otherwise it returns FALSE
                excOccurred = authExistsAdd(author);
                if (excOccurred)
                    returnStr = "ERR_ADD";
                else {
                    // does the book with that title exist in the table BOOK
                    // select title from book where title='title'
                    boolean isbn_exist = false; // whether the book with that TITLE or ISBN already exists in the database

                    if (!isbn_exist) {
                        rs_query = "select isbn from book where (isbn = '" + isbn + "');";
                        rs = stmt.executeQuery(rs_query);
                        if (rs.next()) {
                            isbn_exist = true;
                            returnStr = "ERR_ADD_EXISTS"; // the outcome of the adding the book to the DB
                        }
                    }

                    // if the user entered a publisher's AND author's name AND (the book's title OR isbn) then insert the entered values into the database
                    if ((!isbn_exist) && ((!(publisher.equalsIgnoreCase(""))) && (!(author.equalsIgnoreCase("")))) && ((!(title.equalsIgnoreCase(""))) || (!(isbn.equalsIgnoreCase(""))))) {
                        String query = "insert into book(au_id, publ_id";
                        if (!(title.equalsIgnoreCase(""))) {
                            query += ", title"; // add title to the list of the columns  
                        }
                        if (!(isbn.equalsIgnoreCase(""))) {
                            query += ", isbn"; // add isbn to the list of the columns
                        }
                        if (!(price.equalsIgnoreCase(""))) {
                            query += ", price"; // add price to the list of the columns
                        }
                        if (!(pages.equalsIgnoreCase(""))) {
                            query += ", pages"; // add pages to the list of the columns
                        }
                        if (!(category.equalsIgnoreCase(""))) {
                            query += ", category"; // add category to the list of the columns
                        }
                        if (!(descr.equalsIgnoreCase(""))) {
                            query += ", descr"; // add descr to the list of the columns
                        }
                        if (!(yrpublished.equalsIgnoreCase(""))) {
                            query += ", publ_year"; // add yrpublished to the list of the columns
                        }
                        
                        query += " ) values ((select au_id from author where au_name='" + author + "'),"; // determine the au_id for the author
                        query += " (select publ_id from publisher where (publ_name='" + publisher + "') "; // determine the publ_id for the publisher
                        query += " ),";
                        if (!(title.equalsIgnoreCase(""))) {
                            query += "'" + title + "'"; // add the title to the query
                        }
                        if ((!(title.equalsIgnoreCase(""))) && (!(isbn.equalsIgnoreCase("")))) {
                            query +=  ",";
                        }
                        if (!(isbn.equalsIgnoreCase(""))) {
                            query += "'" + isbn + "'"; // add the isbn to the query
                        }
                        if (!(price.equalsIgnoreCase(""))) {
                            query += ",'" + price + "'"; // add the price to the query
                        }
                        if (!(pages.equalsIgnoreCase(""))) {
                            query += ",'" + pages + "'"; // add the pages to the query
                        }
                        if (!(category.equalsIgnoreCase(""))) {
                            query += ",'" + category + "'"; // add the pages to the query
                        }
                        if (!(descr.equalsIgnoreCase(""))) {
                            query += ",'" + descr + "'"; // add the pages to the query
                        }
                        if (!(yrpublished.equalsIgnoreCase(""))) {
                            query += ",'" + yrpublished + "'"; // add the pages to the query
                        }
                        query += ");";
                        
                        preparedStmt = con.prepareStatement(query);
                        preparedStmt.execute(); // run the query
                        
                        // Show the page with the message that the book was successfully added to the database 
                        returnStr = "SUCC_ADD"; // the outcome of the adding the book to the DB
                    } 
                } // end of else ( of if (excOccured))
            } // end of else ( of if (excOccured))
        } catch (SQLException e) {
            returnStr = "ERR_ADD";
        }
        
        // some exception handling
        finally {
            if (con != null) {
                try {
                    con.close(); // closing the Connection object
                } catch (Exception e) {
                    System.out.print("The following error occured: ");
                    System.out.println(e.getMessage());
                }
                con = null;
            }
            
            if (rs != null) {
                try {
                    rs.close(); // closing the RecordSet object
                } catch (Exception e) {
                    System.out.print("The following error occured: ");
                    System.out.println(e.getMessage());
                }
                rs = null;
            }
	
            if (stmt != null) {
                try {
                    stmt.close(); // closing the Statement object
                } catch (Exception e) {
                    System.out.print("The following error occured: ");
                    System.out.println(e.getMessage());
                }
                stmt = null;
            }
            
            if (preparedStmt != null) {
                try {
                    preparedStmt.close(); // closing the Statement object
                } catch (Exception e) {
                    System.out.print("The following error occured: ");
                    System.out.println(e.getMessage());
                }
                preparedStmt = null;
            }
        }
        return returnStr;
    }
}
