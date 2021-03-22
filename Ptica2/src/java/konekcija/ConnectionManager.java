/*
 * autor   : Ingrid Farkaš
 * projekat: Ptica
 * ConnectionManager.java: povezivanje sa bazom
 */
package konekcija;

import java.sql.*;

public class ConnectionManager {
    static Connection con;
    static String url;
            
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3305/knjige?useSSL=false"; // !!!!!!!!!! useUnicode=yes&characterEncoding=UTF-8&
            try { 
               // povezivanje sa bazom, sa korisničkim imenom: "root" i lozinkom: "bird&2018" 
               con = DriverManager.getConnection(url, "root", "bird&2018"); 
            }
            
            catch (SQLException ex) {
               ex.printStackTrace();
               
            }
        }

        catch (ClassNotFoundException e)
        {
            System.out.println(e);
        }
        return con;
    }
}
    

