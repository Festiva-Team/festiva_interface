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
* Servlet zur Steuerung der Artikeldaten durch den Administrator<br>
* 1. aktion = anlegen<br>
* 	 Anlage von Artikeln (sowohl Tickets mit Festivalverknüpfung als auch festivalübergreifende Artikel mit Bild)<br>
* 2. aktion = anzeigen<br>
* 	 Selektierung aller festivalübergreifenden Artikel zur Darstellung in der Artikelverwaltung<br>
* 3. aktion = aendern<br>
* 	 Selektierung der Daten zu einem bestimmten Artikel um aus der Artikelverwaltung in den Modus "Artikel bearbeiten" über zu gehen<br>
* 4. aktion = datenaendern<br>
* 	 Durchführung der Änderungen an Artikeln (sowohl Tickets mit Festivalverknüpfung als auch festivalübergreifende Artikel mit Bild)<br>
* 5. aktion = loeschen<br>
* 	 Löschen von Tickets oder festivalübergreifenden Artikeln<br>
* 6. aktion = b_loeschen<br>
* 	 Löschen des Bildes eines festivalübergreifenden Artikels<br>
* 7. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgeführt und der User zur Anmelden-Seite weitergeleitet<br>
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

		try {

			if (session != null && session.getAttribute("begrüßung") != null
					&& Integer.parseInt(session.getAttribute("gruppenid").toString()) == 1) {

				String antwort = "";
				if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anlegen")) {
					int festivalid = Integer.parseInt(request.getParameter("festivalid"));
					String beschreibung = request.getParameter("beschreibung");
					String details = request.getParameter("details");

					if (beschreibung.trim().length() == 0 || request.getParameter("preis").trim().length() == 0
							|| details.trim().length() == 0) {
						antwort = "Sie können den Artikel erst anlegen, wenn Sie alle Pflichtfelder gefüllt haben.";
					} else {
						float preis = Float.parseFloat(request.getParameter("preis"));

						Artikel artikel = new Artikel(-1, beschreibung, details, preis, false, "", festivalid);
						ArtikelManager.erstelleArtikel(artikel);

						Part dateiPart = request.getPart("bild");
						artikel = verarbeiteBild(dateiPart, artikel, false);
						antwort = "Der Artikel '" + artikel.beschreibung + "' wurde erfolgreich mit der ID "
								+ artikel.id + " angelegt.";
					}
					session.setAttribute("antwort", antwort);
					request.getRequestDispatcher("a_artikelAnlegen.jsp").include(request, response);
				} else {

					if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anzeigen")) {
						List<Artikel> listArtikel = ArtikelManager.selektiereAlleUnabhaengigenArtikel();
						session.setAttribute("listArtikel", listArtikel);
						request.getRequestDispatcher("a_artikelverwaltung.jsp").include(request, response);
					} else {
						int artikelid = Integer.parseInt(request.getParameter("artikelid").toString());
						Artikel artikel = ArtikelManager.selektiereArtikel(artikelid);
						if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("aendern")) {
						} else {
							if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("datenaendern")) {

								String beschreibung = request.getParameter("beschreibung");
								String details = request.getParameter("details");

								if (beschreibung.trim().length() == 0
										|| request.getParameter("preis").trim().length() == 0
										|| details.trim().length() == 0) {
									antwort = "Sie können den Artikel erst ändern, wenn Sie alle Pflichtfelder gefüllt haben.";
								} else {

									Part dateiPart = request.getPart("bild");
									artikel = verarbeiteBild(dateiPart, artikel, true);
									float preis = Float.parseFloat(request.getParameter("preis"));
									artikel.beschreibung = beschreibung;
									artikel.details = details;
									artikel.preis = preis;
									ArtikelManager.aktualisiereArtikel(artikel);
									antwort = "Der Artikel wurde erfolgreich geändert.";
								}
								session.setAttribute("antwort", antwort);
							} else {
								if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("loeschen")) {
									if (artikel.id != 6) {
										artikel.istGelöscht = true;
										ArtikelManager.löscheArtikel(artikel);
										antwort = "Der Artikel wurde erfolgreich gelöscht.";
									} else {
										antwort = "Dieser Artikel darf nicht gelöscht werden.";
									}
									session.setAttribute("antwort", antwort);
								} else {
									if (request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("b_loeschen")) {
										File datei = new File(System.getenv("myPath")
												+ "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\"
												+ artikel.bildpfad + ".jpg");

										if (datei.exists())
											datei.delete();
										artikel.bildpfad = "";
										ArtikelManager.aktualisiereArtikel(artikel);
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
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"Die angeforderte Seite ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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
	 * @param p_dateiPart Part der Datei
	 * @param p_artikel Artikel, an dem das Bild geändert werden soll
	 * @param p_loeschen gibt an, ob das bestehende gespeicherte Bild vorher gelöscht werden soll
	 * @return artikel Artikel mit aktuellem Bildpfad
	 */
	private Artikel verarbeiteBild(Part p_dateiPart, Artikel p_artikel, boolean p_loeschen) {
		
		if (p_dateiPart != null && gibDateiNamen(p_dateiPart) != null && !gibDateiNamen(p_dateiPart).equals("")) {
			
			if(p_loeschen) {
				File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + p_artikel.bildpfad + ".jpg");  
			    if (datei.exists()) datei.delete();
			}
			
			p_artikel.bildpfad = "Artikel" + "_" + p_artikel.id + "_" + new Date().getTime();
		    File datei = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + p_artikel.bildpfad + ".jpg");
		    
		    try (InputStream input = p_dateiPart.getInputStream()) {
		        Files.copy(input, datei.toPath());
		    } catch (IOException e) {
				e.printStackTrace();
			}
		    
		    if(p_loeschen == false) {
		    try {
		    	ArtikelManager.aktualisiereArtikel(p_artikel);
		    } catch (DatenbankException e) {
		    	e.printStackTrace();
		    }}
		}
		return p_artikel;		
	}

}
