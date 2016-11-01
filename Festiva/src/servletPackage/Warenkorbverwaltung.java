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
			Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid);
			List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
			session.setAttribute("listFestivals", listFestivals);
			session.setAttribute("warenkorb", warenkorb);
			request.getRequestDispatcher("k_warenkorb.jsp").include(request, response);
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

}
