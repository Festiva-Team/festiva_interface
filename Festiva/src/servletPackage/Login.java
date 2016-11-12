package servletPackage;

import standardPackage.*;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Alina Fankhänel
 */
@WebServlet("/Login")
public class Login extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request
	 *            servlet request
	 * @param response
	 *            servlet response
	 * @throws ServletException
	 *             if a servlet-specific error occurs
	 * @throws IOException
	 *             if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		String antwort = " ";
		String begrüßung = " ";

		try{
		Benutzer benutzer = BenutzerAdministration.selektiereBenutzer(request.getParameter("email"));

		if (benutzer != null) {
				if (benutzer.istGesperrt == true) {
					
					if(BenutzerAdministration.selektierePasswortZaehlerVonKunde(benutzer.id) >= 3) {
						antwort = "Ihr Benutzerkonto wurde gesperrt, da Sie zu oft ein falsches Passwort eingegeben haben. Bitte wenden Sie sich an den Administrator: admin@festiva.de";
					} else {
					antwort = "Ihr Benutzerkonto wurde gesperrt. Bitte wenden Sie sich an den Administrator: admin@festiva.de";
					}
					request.getSession(false).setAttribute("antwort", antwort);
					request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
					
				} else {
					if (benutzer.istGelöscht == true) {
						antwort = "Das Benutzerkonto mit dieser E-Mail-Adresse wurde gelöscht. Sollten Sie Fragen dazu haben, wenden Sie sich bitte an den Administrator: admin@festiva.de";
						request.getSession(false).setAttribute("antwort", antwort);
						request.getRequestDispatcher("k_anmelden.jsp").include(request, response);

					} else {
						String pwHash = Registrierung.generiereHash((request.getParameter("passwort") + "76ZuOp(6?ssXY0"));
						if ((benutzer.passwortHash).equals(pwHash)) {
						HttpSession session = request.getSession(true);
						session.setAttribute("userid", benutzer.id);
						session.setAttribute("gruppenid", benutzer.gruppenID);
						session.setMaxInactiveInterval(3600);

						
						if (benutzer.gruppenID == 1){
							begrüßung = "Herzlich Willkommen bei Festiva!";
							request.getSession(false).setAttribute("begrüßung", begrüßung);
							request.getRequestDispatcher("a_startseiteAdmin.jsp").include(request, response);
							
						} else {
							BenutzerAdministration.aktualisierePasswortZaehlerBeiKunde(benutzer.id, 0);
							if((benutzer.vorname).equals("") && benutzer.nachname.equals("")) {
							begrüßung = "Herzlich Willkommen bei Festiva!";	
							} else {
							begrüßung = "Herzlich Willkommen bei Festiva, " + benutzer.vorname + " " + benutzer.nachname + "!";
							}
							request.getSession(false).setAttribute("begrüßung", begrüßung);
							request.getRequestDispatcher("/Produktverwaltung?aktion=s_anzeigen").include(request, response);

						}

						} else {
							
							if(benutzer.gruppenID == 1) {
								antwort = "Sie haben ein falsches Passwort eingegeben. Bitte versuchen Sie es nochmal!";
							} else {
								int zaehler = BenutzerAdministration.selektierePasswortZaehlerVonKunde(benutzer.id);
								zaehler = zaehler + 1;
								BenutzerAdministration.aktualisierePasswortZaehlerBeiKunde(benutzer.id, zaehler);
								
								if(zaehler >= 3) {
									antwort = "Ihr Benutzerkonto wurde gesperrt, da Sie 3 Mal ein falsches Passwort eingegeben haben. Bitte wenden Sie sich an den Administrator: admin@festiva.de";
								} else {
									antwort = "Sie haben ein falsches Passwort eingegeben. Bitte versuchen Sie es nochmal!";
								}
							}
							request.getSession(false).setAttribute("antwort", antwort);
							request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
						}
					}
				}
		} else {
			antwort = "Zu der eingegebenen E-Mail-Adresse konnte kein Benutzer gefunden werden. Bitte registieren Sie sich zuerst oder geben eine korrekte E-Mail-Adresse an!";
			request.getSession(false).setAttribute("antwort", antwort);
			request.getRequestDispatcher("k_anmelden.jsp").include(request, response);

		}
		} catch (DatenbankException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Die angeforderte Seite ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal!");
		}

	}

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
     //   processRequest(request, response);
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}