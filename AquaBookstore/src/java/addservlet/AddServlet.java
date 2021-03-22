/*
 * author : Ingrid Farkas
 * project : Aqua Bookstore
 * AddServlet.java : when the user clicks on the Submit button (add_form.jsp) this servlet is called
 */
package addservlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import miscellaneous.AquaMethods;

public class AddServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */ 
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sTitle = "Add Book"; // used for passing the title to the error_succ.jsp
        HttpSession hSession = request.getSession();
        
        String form_publ = request.getParameter("publisher"); // the text entered as the publisher
        // if the lengh of the form_publ is longer then the size of the column publ_name (the table publisher)
        if (form_publ.length() > AquaMethods.PUBL_LEN) {  
            form_publ = form_publ.substring(0, AquaMethods.PUBL_LEN); // in the DB is written only first PUBL_LEN characters
        }
        
        String form_auth = request.getParameter("author"); // the text entered as the author
        // if the lengh of the form_auth is longer then the size of the column au_name (the table author)
        if (form_auth.length() > AquaMethods.AUTHOR_LEN) {  
            form_auth = form_auth.substring(0, AquaMethods.AUTHOR_LEN); // in the DB is written only first AUTHOR_LEN characters
        }
        
        String form_title = request.getParameter("title"); // the text entered as the title
        // if the lengh of the form_title is longer then the size of the column title (the table book)
        if (form_title.length() > AquaMethods.TITLE_LEN) {  
            form_title = form_title.substring(0, AquaMethods.TITLE_LEN); // in the DB is written only first TITLE_LEN characters
        }
        
        String form_isbn = request.getParameter("isbn"); // the text entered as the isbn
        // if the lengh of the form_isbn is longer then the size of the column isbn (the table book)
        if (form_isbn.length() > AquaMethods.ISBN_LEN) {  
            form_isbn = form_isbn.substring(0, AquaMethods.ISBN_LEN); // in the DB is written only first ISBN_LEN characters
        }
        
        String form_price = request.getParameter("price"); // the text entered as the price
        // if the lengh of the form_price is longer then the size of the column price (the table book)
        if (form_price.length() > AquaMethods.PRICE_LEN) {  
            form_price = form_price.substring(0, AquaMethods.PRICE_LEN); // in the DB is written only first PRICE_LEN characters
        }
        
        String form_pages = request.getParameter("pages"); // the text entered as pages
        // if the lengh of the form_pages is longer then the size of the column pages (the table book)
        if (form_pages.length() > AquaMethods.PG_LEN) {  
            form_pages = form_pages.substring(0, AquaMethods.PG_LEN); // in the DB is written only first PG_LEN characters
        }
        
        String form_categ = request.getParameter("category"); // the choice of the category
        String form_descr = request.getParameter("descr"); // the text entered as the description
        
        String form_yrpublished = request.getParameter("yrpublished"); // the text entered as the year when published 
        // if the lengh of the form_yrpublished is longer then the size of the column publ_year (the table book)
        if (form_yrpublished.length() > AquaMethods.PUBLYR_LEN) {  
            form_yrpublished = form_yrpublished.substring(0, AquaMethods.PUBLYR_LEN); // in the DB is written only first PUBLYR_LEN characters
        }
        
        form_price = form_price.replace(",", ""); // the price is represented with float
        
        // deleteSpaces: removes space characters from the begining and end of the string, and replaces 2 or more white spaces with single space
        // inside of the string
        form_title = AquaMethods.deleteSpaces(form_title);
        form_auth = AquaMethods.deleteSpaces(form_auth);
        form_isbn = AquaMethods.deleteSpaces(form_isbn);
        form_price = AquaMethods.deleteSpaces(form_price);
        form_pages = AquaMethods.deleteSpaces(form_pages);
        form_descr = AquaMethods.deleteSpaces(form_descr);
        form_publ = AquaMethods.deleteSpaces(form_publ);
        form_yrpublished = AquaMethods.deleteSpaces(form_yrpublished);
        
        // addBacksl replaces every occurence of \ with \\\\ and replaces every occurence of ' with \\'
        form_title = AquaMethods.addBacksl(form_title);
        form_auth = AquaMethods.addBacksl(form_auth);
        form_descr = AquaMethods.addBacksl(form_descr);
        form_publ = AquaMethods.addBacksl(form_publ);
        
        // method addNewBook adds a new book to the table book (returns a String based on which one the error_succ.jsp shows the message)
        String sMessage = AddDAO.addNewBook(hSession, form_title, form_auth, form_publ, form_isbn, form_price, form_pages, form_categ, form_descr, form_yrpublished);
        
        // depending on the value returned by the method addNewBook determine sTitle
        if ((sMessage.equals("ERR_ADD")) || (sMessage.equals("ERR_ADD_EXISTS"))) {
            sTitle = "Error"; // used for passing the title to the JSP
        } else if (sMessage.equals("SUCC_ADD")) {
            sTitle = "Add Book"; // used for passing the title to the JSP
        }
        
        hSession.setAttribute("source_name", "Add Book"); // on which page I am now
        hSession.setAttribute("message", sMessage); // setting the attribute message to the value sMessage
        hSession.setAttribute("title", sTitle); // setting the attribute message to the value sTitle
        response.sendRedirect("error_succ.jsp"); // redirects the response to error_succ.jsp                        
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
