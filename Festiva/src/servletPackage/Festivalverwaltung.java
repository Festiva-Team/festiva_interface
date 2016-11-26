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
import managerPackage.*;

/** 
* Servlet zur Steuerung der Festivaldaten durch den Administrator<br>
* 1. aktion = anzeigen<br>
* 	 Selektierung aller Festivals zur Darstellung in der Festivalverwaltung<br>
* 2. aktion = anlegen<br>
* 	 Anlage eines Festivals mit den übermittelten Daten <br>
* 3. aktion = aendern<br>
* 	 Selektierung der Daten zu einem bestimmten Festival um aus der Festivalverwaltung in den Modus "Festival bearbeiten" über zu gehen<br>
* 4. aktion = datenaendern<br>
* 	 Durchführung der Änderungen an einem Festival<br>
* 5. aktion = loeschen<br>
* 	 Löschen des Festivals<br>
* 6. aktion = b_loeschen<br>
* 	 Löschen des Bildes eines Festivals<br>
* 7. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgeführt und der User zur Anmelden-Seite weitergeleitet<br>
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
			
			if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anzeigen")) {
				List<Festival> listFestivals = FestivalManager.selektiereAlleFestivals();
				List<Kategorie> listKategorien = KategorienManager.selektiereAlleKategorien();
				session.setAttribute("listKategorien", listKategorien);
				session.setAttribute("listFestivals", listFestivals);
				request.getRequestDispatcher("a_festivalverwaltung.jsp").include(request, response);
			} else { 
				List<Kategorie> listKategorien = KategorienManager.selektiereAlleKategorien();
				session.setAttribute("listKategorien", listKategorien);
				if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anlegenanzeigen")) {
					listKategorien = KategorienManager.selektiereAlleAktivenKategorien();
					session.setAttribute("listKategorien", listKategorien);
				request.getRequestDispatcher("a_festivalAnlegen.jsp").include(request, response);
			} else {
				
				if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anlegen")) {
															
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
					
					if(name.trim().length() == 0 || ort.trim().length() == 0 || startdatum == null || enddatum == null || kurzbeschreibung.trim().length() == 0 || kategorie == 0 || langbeschreibung.trim().length() == 0) {
						antwort = "Ihr Festival kann erst angelegt werden, wenn Sie die Pflichtfelder gefüllt haben.";
					} else {
						
					Festival festival = new Festival(-1, name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, "", false, kategorie);
					FestivalManager.erstelleFestival(festival);
					
					Part dateiPart = request.getPart("bild");
					festival = verarbeiteBild(dateiPart, festival, false);
					antwort = "Das Festival '" + festival.name + "' wurde erfolgreich mit der ID " + festival.id + " angelegt.";
					
					}
					session.setAttribute("antwort", antwort);
				    request.getRequestDispatcher("a_festivalAnlegen.jsp").include(request, response);
					
				} else {
					
					int festivalid = Integer.parseInt(request.getParameter("festivalid").toString());
					Festival festival = FestivalManager.selektiereFestival(festivalid);
					List<Artikel> listArtikel = ArtikelManager.selektiereAlleArtikelVonFestival(festivalid);
					session.setAttribute("listArtikel", listArtikel);
					
					if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("aendern")) {

					} else {
						
						if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("datenaendern")) {
							
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
							
							if(name.trim().length() == 0 || ort.trim().length() == 0 || startdatum == null || enddatum == null || kurzbeschreibung.trim().length() == 0 || kategorie == 0 || langbeschreibung.trim().length() == 0) {
								antwort = "Sie können das Festival erst ändern, wenn Sie alle Pflichtfelder gefüllt haben.";
								session.setAttribute("antwort", antwort);
							} else { 
								
							Part dateiPart = request.getPart("bild"); 
							festival = verarbeiteBild(dateiPart, festival, true);						
						    festival.name = name;
						    festival.ort = ort;
						    festival.startDatum = startdatum;
						    festival.endDatum = enddatum;
						    festival.kurzbeschreibung = kurzbeschreibung;
						    festival.langbeschreibung = langbeschreibung;
						    festival.kategorienID = kategorie;
						    FestivalManager.aktualisiereFestival(festival);
							antwort = "Das Festival wurde erfolgreich geändert.";
							session.setAttribute("antwort", antwort);
							}
						} else {
							if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("loeschen")) {
								festival.istGelöscht = true;
								FestivalManager.löscheFestival(festival);
								for (Artikel artikel : listArtikel) {
									artikel.istGelöscht = true;
									ArtikelManager.löscheArtikel(artikel);
								}
								
								antwort = "Das Festival und alle dazugehörigen Artikel wurden erfolgreich gelöscht.";
								session.setAttribute("antwort", antwort);
							} 	else {
								if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("b_loeschen")) {
									File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg");
								    
								    if (datei.exists()) datei.delete();
								    festival.bildpfad = "";
								    FestivalManager.aktualisiereFestival(festival);
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
	
	/**
	 * Methode zur Ermittlung des Datei Namens
	 * 
	 * @param p_part Part der Datei
	 * @return rueckmeldung ermittelter Datei-Name, wenn die Ermittlung nicht möglich war, wird null zurückgegeben
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
	 * @param p_part Part der Datei
	 * @param p_festival Festival, an dem das Bild geändert werden soll
	 * @param p_loeschen gibt an, ob das bestehende gespeicherte Bild vorher gelöscht werden soll
	 * @return festival Festival mit aktuellem Bildpfad
	 */
	private Festival verarbeiteBild(Part p_dateiPart, Festival p_festival, boolean p_loeschen) {
		
		if (p_dateiPart != null && gibDateiNamen(p_dateiPart) != null && !gibDateiNamen(p_dateiPart).equals("")) {
			
			if(p_loeschen) {
				File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + p_festival.bildpfad + ".jpg");  
			    if (datei.exists()) datei.delete();
			}
			
			p_festival.bildpfad = "Festival" + "_" + p_festival.id + "_" + new Date().getTime();
		    File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + p_festival.bildpfad + ".jpg");
		    
		    try (InputStream input = p_dateiPart.getInputStream()) {
		        Files.copy(input, datei.toPath());
		    } catch (IOException e) {
				e.printStackTrace();
			}
		    
		    if(p_loeschen == false) {
		    try {
		    	FestivalManager.aktualisiereFestival(p_festival);
		    } catch (DatenbankException e) {
		    	e.printStackTrace();
		    }}
		}
		return p_festival;		
	}

}
