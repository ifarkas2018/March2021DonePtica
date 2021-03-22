/*
 * author : Ingrid Farkas
 * project : Aqua Bookstore
 * SubscribeServl.java : after clicking on the Subscribe button (footer.jsp) this servlet is called
 */
package subscrservlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import miscellaneous.AquaMethods;

public class SubscrServl extends HttpServlet {

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
            out.println("<title>Aqua Books - Subscribe</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubscrServl at " + request.getContextPath() + "</h1>");
            out.println("Subscribe Servlet");
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String valid_email = "false"; // is the email valid
        String cookie_val = ""; // value of the cookie
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {	    
            HttpSession hSession2 = AquaMethods.returnSession(request);
            // if there is no cookie with name that starts with "input" then there are no data to be filled in 
            hSession2.setAttribute("fill_in", "false"); 
            
            // read the text from the subscr_email ( the footer.jsp ) - Email address for the subscription 
            String subscrEmail = request.getParameter("subscr_email"); // the text in the input field subscr_email ( footer.jsp )
            String pageName = "";
            if (AquaMethods.sessVarExists( hSession2, "webpg_name") ) {
                pageName = String.valueOf( hSession2.getAttribute("webpg_name") );
            }
            
            // if the index.jsp was shown before the user entered the email I don't need to read the cookies which contain the values 
            // of the input fields and to write them to the session variables 
            if ((!(pageName.equalsIgnoreCase("index.jsp"))) && (!(pageName.equalsIgnoreCase("contact_page.jsp"))) && 
                    (!(pageName.equalsIgnoreCase("about_page.jsp"))) && (!(pageName.equalsIgnoreCase("")))) {
                Cookie[] cookies = request.getCookies();
                boolean first_time = false; // is it the first cookie whose name starts with "input" 

                // going through the cookies
                for (Cookie cookie:cookies) {
                    // set the session variable values to "" for the variables named input0, input1, ...
                    String cookie_name = cookie.getName();
                    boolean is_input = cookie_name.startsWith("input", 0); // whether the cookie I have retrieved contains text from one of the input fileds

                    if (is_input) {
                        // if this is the first cookie whose key starts with input set the variable fill_in to true
                        // when I load the page if the fill_in is set to true that means that the fields of the form need to be field in with the values
                        // from session variables
                        if (!first_time) {
                            first_time = true;
                            hSession2.setAttribute("fill_in", "true");
                        }
                        cookie_val = cookie.getValue();
                        // I am adding this value to the session - because of the SUBSCRIPTION
                        // the IDEA of the SUBSCRIPTION : after entering the email address and clicking on the button (Subscribe) the page is shown whether
                        // the user successfully subscribed to the Newsletter - after that when the user clicks on the Close button the web page which was before
                        // loaded has to be loaded with the values - these values are the values I am writing to the session
                        hSession2.setAttribute(cookie_name, cookie_val);
                    }
                }  
            }
            
            String exOccurred = "false";
            
            Cookie[] cookies = request.getCookies();
            // going throught the cookies
            for (Cookie cookie:cookies) {
                String cookie_name = cookie.getName();
                if (cookie_name.equalsIgnoreCase("valid_email")){
                    // is the email valid
                    valid_email = cookie.getValue();
                    // create a session var. named cookie_name with the value valid_email
                    hSession2.setAttribute(cookie_name, valid_email);
                }
            }
            
            // method addEmail adds the new email for the subscription to the table subscription
            // returns TRUE if an exception occurred, otherwise it returns FALSE
            if (valid_email.equalsIgnoreCase("true")) {
                exOccurred = SubscrDAO.addEmail(subscrEmail);
            }
            hSession2.setAttribute("db_exoccurred", exOccurred );
            // show the page subscrres_page.jsp
            response.sendRedirect("subscrres_page.jsp"); // redirects the response to subscrres_page.jsp
        } catch (Exception e){ // Throwable
            System.out.print("The following error occured: ");
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
