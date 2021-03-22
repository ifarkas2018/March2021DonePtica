/*
 * author : Ingrid Farkas
 * project : Aqua Bookstore
 * DetermineID.java : used in DelServlet.java
 */
package delservlet;

// importing packages
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class DetermineID {
    
    // for the author named auth_name returns the author id
    public String determineAuthID(String auth_name, Statement stmt) { 
        try {
            // creating the query SELECT au_id FROM author WHERE au_name='...';
            String authid = ""; // author ID
            
            // creating the query string
            String rs_query = "SELECT au_id "; 
            rs_query += "FROM author WHERE au_name='" + auth_name + "'";
            rs_query += ";";   
            
            // running the query
            ResultSet rs = stmt.executeQuery(rs_query);
            
            // if the query returned some records, retrieve the author id 
            if (rs.next()) 
                authid = rs.getString("au_id");
            return authid;
            
        } catch (SQLException ex) {
            return ""; // if an exception occurred return author id = ""
        }
    }
}
