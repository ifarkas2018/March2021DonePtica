/*
 * author : Ingrid Farkas
 * project : Lesen
 * SubscrDAO.java : handles running the SQL query (SubscrServl.java, method doPost)
 */
package subscrservlet;

import connection.ConnectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SubscrDAO {
    static Connection con; 
    static ResultSet rs = null;  // result of the query 
    
    // method addEmail adds the new email for the subscription to the table subscription
    // returns "exists" if the email already exists in the subscription table otherwise returns TRUE if an exception occurred,
    // it returns FALSE if the exception didn't occur
    public static String addEmail(String subscrEmail) {
        String excOccurred = "false"; // did an exception occure while accessing the DB
    
        try {
            con = ConnectionManager.getConnection(); //connecting to database 
            ResultSet rs; // object where the query's results are stored
            Statement stmt = con.createStatement();
            
            // does that email already exist in the table subscription
            String query = "select * from subscription where email='" + subscrEmail + "';";
            rs = stmt.executeQuery(query);
            if (!(rs.next())) { // if the email doesn't exist in the database ADD it to the DB    
                PreparedStatement preparedStmt;
                // 2. the insert statement
                query = "insert into subscription(email) values ('" + subscrEmail + "');"; 
                preparedStmt = con.prepareStatement(query);
                preparedStmt.execute();
            } else {
                excOccurred = "exists";
            }
        } catch (SQLException e) {
            excOccurred = "true"; // an axception occurred
            return excOccurred;
        }
        return excOccurred; // return whether an exception occurred
    }
}
