/*
 * autor   : Ingrid Farkaš
 * projekat: Ptica
 * DodajDAO.java : izvršavanje SQL upita (koristi se u DodajServlet.java)
 */
package dodaj;

import konekcija.ConnectionManager;
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

public class DodajDAO {
    static Connection con;
    static ResultSet rs = null;  // objekat gde ae čuvaju rezultati upita
    
    // izdPostoji: proverava da li slog sa unetim unetim imenom izdavača i gradom postoji. Ako ne postoji tada dodaje novi slog
    // ako je došlo do izuzetka onda vraća TRUE inače vraća FALSE
    public static boolean izdPostoji(String izdavac) {
        boolean izuzetak = false; // da li došlo do izuzetka
        Statement stmt;
        
        try {
            stmt = con.createStatement();
            rs = null;
       
            // Prvo proveravam da li u tabeli IZDAVAČ slog sa unetim IMENOM IZDAVAČA i GRADOM postoji
            // Da bih to uradila prvo izvršavam select upit u tabeli izdavač da bih proverila da li slog sa unetim imenom izdavača i gradom postoji
            // Ako select ne vrati slog tada treba da izvršim insert
            // 1. select upit
            String rs_upit = ""; 
          
            if (!((izdavac.equalsIgnoreCase("")))) {
                PreparedStatement preparedStmt;
                // proveri da li u bazi postoji samo ime izdavača bez grada
                rs_upit = "select br_izdavača from izdavač where (ime_izdavača = '" + izdavac + "');";
                rs = stmt.executeQuery(rs_upit);
                if (!rs.next()) {
                    // 2. insert upit
                    String upit = "insert into izdavač(ime_izdavača) values ('" + izdavac + "');";
                    preparedStmt = con.prepareStatement(upit);
                    preparedStmt.execute();
                }
            }
            izuzetak = false; // nije došlo do izuzetka
        } catch (SQLException e) {
            izuzetak = true; // došlo je do izuzetka
        }
        return izuzetak; // vraća da li je došlo do izuzetka
    }
   
    // autPostoji: proverava da li u tabeli AUTOR slog sa unetim IMENOM AUTORA postoji. Ako slog ne postoji tada dodaje slog.
    // ako je došlo do izuzetka vraća TRUE inače vraća FALSE 
    public static boolean autPostoji(String autor) {
        boolean izuzetak = false; // došlo je do izuzetka
        Statement stmt;
        
        try {
            String rs_upit = ""; 
            boolean prazno_polje = false; // da li je input polje prazno
            
            // tabela autor
            // Prvo proveravam da li u tabeli AUTOR slog sa unesenim IMENOM AUTORA postoji
            // Da bih to uradila ja prvo izvršavam select u tabeli autor da proverim da li slog sa unetim imenom autora postoji.
            // Ako select nije vratio ni jedan slog tada izvršavam insert
            // 1. select upit
            stmt = con.createStatement(); 
            rs_upit = "";
            rs = null;
            prazno_polje = false; // korisnik nije uneo ime autora u input polje
            // ako korisnik nije uneo ime autora tada ništa nije potrebno da se uradi, inače dodaj vrednosti u bazu
            if (autor.equalsIgnoreCase(""))
                prazno_polje = true; 
            if (!(prazno_polje)) {
                rs_upit = "select ime_autora from autor where (ime_autora = '" + autor + "');";
                rs = stmt.executeQuery(rs_upit);
                PreparedStatement preparedStmt;
                
                // 2. upit insert - slučaj kada autor sa tim imenom ne postoji u tabeli autor
                if (!rs.next()) {
                    String upit = "insert into autor (ime_autora) values ('" + autor + "');";
                    preparedStmt = con.prepareStatement(upit);
                    preparedStmt.execute();
                }
            }
            izuzetak = false; // nije došlo do izuzetka
        } catch (SQLException e) {
            izuzetak = true; // došlo je do izuzetka
        }
        return izuzetak; // vraća da li je došlo do izuzetka
    }
    
