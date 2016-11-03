package servletPackage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

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
		// TODO Auto-generated method stub

		if ((request.getParameter("aktion")).equals("anzeigen")) {
			List<Artikel> listArtikel = ArtikelAdministration.selektiereUnabhaengigeArtikel();
			session.setAttribute("listArtikel", listArtikel);
			request.getRequestDispatcher("k_merchandiseShop.jsp").include(request, response);
		}
		else {
		int elementID = Integer.parseInt(request.getParameter("elementid"));
		int userid = Integer.parseInt(session.getAttribute("userid").toString());
			if((request.getParameter("aktion")).equals("hinzufuegen")) {
				Warenkorbelement warenkorbelement = WarenkorbAdministration.selektiereWarenkorbelement(elementID);
				WarenkorbAdministration.fügeWarenkorbelementEin(warenkorbelement, userid);
				
			}
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
