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

/**
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		try{

		if ((request.getParameter("aktion")).equals("z_anzeigen")) {
			
			if(session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
				int userid = Integer.parseInt(session.getAttribute("userid").toString());
				Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, false);
				List<Integer> listArtikelID = new ArrayList<Integer>();
				for(Warenkorbelement warenkorbelement : warenkorb.listElemente) {
					listArtikelID.add(warenkorbelement.artikel.id);					
				}
				session.setAttribute("listArtikelID", listArtikelID);
			}
			List<Artikel> listArtikel = ArtikelAdministration.selektiereUnabhaengigeArtikel();
			session.setAttribute("listArtikel", listArtikel);
			session.setAttribute("aufrufer", request.getRequestURI() + "?" + request.getQueryString());
			request.getRequestDispatcher("k_merchandiseShop.jsp").include(request, response);		
		} else {
			if((request.getParameter("aktion")).equals("s_anzeigen")) {
				List<Kategorie> listKategorien = KategorienAdministration.selektiereAlleKategorienFuerSlideshow();
				if(session != null){
				session.setAttribute("listKategorien", listKategorien);
				} else {
					request.getSession(true).setAttribute("listKategorien", listKategorien);
				}
				request.getRequestDispatcher("k_startseite.jsp").include(request, response);	
			} else {
//				if((request.getParameter("aktion")).equals("f_k_anzeigen")) {
//					int kategorienid = 0;
//					
//					if(!request.getParameter("kategorienid").equals("")) {
//						try{
//							kategorienid = Integer.parseInt(request.getParameter("kategorienid"));
//						} catch (Exception e) {
//							e.printStackTrace();
//							kategorienid = 0;
//						} }
//					List<FestivalSuchobjekt> listFestivalSuchobjekte = FestivalAdministration.selektiereFestivalsInSuche(kategorienid, null, null, null, null, (float)0.0);
//					session.setAttribute("listFestivalSuchobjekte", listFestivalSuchobjekte);
//					request.getRequestDispatcher("").include(request, response);	
//					
//				}
			}
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
