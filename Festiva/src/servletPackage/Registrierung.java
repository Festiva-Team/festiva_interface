package servletPackage;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import standardPackage.Benutzer;
import standardPackage.BenutzerAdministration;
import standardPackage.DatenbankException;
import standardPackage.WarenkorbAdministration;

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
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		String email = request.getParameter("email");
		String emailBestätigung = request.getParameter("emailbestätigung");		
		String passwort = request.getParameter("passwort");
		String passwortBestätigung = request.getParameter("passwortbestätigung");
		
		String antwort = "";
		try{
		
		if (BenutzerAdministration.selektiereBenutzer(email) != null) {
			antwort = "Zu der eingegebenen E-Mail-Adresse existiert bereits ein Benutzerkonto. Verwenden Sie bitte eine andere E-Mail-Adresse.";
			
		} else {
		
		if(!email.equals(emailBestätigung)) {
			antwort = "Die beiden eingegebenen E-Mail-Adressen stimmen nicht überein. Registrierung wurde nicht durchgeführt.";
		} else {
			if(!passwort.equals(passwortBestätigung)) {
				antwort = "Die beiden eingegebenen Passwörter stimmen nicht überein. Registrierung wurde nicht durchgeführt.";
			} else {
				passwort = passwort + "76ZuOp(6?ssXY0";
				Benutzer benutzer = new Benutzer(-1, "", "", email, generiereHash(passwort), "", "", 0, "", false, "", "", false, false, 2);
				BenutzerAdministration.erstelleKunden(benutzer);
				WarenkorbAdministration.erstelleLeerenWarenkorb(benutzer.id);
				antwort = "Die Registrierung wurde erfolgreich durchgeführt.";
			}
		}
		}
		request.getSession(false).setAttribute("antwort", antwort);
		
		if(request.getSession(false).getAttribute("gruppenid") == null) {
			request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
		} else {
			int gruppenid = Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString());
			if(gruppenid == 1) {
				request.getRequestDispatcher("a_kundenAnlegen.jsp").include(request, response);
			} else {
				request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
			}
		}
		} catch (DatenbankException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Die angeforderte Seite ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	
	/**
	 * Methode zur Generierung eines Hash-Keys
	 * 
	 * @param p_input: String, der in einen Hash verwandelt werden soll
	 * @return String: Hash-Wert zu dem eingegebenen String
	 */
	public static String generiereHash(String p_input) {
		StringBuilder hash = new StringBuilder();

		try {
			MessageDigest sha = MessageDigest.getInstance("SHA-1");
			byte[] hashedBytes = sha.digest(p_input.getBytes());
			char[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
					'a', 'b', 'c', 'd', 'e', 'f' };
			for (int idx = 0; idx < hashedBytes.length; ++idx) {
				byte b = hashedBytes[idx];
				hash.append(digits[(b & 0xf0) >> 4]);
				hash.append(digits[b & 0x0f]);
			}
		} catch (NoSuchAlgorithmException e) {
			
		}

		return hash.toString();
	}

}
