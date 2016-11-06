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
*
* @author Alina Fankhänel
*/
@WebServlet("/Artikelverwaltung")
@MultipartConfig
public class Artikelverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Artikelverwaltung() {
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
		
		try{
		
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			
			String antwort = "";
			if((request.getParameter("aktion")).equals("anlegen")) {
				
				int festivalid = Integer.parseInt(request.getParameter("festivalid"));
				String beschreibung = request.getParameter("beschreibung");
				
				if(beschreibung.equals("") || request.getParameter("preis").equals("")) {
					antwort = "Sie können den Artikel erst anlegen, wenn Sie alle Pflichtfelder gefüllt haben.";
				} else {
				float preis = Float.parseFloat(request.getParameter("preis"));
				
				Artikel artikel = new Artikel(-1, beschreibung, preis, false, "", festivalid);
				ArtikelAdministration.erstelleArtikel(artikel);
				
			    Part filePart = request.getPart("bild");
			    
				if (filePart != null && getFileName(filePart) != null && !getFileName(filePart).equals("")) {
					
					artikel.bildpfad = "Artikel" + "_" + artikel.id + "_" + new Date().getTime();
				    File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg");
				    
				    try (InputStream input = filePart.getInputStream()) {
				        Files.copy(input, file.toPath());
				    }
				    
					ArtikelAdministration.aktualisiereArtikel(artikel);
				}

				antwort = "Der Artikel '" + artikel.beschreibung + "' wurde erfolgreich mit der ID " + artikel.id + " angelegt.";
				}
				session.setAttribute("antwort", antwort);
			    request.getRequestDispatcher("a_artikelAnlegen.jsp").include(request, response);
			} else {
				
				if((request.getParameter("aktion")).equals("anzeigen")) {
					List<Artikel> listArtikel = ArtikelAdministration.selektiereAlleUnabhaengigenArtikel();
					session.setAttribute("listArtikel", listArtikel);
					request.getRequestDispatcher("a_artikelverwaltung.jsp").include(request, response);
				} else {
				int artikelid = Integer.parseInt(request.getParameter("artikelid").toString());
				Artikel artikel = ArtikelAdministration.selektiereArtikel(artikelid);
			if ((request.getParameter("aktion")).equals("aendern")) {			
			} else {
				if ((request.getParameter("aktion")).equals("datenaendern")) {
					
					String beschreibung = request.getParameter("beschreibung");
					
					
					if(beschreibung.equals("") || request.getParameter("preis").equals("")) {
						antwort = "Sie können den Artikel erst ändern, wenn Sie alle Pflichtfelder gefüllt haben.";
					} else {
						
						Part filePart = request.getPart("bild"); 
						
						if ( filePart != null && getFileName(filePart) != null && !getFileName(filePart).equals("")) {
					    File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg");
					    
					    if (file.exists()) file.delete();
					    
					    artikel.bildpfad = "Artikel" + "_" + artikel.id + "_" + new Date().getTime();
					    file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg");
					    
					    try (InputStream input = filePart.getInputStream()) {
					        Files.copy(input, file.toPath());
					        try {
								Thread.sleep(3000);
							} catch (InterruptedException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
					    }
						}
						
					float preis = Float.parseFloat(request.getParameter("preis"));
					artikel.beschreibung = beschreibung;
					artikel.preis = preis;
					ArtikelAdministration.aktualisiereArtikel(artikel);
					antwort = "Der Artikel wurde erfolgreich geändert.";
					}
					session.setAttribute("antwort", antwort);
				} else {
					if((request.getParameter("aktion")).equals("loeschen")) {
						if(artikel.id != 6) {
							artikel.istGelöscht = true;
							ArtikelAdministration.löscheArtikel(artikel);
							antwort = "Der Artikel wurde erfolgreich gelöscht.";}
						else {
							antwort = "Dieser Artikel darf nicht gelöscht werden.";
						}
						session.setAttribute("antwort", antwort);
					} else {
						if((request.getParameter("aktion")).equals("b_loeschen")) {
							File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg");
						    
						    if (file.exists()) file.delete();
						    artikel.bildpfad = "";
						    ArtikelAdministration.aktualisiereArtikel(artikel);
						    antwort = "Das Bild wurde erfolgreich gelöscht.";
						    session.setAttribute("antwort", antwort);
						}
					}
				}
			
			}
			session.setAttribute("artikel", artikel);	
			request.getRequestDispatcher("a_artikelAendern.jsp").include(request, response);
		  } 
	     }
		}
		
		else {
			response.sendRedirect("k_anmelden.jsp");
		}
		} catch (DatenbankException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Die angeforderte Seite ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	
	
	private String getFileName(Part part) {
		String partHeader = part.getHeader("content-disposition");
		log("Part Header = " + partHeader);
		for (String cd : part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				return cd.substring(cd.indexOf('=') + 1).trim()
						.replace("\"", "");
			}
		}
		return null;
	}

}
