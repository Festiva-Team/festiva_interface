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
@WebServlet("/Warenkorbverwaltung")
public class Warenkorbverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Warenkorbverwaltung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
			
			if ((request.getParameter("aktion")).equals("anzeigen")) {
			int userid = Integer.parseInt(session.getAttribute("userid").toString());
			Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, false);
			List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
			session.setAttribute("listFestivals", listFestivals);
			session.setAttribute("warenkorb", warenkorb);
			request.getRequestDispatcher("k_warenkorb.jsp").include(request, response);
			} else { 
					if ((request.getParameter("aktion")).equals("k_anzeigen")) {
						int userid = Integer.parseInt(session.getAttribute("userid").toString());
						Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, true);
						Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(userid);
						List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
						boolean kundendatenVollstaendig = ueberpruefeKundendaten(benutzer);
						session.setAttribute("kundendatenVollstaendig", kundendatenVollstaendig);
						session.setAttribute("listFestivals", listFestivals);
						session.setAttribute("warenkorb", warenkorb);
						session.setAttribute("benutzer", benutzer);
						request.getRequestDispatcher("k_kasse.jsp").include(request, response);
					} else {
						if ((request.getParameter("aktion")).equals("p_versand")) {
							int userid = Integer.parseInt(session.getAttribute("userid").toString());
							Artikel artikel = ArtikelAdministration.selektiereArtikel(6);
							Warenkorbelement warenkorbelement = new Warenkorbelement(-1, 1, artikel);
							WarenkorbAdministration.fügeWarenkorbelementEin(warenkorbelement, userid);
							boolean perPost = true;
							session.setAttribute("perPost", perPost);
							request.getRequestDispatcher("/Warenkorbverwaltung?aktion=k_anzeigen").include(request, response);
						} else {
							if ((request.getParameter("aktion")).equals("m_versand")) {	
								Warenkorbelement warenkorbelement = WarenkorbAdministration.selektiereWarenkorbelementMitArtikelID(6);
								WarenkorbAdministration.loescheWarenkorbelement(warenkorbelement.id);
								boolean perPost = false;
								session.setAttribute("perPost", perPost);
								request.getRequestDispatcher("/Warenkorbverwaltung?aktion=k_anzeigen").include(request, response);
								
							} else {
				int elementID = Integer.parseInt(request.getParameter("elementid"));
				if ((request.getParameter("aktion")).equals("aendern")) {
					int mengeNeu = Integer.parseInt(request.getParameter("menge"));
					Warenkorbelement warenkorbelement = WarenkorbAdministration.selektiereWarenkorbelement(elementID);
					warenkorbelement.menge = mengeNeu;
					WarenkorbAdministration.aktualisiereWarenkorbelement(warenkorbelement);
					
				} else {
					if ((request.getParameter("aktion")).equals("loeschen")) {
						WarenkorbAdministration.loescheWarenkorbelement(elementID);
						
					} 
				}
				request.getRequestDispatcher("/Warenkorbverwaltung?aktion=anzeigen").include(request, response);
			}
						}
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
		doGet(request, response);
	}
	
	private boolean ueberpruefeKundendaten(Benutzer benutzer) {
		if(benutzer.vorname.trim().length() == 0 || benutzer.nachname.trim().length() == 0 || benutzer.strasse.trim().length() == 0 ||
		   benutzer.hausnummer.trim().length() == 0 || benutzer.ort.trim().length() == 0 || benutzer.iban.trim().length() == 0 ||
		   benutzer.plz == 0 || benutzer.einzugsermächtigungErteilt == false) {
			return false;
		} else {
		return true;
		}
	}

}
