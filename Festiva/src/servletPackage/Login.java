package servletPackage;

import standardPackage.*;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import managerPackage.*;

/**
 * Servlet zum Login-Vorgang<br>
 * Erstellt eine neue Session und leitet den Kunden zur Startseite mit der Slideshow und den Administrator zur Admin-Startseite weiter<br>
 * 1. Pr�fung ob eingegebene Login-Daten korrekt sind<br>
 * 2. Setzen der User-ID, Gruppen-ID und der maximalen Inaktivit�t vor Beenden der Session als Session-Attribute<br>
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
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		String antwort = " ";
		String begr��ung = " ";

		try{
		Benutzer benutzer = BenutzerManager.selektiereBenutzer(request.getParameter("email"));

		if (benutzer != null) {
				if (benutzer.istGesperrt == true) {
					if(BenutzerManager.selektierePasswortZaehlerVonKunde(benutzer.id) >= 3) {
						antwort = "Ihr Benutzerkonto wurde gesperrt, da Sie zu oft ein falsches Passwort eingegeben haben. Bitte wenden Sie sich an den Administrator: admin@festiva.de";
					} else {
						antwort = "Ihr Benutzerkonto wurde gesperrt. Bitte wenden Sie sich an den Administrator: admin@festiva.de";
					}
					request.getSession(false).setAttribute("antwort", antwort);
					request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
					
				} else {
					if (benutzer.istGel�scht == true) {
						antwort = "Das Benutzerkonto mit dieser E-Mail-Adresse wurde gel�scht. Sollten Sie Fragen dazu haben, wenden Sie sich bitte an den Administrator: admin@festiva.de";
						request.getSession(false).setAttribute("antwort", antwort);
						request.getRequestDispatcher("k_anmelden.jsp").include(request, response);

					} else {
						String pwHash = Registrierung.generiereHash((request.getParameter("passwort") + "76ZuOp(6?ssXY0"));
						if ((benutzer.passwortHash).equals(pwHash)) {
							String anforderer = null;
							if(request.getSession(false).getAttribute("anforderer") != null) {
						    anforderer = request.getSession(false).getAttribute("anforderer").toString();
						    request.getSession(false).removeAttribute("anforderer");
							}
								HttpSession session = request.getSession(true);
								session.setAttribute("userid", benutzer.id);
								session.setAttribute("gruppenid", benutzer.gruppenID);
								session.setMaxInactiveInterval(3600);
						// Weiterleitung je nach User wenn der Login erfolgreich war
						// Wenn der User ein Administrator ist
						if (benutzer.gruppenID == 1){
							begr��ung = "Herzlich Willkommen bei Festiva!";
							request.getSession(false).setAttribute("begr��ung", begr��ung);
							request.getRequestDispatcher("a_startseiteAdmin.jsp").include(request, response);
							
						} else {
							// Wenn der User ein Kunde ist
							BenutzerManager.aktualisierePasswortZaehlerBeiKunde(benutzer.id, 0);
							if((benutzer.vorname).equals("") && benutzer.nachname.equals("")) {
							begr��ung = "Herzlich Willkommen bei Festiva!";	
							} else {
							begr��ung = "Herzlich Willkommen bei Festiva, " + benutzer.vorname + " " + benutzer.nachname + "!";
							}
							request.getSession(false).setAttribute("begr��ung", begr��ung);
							if(anforderer != null) {
								request.getRequestDispatcher(anforderer.substring(8)).include(request, response);
								
							} else {
							request.getRequestDispatcher("/Produktverwaltung?aktion=s_anzeigen").include(request, response); }

						}

						} else {
							// Registrierung des falschen Logins in der Datenbank je nach User-Gruppe
							// Wenn der User ein Administrator ist
							if(benutzer.gruppenID == 1) {
								antwort = "Sie haben falsche Login-Daten eingegeben. Bitte versuchen Sie es nochmal!";
							} else {
							// Wenn der User ein Kunde ist
								int zaehler = BenutzerManager.selektierePasswortZaehlerVonKunde(benutzer.id);
								zaehler = zaehler + 1;
								BenutzerManager.aktualisierePasswortZaehlerBeiKunde(benutzer.id, zaehler);
								
								if(zaehler >= 3) {
									antwort = "Ihr Benutzerkonto wurde gesperrt, da Sie 3 Mal ein falsches Passwort eingegeben haben. Bitte wenden Sie sich an den Administrator: admin@festiva.de";
								} else {
									antwort = "Sie haben falsche Login-Daten eingegeben. Bitte versuchen Sie es nochmal!";
								}
							}
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
		} catch (DatenbankException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Die angeforderte Seite ist derzeit nicht verf�gbar. Bitte versuchen Sie es sp�ter noch einmal!");
		}

	}

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
        processRequest(request, response);
    }

}