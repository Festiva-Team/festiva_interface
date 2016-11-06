package servletPackage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		
		try{
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			
			String antwort = "";
			SimpleDateFormat datum = new SimpleDateFormat( "dd.MM.yyyy" );
			
			if ((request.getParameter("aktion")).equals("anzeigen")) {
				List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
				List<Kategorie> listKategorien = KategorienAdministration.selektiereAlleKategorien();
				session.setAttribute("listKategorien", listKategorien);
				session.setAttribute("listFestivals", listFestivals);
				request.getRequestDispatcher("a_festivalverwaltung.jsp").include(request, response);
			} else { 
				List<Kategorie> listKategorien = KategorienAdministration.selektiereAlleKategorien();
				session.setAttribute("listKategorien", listKategorien);
				if((request.getParameter("aktion")).equals("anlegenanzeigen")) {
				
				request.getRequestDispatcher("a_festivalAnlegen.jsp").include(request, response);
			} else {
				
				if((request.getParameter("aktion")).equals("anlegen")) {
															
					String name = request.getParameter("name");
					String ort = request.getParameter("ort");
					Date startdatum = null;
					Date enddatum = null;
					try {
						startdatum = datum.parse(request.getParameter("startdatum"));
						enddatum = datum.parse(request.getParameter("enddatum"));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					int kategorie = 0;
					String kurzbeschreibung = request.getParameter("kurzbeschreibung");
					kategorie = Integer.parseInt(request.getParameter("kategorie").toString());
					String langbeschreibung = request.getParameter("langbeschreibung");
					
					if(name.equals("") || ort.equals("") || startdatum == null || enddatum == null || kurzbeschreibung.equals("") || kategorie == 0 || langbeschreibung.equals("")) {
						antwort = "Ihr Festival kann erst angelegt werden, wenn Sie die Pflichtfelder gefüllt haben.";
					} else {
						
					Festival festival = new Festival(-1, name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, "", false, kategorie);
					FestivalAdministration.erstelleFestival(festival);
					
					Part filePart = request.getPart("bild");
					
					if (getFileName(filePart) != null && !getFileName(filePart).equals("")) {
						
						festival.bildpfad = "Festival" + "_" + festival.id + "_" + new Date().getTime();
					    File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg");
					    
					    try (InputStream input = filePart.getInputStream()) {
					        Files.copy(input, file.toPath());
					    }
					    
						FestivalAdministration.aktualisiereFestival(festival);
					}
					antwort = "Das Festival '" + festival.name + "' wurde erfolgreich mit der ID " + festival.id + " angelegt.";
					
					}
					session.setAttribute("antwort", antwort);
				    request.getRequestDispatcher("a_festivalAnlegen.jsp").include(request, response);
					
				} else {
					
					int festivalid = Integer.parseInt(request.getParameter("festivalid").toString());
					Festival festival = FestivalAdministration.selektiereFestival(festivalid);
					List<Artikel> listArtikel = ArtikelAdministration.selektiereAlleArtikelVonFestival(festivalid);
					session.setAttribute("listArtikel", listArtikel);
					
					if ((request.getParameter("aktion")).equals("aendern")) {

					} else {
						
						if ((request.getParameter("aktion")).equals("datenaendern")) {
							
							String name = request.getParameter("name");
							String ort = request.getParameter("ort");
							Date startdatum = null;
							Date enddatum = null;
							try {
								startdatum = datum.parse(request.getParameter("startdatum"));
								enddatum = datum.parse(request.getParameter("enddatum"));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							
							int kategorie = 0;
							String kurzbeschreibung = request.getParameter("kurzbeschreibung");
							kategorie = Integer.parseInt(request.getParameter("kategorie").toString());
							String langbeschreibung = request.getParameter("langbeschreibung");
							
							if(name.equals("") || ort.equals("") || startdatum == null || enddatum == null || kurzbeschreibung.equals("") || kategorie == 0 || langbeschreibung.equals("")) {
								antwort = "Sie können das Festival erst ändern, wenn Sie alle Pflichtfelder gefüllt haben.";
								session.setAttribute("antwort", antwort);
							} else { 
								
							Part filePart = request.getPart("bild"); 
							
							if (getFileName(filePart) != null && !getFileName(filePart).equals("")) {
						    File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg");
						    
						    if (file.exists()) file.delete();
						    
						    festival.bildpfad = "Festival" + "_" + festival.id + "_" + new Date().getTime();
						    file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg");
						    
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
						
						    festival.name = name;
						    festival.ort = ort;
						    festival.startDatum = startdatum;
						    festival.endDatum = enddatum;
						    festival.kurzbeschreibung = kurzbeschreibung;
						    festival.langbeschreibung = langbeschreibung;
						    festival.kategorienID = kategorie;
						    FestivalAdministration.aktualisiereFestival(festival);
							antwort = "Das Festival wurde erfolgreich geändert.";
							session.setAttribute("antwort", antwort);
							}
						} else {
							if((request.getParameter("aktion")).equals("loeschen")) {
								festival.istGelöscht = true;
								FestivalAdministration.löscheFestival(festival);
								for (Artikel artikel : listArtikel) {
									artikel.istGelöscht = true;
									ArtikelAdministration.löscheArtikel(artikel);
								}
								
								antwort = "Das Festival und alle dazugehörigen Artikel wurden erfolgreich gelöscht.";
								session.setAttribute("antwort", antwort);
							} 	else {
								if((request.getParameter("aktion")).equals("b_loeschen")) {
									File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg");
								    
								    if (file.exists()) file.delete();
								    festival.bildpfad = "";
								    FestivalAdministration.aktualisiereFestival(festival);
								    antwort = "Das Bild wurde erfolgreich gelöscht.";
								    session.setAttribute("antwort", antwort);
								}
							}
						}
					}
					session.setAttribute("festival", festival);
					request.getRequestDispatcher("a_festivalAendern.jsp").include(request, response);
				}
			  }
			}		
		} else {
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
		// TODO Auto-generated method stub
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
