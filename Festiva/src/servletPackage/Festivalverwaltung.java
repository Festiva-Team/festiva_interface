package servletPackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
@WebServlet("/Festivalverwaltung")
@MultipartConfig
public class Festivalverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Festivalverwaltung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		if(session != null && session.getAttribute("begr��ung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			
			String antwort = "";
			
			if ((request.getParameter("aktion")).equals("anzeigen")) {
				List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
				session.setAttribute("listFestivals", listFestivals);
				request.getRequestDispatcher("a_festivalverwaltung.jsp").include(request, response);
			} else {
				
				int festivalid = Integer.parseInt(request.getParameter("festivalid").toString());
				Festival festival = FestivalAdministration.selektiereFestival(festivalid);
				
				if ((request.getParameter("aktion")).equals("aendern")) {
					session.setAttribute("festival", festival);
					request.getRequestDispatcher("a_festivalAendern.jsp").include(request, response);	
				}
			}		
		} else {
			response.sendRedirect("k_anmelden.jsp");
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
