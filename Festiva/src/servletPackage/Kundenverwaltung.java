package servletPackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import standardPackage.*;
import managerPackage.*;

/** 
* Servlet zur Steuerung der Kundendaten durch den Administrator<br>
* 1. aktion = anzeigen<br>
* 	 Selektierung aller Kunden zur Darstellung in der Kundenverwaltung<br>
* 2. aktion = anlegen<br>
* 	 Anlage eines Kunden mit den übermittelten Daten <br>
* 3. aktion = aendern<br>
* 	 Selektierung der Daten zu einem bestimmten Kunden um aus der Kundenverwaltung in den Modus "Kunden bearbeiten" über zu gehen<br>
* 4. aktion = datenaendern<br>
* 	 Durchführung der Änderungen an einem Kunden<br>
* 5. aktion = loeschen<br>
* 	 Löschen des Kunden<br>
* 6. aktion = pw_aendern<br>
* 	 Durchführung der Änderungen an dem Passwort des Kunden<br>
* 7. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgeführt und der User zur Anmelden-Seite weitergeleitet<br>
* 
* @author Alina Fankhänel
*/
@WebServlet("/Kundenverwaltung")
public class Kundenverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Kundenverwaltung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		
		try{
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			
			String antwort = "";
			
			if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anzeigen")) {
				List<Benutzer> listBenutzer = BenutzerManager.selektiereAlleKunden();
				session.setAttribute("listBenutzer", listBenutzer);
				request.getRequestDispatcher("a_kundenverwaltung.jsp").include(request, response);
				
			} else {
				
				int kundenid = Integer.parseInt(request.getParameter("kundenid").toString());
				Benutzer benutzer = BenutzerManager.selektiereBenutzerMitID(kundenid);
				
				if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("pw_aendern")) {
					
					String passwortNeu = request.getParameter("passwortneu");
					String passwortBestätigung = request.getParameter("passwortbestätigung");
					
						if(!passwortNeu.equals(passwortBestätigung)) {
							antwort = "Das neue Passwort und die Wiederholung des Passworts stimmen nicht überein. Keine Passwortänderung durchgeführt.";
						} else {
							passwortNeu = Registrierung.generiereHash((passwortNeu + "76ZuOp(6?ssXY0"));
							benutzer.passwortHash = passwortNeu;
							
							benutzer.istGesperrt = false;
							BenutzerManager.aktualisierePasswortZaehlerBeiKunde(benutzer.id, 0);
							
							BenutzerManager.aktualisiereBenutzer(benutzer);
							antwort = "Das Passwort wurde erfolgreich geändert.";
								}
						session.setAttribute("antwort", antwort);
					} else {
			
					if( request.getParameter("aktion") != null && request.getParameter("aktion").equals("loeschen")) {	
						benutzer.istGelöscht = true;
						BenutzerManager.löscheBenutzer(benutzer);
						antwort = "Der Benutzer wurde erfolgreich gelöscht.";
						session.setAttribute("antwort", antwort);
					} else {
						
						if( request.getParameter("aktion") != null && request.getParameter("aktion").equals("datenaendern")) {
							
							String eMail = request.getParameter("email");
							if ((!(benutzer.eMailAdresse).equals(eMail)) && BenutzerManager.selektiereBenutzer(eMail) != null) {
								antwort = "Zu der eingegebenen E-Mail-Adresse existiert bereits ein anderes Benutzerkonto. Verwenden Sie bitte eine andere E-Mail-Adresse.";
							} else {
							
							String vorname = request.getParameter("vorname");
							String nachname = request.getParameter("nachname");
							String strasse = request.getParameter("strasse");
							String hausnummer = request.getParameter("hausnummer");
							int plz = 0;
							
							if(!request.getParameter("plz").equals("")) {
								try{
									plz = Integer.parseInt(request.getParameter("plz"));
								} catch (Exception e) {
									e.printStackTrace();
									plz = 0;
								} }
							
							String ort = request.getParameter("ort");	
							String iban = request.getParameter("iban");
							String bic = request.getParameter("bic");
							
							String passwort = benutzer.passwortHash;
							boolean istGesperrt = benutzer.istGesperrt;
							boolean istGelöscht = benutzer.istGelöscht;
							boolean einzugsermächtigungErteilt = benutzer.einzugsermächtigungErteilt;
							
							if(request.getParameter("einzugsermächtigungErteilt") != null){
								einzugsermächtigungErteilt = true;
							} else {
								einzugsermächtigungErteilt = false;
							}
							
							if(request.getParameter("gesperrt") != null){
								istGesperrt = true;
							} else {
								istGesperrt = false;
							}
							
												
							benutzer = new Benutzer(kundenid, vorname, nachname, eMail, passwort, strasse, hausnummer, plz, ort, istGesperrt, iban, bic, einzugsermächtigungErteilt, istGelöscht, 2);
							BenutzerManager.aktualisiereBenutzer(benutzer);	
							
							antwort = "Die Änderungen an den persönlichen Daten wurden gespeichert!";
						}
							session.setAttribute("antwort", antwort);
					}
				  }
				}
				
				session.setAttribute("benutzer", benutzer);
				request.getRequestDispatcher("a_kundenAendern.jsp").include(request, response);	
			}
		} else {
			response.sendRedirect("k_anmelden.jsp");
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

}
