/*
 * autor   : Ingrid Farkaš
 * projekat: Ptica
 * OdrediID.java : koristi se u ObrServlet.java
 */
package obrservlet;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class OdrediID {
    
    // za autora sa imenom ime_aut vraća author id
    public String odrediBrAut(String ime_aut, Statement stmt) { 
        try {
            // formiranje upita SELECT br_autora FROM autor WHERE ime_autora = '...';
            String braut = ""; // broj autora
            
            // formiranje upita
            String rs_upit = "SELECT br_autora "; 
            rs_upit += "FROM autor WHERE ime_autora = '" + ime_aut + "'";
            rs_upit += ";";   
            
            // izvršavanje upita
            ResultSet rs = stmt.executeQuery(rs_upit);
            
            // ako rezultat upita sadrži slogove, nalazim broj autora 
            if (rs.next()) 
                braut = rs.getString("br_autora");
            return braut;
            
        } catch (SQLException ex) {
            return ""; // ako je došlo do izuzetka vraćam broj autora = ""
        }
    }
}
