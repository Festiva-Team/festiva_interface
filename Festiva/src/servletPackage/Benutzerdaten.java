package servletPackage;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import standardPackage.*;
import managerPackage.*;
/** 
* Servlet zur Steuerung der Benutzerdaten durch den Benutzer (Kunden oder Administrator)<br>
* 1. aktion = anzeigen<br>
* 	 Selektierung der Benutzerdaten und entsprechende Weiterleitung zu der Admin-Konto-Übersicht bzw zu der Meine-Daten-Übersicht<br> 
* 2. aktion = aendern<br>
* 	 Durchführung der Änderungen an den eigenen Kundendaten durch den Kunden selbst<br>
* 3. aktion = p_aendern<br>
* 	 Durchführung der Änderungen an dem eigenen Passwort durch den Kunden oder den Administrator<br>
* 4. aktion = loeschen<br>
* 	 Löschen des Kundenkontos durch den Kunden selbst<br>
* 5. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgeführt und der User zur Anmelden-Seite weitergeleitet<br>
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		String antwort = "";
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		try {
			if (session != null && session.getAttribute("begrüßung") != null) {

				int userGruppenID = Integer.parseInt(session.getAttribute("gruppenid").toString());
				int userid = Integer.parseInt(session.getAttribute("userid").toString());
				Benutzer benutzer = BenutzerManager.selektiereBenutzerMitID(userid);

				if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anzeigen")) {

					session.setAttribute("benutzer", benutzer);

					if (userGruppenID == 1) {
						request.getRequestDispatcher("a_adminKonto.jsp").include(request, response);
					} else {
						request.getRequestDispatcher("k_kundendaten.jsp").include(request, response);
					}
				}

				if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("aendern")) {

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

					if (!request.getParameter("plz").equals("")) {
						try {
							plz = Integer.parseInt(request.getParameter("plz"));
						} catch (Exception e) {
							e.printStackTrace();
							plz = 0;
						}
					}

					if (request.getParameter("einzugsermächtigungErteilt") != null) {
						einzugsermächtigungErteilt = true;
					} else {
						einzugsermächtigungErteilt = false;
					}

					if (session.getAttribute("aufrufer_k") != null) {
						String anforderer_k = session.getAttribute("aufrufer_k").toString();
						session.removeAttribute("aufrufer_k");
						session.setAttribute("anforderer_k", anforderer_k);
					}

					antwort = aendereDaten(vorname, nachname, strasse, hausnummer, plz, ort, iban, bic,
							einzugsermächtigungErteilt, eMail, benutzer);
					session.setAttribute("antwort", antwort);
					request.getRequestDispatcher("/Benutzerdaten?aktion=anzeigen").include(request, response);
				}

				if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("p_aendern")) {

					String passwortAlt = request.getParameter("passwortalt");
					passwortAlt = Registrierung.generiereHash((passwortAlt + "76ZuOp(6?ssXY0"));
					String passwortNeu = request.getParameter("passwortneu");
					passwortNeu = Registrierung.generiereHash((passwortNeu + "76ZuOp(6?ssXY0"));
					String passwortBestätigung = request.getParameter("passwortbestätigung");
					passwortBestätigung = Registrierung.generiereHash((passwortBestätigung + "76ZuOp(6?ssXY0"));
					antwort = aenderePasswort(passwortAlt, passwortNeu, passwortBestätigung, benutzer);
					session.setAttribute("antwort", antwort);
					request.getRequestDispatcher("/Benutzerdaten?aktion=anzeigen").include(request, response);
				}

				if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("loeschen")) {
					benutzer.istGelöscht = true;
					BenutzerManager.löscheBenutzer(benutzer);
					request.getRequestDispatcher("/Logout").include(request, response);
				}

			} else {
				response.sendRedirect("k_anmelden.jsp");
			}
		} catch (DatenbankException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"Die angeforderte Seite ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal!");
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
	 * @param p_pwAlt eingegebenes altes Passwort
	 * @param p_pwNeu eingegebenes neues Passwort
	 * @param p_pwBestätigung eingegebenes Passwort zur Bestätigung des neuen Passworts
	 * @param p_benutzer BenutzerObjekt, an dem die Passwortänderung durchgeführt werden soll
	 * @return rueckmeldung Rückmeldung über die durchgeführten Aktivitäten, die an den Kunden weitergeleitet werden kann
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	private String aenderePasswort(String p_pwAlt, String p_pwNeu, String p_pwBestätigung, Benutzer p_benutzer)
			throws DatenbankException {

		String rueckmeldung = "";
		if (!p_pwAlt.equals(p_benutzer.passwortHash)) {
			rueckmeldung = "Das eingegebene alte Passwort ist falsch. Keine Passwortänderung durchgeführt.";
			return rueckmeldung;
		} else {
			if (!p_pwNeu.equals(p_pwBestätigung)) {
				rueckmeldung = "Das neue Passwort und die Wiederholung des Passworts stimmen nicht überein. Keine Passwortänderung durchgeführt.";
				return rueckmeldung;
			} else {
				p_benutzer.passwortHash = p_pwNeu;
				BenutzerManager.aktualisiereBenutzer(p_benutzer);
				rueckmeldung = "Ihr Passwort wurde erfolgreich geändert.";
				return rueckmeldung;
			}
		}
	}
	
	
	/**
	 * Methode zur Änderung der persönlichen Daten
	 * 
	 * @param p_vorname eingegebener Vorname
	 * @param p_nachname eingegebener Nachname
	 * @param p_strasse eingegebene Straße
	 * @param p_hausnummer eingegebene Hausnummer
	 * @param p_plz eingegebene PLZ
	 * @param p_ort eingegebener Ort
	 * @param p_iban eingegebene IBAN
	 * @param p_bic eingegebene BIC
	 * @param p_einzugsermächtigungErteilt gibt an, ob der Kunde die Einzugsermächtigung erteilt hat
	 * @param p_Email eingegebene E-Mail-Adresse
	 * @param p_benutzer BenutzerObjekt, an dem die Datenänderung durchgeführt werden soll
	 * @return rueckmeldung Rückmeldung über die durchgeführten Aktivitäten, die an den Kunden weitergeleitet werden kann
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	private String aendereDaten(String p_vorname, String p_nachname, String p_strasse, String p_hausnummer, int p_plz,
			String p_ort, String p_iban, String p_bic, boolean p_einzugsermächtigungErteilt, String p_Email,
			Benutzer p_benutzer) throws DatenbankException {
			String rueckmeldung = "";

		if ((!(p_benutzer.eMailAdresse).equals(p_Email)) && BenutzerManager.selektiereBenutzer(p_Email) != null) {
			rueckmeldung = "Zu der eingegebenen E-Mail-Adresse existiert bereits ein anderes Benutzerkonto. Verwenden Sie bitte eine andere E-Mail-Adresse.";
			return rueckmeldung;
		} else {

			String passwort = p_benutzer.passwortHash;
			boolean istGesperrt = p_benutzer.istGesperrt;
			boolean istGelöscht = p_benutzer.istGelöscht;
			int id = p_benutzer.id;

			p_benutzer = new Benutzer(id, p_vorname, p_nachname, p_Email, passwort, p_strasse, p_hausnummer, p_plz,
					p_ort, istGesperrt, p_iban, p_bic, p_einzugsermächtigungErteilt, istGelöscht, 2);
			BenutzerManager.aktualisiereBenutzer(p_benutzer);
			
			rueckmeldung = "Die Änderungen an Ihren persönlichen Daten wurden gespeichert!";
			return rueckmeldung;
		}

	}

}
