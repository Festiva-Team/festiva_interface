package servletPackage;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import standardPackage.*;

/**
 * Servlet implementation class Festivaldetails
 */
@WebServlet("/Festivaldetails")
public class Festivaldetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Festivaldetails() {
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
		
		try {
			int festivalid = Integer.parseInt(request.getParameter("festivalid").toString());
			Festival festival;
			festival = FestivalAdministration.selektiereFestival(festivalid);
			
			String name = festival.name;
			String ort = festival.ort;
			Date startDatum = festival.startDatum;
			Date endDatum = festival.endDatum;
			String bildpfad = festival.bildpfad;
			String kurzbeschreibung = festival.kurzbeschreibung;
			String langbeschreibung = festival.langbeschreibung;
			String maxPreis = request.getParameter("maxPreis").toString();
			if (maxPreis.equals("null"))
			{
				maxPreis = "";
			}
			if (maxPreis == "")
			{
				maxPreis = "";
			}
			if (maxPreis == null)
			{
				maxPreis = "";
			}
			//float maxPreis = Float.parseFloat(request.getParameter("maxPreis").toString());
			
			
			session.setAttribute("festivalid", festivalid);
			session.setAttribute("name", name);
			session.setAttribute("ort", ort);
			session.setAttribute("startDatum", startDatum);
			session.setAttribute("endDatum", endDatum);
			session.setAttribute("bildpfad", bildpfad);
			session.setAttribute("kurzbeschreibung", kurzbeschreibung);
			session.setAttribute("langbeschreibung", langbeschreibung);
			session.setAttribute("maxPreis", maxPreis);
			
			List<Artikel> listArtikel = ArtikelAdministration.selektiereAlleArtikelVonFestival(festivalid);
		session.setAttribute("listArtikel", listArtikel);
		
		
			request.getRequestDispatcher("k_festivaldetails.jsp").include(request, response);
		} catch (DatenbankException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Die angeforderte Seite ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal!");
			request.getRequestDispatcher("k_shop.jsp").include(request, response);
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
