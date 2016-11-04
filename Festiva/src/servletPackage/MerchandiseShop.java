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
 * Servlet implementation class MerchandiseShop
 * @author Nicola Kloke
 */

@WebServlet("/MerchandiseShop")
public class MerchandiseShop extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MerchandiseShop() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if ((request.getParameter("aktion")).equals("m_anzeigen")) {
			
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
			request.getRequestDispatcher("k_merchandiseShop.jsp").include(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
