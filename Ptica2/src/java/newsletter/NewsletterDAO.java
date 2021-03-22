/*
 * autor    : Ingrid Farkaš
 * projekat : Ptica
 * NewsletterDAO.java : rukuje izvršavanjem SQL upita (NewsletterServl.java, metod doPost)
 */
package newsletter;

import konekcija.ConnectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class NewsletterDAO {
    static Connection con; 
    static ResultSet rs = null;  // rezultat upita
   
    // metod addEmail dodaje novi email u tabelu newsletter
    // vraća "postoji" ako email već postoji u tabeli newsletter inače vraća TRUE ako je došlo do izuzetka, a vraća FALSE ako nije 
    // došlo do izuzetka
    public static String addEmail(String newslEmail) {
        String izuzetak = "false"; // da li je došlo do izuzetka prilikom pristupa bazi podataka
    
        try {
            con = ConnectionManager.getConnection(); // povezivanje sa bazom 
            ResultSet rs; // objekat gde se čuva rezultat upita
            Statement stmt = con.createStatement();
            
            // da li email već postoji u tabeli newsletter
            String upit = "select * from newsletter where email = '" + newslEmail + "';";
            rs = stmt.executeQuery(upit);
            if (!(rs.next())) { // ako email NE POSTOJI u bazi dodaj ga    
                PreparedStatement preparedStmt;
                // 2. insert upit
                upit = "insert into newsletter(email) values ('" + newslEmail + "');"; 
                preparedStmt = con.prepareStatement(upit);
                preparedStmt.execute();
            } else {
                izuzetak = "postoji";
            }
        } catch (SQLException e) {
            izuzetak = "true"; // došlo je do izuzetka
            return izuzetak;
        }
        return izuzetak; // vraća da li je došlo do izuzetka
    }
}
