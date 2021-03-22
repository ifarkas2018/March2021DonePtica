/*
 * Autor       : Ingrid Farkaš
 * Projekat    : Ptica
 * NoviNalog.java : kada korisnik klikne na Novi nalog (u navigaciji) tada se poziva ovaj servlet
 */
package prijava;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NoviNalog extends HttpServlet {
    
public void procitajKolacice( HttpServletRequest request){
        Cookie[] kolacici = request.getCookies();
        
        for (Cookie kolacic : kolacici) {
                    // postavljanje vrednosti varijabli sesije na "" za varijable sa imenom input0, input1, ...
                    String ime_kolacic = kolacic.getName();
                    String value = kolacic.getValue(); 
                    value = value + " ";
                    
        }
}

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
        HttpSession hSesija = request.getSession(); // sesija
        hSesija.setAttribute("novi_korisnik", "true"); // korisnik vrši prijavu
        procitajKolacice(request);
        response.sendRedirect("novinal_str.jsp"); // preusmeravanje na gr_uspeh.jsp       
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
