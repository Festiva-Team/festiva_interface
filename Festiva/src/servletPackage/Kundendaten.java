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
 * Servlet implementation class Kundendaten
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
		
		if(session != null && session.getAttribute("begrüßung") != null) {
			
			int userid = Integer.parseInt(session.getAttribute("userid").toString());
			Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(userid);
			
			if (request.getParameter("aktion") == "anzeigen") {
				
				session.setAttribute("benutzer", benutzer);
				request.getRequestDispatcher("k_kundendaten.jsp").include(request, response);
				
			} else {
				if (request.getParameter("aktion") == "ändern") {
					
					String vorname = request.getParameter("vorname");
					String nachname = request.getParameter("nachname");
					String eMail = request.getParameter("email");
					String strasse = request.getParameter("strasse");
					String hausnummer = request.getParameter("hausnummer");
					int plz = Integer.parseInt(request.getParameter("plz"));
					String ort = request.getParameter("ort");	
					String iban = request.getParameter("iban");
					String bic = request.getParameter("bic");		
					
					String passwort = benutzer.passwortHash;
					boolean istGesperrt = benutzer.istGesperrt;
					boolean istGelöscht = benutzer.istGelöscht;
					boolean einzugsermächtigungErteilt = benutzer.einzugsermächtigungErteilt;
					benutzer = new Benutzer(userid, vorname, nachname, eMail, passwort, strasse, hausnummer, plz, ort, istGesperrt, iban, bic, einzugsermächtigungErteilt, istGelöscht, 2);
					BenutzerAdministration.aktualisiereBenutzer(benutzer);
					
					String antwort = "Ihre Änderungen wurden gespeichert!";
					session.setAttribute("antwort", antwort);
					request.getRequestDispatcher("k_kundendaten.jsp").include(request, response);
				}
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
