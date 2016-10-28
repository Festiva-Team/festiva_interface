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
* @author Alina Fankh�nel
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
		String emailBest�tigung = request.getParameter("emailbest�tigung");		
		String passwort = request.getParameter("passwort");
		String passwortBest�tigung = request.getParameter("passwortbest�tigung");
		
		String antwort = "";
		
		if (BenutzerAdministration.selektiereBenutzer(email) != null) {
			antwort = "Zu der eingegebenen E-Mail-Adresse existiert bereits ein Benutzerkonto. Verwenden Sie bitte eine andere E-Mail-Adresse.";
			
		} else {
		
		if(!email.equals(emailBest�tigung)) {
			antwort = "Die beiden eingegebenen E-Mail-Adressen stimmen nicht �berein. Registrierung wurde nicht durchgef�hrt.";
		} else {
			if(!passwort.equals(passwortBest�tigung)) {
				antwort = "Die beiden eingegebenen Passw�rter stimmen nicht �berein. Registrierung wurde nicht durchgef�hrt.";
			} else {
				Benutzer benutzer = new Benutzer(-1, "", "", email, passwort, "", "", 0, "", false, "", "", false, false, 2);
				BenutzerAdministration.erstelleKunden(benutzer);
				antwort = "Die Registrierung wurde erfolgreich durchgef�hrt.";
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
