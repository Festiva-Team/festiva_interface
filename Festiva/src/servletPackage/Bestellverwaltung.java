package servletPackage;

import java.io.IOException;
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
@WebServlet("/Bestellverwaltung")
public class Bestellverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bestellverwaltung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession(false);
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
			if ((request.getParameter("aktion")).equals("anlegen")) {
				int userid = Integer.parseInt(session.getAttribute("userid").toString());
				String versand = request.getParameter("versand");
				boolean perPost = false;
				
				if(versand.equals("post")) {
					perPost = true;
				}
				
				Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, true);
				Bestellung bestellung = new Bestellung(warenkorb, perPost);
				BestellungsAdministration.erstelleBestellung(bestellung);
				WarenkorbAdministration.loescheWarenkorbinhalt(warenkorb.id);
			} else {
				if ((request.getParameter("aktion")).equals("anzeigen")) {
					
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
		doGet(request, response);
	}

}
