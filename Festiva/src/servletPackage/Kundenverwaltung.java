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
@WebServlet("/Kundenverwaltung")
public class Kundenverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Kundenverwaltung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			
			if ((request.getParameter("aktion")).equals("anzeigen")) {
				List<Benutzer> listBenutzer = BenutzerAdministration.selektiereAlleKunden();
				session.setAttribute("listBenutzer", listBenutzer);
				request.getRequestDispatcher("a_kundenverwaltung.jsp").include(request, response);
			} else {
				if(request.getParameter("aktion").equals("aendern")) {
					int kundenid = Integer.parseInt(request.getParameter("kundenid").toString());
					Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(kundenid);
					session.setAttribute("benutzer", benutzer);
					request.getRequestDispatcher("a_kundenAendern.jsp").include(request, response);
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
