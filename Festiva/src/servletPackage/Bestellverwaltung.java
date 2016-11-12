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
* @author Alina Fankhänel
*/
@WebServlet("/Bestellverwaltung")
public class Bestellverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bestellverwaltung() {
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
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
			if ((request.getParameter("aktion")).equals("anlegen")) {
				int userid = Integer.parseInt(session.getAttribute("userid").toString());
				String versand = request.getParameter("versand");
				boolean perPost = false;
				if(session.getAttribute("aufrufer_k") != null) {
				session.removeAttribute("aufrufer_k");}
				if(session.getAttribute("anforderer_k") != null) {
					session.removeAttribute("anforderer_k");}
				
				if(versand.equals("post")) {
					perPost = true;
				}
				
				Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, true);
				Bestellung bestellung = new Bestellung(warenkorb, perPost);
				BestellungsAdministration.erstelleBestellung(bestellung);
				WarenkorbAdministration.loescheWarenkorbinhalt(warenkorb.id);
				request.getRequestDispatcher("/Bestellverwaltung?aktion=anzeigen").include(request, response);
			} else {
				if ((request.getParameter("aktion")).equals("anzeigen")) {
					int userid = Integer.parseInt(session.getAttribute("userid").toString());
					List<Bestellung> listBestellungen = BestellungsAdministration.selektiereBestellungenVonKunden(userid);
					List<Artikel> listArtikel = ArtikelAdministration.selektiereAlleArtikel();
					List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
					session.setAttribute("listArtikel", listArtikel);
					session.setAttribute("listFestivals", listFestivals);
					session.setAttribute("listBestellungen", listBestellungen);
					request.getRequestDispatcher("k_bestellungen.jsp").include(request, response);
				}
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
		doGet(request, response);
	}

}
