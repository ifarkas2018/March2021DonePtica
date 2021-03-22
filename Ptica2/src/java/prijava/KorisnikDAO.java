/*
 * autor   : Ingrid Farkaš
 * projekat: Ptica
 * KorisnikDAO.java: izvršava SQL upit (PrijavaServl.java - metod doPost, NoviNalogServl - metod doPost)
 */
package prijava;

import java.sql.*;
import konekcija.ConnectionManager;

public class KorisnikDAO {
    static Connection currentCon = null;
    static ResultSet rs = null;  // rezultat upita 
	
    // metod prijava vraća admin - za administratora, zaposleni - za zaposlenog koji nije admnistrator, none ako korisnik nije prijavljen 
    public static String prijava(String korIme, String lozinka) {
	
        String je_zaposleni = "false"; // da li je korisnik zaposleni
        String je_admin = "false"; // da li je korisnik administrator
        
        Statement stmt = null;       
	    
        // upit
        String upitPrijave = "select kor_ime, lozinka, administ from prijava where kor_ime = '"
                            + korIme
                            + "' AND lozinka = '"
                            + lozinka + "' COLLATE utf8mb4_0900_as_cs"
                            + ";";
	    
        try {
            currentCon = ConnectionManager.getConnection(); // povezivanje sa bazom 
            stmt = currentCon.createStatement(); 
            rs = stmt.executeQuery(upitPrijave);	// izvršavanje upita        
            
            if (rs.next()) { // korisnik sa unetim korisničkim imenom i lozinkom već postoji u bazi 
                je_admin = rs.getString("administ"); // da li je korisnik prijavljen kao administrator
                if (je_admin.equalsIgnoreCase("da")) { // ako je korisnik administrator tada on nije običan zaposleni 
                    je_zaposleni = "false";
                    je_admin = "true";
                } else { // ako je korisnik nije administrator tada je on običan zaposleni 
                    je_zaposleni = "true";
                    je_admin = "false";
                }
            }
        } catch (Exception ex) {
            System.out.println("Neuspela prijava: Izuzetak: " + ex);
        } 
	    
        // rukovanje izuzecima
        finally {
            if (rs != null) {
                try {
                    rs.close(); // zatvaranje objekta RecordSet 
                } catch (Exception e) {
                    e.printStackTrace();
                }
                rs = null;
            }
	
            if (stmt != null) {
                try {
                    stmt.close(); // zatvaranje objekta Statement
                } catch (Exception e) {
                    e.printStackTrace();
                }
                stmt = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close(); // zatvaranje objekta Connection 
                } catch (Exception e) {
                    e.printStackTrace();
                }
                currentCon = null;
            }
        }

        if (je_zaposleni.equals("true")) { // ako je korisnik prijavljen kao zaposleni, vraća "zaposleni"
            return "zaposleni";
        } else if (je_admin.equals("true")) { // ako je korisnik prijavljen kao admin vraća "admin"
            return "admin";
        } else { // ako se korisnik nije prijavio ni kao administrator ni kao zaposleni vraća "customer"
            return "customer";
        }
    }	
   
    // korPostoji: vraća TRUE ako korisnik sa unetim korisničkim imenom i lozinkom već postoji u bazi, inače vraća FALSE
    public static boolean korPostoji(String korIme, String lozinka) {
        boolean vrednost = false; // da li korisnik postoji
        
        Statement stmt = null;       
	    
        // upit za selektovanje korisnika sa unetim korisničkim imenom i lozinkom
        String upitKor = "select kor_ime, lozinka from prijava where kor_ime = '";
        upitKor += korIme + "'";
        upitKor += ";";
        
        try {
           currentCon = ConnectionManager.getConnection(); // povezivanje sa bazom 
           stmt = currentCon.createStatement(); 
           ResultSet rs = stmt.executeQuery(upitKor); // izvršavanje upita 
           if (rs.next())
               vrednost = true; // korisnik sa unetim korisničkim imenom i lozinkom već postoji u bazi 
           else
               vrednost = false; // korisnik ne postoji u bazi
        } catch (Exception ex) {
            System.out.println("Korisnik sa datim korisničkim imenom i lozinkom ne postoji: Izuzetak: " + ex);    
        } 
        
        // rukovanje izuzetkom
        finally {
            if (rs != null){
                try {
                    rs.close(); // zatvaranje objekta RecordSet
                } catch (Exception e) {
                    e.printStackTrace();
                }
                rs = null;
            } 
	
            if (stmt != null) {
                try {
                    stmt.close(); // zatvaranje objekta Statement
                } catch (Exception e) {
                    e.printStackTrace();
                }
                stmt = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close(); // zatvaranje objekta Connection
                } catch (Exception e) {
                    e.printStackTrace();
                }
                currentCon = null;
            }
        }
        return vrednost;
    }
           
    // noviNalog: vraća TRUE ako je novi korisnik uspešno dodat u tabelu prijava, inače vraća FALSE
    public static boolean noviNalog(String korIme, String lozinka, String ime, String admin) {
        boolean vrednost = false; // da li je dodavanje novog korisnika uspešno 
        
        PreparedStatement pStmt = null;       
	    
        // SQL upit
        String upitPrijave = "insert into prijava(kor_ime, lozinka";
        
        if (!ime.equals(""))
            upitPrijave += ", ime"; 

        upitPrijave += ", administ"; 
        upitPrijave += ") values ('" + korIme + "', '" + lozinka + "'";
        // ako je korisnik uneo ime dodaj ime upitu
        if (!ime.equals(""))
            upitPrijave += ", '" + ime + "'";
        // dodaj da li je novi korisnik administrator  
        if (admin.equals("adm_da"))
            upitPrijave += ", 'da'";
        else
            upitPrijave += ", 'ne'";
        upitPrijave += ");";
	    
        try {
           currentCon = ConnectionManager.getConnection(); // povezivanje sa bazom  
           pStmt = currentCon.prepareStatement(upitPrijave); 
           pStmt.execute(upitPrijave); // izvršavanje upita 
           vrednost = true; // novi korisnik je  uspešno dodat u bazu
        } catch (Exception ex) {
            System.out.println("Nije uspeo unos novog korisnika: Izuzetak: " + ex);    
        } 
        
        // rukovanje izuzetkom
        finally {	
            if (pStmt != null) {
                try {
                    pStmt.close(); // zatvarnje objekta PreparedStatement
                } catch (Exception e) {
                    System.out.println("Izuzetak: " + e); 
                }
                pStmt = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close(); // zatvaranje objekta Connection
                } catch (Exception e) {
                    System.out.println("Izuzetak: " + e); 
                }
                currentCon = null;
            }
        }
        return vrednost;
    }
}
