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
* Servlet zur Steuerung der Benutzerdaten durch den Benutzer (Kunden oder Administrator) selbst
* Ermöglicht das Anzeigen und Ändern der persönlichen Daten (für Kunden) sowie die Änderung des Passworts (für Kunden & Administrator)
* 
* @author Alina Fankhänel
*/
@WebServlet("/Benutzerdaten")
public class Benutzerdaten extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Benutzerdaten() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		String antwort = "";
		int userGruppenID = Integer.parseInt(session.getAttribute("gruppenid").toString()); 
		
		if(session != null && session.getAttribute("begrüßung") != null ) {
			
			int userid = Integer.parseInt(session.getAttribute("userid").toString());
			Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(userid);
					
			if ((request.getParameter("aktion")).equals("anzeigen")) {
				
				session.setAttribute("benutzer", benutzer);
				
					if(userGruppenID == 1) {
						request.getRequestDispatcher("a_adminKonto.jsp").include(request, response);
					} else {
						request.getRequestDispatcher("k_kundendaten.jsp").include(request, response);
					}					
			} 
			
			if ((request.getParameter("aktion")).equals("aendern")) {
					
					String eMail = request.getParameter("email");
					String vorname = request.getParameter("vorname");
					String nachname = request.getParameter("nachname");
					String strasse = request.getParameter("strasse");
					String hausnummer = request.getParameter("hausnummer");
					String ort = request.getParameter("ort");	
					String iban = request.getParameter("iban");
					String bic = request.getParameter("bic");
					boolean einzugsermächtigungErteilt = benutzer.einzugsermächtigungErteilt;
					int plz = 0;
					
					try{
						plz = Integer.parseInt(request.getParameter("plz"));
					} catch (Exception e) {
						e.printStackTrace();
						plz = 0;
					}
					
					if(request.getParameter("einzugsermächtigungErteilt") != null){
						einzugsermächtigungErteilt = true;
					} else {
						einzugsermächtigungErteilt = false;
					}
					
					antwort = aendereDaten(vorname, nachname, strasse, hausnummer, plz, ort, iban, bic, einzugsermächtigungErteilt, eMail, benutzer);						
					session.setAttribute("antwort", antwort);
					request.getRequestDispatcher("/Benutzerdaten?aktion=anzeigen").include(request, response); }
			
					
					if ((request.getParameter("aktion")).equals("p_aendern")) {
						
						String passwortAlt = request.getParameter("passwortalt");
						String passwortNeu = request.getParameter("passwortneu");
						String passwortBestätigung = request.getParameter("passwortbestätigung");
						antwort = aenderePasswort(passwortAlt, passwortNeu, passwortBestätigung, benutzer);
						session.setAttribute("antwort", antwort);
						request.getRequestDispatcher("/Benutzerdaten?aktion=anzeigen").include(request, response); } 
					
				} else {
					response.sendRedirect("k_anmelden.jsp");
			}
		}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	
	/**
	 * Methode zur Änderung des Passworts
	 * 
	 * @param p_pwAlt: eingegebenes altes Passwort
	 * @param p_pwNeu: eingegebenes neues Passwort
	 * @param p_pwBestätigung: eingegebenes Passwort zur Bestätigung des neuen Passworts
	 * @param p_benutzer: BenutzerObjekt, an dem die Passwortänderung durchgeführt werden soll
	 * @return String: Rückmeldung über die durchgeführten Aktivitäten, die an den Kunden weitergeleitet werden kann
	 */
	private String aenderePasswort(String p_pwAlt, String p_pwNeu, String p_pwBestätigung, Benutzer p_benutzer) {
					
			if(!p_pwAlt.equals(p_benutzer.passwortHash)) {
				return "Das eingegebene alte Passwort ist falsch. Keine Passwortänderung durchgeführt.";
			} else {
				if(!p_pwNeu.equals(p_pwBestätigung)) {
					return "Das neue Passwort und die Wiederholung des Passworts stimmen nicht überein. Keine Passwortänderung durchgeführt.";
				} else {
					p_benutzer.passwortHash = p_pwNeu;
					BenutzerAdministration.aktualisiereBenutzer(p_benutzer);
					return "Ihr Passwort wurde erfolgreich geändert.";
				}
		}		
	}
	
	
	/**
	 * Methode zur Änderung der persönlichen Daten
	 * 
	 * @param p_vorname: eingegebener Vorname
	 * @param p_nachname: eingegebener Nachname
	 * @param p_strasse: eingegebene Straße
	 * @param p_hausnummer: eingegebene Hausnummer
	 * @param p_plz: eingegebene PLZ
	 * @param p_ort: eingegebener Ort
	 * @param p_iban: eingegebene IBAN
	 * @param p_bic: eingegebene BIC
	 * @param p_einzugsermächtigungErteilt: gibt an, ob der Kunde die Einzugsermächtigung erteilt hat
	 * @param p_Email: eingegebene E-Mail-Adresse
	 * @param p_benutzer: BenutzerObjekt, an dem die Datenänderung durchgeführt werden soll
	 * @return String: Rückmeldung über die durchgeführten Aktivitäten, die an den Kunden weitergeleitet werden kann
	 */
	private String aendereDaten(String p_vorname, String p_nachname, String p_strasse, String p_hausnummer, int p_plz, String p_ort, String p_iban, String p_bic, boolean p_einzugsermächtigungErteilt, String p_Email, Benutzer p_benutzer) {
		
		if ((!(p_benutzer.eMailAdresse).equals(p_Email)) && BenutzerAdministration.selektiereBenutzer(p_Email) != null) {
			return "Zu der eingegebenen E-Mail-Adresse existiert bereits ein anderes Benutzerkonto. Verwenden Sie bitte eine andere E-Mail-Adresse.";
		} else {
		
		String passwort = p_benutzer.passwortHash;
		boolean istGesperrt = p_benutzer.istGesperrt;
		boolean istGelöscht = p_benutzer.istGelöscht;
		int id = p_benutzer.id;
									
		p_benutzer = new Benutzer(id, p_vorname, p_nachname, p_Email, passwort, p_strasse, p_hausnummer, p_plz, p_ort, istGesperrt, p_iban, p_bic, p_einzugsermächtigungErteilt, istGelöscht, 2);
		BenutzerAdministration.aktualisiereBenutzer(p_benutzer);	
		
		return "Die Änderungen an Ihren persönlichen Daten wurden gespeichert!";
		}
	}

}
