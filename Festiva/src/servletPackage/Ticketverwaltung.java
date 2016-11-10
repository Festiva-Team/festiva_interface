package servletPackage;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
@WebServlet("/Ticketverwaltung")
public class Ticketverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Ticketverwaltung() {
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
			if ((request.getParameter("aktion")).equals("t_anzeigen")) {
				SimpleDateFormat datum1 = new SimpleDateFormat( "dd.MM.yyyy" );
				SimpleDateFormat datum2 = new SimpleDateFormat( "yyyy-MM-dd" );
				
				int kategorienID = 0;
				String name = null;
				String ort = null;
				Date start = null;
				Date end = null;
				String startDatum = null;
				String endDatum = null;
				float maxPreis = 0;
				
				if(request.getParameter("kategorie") != null && request.getParameter("kategorie").trim().length() != 0) {
					kategorienID = Integer.parseInt(request.getParameter("kategorie"));
				}
				if(request.getParameter("name") != null && request.getParameter("name").trim().length() != 0) {
					name = request.getParameter("name");
				}
				if(request.getParameter("ort") != null && request.getParameter("ort").trim().length() != 0) {
					ort = request.getParameter("ort");
				}
				try {
				if(request.getParameter("startdatum") != null && request.getParameter("startdatum").trim().length() != 0) {			
					start = datum1.parse(request.getParameter("startdatum"));
					startDatum = datum2.format(start);
				}
				if(request.getParameter("enddatum") != null && request.getParameter("enddatum").trim().length() != 0) {
					end = datum1.parse(request.getParameter("enddatum"));
					endDatum = datum2.format(end);
				} 
				} catch (ParseException e) {
					e.printStackTrace();
				}
			
				if(request.getParameter("maxpreis") != null && request.getParameter("maxpreis").trim().length() != 0) {
					maxPreis = Float.parseFloat(request.getParameter("maxpreis"));
				}
				if(startDatum != null && endDatum != null) {
					
				}
				
				FestivalSuchobjekt suchKriterien = new FestivalSuchobjekt(-1, name, ort, "", start, end, 0, maxPreis, kategorienID);
				List<FestivalSuchobjekt> listFestivals = FestivalAdministration.selektiereFestivalsInSuche(kategorienID, ort, name, startDatum, endDatum, maxPreis);
				List<Kategorie> listKategorien = KategorienAdministration.selektiereAlleAktivenKategorien();
				session.setAttribute("suchKriterien", suchKriterien);
				session.setAttribute("listFestivals", listFestivals);
				session.setAttribute("listKategorien", listKategorien);
				request.getRequestDispatcher("k_ticketShop.jsp").include(request, response);
			} else {
				if((request.getParameter("aktion")).equals("f_anzeigen")) {
					int festivalid = Integer.parseInt(request.getParameter("festivalid"));
					float maxpreis = Float.parseFloat(request.getParameter("maxpreis"));
					
					if(session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
						int userid = Integer.parseInt(session.getAttribute("userid").toString());
						Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, false);
						List<Integer> listArtikelID = new ArrayList<Integer>();
						for(Warenkorbelement warenkorbelement : warenkorb.listElemente) {
							listArtikelID.add(warenkorbelement.artikel.id);					
						}
						session.setAttribute("listArtikelID", listArtikelID);
					}
					Festival festival = FestivalAdministration.selektiereFestival(festivalid);
					
					if(maxpreis == 0.0) {
						List<Artikel> listArtikel = ArtikelAdministration.selektiereArtikelVonFestival(festivalid);
						session.setAttribute("listArtikel", listArtikel);
					} else {
						List<Artikel> listArtikelMitMaxPreis = ArtikelAdministration.selektiereArtikelVonFestivalMitMaxPreis(festivalid, maxpreis);
						List<Artikel> listArtikelUeberMaxPreis = ArtikelAdministration.selektiereArtikelVonFestivalÜberMaxPreis(festivalid, maxpreis);
						session.setAttribute("listArtikelMitMaxPreis", listArtikelMitMaxPreis);
						session.setAttribute("listArtikelUeberMaxPreis", listArtikelUeberMaxPreis);
					}
					session.setAttribute("festival", festival);
					session.setAttribute("maxpreis", maxpreis);
					request.getRequestDispatcher("k_festivaldetails.jsp").include(request, response);
					
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
