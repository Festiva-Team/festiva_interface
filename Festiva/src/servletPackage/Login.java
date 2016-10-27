package servletPackage;

import standardPackage.*;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Alina Fankh�nel
 */
@WebServlet("/Login")
public class Login extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request
	 *            servlet request
	 * @param response
	 *            servlet response
	 * @throws ServletException
	 *             if a servlet-specific error occurs
	 * @throws IOException
	 *             if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String antwort = " ";
		String begr��ung = " ";

		Benutzer benutzer = BenutzerAdministration.selektiereBenutzer(request.getParameter("email"));

		if (benutzer != null) {
				if (benutzer.istGesperrt == true) {
					antwort = "Ihr Benutzerkonto wurde gesperrt. Bitte wenden Sie sich an den Administrator: admin@festiva.de";
					request.getSession(false).setAttribute("antwort", antwort);
					request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
					
				} else {
					if (benutzer.istGel�scht == true) {
						antwort = "Das Benutzerkonto mit dieser E-Mail-Adresse wurde gel�scht. Sollten Sie Fragen dazu haben, wenden Sie sich bitte an den Administrator: admin@festiva.de";
						request.getSession(false).setAttribute("antwort", antwort);
						request.getRequestDispatcher("k_anmelden.jsp").include(request, response);

					} else {
						if ((benutzer.passwortHash).equals(request.getParameter("passwort"))) {
						HttpSession session = request.getSession(true);
						session.setAttribute("userid", benutzer.id);
						session.setAttribute("gruppenid", benutzer.gruppenID);
						session.setMaxInactiveInterval(3600);

						
						if (benutzer.gruppenID == 1){
							RequestDispatcher dispatcher = request.getRequestDispatcher("a_startseiteAdmin.jsp");
							dispatcher.forward(request, response);
						} else {
							if((benutzer.vorname).equals("") && benutzer.nachname.equals("")) {
							begr��ung = "Herzlich Willkommen bei Festiva!";	
							} else {
							begr��ung = "Herzlich Willkommen bei Festiva, " + benutzer.vorname + " " + benutzer.nachname + "!";
							}
							request.getSession(false).setAttribute("begr��ung", begr��ung);
							request.getRequestDispatcher("k_startseite.jsp").include(request, response);

						}

						} else {
							antwort = "Sie haben ein falsches Passwort eingegeben. Bitte versuchen Sie es nochmal!";
							request.getSession(false).setAttribute("antwort", antwort);
							request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
						}
					}
				}
		} else {
			antwort = "Zu der eingegebenen E-Mail-Adresse konnte kein Benutzer gefunden werden. Bitte registieren Sie sich zuerst oder geben eine korrekte E-Mail-Adresse an!";
			request.getSession(false).setAttribute("antwort", antwort);
			request.getRequestDispatcher("k_anmelden.jsp").include(request, response);

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
     //   processRequest(request, response);
        
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