/*
 * autor    : Ingrid Farkaš
 * projekat : Ptica
 * NewsletterServl.java : posle klika na dugme Prijavite se (footer.jsp) poziva se ovaj servlet
 */
package newsletter;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import razno.PticaMetodi;

public class NewsletterServl extends HttpServlet {

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
            out.println("<title>Ptica - Subscribe</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewsletterServl at " + request.getContextPath() + "</h1>");
            out.println("Subscribe Servlet");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    
    public void procitajKolacice(HttpServletRequest request){
        Cookie[] kolacici = request.getCookies();
        
        for (Cookie kolacic : kolacici) {
            // postavljanje vrednosti varijabli sesije na "" za varijable sa imenom input0, input1, ...
            String ime_kolacic = kolacic.getName();
            String value = kolacic.getValue(); // vrednost kolačića
            value = value + " ";      
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
        
        String valid_email = "false"; // da li je to važeći email 
        String vr_kolacic = ""; // vrednost kolačića
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {	    
            HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);
            // ako ne postoji kolačić čije ime počinje sa "input" tada nema podataka kojima treba da se popuni formular
            hSesija2.setAttribute("popunjeno", "false");
            
            // čitanje teksta iz newsl_email (footer.jsp) - email adresa za Newsletter
            String newslEmail = request.getParameter("newsl_email"); // tekst u input kontroli newsl_email (footer.jsp)
            newslEmail = PticaMetodi.dekoder(newslEmail); // može da sadrži ćĆčČšŠžŽđĐ
            String imeVebStr = "";
            if (PticaMetodi.varSesijePostoji(hSesija2, "ime_vebstr") ) {
                imeVebStr = String.valueOf(hSesija2.getAttribute("ime_vebstr"));
            }
           
            // ako je pre unošenja email-a jedna od veb stranica (index.jsp, contact_page.jsp, onama_str.jsp) bila prikazana nije potrebno
            // da čitam kolačiće koji sadrže vrednosti input polja i da ih čuvam u varijablama sesije 
            if ((!(imeVebStr.equalsIgnoreCase("index.jsp"))) && (!(imeVebStr.equalsIgnoreCase("contact_page.jsp"))) && 
                    (!(imeVebStr.equalsIgnoreCase("onama_str.jsp"))) && (!(imeVebStr.equalsIgnoreCase("")))) {
                Cookie[] kolacici = request.getCookies();
                boolean prvi_put = false; // da li je prvi kolačić čije ime počinje sa "input" 

                // prolazim kroz kolačiće
                for (Cookie kolacic : kolacici) {
                    // postavljanje vrednosti varijabli sesije na "" za varijable sa imenom input0, input1, ...
                    String ime_kolacic = kolacic.getName();
                    // da li kolačić koji sam pročitala sadrži tekst koji je bio u jednom od input polja
                    boolean je_input = ime_kolacic.startsWith("input", 0); 

                    if (je_input) {
                        // ako je ovo prvi kolačić čije ime počinje sa "input" postavi varijablu popunjeno na true
                        // kada učitam stranicu ako je popunjeno postavljen na true tada obrazac treba da se popuni sa vrednostima iz 
                        // varijabli sesije
                        if (!prvi_put) {
                            prvi_put = true;
                            hSesija2.setAttribute("popunjeno", "true");
                        }
                        vr_kolacic = kolacic.getValue();
                        
                        // dodajem ovu vrednost sesiji zbog prijave na NEWSLETTER
                        // IDEJA prijave na NEWSLETTER: posle unosa email adrese i klika na dugme (prijava na Newsletter) korisnik se uspešno 
                        // prijavio na Newsletter - posle toga kada korisnik klikne na Zatvori dugme veb stranica koja je bila prethodno prikazana
                        // treba da se popuni sa vrednostima - ove vrednosti su vrednosti koje treba da zapamtim u sesiji
                        hSesija2.setAttribute(ime_kolacic, vr_kolacic);
                    }
                }  
            }
            
            String izuzetak = "false";
            
            Cookie[] kolacici = request.getCookies();
            // prolazim kroz kolačiće
            for (Cookie kolacic : kolacici) {
                String ime_kolacic = kolacic.getName();
                if (ime_kolacic.equalsIgnoreCase("valid_email")){
                    // da li je to važeći email 
                    valid_email = kolacic.getValue();
                    // formiram varijablu sesije sa imenom ime_kolacic koja sadrži vrednost valid_email 
                    hSesija2.setAttribute(ime_kolacic, valid_email);
                }
            }
            
            // metod addEmail dodaje emajl za Newsletter u tabelu subscription
            // vraća TRUE ako je došlo do izuzetka inače vraća FALSE 
            if (valid_email.equalsIgnoreCase("true")) {
                izuzetak = NewsletterDAO.addEmail(newslEmail);
            }
            hSesija2.setAttribute("baza_izuzetak", izuzetak);
            procitajKolacice(request);
            // prikaži veb stranicu newsletter_str.jsp
            response.sendRedirect("newsletter_str.jsp"); 
        } catch (Exception e){ // Throwable
            System.out.print("Izuzetak: ");
            System.out.println(e.getMessage());
        }
    }

    /**.
     * Returns a short description of the servlet     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
