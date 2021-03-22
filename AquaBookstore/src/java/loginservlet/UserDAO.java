/*
 * author : Ingrid Farkas
 * project : Aqua Bookstore
 * UserDAO.java : handles running the SQL query (LoginServlet.java - method doPost, SignUpServlet - method doPost)
 */
package loginservlet;

import java.sql.*;
import connection.ConnectionManager;

public class UserDAO {
    static Connection currentCon = null;
    static ResultSet rs = null;  // result of the query 
	
    // method login returns admin - for administrator, emp - for employee who is not an administrator, none if the user is not logged in  
    public static String login(String userName, String password) {
	
        String is_employee = "false"; // is the user an employee
        String is_admin = "false"; // is a user an administrator
        
        // preparing some objects for connection 
        Statement stmt = null;       
	    
        // the query
        String loginQuery = "select username, passw, adm from login where username='"
                            + userName
                            + "' AND passw='"
                            + password + "' COLLATE utf8mb4_0900_as_cs"
                            + ";";
	    
        try {
            currentCon = ConnectionManager.getConnection(); //connecting to database 
            stmt = currentCon.createStatement(); 
            rs = stmt.executeQuery(loginQuery);	// executing the query        
            
            if (rs.next()) { // the user with that username, password exists in the database
                is_admin = rs.getString("adm"); // is that an administrator login
                if (is_admin.equalsIgnoreCase("yes")) { // if the user is an administrator then he is not a regular employee
                    is_employee = "false";
                    is_admin = "true";
                } else { // if the user is not an administrator then he is a regular employee
                    is_employee = "true";
                    is_admin = "false";
                }
            }
        } catch (Exception ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        } 
	    
        // some exception handling
        finally {
            if (rs != null) {
                try {
                    rs.close(); // closing the RecordSet object
                } catch (Exception e) {
                    e.printStackTrace();
                }
                rs = null;
            }
	
            if (stmt != null) {
                try {
                    stmt.close(); // closing the Statement object
                } catch (Exception e) {
                    e.printStackTrace();
                }
                stmt = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close(); // closing the Connection object
                } catch (Exception e) {
                    e.printStackTrace();
                }
                currentCon = null;
            }
        }

        if (is_employee.equals("true")) { // if the user logged in as employee, then return "emp"
            return "emp";
        } else if (is_admin.equals("true")) { // if the user is logged in as admin then return "admin"
            return "admin";
        } else { // if the user is neither logged in as administrator nor as regular employee return "customer"
            return "customer";
        }
    }	
    
    // method userExists returns TRUE if the user with the entered username and password already exists in the DB, otherwise returns FALSE
    public static boolean userExists(String userName, String password) {
        boolean returnVal = false; // does the user exist
        
        // preparing some objects for connection 
        Statement stmt = null;       
	    
        // forming the query for selecting the users with the entered username and password
        String userQuery = "select username, passw from login where username='";
        userQuery += userName + "'";
        userQuery += ";";
        
        try {
           currentCon = ConnectionManager.getConnection(); //connecting to database 
           stmt = currentCon.createStatement(); 
           ResultSet rs = stmt.executeQuery(userQuery); // executing the query
           if (rs.next())
               returnVal = true; // the user with the entered username and password already exists in the DB
           else
               returnVal = false; // the user doesn't exist in the database
        } catch (Exception ex) {
            System.out.println("Selecting the user with the entered username and password failed: An Exception has occurred! " + ex);    
        } 
        
        // some exception handling
        finally {
            if (rs != null){
                try {
                    rs.close(); // closing the RecordSet object
                } catch (Exception e) {
                    e.printStackTrace();
                }
                rs = null;
            } 
	
            if (stmt != null) {
                try {
                    stmt.close(); // closing the Statement object
                } catch (Exception e) {
                    e.printStackTrace();
                }
                stmt = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close(); // closing the Connection object
                } catch (Exception e) {
                    e.printStackTrace();
                }

                currentCon = null;
            }
        }
        return returnVal;
    }
            
    // method signUp returns TRUE if the new user was successfully added to the table login, otherwise it returns FALSE
    public static boolean signUp(String userName, String password, String name, String admin) {
        boolean returnVal = false; // was the inserting of the new user successful
        
        // preparing some objects for connection 
        PreparedStatement pStmt = null;       
	    
        // the query
        String loginQuery = "insert into login( username, passw";
        
        // if the user entered a name
        if (!name.equals(""))
            loginQuery += ", name"; // add to the query , name

        loginQuery += ", adm"; // add to the query , adm
        loginQuery += " ) values ( '" + userName + "', '" + password + "'";
        // if the user entered a name add the name to the query
        if (!name.equals(""))
            loginQuery += ", '" + name + "'";
        // add whether the new user is the administrator 
        if (admin.equals("adm_yes"))
            loginQuery += ", 'yes'";
        else
            loginQuery += ", 'no'";
        loginQuery += " );";
	    
        try {
           currentCon = ConnectionManager.getConnection(); //connecting to database 
           pStmt = currentCon.prepareStatement(loginQuery); 
           pStmt.execute(loginQuery); // executing the query
           returnVal = true; // the new user was added successfully
        } catch (Exception ex) {
            System.out.println("Adding a new user failed: An Exception has occurred! " + ex);    
        } 
        
        // some exception handling
        finally {	
            if (pStmt != null) {
                try {
                    pStmt.close(); // closing the PreparedStatement object
                } catch (Exception e) {
                    System.out.println("An Exception has occurred! " + e); 
                }
                pStmt = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close(); // closing the Connection object
                } catch (Exception e) {
                    System.out.println("An Exception has occurred! " + e); 
                }
                currentCon = null;
            }
        }
        return returnVal;
    }
}
