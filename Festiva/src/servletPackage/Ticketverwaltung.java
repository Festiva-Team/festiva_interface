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
import managerPackage.*;

/** 
* Servlet zur Steuerung der Ticketdaten f�r jeden Besucher, Kunden und Administrator
* 1. aktion = t_anzeigen
* 	 Selektierung aller Festivals, die den optional �bermittelten Suchkriterien entsprechen um sie im Ticket-Shop anzuzeigen
* 2. aktion = f_anzeigen
* 	 Selektierung der Daten zu einem bestimmten Festival um aus dem Ticket-Shop in die Detail-Ansicht f�r ein Festival zu wechseln 
* 3. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgef�hrt und der User zur Anmelden-Seite weitergeleitet
* 
* @author Alina Fankh�nel
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
		HttpSession session = request.getSession(true);
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "max-age=600");
		response.setDateHeader("Expires", 600);
		try{
			if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("t_anzeigen")) {
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
				String antwort = "";
				
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
				if(start != null && end != null && start.compareTo(end) > 0) {
						antwort = "Das eingegebene Enddatum liegt vor dem Startdatum. Bitte korrigieren Sie Ihre Eingabe.";
						session.setAttribute("antwort", antwort);
				} else {				
					List<FestivalSuchobjekt> listFestivals = FestivalManager.selektiereFestivalsInSuche(kategorienID, ort, name, startDatum, endDatum, maxPreis);
					session.setAttribute("listFestivals", listFestivals);	
				}
				List<Kategorie> listKategorien = KategorienManager.selektiereAlleAktivenKategorien();
				FestivalSuchobjekt suchKriterien = new FestivalSuchobjekt(-1, name, ort, "", start, end, 0, maxPreis, "",kategorienID);
				session.setAttribute("suchKriterien", suchKriterien);
				session.setAttribute("listKategorien", listKategorien);
				request.getRequestDispatcher("k_ticketShop.jsp").include(request, response);
			} else {
				if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("f_anzeigen")) {
					int festivalid = Integer.parseInt(request.getParameter("festivalid"));
					float maxpreis = Float.parseFloat(request.getParameter("maxpreis"));
					
					// Wenn der User der aktuellen Session ein Kunde ist, wird der aktuelle Warenkorbinhalt selektiert
					if(session.getAttribute("begr��ung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
						int userid = Integer.parseInt(session.getAttribute("userid").toString());
						Warenkorb warenkorb = WarenkorbManager.selektiereWarenkorbVonKunden(userid, false);
						List<Integer> listArtikelID = new ArrayList<Integer>();
						for(Warenkorbelement warenkorbelement : warenkorb.listElemente) {
							listArtikelID.add(warenkorbelement.artikel.id);					
						}
						session.setAttribute("listArtikelID", listArtikelID);
					}
					Festival festival = FestivalManager.selektiereFestival(festivalid);
					
					if(maxpreis == 0.0) {
						List<Artikel> listArtikel = ArtikelManager.selektiereArtikelVonFestival(festivalid);
						session.setAttribute("listArtikel", listArtikel);
					} else {
						List<Artikel> listArtikelMitMaxPreis = ArtikelManager.selektiereArtikelVonFestivalMitMaxPreis(festivalid, maxpreis);
						List<Artikel> listArtikelUeberMaxPreis = ArtikelManager.selektiereArtikelVonFestival�berMaxPreis(festivalid, maxpreis);
						session.setAttribute("listArtikelMitMaxPreis", listArtikelMitMaxPreis);
						session.setAttribute("listArtikelUeberMaxPreis", listArtikelUeberMaxPreis);
					}
					session.setAttribute("festival", festival);
					session.setAttribute("maxpreis", maxpreis);
					session.setAttribute("aufrufer", request.getRequestURI() + "?" + request.getQueryString());
					request.getRequestDispatcher("k_festivaldetails.jsp").include(request, response);
					
				}
			}
			
		} catch (DatenbankException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Die angeforderte Seite ist derzeit nicht verf�gbar. Bitte versuchen Sie es sp�ter noch einmal!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
