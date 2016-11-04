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
@WebServlet("/Artikelverwaltung")
public class Artikelverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Artikelverwaltung() {
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
		
		if(session != null && session.getAttribute("begr��ung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			
			String antwort = "";
			if((request.getParameter("aktion")).equals("anlegen")) {
				
				int festivalid = Integer.parseInt(request.getParameter("festivalid"));
				String beschreibung = request.getParameter("beschreibung");
				
				if(beschreibung.equals("") || request.getParameter("preis").equals("")) {
					antwort = "Sie k�nnen den Artikel erst anlegen, wenn Sie alle Pflichtfelder gef�llt haben.";
				} else {
				float preis = Float.parseFloat(request.getParameter("preis"));
				Artikel artikel = new Artikel(-1, beschreibung, preis, false, festivalid);
				ArtikelAdministration.erstelleArtikel(artikel);
				antwort = "Der Artikel '" + artikel.beschreibung + "' wurde erfolgreich mit der ID " + artikel.id + " angelegt.";
				}
				session.setAttribute("antwort", antwort);
			    request.getRequestDispatcher("a_artikelAnlegen.jsp").include(request, response);
			} else {
				
				if((request.getParameter("aktion")).equals("anzeigen")) {
					List<Artikel> listArtikel = ArtikelAdministration.selektiereAlleUnabhaengigenArtikel();
					session.setAttribute("listArtikel", listArtikel);
					request.getRequestDispatcher("a_artikelverwaltung.jsp").include(request, response);
				} else {
				int artikelid = Integer.parseInt(request.getParameter("artikelid").toString());
				Artikel artikel = ArtikelAdministration.selektiereArtikel(artikelid);
			if ((request.getParameter("aktion")).equals("aendern")) {			
			} else {
				if ((request.getParameter("aktion")).equals("datenaendern")) {
					
					String beschreibung = request.getParameter("beschreibung");
					
					
					if(beschreibung.equals("") || request.getParameter("preis").equals("")) {
						antwort = "Sie k�nnen den Artikel erst �ndern, wenn Sie alle Pflichtfelder gef�llt haben.";
					} else {
					float preis = Float.parseFloat(request.getParameter("preis"));
					artikel.beschreibung = beschreibung;
					artikel.preis = preis;
					ArtikelAdministration.aktualisiereArtikel(artikel);
					antwort = "Der Artikel wurde erfolgreich ge�ndert.";
					}
					session.setAttribute("antwort", antwort);
				} else {
					if((request.getParameter("aktion")).equals("loeschen")) {
						if(artikel.id != 6) {
							artikel.istGel�scht = true;
							ArtikelAdministration.l�scheArtikel(artikel);
							antwort = "Der Artikel wurde erfolgreich gel�scht.";}
						else {
							antwort = "Dieser Artikel darf nicht gel�scht werden.";
						}
						session.setAttribute("antwort", antwort);
					}
				}
			
			}
			session.setAttribute("artikel", artikel);	
			request.getRequestDispatcher("a_artikelAendern.jsp").include(request, response);
		  } 
	     }
		}
		
		else {
			response.sendRedirect("k_anmelden.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	

}
