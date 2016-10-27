package servletPackage;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import standardPackage.*;

/**
*
* @author Alina Fankh�nel
*/
@WebServlet("/Kundendaten")
public class Kundendaten extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Kundendaten() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		String antwort = "";
		
		if(session != null && session.getAttribute("begr��ung") != null) {
			
			int userid = Integer.parseInt(session.getAttribute("userid").toString());
			Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(userid);
			
			if ((request.getParameter("aktion")).equals("anzeigen")) {
				
				session.setAttribute("benutzer", benutzer);
				request.getRequestDispatcher("k_kundendaten.jsp").include(request, response);
				
			} else {
				if ((request.getParameter("aktion")).equals("aendern")) {
					
					String vorname = request.getParameter("vorname");
					String nachname = request.getParameter("nachname");
					String eMail = request.getParameter("email");
					String strasse = request.getParameter("strasse");
					String hausnummer = request.getParameter("hausnummer");
					int plz = 0;
					try{
						plz = Integer.parseInt(request.getParameter("plz"));
					} catch (Exception e) {
						e.printStackTrace();
						plz = 0;
					}
					
					String ort = request.getParameter("ort");	
					String iban = request.getParameter("iban");
					String bic = request.getParameter("bic");
					
					String passwort = benutzer.passwortHash;
					boolean istGesperrt = benutzer.istGesperrt;
					boolean istGel�scht = benutzer.istGel�scht;
					boolean einzugserm�chtigungErteilt = benutzer.einzugserm�chtigungErteilt;
					
					if(request.getParameter("einzugserm�chtigungErteilt") != null){
						einzugserm�chtigungErteilt = true;
					} else {
						einzugserm�chtigungErteilt = false;
					}
					
					benutzer = new Benutzer(userid, vorname, nachname, eMail, passwort, strasse, hausnummer, plz, ort, istGesperrt, iban, bic, einzugserm�chtigungErteilt, istGel�scht, 2);
					BenutzerAdministration.aktualisiereBenutzer(benutzer);		
					antwort = "Die �nderungen an Ihren pers�nlichen Daten wurden gespeichert!";
					
				} else {
					
					if ((request.getParameter("aktion")).equals("p_aendern")) {
						
						String passwortAlt = request.getParameter("passwortalt");
						String passwortNeu = request.getParameter("passwortneu");
						String passwortBest�tigung = request.getParameter("passwortbest�tigung");
						
						if(!passwortAlt.equals(benutzer.passwortHash)) {
							antwort = "Das eingegebene alte Passwort ist falsch. Keine Passwort�nderung durchgef�hrt.";
						} else {
							if(!passwortNeu.equals(passwortBest�tigung)) {
								antwort = "Das neue Passwort und die Wiederholung des Passworts stimmen nicht �berein. Keine Passwort�nderung durchgef�hrt.";
							} else {
								benutzer.passwortHash = passwortNeu;
								BenutzerAdministration.aktualisiereBenutzer(benutzer);
								antwort = "Ihr Passwort wurde erfolgreich ge�ndert.";
							}
						}
					}
				} 
				session.setAttribute("antwort", antwort);
				request.getRequestDispatcher("/Kundendaten?aktion=anzeigen").include(request, response);
			}
	
		} else {
			response.sendRedirect("k_anmelden.jsp");
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
