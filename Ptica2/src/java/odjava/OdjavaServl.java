/*
 * autor   : Ingrid Farkaš
 * projekat: Ptica
 * OdjavaServl.java : kada korisnik klikne na link Odjava ( u navigaciji ) ovaj servlet se poziva
 */
package odjava;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/OdjavaServlet"}) // ako je URL /OdjavaServlet
public class OdjavaServl extends HttpServlet {

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
            out.println("<title>APtica - Log Out</title>");            
            out.println("</head>");
            out.println("<body>");
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
        HttpSession hSesija = request.getSession(); // sesija kojoj ću dodati varijablu
        hSesija.setAttribute("prijavljen", "false"); // da li je korisnik prijavljen 
        hSesija.setAttribute("zap_adm", "false"); // korisnik ne koristi više veb sajtu za zaposlene ili administratore
        hSesija.setAttribute("tip_koris", "customer"); // vrsta korisnika
        String sNaslov = "Odjava"; // za prosleđivanje naslova 
        String sPoruka = "USPEH_ODJAVA"; // koristi se za prosleđivanje poruke	 
        hSesija.setAttribute("ime_izvora", "Odjava"); // veb stranica na kojoj sam sada
        hSesija.setAttribute("poruka", sPoruka); 
        hSesija.setAttribute("naslov", sNaslov); 
        response.sendRedirect("gr_uspeh.jsp"); // prikazujem stranicu sa porukom za grešku    
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
        processRequest(request, response);
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
