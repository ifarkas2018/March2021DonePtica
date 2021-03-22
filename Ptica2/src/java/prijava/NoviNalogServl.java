/*
 * Autor    : Ingrid Farkaš
 * Projekat : Ptica
 * NoviNalogServl.java : kada korisnik na stranici Novi nalog klikne na Pošaljite dugme tada se poziva ovaj servlet
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

public class NoviNalogServl extends HttpServlet {

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
            out.println("<title>Ptica - Novi nalog</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NoviNalogServl at " + request.getContextPath() + "</h1>");
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
            // pročitaj tekst iz polja kor_ime, loz1, ime, prezime, admin (novinal_obr.jsp) 
            String korIme = request.getParameter("kor_ime"); 
            korIme = korIme.trim(); // uklanjam prazan prostor sa početka i kraja stringa
            korIme = PticaMetodi.dekoder(korIme); // dekodiranje korisničkog imena (može da sadrži srpska slova)
            // ako je dužina unetog korisničkog imena duža nego veličina kolone kor_ime u tabeli prijava
            if (korIme.length() > PticaMetodi.DUZ_KOR_IME) {  
                korIme = korIme.substring(0, PticaMetodi.DUZ_KOR_IME); // u bazu podataka se zapisuje samo prvih DUZ_KOR_IME karaktera
            }
            
            String loz1 = request.getParameter("loz1");
            loz1 = loz1.trim(); // uklanjam prazan prostor sa početka i kraja stringa
            loz1 = PticaMetodi.dekoder(loz1); // dekodiranje lozinke (može da sadrži srpska slova)
            // ako je dužina unete lozinke duža nego veličina kolone lozinka u tabeli prijava
            if (loz1.length() > PticaMetodi.DUZ_LOZINKA) {  
                loz1 = loz1.substring(0, PticaMetodi.DUZ_LOZINKA); // u bazu podataka se zapisuje samo prvih DUZ_LOZINKA karaktera
            }
            
            String ime = request.getParameter("ime");
            ime = PticaMetodi.dekoder(ime); // dekodiranje imena (može da sadrži srpska slova)
            String prezime = request.getParameter("prezime");
            prezime = PticaMetodi.dekoder(prezime); 
            String admin = request.getParameter("admin");
            
            // izbrisiPrazno: uklanja prazan prostor sa početka i kraja stringa i zamenjuje 2 ili više prazna mesta (unutar stringa)
            // sa jednim praznim mestom
            ime = PticaMetodi.izbrisiPrazno(ime); 
            prezime = PticaMetodi.izbrisiPrazno(prezime);
            
            // dKosuC: poziva metod koji zamenjuje svaku pojavu \ sa \\\\ i zamenjuje svaku pojavu ' sa \\'
            ime = PticaMetodi.dKosuC(ime);
            prezime = PticaMetodi.dKosuC(prezime);
            korIme = PticaMetodi.dKosuC(korIme);
            loz1 = PticaMetodi.dKosuC(loz1);
            
            String celoIme = ime + " " + prezime;
            // ako je dužina unetog imena duža nego veličina kolone ime u tabeli prijava
            if (celoIme.length() > PticaMetodi.DUZ_IME) {  
                celoIme = celoIme.substring(0, PticaMetodi.DUZ_IME); // u bazu podataka se zapisuje samo prvih DUZ_IME karaktera
            }
            
            HttpSession hSesija = request.getSession(); // sesija kojoj ću da dodam varijable
            
            // metod korPostoji vraća TRUE ako korisnik sa tim korisničkim imenom i lozinkom postoji u bazi, inače vraća FALSE
            boolean korPostoji = KorisnikDAO.korPostoji(korIme, loz1); 
            if (korPostoji){ 
                // postavljanje varijabli sesije (da bi se prosledile u gr_uspeh.jsp) i prikazivanje veb stranice gr_uspeh.jsp
                String sNaslov = "Greška"; // koristi se za prosleđivanje naslova
                String sPoruka = "GR_KOR_POSTOJI"; // koristi se za prosleđivanje naslova	 
                hSesija.setAttribute("ime_izvora", "Novi nalog"); // naziv veb strane na kojoj sam sada
                hSesija.setAttribute("poruka", sPoruka); 
                hSesija.setAttribute("naslov", sNaslov); 
                hSesija.setAttribute("novi_korisnik", "false" ); // korisnik je završio unošenje novog naloga 
                response.sendRedirect("gr_uspeh.jsp"); // preusmeravanje na gr_uspeh.jsp     
            } else { // korisničko ime i lozinka ne postoje
                // noviNalog: vraća TRUE ako je novi korisnik uspešno dodat u tabelu login, inače vraća FALSE
                boolean rezultat = KorisnikDAO.noviNalog(korIme, loz1, celoIme, admin);

                if (rezultat){ // novi korisnik je uspešno dodat bazi 
                    // postavljanje varijabli sesije (da bi se prosledile u gr_uspeh.jsp) i prikazivanje veb stranice gr_uspeh.jsp
                    String sNaslov = "Novi nalog"; // za prosleđivanje naslova u JSP
                    String sPoruka = "USPEH_REGIST"; // za prosleđivanje poruke u JSP	 
                    hSesija.setAttribute("ime_izvora", "Novi nalog"); // naziv veb strane na kojoj sam sada
                    hSesija.setAttribute("poruka", sPoruka); 
                    hSesija.setAttribute("naslov", sNaslov); 
                    hSesija.setAttribute("novi_korisnik", "false" ); // korisnik je završio unošenje novog naloga 
                    response.sendRedirect("gr_uspeh.jsp"); // preusmeravanje na gr_uspeh.jsp   
                } else { // novi korisnik nije uspešno dodat bazi  
                    // postavljanje varijabli sesije (da bi se prosledile u gr_uspeh.jsp) i prikazivanje veb stranice gr_uspeh.jsp
                    String sNaslov = "Greška"; // za prosleđivanje naslova u JSP
                    String sPoruka = "GR_NOVI_KOR"; // za prosleđivanje poruke u JSP	 
                    hSesija.setAttribute("ime_izvora", "Novi nalog"); // naziv veb strane na kojoj sam sada
                    hSesija.setAttribute("poruka", sPoruka); 
                    hSesija.setAttribute("naslov", sNaslov); 
                    hSesija.setAttribute("novi_korisnik", "false"); // korisnik je završio unošenje novog naloga 
                    response.sendRedirect("gr_uspeh.jsp"); // preusmeravanje na gr_uspeh.jsp
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
