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
		String action = request.getParameter("action");
		//Auslesen der Parameter, ggf. Konvertierung (Validierung ist clientseitig geschehen)
		String vorname = request.getParameter("inputVorname");
		String nachname = request.getParameter("inputNachname");
		String eMail = request.getParameter("inputEMail");
		String strasse = request.getParameter("inputStrasse");
		String hausnummer = request.getParameter("inputHausnummer");
		int postleitzahl = Integer.parseInt(request.getParameter("inputPostleitzahl"));
		String ort = request.getParameter("inputOrt");	
		String passwortHash = request.getParameter("inputPasswortHash");
		if (action.equals("neu"))
		{
			Benutzer benutzer = BenutzerAdministration.selektiereBenutzer(request.getParameter("inputEMail"));
			Boolean emailMoeglich = false;
			if (benutzer == null)
				emailMoeglich = true;
			
			if (emailMoeglich)
			{


//				benutzer = new Benutzer(-1, );
				BenutzerAdministration.erstelleKunden(benutzer);
				response.sendRedirect("k_startseite.jsp");
			}
			else
			{
				//E-Mail bereits vergeben ==> Weiterleiten des Nutzers zur Registrierungsseite mit Hinweis
				response.sendRedirect("k_registrieren.jsp");
			}
		}
		else if (action.equals("aendern"))
		{
			//Anwender ändern
			HttpSession session = request.getSession(false);
			int userid = Integer.parseInt(session.getAttribute("userid").toString());
//			Benutzer benutzer = new Benutzer(userid, vorname, nachname, eMail, strasse, hausnummer, postleitzahl, ort, passwortHash, false);
//			BenutzerAdministration.aktualisiereBenutzer(benutzer);
			response.sendRedirect("k_startseite.jsp");
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
