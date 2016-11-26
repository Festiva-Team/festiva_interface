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
import managerPackage.*;

/** 
* Servlet zur Steuerung der Kategoriendaten durch den Administrator
* 1. aktion = anzeigen
* 	 Selektierung aller Kategorien zur Darstellung in der Kategorienverwaltung
* 2. aktion = anlegen
* 	 Anlage einer Kategorie mit den übermittelten Daten 
* 3. aktion = aendern
* 	 Selektierung der Daten zu einer bestimmten Kategorie um aus der Kategorienverwaltung in den Modus "Kategorie bearbeiten" über zu gehen
* 4. aktion = datenaendern
* 	 Durchführung der Änderungen an einer Kategorie
* 5. aktion = loeschen
* 	 Löschen der Kategorie
* 6. aktion = b_loeschen
* 	 Löschen des Bildes eines Festivals
* 7. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgeführt und der User zur Anmelden-Seite weitergeleitet
* 
* @author Alina Fankhänel
*/
@WebServlet("/Kategorienverwaltung")
@MultipartConfig
public class Kategorienverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Kategorienverwaltung() {
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
			
			if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anlegen")) {
				String name = request.getParameter("name");
				String beschreibung = request.getParameter("beschreibung");
				
				if(name.trim().length() == 0 || beschreibung.trim().length() == 0) {
					antwort = "Ihre Kategorie kann erst angelegt werden, wenn Sie die Pflichtfelder gefüllt haben.";
				} else { 
				
				Kategorie kategorie = new Kategorie(-1, name, beschreibung, "", false);
				KategorienManager.erstelleKategorie(kategorie);
				
			    Part filePart = request.getPart("bild");
			    
				if (getFileName(filePart) != null && !getFileName(filePart).equals("")) {
					
					kategorie.bildpfad = "Kategorie" + "_" + kategorie.id + "_" + new Date().getTime();
				    File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg");
				    
				    try (InputStream input = filePart.getInputStream()) {
				        Files.copy(input, file.toPath());
				    }
				    
					KategorienManager.aktualisiereKategorie(kategorie);
				}		    
				
				antwort = "Die Kategorie '" + kategorie.name + "' wurde erfolgreich mit der ID " + kategorie.id + " angelegt.";
				}
				session.setAttribute("antwort", antwort);
			    request.getRequestDispatcher("a_kategorieAnlegen.jsp").include(request, response);
			} else {
				if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anzeigen")) {
					List<Kategorie> listKategorien = KategorienManager.selektiereAlleKategorien();
					session.setAttribute("listKategorien", listKategorien);
					request.getRequestDispatcher("a_kategorienverwaltung.jsp").include(request, response);
				}
				else {
					int kategorienid = Integer.parseInt((request.getParameter("kategorienid")).toString());
					Kategorie kategorie = KategorienManager.selektiereKategorie(kategorienid);
					
					if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("aendern")) {
						
						
					}
					else {
						if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("datenaendern")) {
							
							String name = request.getParameter("name");
							String beschreibung = request.getParameter("beschreibung");
							
							if(name == null || beschreibung == null || name.trim().length() == 0 || beschreibung.trim().length() == 0) {
								antwort = "Die Felder Name und Beschreibung müssen gefüllt sein.";
								session.setAttribute("antwort", antwort);
							} else { 
								
							Part filePart = request.getPart("bild"); 
							
							if (getFileName(filePart) != null && !getFileName(filePart).equals("")) {
						    File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg");
						    
						    if (file.exists()) file.delete();
						    
						    kategorie.bildpfad = "Kategorie" + "_" + kategorie.id + "_" + new Date().getTime();
						    file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg");
						    
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
						
						    kategorie.name = name;
						    kategorie.beschreibung = beschreibung;
						    KategorienManager.aktualisiereKategorie(kategorie);
							antwort = "Die Kategorie wurde erfolgreich geändert.";
							session.setAttribute("antwort", antwort);
							}
							
						} else {
							if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("loeschen")) {			
								List<Festival> listFestivals = FestivalManager.selektiereAlleFestivalObjekteVonKategorie(kategorie.id);
								boolean loeschenMoeglich = true;
								for(Festival festival : listFestivals) {
									if(festival.istGelöscht == false) {
										loeschenMoeglich = false;
									}
								}
								if(loeschenMoeglich) {
									kategorie.istGelöscht = true;
									KategorienManager.löscheKategorie(kategorie);
									antwort = "Die Kategorie wurde erfolgreich gelöscht.";
								} else{
									antwort = "Die Kategorie konnte nicht gelöscht werden, da sie Festivals beinhaltet, die noch nicht gelöscht wurden.";
								}
							
								session.setAttribute("antwort", antwort);
							} else {
								if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("b_loeschen")) {
									File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg");
								    
								    if (file.exists()) file.delete();
								    kategorie.bildpfad = "";
								    KategorienManager.aktualisiereKategorie(kategorie);
								    antwort = "Das Bild wurde erfolgreich gelöscht.";
								    session.setAttribute("antwort", antwort);
								}
							}
						}
					}
					session.setAttribute("kategorie", kategorie);
					request.getRequestDispatcher("a_kategorieAendern.jsp").include(request, response);	
					
					
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
