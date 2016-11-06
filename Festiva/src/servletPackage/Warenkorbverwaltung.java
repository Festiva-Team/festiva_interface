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
			
			if ((request.getParameter("aktion")).equals("anzeigen")) {
			int userid = Integer.parseInt(session.getAttribute("userid").toString());
			Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, false);
			List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
			session.setAttribute("listFestivals", listFestivals);
			session.setAttribute("warenkorb", warenkorb);
			request.getRequestDispatcher("k_warenkorb.jsp").include(request, response);
			} else { 
					if ((request.getParameter("aktion")).equals("k_anzeigen")) {
						int userid = Integer.parseInt(session.getAttribute("userid").toString());
						boolean perPost = false;
						boolean postEnthalten = false;
						Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, true);
						for(Warenkorbelement warenkorbelement : warenkorb.listElemente) {
							if (warenkorbelement.artikel.festivalID == 0) {
								perPost = true;
							}
							if(warenkorbelement.artikel.id == 6) {
								postEnthalten = true;
							}
						}
						if(perPost == true && postEnthalten == false) {
							Artikel artikel = ArtikelAdministration.selektiereArtikel(6);
							Warenkorbelement warenkorbelement = new Warenkorbelement(-1, 1, artikel);
							WarenkorbAdministration.fügeWarenkorbelementEin(warenkorbelement, userid);
							warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, true);
						}
						
						Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(userid);
						List<Festival> listFestivals = FestivalAdministration.selektiereAlleFestivals();
						boolean kundendatenVollstaendig = ueberpruefeKundendaten(benutzer);
						session.setAttribute("kundendatenVollstaendig", kundendatenVollstaendig);
						session.setAttribute("listFestivals", listFestivals);
						session.setAttribute("warenkorb", warenkorb);
						session.setAttribute("benutzer", benutzer);
						request.getRequestDispatcher("k_kasse.jsp").include(request, response);
					} else {
						if ((request.getParameter("aktion")).equals("p_versand")) {
							int userid = Integer.parseInt(session.getAttribute("userid").toString());
							boolean postEnthalten = false;
							Warenkorb warenkorb = WarenkorbAdministration.selektiereWarenkorbVonKunden(userid, true);
							for(Warenkorbelement warenkorbelement : warenkorb.listElemente) {
								if(warenkorbelement.artikel.id == 6) {
									postEnthalten = true;
								}
							}
							if(postEnthalten == false) {
							Artikel artikel = ArtikelAdministration.selektiereArtikel(6);
							Warenkorbelement warenkorbelement = new Warenkorbelement(-1, 1, artikel);
							WarenkorbAdministration.fügeWarenkorbelementEin(warenkorbelement, userid);}
							boolean perPost = true;
							session.setAttribute("perPost", perPost);
							request.getRequestDispatcher("/Warenkorbverwaltung?aktion=k_anzeigen").include(request, response);
						} else {
							if ((request.getParameter("aktion")).equals("m_versand")) {	
								Warenkorbelement warenkorbelement = WarenkorbAdministration.selektiereWarenkorbelementMitArtikelID(6);
								if(warenkorbelement != null) {
								WarenkorbAdministration.loescheWarenkorbelement(warenkorbelement.id);}
								boolean perPost = false;
								session.setAttribute("perPost", perPost);
								request.getRequestDispatcher("/Warenkorbverwaltung?aktion=k_anzeigen").include(request, response);
								
							} else {
								if((request.getParameter("aktion")).equals("hinzufuegen")) {
									int userid = Integer.parseInt(session.getAttribute("userid").toString());
									int artikelid = Integer.parseInt(request.getParameter("artikelid"));
									int menge = Integer.parseInt(request.getParameter("menge"));
									Artikel artikel = ArtikelAdministration.selektiereArtikel(artikelid);
									Warenkorbelement warenkorbelement = new Warenkorbelement(-1, menge, artikel);
									WarenkorbAdministration.fügeWarenkorbelementEin(warenkorbelement, userid);
									antwort = "Der Artikel '" + artikel.beschreibung + "' wurde dem Warenkorb mit der Menge " + menge + " hinzugefügt.";
									session.setAttribute("antwort", antwort);
									if(artikel.festivalID == 0) {
									request.getRequestDispatcher("/MerchandiseShop?aktion=m_anzeigen").include(request, response); }
									else {
									request.getRequestDispatcher("k_shop.jsp").include(request, response);	
									}
								} else { 
									if((request.getParameter("aktion")).equals("aktualisieren")) {
										int artikelid = Integer.parseInt(request.getParameter("artikelid"));
										int menge = Integer.parseInt(request.getParameter("menge"));
										Artikel artikel = ArtikelAdministration.selektiereArtikel(artikelid);	
										Warenkorbelement warenkorbelement = WarenkorbAdministration.selektiereWarenkorbelementMitArtikelID(artikelid);
										warenkorbelement.menge = warenkorbelement.menge + menge;
										if(warenkorbelement.menge > 10) {
											if((warenkorbelement.menge - menge) == 10) {
												antwort = "Sie können keine weitere Einheit des Artikels '" + artikel.beschreibung + "' in den Warenkorb legen, da die maximale Anzahl von 10 erreicht ist.";
											} else {
										antwort = "Sie können nur noch " + (10 - (warenkorbelement.menge - menge)) + " Einheit(en) dieses Artikels in den Warenkorb legen, da dann die maximale Anzahl von 10 erreicht ist.";
										} } 
											else {
										WarenkorbAdministration.aktualisiereWarenkorbelement(warenkorbelement);

										antwort = "Die Anzahl des Artikels '" + artikel.beschreibung + "' wurde in Ihrem Warenkorb um " + menge + " erhöht.";}
										session.setAttribute("antwort", antwort);
										if(artikel.festivalID == 0) {
										request.getRequestDispatcher("/MerchandiseShop?aktion=m_anzeigen").include(request, response); }
										else {
										request.getRequestDispatcher("k_shop.jsp").include(request, response);	
										}
									} else {
									
				int elementID = Integer.parseInt(request.getParameter("elementid"));
				if ((request.getParameter("aktion")).equals("aendern")) {
					int mengeNeu = Integer.parseInt(request.getParameter("menge"));
					Warenkorbelement warenkorbelement = WarenkorbAdministration.selektiereWarenkorbelement(elementID);
					warenkorbelement.menge = mengeNeu;
					WarenkorbAdministration.aktualisiereWarenkorbelement(warenkorbelement);
					
				} else {
					if ((request.getParameter("aktion")).equals("loeschen")) {
						WarenkorbAdministration.loescheWarenkorbelement(elementID);
						
					} 
				}
				request.getRequestDispatcher("/Warenkorbverwaltung?aktion=anzeigen").include(request, response);
			}}}
						}
					}	
			}
			
		} else {
			if((request.getParameter("aktion")).equals("anmelden")) {
				antwort = "Sie müssen sich erst anmelden bevor Sie Artikel in Ihren Warenkorb legen können.";
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
	
	private boolean ueberpruefeKundendaten(Benutzer benutzer) {
		if(benutzer.vorname.trim().length() == 0 || benutzer.nachname.trim().length() == 0 || benutzer.strasse.trim().length() == 0 ||
		   benutzer.hausnummer.trim().length() == 0 || benutzer.ort.trim().length() == 0 || benutzer.iban.trim().length() == 0 ||
		   benutzer.plz == 0 || benutzer.einzugsermächtigungErteilt == false) {
			return false;
		} else {
		return true;
		}
	}

}
