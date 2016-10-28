package servletPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import standardPackage.Benutzer;
import standardPackage.BenutzerAdministration;

/**
*
* @author Alina Fankhänel
*/
@WebServlet("/Registrierung")
public class Registrierung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registrierung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String emailBestätigung = request.getParameter("emailbestätigung");		
		String passwort = request.getParameter("passwort");
		String passwortBestätigung = request.getParameter("passwortbestätigung");
		
		String antwort = "";
		
		if (BenutzerAdministration.selektiereBenutzer(email) != null) {
			antwort = "Zu der eingegebenen E-Mail-Adresse existiert bereits ein Benutzerkonto. Verwenden Sie bitte eine andere E-Mail-Adresse.";
			
		} else {
		
		if(!email.equals(emailBestätigung)) {
			antwort = "Die beiden eingegebenen E-Mail-Adressen stimmen nicht überein. Registrierung wurde nicht durchgeführt.";
		} else {
			if(!passwort.equals(passwortBestätigung)) {
				antwort = "Die beiden eingegebenen Passwörter stimmen nicht überein. Registrierung wurde nicht durchgeführt.";
			} else {
				Benutzer benutzer = new Benutzer(-1, "", "", email, passwort, "", "", 0, "", false, "", "", false, false, 2);
				BenutzerAdministration.erstelleKunden(benutzer);
				antwort = "Die Registrierung wurde erfolgreich durchgeführt.";
			}
		}
		}
		request.getSession(false).setAttribute("antwort", antwort);
		
		if(request.getSession(false).getAttribute("gruppenid") == null) {
			request.getRequestDispatcher("k_registrieren.jsp").include(request, response);
		} else {
			int gruppenid = Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString());
			if(gruppenid == 1) {
				request.getRequestDispatcher("a_kundenAnlegen.jsp").include(request, response);
			} else {
				request.getRequestDispatcher("k_registrieren.jsp").include(request, response);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
