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
* Servlet zur Steuerung der Kategoriendaten durch den Administrator<br>
* 1. aktion = anzeigen<br>
* 	 Selektierung aller Kategorien zur Darstellung in der Kategorienverwaltung<br>
* 2. aktion = anlegen<br>
* 	 Anlage einer Kategorie mit den �bermittelten Daten <br>
* 3. aktion = aendern<br>
* 	 Selektierung der Daten zu einer bestimmten Kategorie um aus der Kategorienverwaltung in den Modus "Kategorie bearbeiten" �ber zu gehen<br>
* 4. aktion = datenaendern<br>
* 	 Durchf�hrung der �nderungen an einer Kategorie<br>
* 5. aktion = loeschen<br>
* 	 L�schen der Kategorie<br>
* 6. aktion = b_loeschen<br>
* 	 L�schen des Bildes eines Festivals<br>
* 7. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgef�hrt und der User zur Anmelden-Seite weitergeleitet<br>
* 
* @author Alina Fankh�nel
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
		if(session != null && session.getAttribute("begr��ung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {
			String antwort = "";
			
			if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anlegen")) {
				String name = request.getParameter("name");
				String beschreibung = request.getParameter("beschreibung");
				
				if(name.trim().length() == 0 || beschreibung.trim().length() == 0) {
					antwort = "Ihre Kategorie kann erst angelegt werden, wenn Sie die Pflichtfelder gef�llt haben.";
				} else { 
				
				Kategorie kategorie = new Kategorie(-1, name, beschreibung, "", false);
				KategorienManager.erstelleKategorie(kategorie);
				
			    Part dateiPart = request.getPart("bild");
			    kategorie = verarbeiteBild(dateiPart, kategorie, false);			
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
								antwort = "Die Felder Name und Beschreibung m�ssen gef�llt sein.";
								session.setAttribute("antwort", antwort);
							} else { 
								
							Part dateiPart = request.getPart("bild"); 
							kategorie = verarbeiteBild(dateiPart, kategorie, true);						
						    kategorie.name = name;
						    kategorie.beschreibung = beschreibung;
						    KategorienManager.aktualisiereKategorie(kategorie);
							antwort = "Die Kategorie wurde erfolgreich ge�ndert.";
							session.setAttribute("antwort", antwort);
							}
							
						} else {
							if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("loeschen")) {			
								List<Festival> listFestivals = FestivalManager.selektiereAlleFestivalObjekteVonKategorie(kategorie.id);
								boolean loeschenMoeglich = true;
								for(Festival festival : listFestivals) {
									if(festival.istGel�scht == false) {
										loeschenMoeglich = false;
									}
								}
								if(loeschenMoeglich) {
									kategorie.istGel�scht = true;
									KategorienManager.l�scheKategorie(kategorie);
									antwort = "Die Kategorie wurde erfolgreich gel�scht.";
								} else{
									antwort = "Die Kategorie konnte nicht gel�scht werden, da sie Festivals beinhaltet, die noch nicht gel�scht wurden.";
								}
							
								session.setAttribute("antwort", antwort);
							} else {
								if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("b_loeschen")) {
									File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg");
								    
								    if (datei.exists()) datei.delete();
								    kategorie.bildpfad = "";
								    KategorienManager.aktualisiereKategorie(kategorie);
								    antwort = "Das Bild wurde erfolgreich gel�scht.";
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
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Die angeforderte Seite ist derzeit nicht verf�gbar. Bitte versuchen Sie es sp�ter noch einmal!");
		}			
	}
	
	/**
	 * Methode zur Ermittlung des Datei Namens
	 * 
	 * @param p_part Part der Datei
	 * @return rueckmeldung ermittelter Datei-Name, wenn die Ermittlung nicht m�glich war, wird null zur�ckgegeben
	 */
	private String gibDateiNamen(Part p_part) {
		String rueckmeldung = null;
		String partHeader = p_part.getHeader("content-disposition");
		log("Part Header = " + partHeader);
		for (String cd : p_part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				rueckmeldung = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
				return rueckmeldung;
			}
		}
		return rueckmeldung;
	}
	
	/**
	 * Methode zur Verarbeitung eines Bildes
	 * 
	 * @param p_dateiPart Part der Datei
	 * @param p_kategorie Kategorie, an dem das Bild ge�ndert werden soll
	 * @param p_loeschen gibt an, ob das bestehende gespeicherte Bild vorher gel�scht werden soll
	 * @return kategorie Kategorie mit aktuellem Bildpfad
	 */
	private Kategorie verarbeiteBild(Part p_dateiPart, Kategorie p_kategorie, boolean p_loeschen) {
		
		if (p_dateiPart != null && gibDateiNamen(p_dateiPart) != null && !gibDateiNamen(p_dateiPart).equals("")) {
			
			if(p_loeschen) {
				File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + p_kategorie.bildpfad + ".jpg");  
			    if (datei.exists()) datei.delete();
			}
			
			p_kategorie.bildpfad = "Festival" + "_" + p_kategorie.id + "_" + new Date().getTime();
		    File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + p_kategorie.bildpfad + ".jpg");
		    
		    try (InputStream input = p_dateiPart.getInputStream()) {
		        Files.copy(input, datei.toPath());
		    } catch (IOException e) {
				e.printStackTrace();
			}
		    
		    if(p_loeschen == false) {
		    try {
		    	KategorienManager.aktualisiereKategorie(p_kategorie);
		    } catch (DatenbankException e) {
		    	e.printStackTrace();
		    }}
		}
		return p_kategorie;		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