    // dodNovuKnj: dodaje novu knjigu u tebelu knjiga (vraća String na osnovu koga gr_uspeh.jsp prikazuje poruku)
    // poziva se iz DodajServlet.java, metod doPost
    public static String dodNovuKnj(HttpSession hSesija, String naslov, String autor, String izdavac, String isbn, String cena, String strane, String zanr, //
                                    String opis, String gd_izdav) {
        String povratniStr = ""; // String koji ovaj metod vraća 
        // objekati koji se koriste za pristup bazi
        Statement stmt = null;  
        PreparedStatement preparedStmt = null;
        rs = null;
        boolean izuzetak; // da li je došlo do izuzetka priliko pristupa bazi
        
        try {
            con = ConnectionManager.getConnection(); // povezivanje sa bazom
            stmt = con.createStatement();
            if (cena.equalsIgnoreCase("")) {
                cena = "0.00";
            }
        
            String rs_upit = ""; 
            boolean prazno_polje = false;
            
            // izdPostoji: proverava da li slog sa unetim unetim imenom izdavača postoji. Ako ne postoji tada dodaje nov slog
            // ako je došlo do izuzetka onda vraća TRUE inače vraća FALSE
            izuzetak = izdPostoji(izdavac);
            if (izuzetak)
                povratniStr = "GR_DODAJ";
            else {    
                // autPostoji: proverava da li u tabeli AUTOR slog sa unetim IMENOM AUTORA postoji. Ako slog ne postoji tada dodaje slog.
                // ako je došlo do izuzetka vraća TRUE inače vraća FALSE 
                izuzetak = autPostoji(autor);
                if (izuzetak)
                    povratniStr = "GR_DODAJ";
                else {
                    // da li knjiga sa tim naslovom postoji u tabeli KNJIGA
                    boolean isbn_postoji = false; // da li knjiga sa tim NASLOVOM ili ISBN-om već postoji u bazi

                    if (!isbn_postoji) {
                        rs_upit = "select isbn from knjiga where (isbn = '" + isbn + "');";
                        rs = stmt.executeQuery(rs_upit);
                        if (rs.next()) {
                            isbn_postoji = true;
                            povratniStr = "GR_NOVA_POST"; // rezultat dodavanja knjige u bazu
                        }
                    }
                    
                    // da li je korisnik uneo ime izdavača i ime autora i (naslov knjige ILI isbn) tada dodaj (insert) unesene vrednsti u bazu
                    if ((!isbn_postoji) && ((!(izdavac.equalsIgnoreCase(""))) && (!(autor.equalsIgnoreCase("")))) && ((!(naslov.equalsIgnoreCase(""))) || (!(isbn.equalsIgnoreCase(""))))) {
                        String upit = "insert into knjiga (br_autora, br_izdavača";
                        if (!(naslov.equalsIgnoreCase(""))) {
                            upit += ", naslov"; // dodaj "naslov" listi kolona   
                        }
                        if (!(isbn.equalsIgnoreCase(""))) {
                            upit += ", isbn"; // dodaj "isbn" listi kolona
                        }
                        if (!(cena.equalsIgnoreCase(""))) {
                            upit += ", cena"; // dodaj "cena" listi kolona
                        }
                        if (!(strane.equalsIgnoreCase(""))) {
                            upit += ", br_strana"; // dodaj "br_strana" listi kolona
                        }
                        if (!(zanr.equalsIgnoreCase(""))) {
                            upit += ", žanr"; // dodaj "žanr" listi kolona
                        }
                        if (!(opis.equalsIgnoreCase(""))) {
                            upit += ", opis"; // dodaj "opis" listi kolona
                        }
                        if (!(gd_izdav.equalsIgnoreCase(""))) {
                            upit += ", god_izdavanja"; // dodaj "god_izdavanja" listi kolona
                        }
                        
                        upit += ") values ((select br_autora from autor where ime_autora='" + autor + "'),"; // nađi br_autora za autora
                        upit += " (select br_izdavača from izdavač where (ime_izdavača='" + izdavac + "') "; // nađi br_izdavača za izdavača
                        upit += "), ";
                        if (!(naslov.equalsIgnoreCase(""))) {
                            upit += "'" + naslov + "'"; // dodaj naslov upitu
                        }
                        if ((!(naslov.equalsIgnoreCase(""))) && (!(isbn.equalsIgnoreCase("")))) {
                            upit +=  ", ";
                        }
                        if (!(isbn.equalsIgnoreCase(""))) {
                            upit += "'" + isbn + "'"; // dodaj isbn upitu 
                        }
                        if (!(cena.equalsIgnoreCase(""))) {
                            upit += ", '" + cena + "'"; // dodaj cenu upitu
                        }
                        if (!(strane.equalsIgnoreCase(""))) {
                            upit += ", '" + strane + "'"; // dodaj broj stranica upitu
                        }
                        if (!(zanr.equalsIgnoreCase(""))) {
                            upit += ", '" + zanr + "'"; // dodaj žanr upitu
                        }
                        if (!(opis.equalsIgnoreCase(""))) {
                            upit += ", '" + opis + "'"; // dodaj opis knjige upitu
                        }
                        if (!(gd_izdav.equalsIgnoreCase(""))) {
                            upit += ", '" + gd_izdav + "'"; // dodaj godinu izdavanja upitu
                        }
                        upit += ");";
                        
                        preparedStmt = con.prepareStatement(upit);
                        preparedStmt.execute(); // izvrši upit
                        
                        // Prikaži veb stranicu sa porukom da je knjiga uspešno dodata bazi
                        povratniStr = "USPEH_DOD"; // rezultat dodavanja knjige bazi
                    } 
                } // kraj else (od if (excOccured))
            } // kraj else (od if (excOccured))
        } catch (SQLException e) {
            povratniStr = "GR_DODAJ";
        }
        
        // rukovanje izuzetkom
        finally {
            if (con != null) {
                try {
                    con.close(); // zatvaranje objekta Connection
                } catch (Exception e) {
                    System.out.print("Izuzetak: ");
                    System.out.println(e.getMessage());
                }
                con = null;
            }
            
            if (rs != null) {
                try {
                    rs.close(); // zatvaranje objekta RecordSet
                } catch (Exception e) {
                    System.out.print("Izuzetak: ");
                    System.out.println(e.getMessage());
                }
                rs = null;
            }
	
            if (stmt != null) {
                try {
                    stmt.close(); // zatvaranje objekta Statement
                } catch (Exception e) {
                    System.out.print("Izuuzetak: ");
                    System.out.println(e.getMessage());
                }
                stmt = null;
            }
            
            if (preparedStmt != null) {
                try {
                    preparedStmt.close(); // zatvaranje objekta Statement
                } catch (Exception e) {
                    System.out.print("Izuuzetak: ");
                    System.out.println(e.getMessage());
                }
                preparedStmt = null;
            }
        }
        return povratniStr;
    }
}
