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
import managerPackage.*;

/** 
* Servlet zur Steuerung des Warenkorbs für Kunden<br>
* 1. aktion = anzeigen<br>
* 	 Selektierung des Warenkorbs mit allen Positionen zu dem derzeit angemeldeten Kunden und Weiterleitung zu der Ansicht "Mein Warenkorb"<br>
* 2. aktion = k_anzeigen<br>
* 	 Selektierung der persönlichen Daten sowie dem Warenkorb zu dem derzeit angemeldeten Kunden und Weiterleitung zu der Ansicht "Kasse"<br>
* 3. aktion = p_versand<br>
* 	 Hinzufügen des Post-Versand-Artikels (vorausgesetzt dieser ist in der Bestellung noch nicht enthalten)<br>
* 4. aktion = m_versand<br>
* 	 Entfernen des Post-Versand-Artikels (vorausgesetzt dieser ist in der Bestellung enthalten)<br>
* 5. aktion = hinzufuegen<br>
* 	 Hinzufügen des ausgewählten Artikels mit der übermittelten Menge als neue Position innerhalb des Warenkorbs<br>
* 6. aktion = aktualisieren<br>
* 	 Hinzufügen der übermittelten Menge zu dem ausgewählten Artikel indem die bestehende Position innerhalb des Warenkorbs angepasst wird<br>
* 7. aktion = aendern<br>
* 	 Durchführung der Änderungen an dem Inhalt des Warenkorbs (erhöhen und verringern der Menge einzelner Artikel) <br>
* 8. aktion = loeschen<br>
* 	 Löschen einer Position im Warenkorb<br>
* 9. aktion = anmelden<br>
* 	 Übermittlung einer Aufforderung zum Anmelden/Registrieren bevor Artikel in den Warenkorb gelegt werden kann (inkl. Speicherung um welchen Artikel es sich handelt, sodass der Kunde anschließend wieder zu dem Artikel zurückgeleitet werden kann)<br>
* 10. Sollte der User unberechtigter Weise dieses Servlet aufrufen, wird keine Aktion durchgeführt und der User zur Anmelden-Seite weitergeleitet<br>
* 
* @author Alina Fankhänel
*/
@WebServlet("/Warenkorbverwaltung")
public class Warenkorbverwaltung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Warenkorbverwaltung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String antwort = "";
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		
		try{
		if(session != null && session.getAttribute("begrüßung") != null && Integer.parseInt(session.getAttribute("gruppenid").toString()) == 2) {
			
			if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anzeigen")) {
			int userid = Integer.parseInt(session.getAttribute("userid").toString());
			Warenkorb warenkorb = WarenkorbManager.selektiereWarenkorbVonKunden(userid, false);
			List<Festival> listFestivals = FestivalManager.selektiereAlleFestivals();
			session.setAttribute("listFestivals", listFestivals);
			session.setAttribute("warenkorb", warenkorb);
			request.getRequestDispatcher("k_warenkorb.jsp").include(request, response);
			} else { 
					if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("k_anzeigen")) {
						int userid = Integer.parseInt(session.getAttribute("userid").toString());
						boolean perPost = false;
						boolean postEnthalten = false;
						Warenkorb warenkorb = WarenkorbManager.selektiereWarenkorbVonKunden(userid, true);
						for(Warenkorbelement warenkorbelement : warenkorb.listElemente) {
							if (warenkorbelement.artikel.festivalID == 0) {
								perPost = true;
							}
							if(warenkorbelement.artikel.id == 6) {
								postEnthalten = true;
							}
						}
						if(perPost == true && postEnthalten == false) {
							Artikel artikel = ArtikelManager.selektiereArtikel(6);
							Warenkorbelement warenkorbelement = new Warenkorbelement(-1, 1, artikel);
							WarenkorbManager.fügeWarenkorbelementEin(warenkorbelement, userid);
							warenkorb = WarenkorbManager.selektiereWarenkorbVonKunden(userid, true);
						}
						
						Benutzer benutzer = BenutzerManager.selektiereBenutzerMitID(userid);
						List<Festival> listFestivals = FestivalManager.selektiereAlleFestivals();
						boolean kundendatenVollstaendig = ueberpruefeKundendaten(benutzer);
						
						
						session.setAttribute("aufrufer_k", request.getRequestURI() + "?" + request.getQueryString());
						session.setAttribute("kundendatenVollstaendig", kundendatenVollstaendig);
						session.setAttribute("listFestivals", listFestivals);
						session.setAttribute("warenkorb", warenkorb);
						session.setAttribute("benutzer", benutzer);
						request.getRequestDispatcher("k_kasse.jsp").include(request, response);
					} else {
						if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("p_versand")) {
							int userid = Integer.parseInt(session.getAttribute("userid").toString());
							boolean postEnthalten = false;
							Warenkorb warenkorb = WarenkorbManager.selektiereWarenkorbVonKunden(userid, true);
							for(Warenkorbelement warenkorbelement : warenkorb.listElemente) {
								if(warenkorbelement.artikel.id == 6) {
									postEnthalten = true;
								}
							}
							if(postEnthalten == false) {
							Artikel artikel = ArtikelManager.selektiereArtikel(6);
							Warenkorbelement warenkorbelement = new Warenkorbelement(-1, 1, artikel);
							WarenkorbManager.fügeWarenkorbelementEin(warenkorbelement, userid);}
							boolean perPost = true;
							session.setAttribute("perPost", perPost);
							request.getRequestDispatcher("/Warenkorbverwaltung?aktion=k_anzeigen").include(request, response);
						} else {
							if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("m_versand")) {	
								int userid = Integer.parseInt(session.getAttribute("userid").toString());
								int warenkorbid = WarenkorbManager.selektiereWarenkorbID(userid);
								Warenkorbelement warenkorbelement = WarenkorbManager.selektiereWarenkorbelementMitArtikelID(6, warenkorbid);
								if(warenkorbelement != null) {
								WarenkorbManager.loescheWarenkorbelement(warenkorbelement.id);}
								boolean perPost = false;
								session.setAttribute("perPost", perPost);
								request.getRequestDispatcher("/Warenkorbverwaltung?aktion=k_anzeigen").include(request, response);
								
							} else {
								if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("hinzufuegen")) {
									response = passeCacheAn(response);
									int userid = Integer.parseInt(session.getAttribute("userid").toString());
									int artikelid = Integer.parseInt(request.getParameter("artikelid"));
									int menge = Integer.parseInt(request.getParameter("menge"));
									Artikel artikel = ArtikelManager.selektiereArtikel(artikelid);
									Warenkorbelement warenkorbelement = new Warenkorbelement(-1, menge, artikel);
									WarenkorbManager.fügeWarenkorbelementEin(warenkorbelement, userid);
									antwort = "Der Artikel '" + artikel.beschreibung + "' wurde dem Warenkorb mit der Menge " + menge + " hinzugefügt.";
									session.setAttribute("antwort", antwort);
									if(artikel.festivalID == 0) {
									request.getRequestDispatcher("/Produktverwaltung?aktion=a_anzeigen&artikelid=" + artikelid).include(request, response); }
									else {
										int festivalid = Integer.parseInt(request.getParameter("festivalid"));
										float maxpreis = Float.parseFloat(request.getParameter("maxpreis"));
									request.getRequestDispatcher("/Ticketverwaltung?aktion=f_anzeigen&festivalid=" + festivalid + "&maxpreis=" + maxpreis).include(request, response);	
									}
								} else { 
									if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("aktualisieren")) {
										response = passeCacheAn(response);
										int userid = Integer.parseInt(session.getAttribute("userid").toString());
										int artikelid = Integer.parseInt(request.getParameter("artikelid"));
										int menge = Integer.parseInt(request.getParameter("menge"));
										Artikel artikel = ArtikelManager.selektiereArtikel(artikelid);	
										int warenkorbid = WarenkorbManager.selektiereWarenkorbID(userid);
										Warenkorbelement warenkorbelement = WarenkorbManager.selektiereWarenkorbelementMitArtikelID(artikelid, warenkorbid);
										warenkorbelement.menge = warenkorbelement.menge + menge;
										if(warenkorbelement.menge > 10) {
											if((warenkorbelement.menge - menge) == 10) {
												antwort = "Sie können keine weitere Einheit des Artikels '" + artikel.beschreibung + "' in den Warenkorb legen, da die maximale Anzahl von 10 erreicht ist.";
											} else {
										antwort = "Sie können nur noch " + (10 - (warenkorbelement.menge - menge)) + " Einheit(en) dieses Artikels in den Warenkorb legen, da dann die maximale Anzahl von 10 erreicht ist.";
										} } 
											else {
										WarenkorbManager.aktualisiereWarenkorbelement(warenkorbelement);

										antwort = "Die Anzahl des Artikels '" + artikel.beschreibung + "' wurde in Ihrem Warenkorb um " + menge + " erhöht.";}
										session.setAttribute("antwort", antwort);
										if(artikel.festivalID == 0) {
											request.getRequestDispatcher("/Produktverwaltung?aktion=a_anzeigen&artikelid=" + artikelid).include(request, response); }
										else {
											int festivalid = Integer.parseInt(request.getParameter("festivalid"));
											float maxpreis = Float.parseFloat(request.getParameter("maxpreis"));
											
											request.getRequestDispatcher("/Ticketverwaltung?aktion=f_anzeigen&festivalid=" + festivalid + "&maxpreis=" + maxpreis).include(request, response);	
									}
									} else {
									
				int elementID = 0;
				if(request.getParameter("elementid") != null) {
						elementID = Integer.parseInt(request.getParameter("elementid"));}
				if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("aendern")) {
					int mengeNeu = Integer.parseInt(request.getParameter("menge"));
					Warenkorbelement warenkorbelement = WarenkorbManager.selektiereWarenkorbelement(elementID);
					warenkorbelement.menge = mengeNeu;
					WarenkorbManager.aktualisiereWarenkorbelement(warenkorbelement);
					
				} else {
					if ( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("loeschen")) {
						WarenkorbManager.loescheWarenkorbelement(elementID);	
					} 
				}
				request.getRequestDispatcher("/Warenkorbverwaltung?aktion=anzeigen").include(request, response);
			}}}}}}			
		} else {
			if( request.getParameter("aktion") != null && (request.getParameter("aktion")).equals("anmelden")) {
				antwort = "Sie müssen sich erst anmelden, bevor Sie Artikel in Ihren Warenkorb legen können.";
				if(session.getAttribute("aufrufer") != null) {
				String anforderer = session.getAttribute("aufrufer").toString();
				session.removeAttribute("aufrufer");
				session.setAttribute("anforderer", anforderer);}
				session.setAttribute("antwort", antwort);
				request.getRequestDispatcher("k_anmelden.jsp").include(request, response);
			} else {
			response.sendRedirect("k_anmelden.jsp");
			}
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
	
	
	/**
	 * Methode zur Überprüfung der Kundendaten an der Kasse
	 * 
	 * @param p_benutzer Benutzer, dessen Daten überprüft werden sollen
	 * @return rueckmeldung Rückmeldung, ob die Kundendaten vollständig sind
	 */
	private boolean ueberpruefeKundendaten(Benutzer p_benutzer) {
		boolean rueckmeldung = true;
		if(p_benutzer.vorname.trim().length() == 0 || p_benutzer.nachname.trim().length() == 0 || p_benutzer.strasse.trim().length() == 0 ||
		   p_benutzer.hausnummer.trim().length() == 0 || p_benutzer.ort.trim().length() == 0 || p_benutzer.iban.trim().length() == 0 ||
		   p_benutzer.plz == 0 || p_benutzer.einzugsermächtigungErteilt == false) {
			rueckmeldung = false;
			return rueckmeldung;
		} else {
		return rueckmeldung;
		}
	}
	
	/**
	 * Methode zur Anpassung der Cache-Eigenschaften
	 * 
	 * @param p_response Response, an der die Anpassung vorgenommen werden soll
	 * @return p_response Response, an der die Anpassungen vorgenommen wurden
	 */
	private HttpServletResponse passeCacheAn(HttpServletResponse p_response) {
		p_response.setHeader("Pragma", "no-cache");
		p_response.setHeader("Cache-Control", "max-age=600");
		p_response.setDateHeader("Expires", 600);
		return p_response;
	}

}
