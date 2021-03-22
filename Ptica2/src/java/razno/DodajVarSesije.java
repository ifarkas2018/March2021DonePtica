/*
 * autor    : Ingrid Farkaš
 * projekat : Ptica
 * DodajVarSesije.java : ovaj servlet se koristi za čitanje vrednosti kolačića (JavaScript) a zatim se dodaju varijablama sesije
 */
package razno;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DodajVarSesije", urlPatterns = {"/DodajVarSesije"})
public class DodajVarSesije extends HttpServlet {

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
            out.println("<title>Ptica</title>");            
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);
            // postaviNaPrazno: postavljanje vrednosti varijabli sesije input0, input1, ... na ""
            PticaMetodi.postaviNaPrazno(hSesija2); 
            
            Cookie[] kolacici = request.getCookies(); // niz koji sadrži kolačiće
            for (Cookie kolacic:kolacici) {
                // ime kolačića
                String ime_kolacic = kolacic.getName();

                // da li je ime kolačića popunjeno
                boolean je_popunjeno = ime_kolacic.startsWith("popunjeno", 0); 
                boolean je_imevstr = ime_kolacic.equalsIgnoreCase("ime_vebstr");

                String vr_kolacic = kolacic.getValue();
                // ako kolačić sadrži ime veb stranice koja treba da se prikaže postavi varijablu sesije ime_kolacic (= ime_vebstr)
                // na vrednost vr_kolacic
                if ((je_imevstr) || (je_popunjeno))
                    hSesija2.setAttribute(ime_kolacic, vr_kolacic);
            }
            String imeVebStr = "";
            if (PticaMetodi.varSesijePostoji(hSesija2, "ime_vebstr")) {
                imeVebStr = String.valueOf(hSesija2.getAttribute("ime_vebstr"));
            }
            
            response.sendRedirect(imeVebStr); // preusmeravanje na veb stranicu sa imenom imeVebStr 
        }
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
