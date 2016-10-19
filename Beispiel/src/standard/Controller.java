package standard;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

/**
 * Steuert die Anzeige von einzelnen JSP-Seiten über den Parameter "seite"
 * 
 * @author Linus Hoppe
 *
 */
@WebServlet("/Grillzone")
public class Controller extends HttpServlet {

	private String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	private static String seiten[][] = {
			new String[] { "startseite", "/startseite.jsp"},
			new String[] { "produktsuche", "/produktsuche.jsp"},
			new String[] { "artikeldetails", "/artikeldetails.jsp"},
			new String[] { "registrierung", "/registrierung.jsp"},
			new String[] { "warenkorb", "/warenkorb.jsp"},
			new String[] { "profil", "/profil.jsp"},
			new String[] { "kasse", "/kasse.jsp"},
			new String[] { "login", "/aktionen/login.jsp"},
			new String[] { "speicherAnwender", "/aktionen/speicherAnwender.jsp"},
			new String[] { "logout", "/aktionen/logout.jsp"},
			new String[] { "aenderWarenkorb", "/aktionen/aenderWarenkorb.jsp"},
			new String[] { "speicherBestellung", "/aktionen/speicherBestellung.jsp"},
			new String[] { "benutzerverwaltung", "/benutzerverwaltung.jsp"},
			new String[] { "administriereAnwender", "/aktionen/administriereAnwender.jsp"},
			new String[] {"bestelluebersicht", "bestelluebersicht.jsp"}
			}; //alle vorhandenen Seiten

	/**
	 * Verarbeitet einen POST-Request
	 */
	@Override
	public void doPost(HttpServletRequest p_request, HttpServletResponse p_response) throws ServletException, IOException 
	{
		doGet(p_request, p_response);
	}

	/**
	 * Verarbeitet einen GET-Request
	 */
	@Override
	public void doGet(HttpServletRequest p_request, HttpServletResponse p_response) throws ServletException, IOException 
	{
		//Forwarding
		String seite = p_request.getParameter("seite");
		seite = seite == null ? seiten[0][0] : seite; //falls keine Seite gefordert, nimm Startseite
		String target = null;
		boolean gefunden = false;
		for (int i = 0; i < seiten.length; i++) {
			if (seite.equals(seiten[i][0])) {
				p_request.setAttribute(seite, seiten[i]);
				target = seiten[i][1];
				gefunden = true;
				break;
			}
		}
		if (!gefunden)
			target = seiten[0][1]; //ungültiger Request, nimm Startseite
		PrintWriter out = p_response.getWriter();
		try
		{
			p_request.getRequestDispatcher(target).forward(p_request, p_response);
			out.print(p_request);
		}
		catch (Exception e)
		{
			//Falls irgendwo eine Exception auftritt: Weiterleiten auf Startseite (per HTML-Forwarding)
			String output = "<head><meta http-equiv=\"refresh\" content=\"0; URL="+ this.PFAD_ZUM_CONTROLLER+ "?seite=startseite&error=true\"></head>";
			out.print(output);
		}
	}
}