/*
 * author  : Ingrid Farkas
 * project : Lesen
 * SignUpServlet.java : when the user clicks on the Sign Up page on the "Submit" button this servlet is triggered
 */
package loginservlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import miscellaneous.LesenMethoden;

public class SignUpServlet extends HttpServlet {

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
            out.println("<title>Lesen - Registrieren</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpServlet at " + request.getContextPath() + "</h1>");
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
        
        try {	    
            // read the text from the username, passw1, first_name, last_name, admin (the signup_form.jsp) 
            String userName = request.getParameter("username"); 
            userName = userName.trim(); // removing the empty space from the begining and the end of the string
            userName = LesenMethoden.decoder(userName); // decoding of the user name (could contain äÄöÖüÜß)
            // if the lengh of the userName is longer then the size of the column username (table login)
            if (userName.length() > LesenMethoden.USR_NAME_LEN) {  
                userName = userName.substring(0, LesenMethoden.USR_NAME_LEN); // in the DB is written only first USR_NAME_LEN characters
            }
            
            String password = request.getParameter("passw1");
            password = password.trim(); // removing the empty space from the begining and the end of the string
            password = LesenMethoden.decoder(password); // decoding of the password (could contain äÄöÖüÜß)
            // if the lengh of the password is longer then the size of the column passw (table login)
            if (password.length() > LesenMethoden.PASSW_LEN) {  
                password = password.substring(0, LesenMethoden.PASSW_LEN); // in the DB is written only first PASSW_LEN characters
            }
            
            String anrede = request.getParameter("anrede");
            String first_name = request.getParameter("first_name");
            first_name = LesenMethoden.decoder(first_name); // decoding of the first name (could contain äÄöÖüÜß)
            String last_name = request.getParameter("last_name");
            last_name = LesenMethoden.decoder(last_name); // decoding of the last name (could contain äÄöÖüÜß)
            String admin = request.getParameter("admin");
            
            // deleteSpaces: removes space characters from the begining and end of the string, and replaces 2 or more white spaces with single space
            // inside of the string
            first_name = LesenMethoden.deleteSpaces(first_name);
            last_name = LesenMethoden.deleteSpaces(last_name);
            
            // addBacksl replaces every occurence of \ with \\\\ and replaces every occurence of ' with \\'
            first_name = LesenMethoden.addBacksl(first_name);
            last_name = LesenMethoden.addBacksl(last_name);
            userName = LesenMethoden.addBacksl(userName);
            password = LesenMethoden.addBacksl(password);
            
            String name = first_name + " " + last_name;
            // if the lengh of the name is longer then the size of the column name (table login)
            if (name.length() > LesenMethoden.NAME_LEN) {  
                name = name.substring(0, LesenMethoden.NAME_LEN); // in the DB is written only first NAME_LEN characters
            }
            
            HttpSession hSession = request.getSession(); // retrieve the session to which I am going to add variables
            
            // method userExists returns TRUE if the user with the entered username and password already exists in the DB, otherwise returns FALSE
            boolean userExists = UserDAO.userExists(userName, password); 
            if (userExists){ 
                // setting the hSession (to pass them to the page error_succ.jsp) and loading the page error_succ.jsp
                String sTitle = "Registrieren"; 
                String sMessage = "ERR_USER_EXISTS"; 	 
                hSession.setAttribute("source_name", "Registrieren"); // on which page I am now
                hSession.setAttribute("message", sMessage); 
                hSession.setAttribute("title", sTitle); 
                hSession.setAttribute("sign_up", "false" ); // set the session variable sign_up (the user finished signing up)
                response.sendRedirect("error_succ.jsp"); // show the page with the message the new user signed up successfully 
            } else { // the username and password doesn't exist
                // method signup returns TRUE if the new user was successfully added to the table login, otherwise it returns FALSE
                boolean result = UserDAO.signUp(userName, password, anrede, name, admin);

                if (result){ // the new user was added to the database successfully 
                    // setting the hSession (to pass them to the page error_succ.jsp) and loading the page error_succ.jsp
                    String sTitle = "Registrieren"; 
                    String sMessage = "SUCC_SIGN_UP"; 	 
                    hSession.setAttribute("source_name", "Registrieren"); // on which page I am now
                    hSession.setAttribute("message", sMessage); 
                    hSession.setAttribute("title", sTitle); 
                    hSession.setAttribute("sign_up", "false" ); // set the session variable sign_up (the user finished signing up)
                    response.sendRedirect("error_succ.jsp"); // show the page with the message the new user signed up successfully 
                } else { // the new user was not added to the database successfully 
                    // setting the hSession (to pass them to the page error_succ.jsp) and loading the page error_succ.jsp
                    String sTitle = "Registrieren"; 
                    String sMessage = "ERR_SIGN_UP";  
                    hSession.setAttribute("source_name", "Registrieren"); // on which page I am now
                    hSession.setAttribute("message", sMessage); 
                    hSession.setAttribute("title", sTitle); 
                    hSession.setAttribute("sign_up", "false"); // set the session variable sign_up (the user wasn't signed up )
                    response.sendRedirect("error_succ.jsp"); // show the page with the message the new user signed up successfully 
                }
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
