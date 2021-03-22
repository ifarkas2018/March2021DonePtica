/*
 * autor   : Ingrid Farkaš
 * projekat: Ptica
 * PrijavaServl.java : kada korisnik klikne na dugme Prijava (login_form.jsp) tada se poziva ovaj servlet
 */
package prijava;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import razno.PticaMetodi;

public class PrijavaServl extends HttpServlet {

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
            out.println("<title>Ptica - Login</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PrijavaServl at " + request.getContextPath() + "</h1>");
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    // kada korisnik klikne na dugme Prijava (login_form.jsp) tada se poziva ovaj metod
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            // pročitaj korisničko ime (login_form.jsp)
            String korIme = request.getParameter("kor_ime"); 
            korIme = korIme.trim(); // izbriši prazno mesto sa početka i kraja
            korIme = PticaMetodi.dekoder(korIme); // dekodiranje kor. imena (može da sadrži srpska slova)
            
            // pročitaj lozinku (login_form.jsp)
            String lozinka = request.getParameter("lozinka");
            lozinka = lozinka.trim(); // izbriši prazno mesto sa početka i kraja
            lozinka = PticaMetodi.dekoder(lozinka); // dekodiranje lozinke (može da sadrži srpska slova)
            
            // dKosuC: poziva metod koji zamenjuje svaku pojavu \ sa \\\\ i zamenjuje svaku pojavu ' sa \\'
            korIme = PticaMetodi.dKosuC(korIme);
            lozinka = PticaMetodi.dKosuC(lozinka);
            
            // metod prijava vraća admin - za administratora, zaposleni - za zaposlenog koji nije admnistrator, none ako korisnik nije prijavljen 
            String tipKorisnika = KorisnikDAO.prijava(korIme, lozinka);
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            if (tipKorisnika.equals("zaposleni")) { // prijava zaposelnog
                hSesija.setAttribute("tip_koris", "zaposleni"); // korisnik koji se prijavio kao zaposleni (može sve da uradi izuzev da doda novi nalog)
                hSesija.setAttribute("prijavljen", "true" ); // postavi varijablu sesije prijavljen (da li se korisnik prijavio)
                response.sendRedirect("index.jsp");     
            } else if (tipKorisnika.equals("admin")) { // prijava administratora
                hSesija.setAttribute("tip_koris", "admin"); // korisnik se prijavio kao administrator (može sve da uradi)
                hSesija.setAttribute("prijavljen", "true" ); // postavi varijablu sesije prijavljen (da li se korisnik prijavio)
                response.sendRedirect("index.jsp"); // prikaži index.jsp - korisnik se prijavio    
            } else {
                // postavljanje vrednosti varijabli sesije
                String sNaslov = "Greška"; // koristi se za prosleđivanje naslova
                String sPoruka = "GR_PRIJAVA"; // koristi se za prosleđivanje naslova	 
                hSesija.setAttribute("ime_izvora", "Prijava"); // naziv veb strane na kojoj sam sada
                hSesija.setAttribute("poruka", sPoruka); 
                hSesija.setAttribute("naslov", sNaslov); 
                hSesija.setAttribute("prijavljen", "false"); // da li se korisnik prijavljen
                response.sendRedirect("gr_uspeh.jsp"); // preusmeravanje na gr_uspeh.jsp                            
            }
        } catch (Throwable theException) {
            System.out.println(theException); 
        }
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
