package servletPackage;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
*
* @author Timo Schlüter
*/
@WebServlet("/ShopSuche")
public class ShopSuche extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShopSuche() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		SimpleDateFormat datum = new SimpleDateFormat( "dd.MM.yyyy" );
		String name = request.getParameter("name");
		String ort = request.getParameter("ort");
		String  maxPreis = request.getParameter("maxPreis").toString();
		String startdatum = request.getParameter("startdatum");
		String enddatum = request.getParameter("enddatum");

		
		request.getSession(false).setAttribute("startdatum", startdatum);
		request.getSession(false).setAttribute("enddatum", enddatum);
		request.getSession(false).setAttribute("maxPreis", maxPreis);
		request.getSession(false).setAttribute("name", name);
		request.getSession(false).setAttribute("ort", ort);
		request.getRequestDispatcher("k_shop.jsp").include(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
