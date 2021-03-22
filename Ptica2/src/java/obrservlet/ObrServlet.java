/*
 * autor           : Ingrid Farkaš
 * projekat        : Ptica
 * ObrServlet.java : koristi se za izvršavanje SQL upita (koristi se u azur_obr_knj.jsp za Brisanje knjige)
 */
package obrservlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Connection;
import konekcija.ConnectionManager;

import javax.servlet.http.HttpSession;
import razno.PticaMetodi;

@WebServlet(urlPatterns = {"/ObrServlet"}) // ako je URL /ObrServlet
public class ObrServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewObrServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewObrServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    // obrisi: briše knjigu sa određenim naslovom, autorom, ISBN iz baze
    // vratiStr: vraća se u doPost. Koristi se za postavljanje atributa u sesiji pre preusmeravanja na gr_uspeh.jsp
    private String obrisi(HttpSession hSesija) {
        String vratiStr = "NO_ERR"; // da li je došlo do greške i kakve
        
        try {
            String preth_naslov = (String)hSesija.getAttribute("preth_naslov");
            String preth_autor = (String)hSesija.getAttribute("preth_autor");
            String preth_isbn = (String)hSesija.getAttribute("preth_isbn");
        
            // izbrisiPrazno: uklanja prazan prostor sa početka i kraja stringa i zamenjuje 2 ili više prazna mesta (unutar stringa)
            // sa jednim praznim mestom
            preth_naslov = PticaMetodi.izbrisiPrazno(preth_naslov);
            preth_autor = PticaMetodi.izbrisiPrazno(preth_autor);
            preth_isbn = PticaMetodi.izbrisiPrazno(preth_isbn);
            
            Connection con = ConnectionManager.getConnection(); // povezivanje sa bazom 
            Statement stmt = con.createStatement();
            
            String upit = ""; 
            String braut = ""; // broj autora (kolona br_autora, tabela autor)
            boolean dodata_kol = false; // da li je ime kolone dodato upitu 
            OdrediID brAutObj = new OdrediID(); // koristi se za pozivanje metoda odrediBrAut(autor, stmt) 
            
            // ODREÐIVANJE BROJA AUTORA  
            if (!((preth_autor.equalsIgnoreCase("")))) {
                // odrediBrAut: formiranje i izvršavanje upita SELECT br_autora FROM autor WHERE ime_autora = '...';
                braut = brAutObj.odrediBrAut(preth_autor, stmt); // određujem ID autora za tog autora 
                
                // ako autor sa tim imenom ne postoji dodaj tog autora tabeli
                if (braut.equals("")) { // autor ne postoji u bazi
                    vratiStr = "GR_NEMA_BR_AUT";
                }
            }
            
            // upit: DELETE FROM knjiga WHERE naslov = '...' AND br_autora = '...' AND isbn = '...'; 
            upit = "DELETE FROM knjiga WHERE ";
            if (!(preth_naslov.equalsIgnoreCase(""))) { // ako je korisnik naslov 
                upit += "naslov = '" + preth_naslov + "' "; // dodaj upitu: naslov = '...'
                dodata_kol = true; // upit sadrži kolonu
            }
            
            if (!(braut.equalsIgnoreCase(""))) { // ako broj autora postoji
                if (dodata_kol == true ) // ako je ime jedne kolone dodate upitu dodaj AND
                    upit += "AND "; 
                
                upit += "br_autora = '" + braut + "' "; // dodaj upitu braut = '...'
                dodata_kol = true; // kolona je dodata upitu
            }
            
            // ako je korisnik uneo ISBN
            if (!(preth_isbn.equalsIgnoreCase(""))) {
                if (dodata_kol == true) // ako je kolona dodata upitu
                    upit += "AND "; // dodaj upitu AND
                
                upit += "isbn = '" + preth_isbn + "' "; // dodaj upitu isbn = '...'
                dodata_kol = true; // kolona je dodata upitu 
            }
            
            upit += ";";
            
            PreparedStatement preparedStmt = con.prepareStatement(upit);
            int brvrsta = preparedStmt.executeUpdate(); // izvršavanje upita
                        
            hSesija.setAttribute("ime_izvora", "Brisanje knjige"); // veb stranica gde sam sada
            
            String sPoruka; // koristi se za slanje poruke iz jednog JSP skripta u drugi
            if (brvrsta > 0) { // vrsta je obrisana
                vratiStr = "USPEH_BRIS";
            } else { 
                vratiStr = "BRIS_NEMA_KNJ";
            }
        } catch (Exception ex) {
            vratiStr = "GR_BRISANJE";
        }
        return vratiStr;
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession hSesija = PticaMetodi.vratiSesiju(request); // hSesija - koristi se za čuvanje informacije o tom korisniku
        String vratiStr = obrisi(hSesija);       
        
            String sNaslov = "Greška"; // koristi se za prosleđivanje naslova od jednog JSP skripta do drugog 
       
        // zavisno od vratiStr postavi varijable sesije (koristi se u gr_uspeh.jsp)
        if (vratiStr.equalsIgnoreCase("GR_NEMA_BR_AUT")) {
            String sPoruka = "GR_NEMA_BR_AUT"; // koristi se za prosleđivanje poruka od jednog JSP skripta do drugog 
            hSesija.setAttribute("ime_izvora", "Brisanje knjige"); // veb stranica gde sam sada
            hSesija.setAttribute("poruka", sPoruka);   
        } else if (vratiStr.equalsIgnoreCase("USPEH_BRIS")) { // koristi se za prosleđivanje poruka od jednog JSP skripta do drugog 
            String sPoruka = "USPEH_BRIS";
            sNaslov = "Brisanje knjige"; // koristi se za prosleđivanje naslova od jednog JSP skripta do drugog 
            hSesija.setAttribute("poruka", sPoruka); 
        } else if (vratiStr.equalsIgnoreCase("BRIS_NEMA_KNJ")) { // koristi se za prosleđivanje poruka od jednog JSP skripta do drugog 
            String sPoruka = "BRIS_NEMA_KNJ";
            hSesija.setAttribute("poruka", sPoruka); 
        } else { // vratiStr is GR_BRISANJE
            String sPoruka = "GR_BRISANJE"; // koristi se za prosleđivanje poruka od jednog JSP skripta do drugog
            hSesija.setAttribute("ime_izvora", "Brisanje knjige"); // veb stranica gde sam sada
            hSesija.setAttribute("poruka", sPoruka); 
        }
        hSesija.setAttribute("naslov", sNaslov); 
        request.getRequestDispatcher("gr_uspeh.jsp").forward(request,response); // preusmeravanje na gr_uspeh.jsp
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
