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

/**
*
* @author Alina Fankh�nel
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
		
		if(session != null && session.getAttribute("begr��ung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			
			String antwort = "";
			
			if ((request.getParameter("aktion")).equals("anzeigen")) {
				List<Benutzer> listBenutzer = BenutzerAdministration.selektiereAlleKunden();
				session.setAttribute("listBenutzer", listBenutzer);
				request.getRequestDispatcher("a_kundenverwaltung.jsp").include(request, response);
				
			} else {
				
				int kundenid = Integer.parseInt(request.getParameter("kundenid").toString());
				Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(kundenid);
				
				if ((request.getParameter("aktion")).equals("pw_aendern")) {
					
					String passwortNeu = request.getParameter("passwortneu");
					String passwortBest�tigung = request.getParameter("passwortbest�tigung");
					
						if(!passwortNeu.equals(passwortBest�tigung)) {
							antwort = "Das neue Passwort und die Wiederholung des Passworts stimmen nicht �berein. Keine Passwort�nderung durchgef�hrt.";
						} else {
							benutzer.passwortHash = passwortNeu;
							BenutzerAdministration.aktualisiereBenutzer(benutzer);
							antwort = "Das Passwort wurde erfolgreich ge�ndert.";
								}
						session.setAttribute("antwort", antwort);
					} else {
			
					if(request.getParameter("aktion").equals("loeschen")) {	
						benutzer.istGel�scht = true;
						BenutzerAdministration.l�scheBenutzer(benutzer);
						antwort = "Der Benutzer wurde erfolgreich gel�scht.";
						session.setAttribute("antwort", antwort);
					} else {
						
						if(request.getParameter("aktion").equals("datenaendern")) {
							
							String eMail = request.getParameter("email");
							if ((!(benutzer.eMailAdresse).equals(eMail)) && BenutzerAdministration.selektiereBenutzer(eMail) != null) {
								antwort = "Zu der eingegebenen E-Mail-Adresse existiert bereits ein anderes Benutzerkonto. Verwenden Sie bitte eine andere E-Mail-Adresse.";
							} else {
							
							String vorname = request.getParameter("vorname");
							String nachname = request.getParameter("nachname");
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
							
							if(request.getParameter("gesperrt") != null){
								istGesperrt = true;
							} else {
								istGesperrt = false;
							}
							
												
							benutzer = new Benutzer(kundenid, vorname, nachname, eMail, passwort, strasse, hausnummer, plz, ort, istGesperrt, iban, bic, einzugserm�chtigungErteilt, istGel�scht, 2);
							BenutzerAdministration.aktualisiereBenutzer(benutzer);	
							
							antwort = "Die �nderungen an den pers�nlichen Daten wurden gespeichert!";
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
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
