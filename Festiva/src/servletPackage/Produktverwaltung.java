package servletPackage;

import java.io.IOException;
import java.util.ArrayList;
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
* Servlet zur Steuerung der Zubehör-Produktdaten & der Anzeige der Startseite für jeden Besucher, Kunden und Administrator
* 1. aktion = z_anzeigen
* 	 Selektierung der Zubehör-Produkte zur Anzeige in dem Zubehör-Shop
* 2. aktion = s_anzeigen
* 	 Selektierung aller aktiven Kategorien zur Anzeige in der Slideshow auf der Startseite für den Kunden
* 3. aktion = a_anzeigen
* 	 Selektierung der Daten zu einem bestimmten Artikel um aus dem Zubehör-Shop in die Detail-Ansicht eines festivalübergreifenden Artikels zu wechseln 
* 4. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgeführt und der User zur Anmelden-Seite weitergeleitet
* 
* @author Alina Fankhänel
*/
@WebServlet("/Produktverwaltung")
public class Produktverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Produktverwaltung() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		try {
			if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("z_anzeigen")) {
				List<Artikel> listArtikel = ArtikelManager.selektiereUnabhaengigeArtikel();
				session.setAttribute("listArtikel", listArtikel);
				request.getRequestDispatcher("k_zubehoerShop.jsp").include(request, response);
			} else {
				if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("s_anzeigen")) {
					List<Kategorie> listKategorien = KategorienManager.selektiereAlleKategorienFuerSlideshow();
					if (session != null) {
						session.setAttribute("listKategorien", listKategorien);
					} else {
						request.getSession(true).setAttribute("listKategorien", listKategorien);
					}
					request.getRequestDispatcher("k_startseite.jsp").include(request, response);
				} else {
					if (request.getParameter("aktion") != null
							&& (request.getParameter("aktion")).equals("a_anzeigen")) {
						int artikelid = Integer.parseInt(request.getParameter("artikelid"));

						// Wenn der User der aktuellen Session ein Kunde ist, wird der aktuelle Warenkorbinhalt selektiert
						if (session.getAttribute("begrüßung") != null
								&& Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
							int userid = Integer.parseInt(session.getAttribute("userid").toString());
							Warenkorb warenkorb = WarenkorbManager.selektiereWarenkorbVonKunden(userid, false);
							List<Integer> listArtikelID = new ArrayList<Integer>();
							for (Warenkorbelement warenkorbelement : warenkorb.listElemente) {
								listArtikelID.add(warenkorbelement.artikel.id);
							}
							session.setAttribute("listArtikelID", listArtikelID);
						}
						Artikel artikel = ArtikelManager.selektiereArtikel(artikelid);
						session.setAttribute("artikel", artikel);
						session.setAttribute("aufrufer", request.getRequestURI() + "?" + request.getQueryString());
						request.getRequestDispatcher("k_artikeldetails.jsp").include(request, response);
					}
				}
			}

		} catch (DatenbankException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"Die angeforderte Seite ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
