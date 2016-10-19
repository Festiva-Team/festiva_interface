<%@page
	import="standard.*"
	import="java.text.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: speicherBestellung.jsp
	# JSP-Aktionen: 1) Erstellt aus dem aktuellen Warenkorb eine Bestellung. 
					2) Zurücksetzen des Warenkorbs
					3) Weiterleiten zur Startseite mit entsprechender Meldung.
	# Aufgerufen durch: kasse.jsp
	# Sicherheit: Aufruf nur mit gültige Session
	*/

	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();

	if (request.getSession(false) != null)
	{
		HttpSession session = request.getSession(false);
		//Anwender und seinen Warenkorb laden
		Anwender anwender = AnwenderVerwaltung.gibAnwender(Integer.parseInt(session.getAttribute("userid").toString()));
		HashMap<Integer, Integer> warenkorb = (HashMap<Integer, Integer>) session.getAttribute("warenkorb");
		
		Bestellung bestellung = Bestellungsverwaltung.erstelleBestellung(warenkorb, anwender.anwenderID);
		Bestellungsverwaltung.erstelleBestellungInDB(bestellung, anwender.anwenderID);
		
		//Warenkorb löschen & zur Startseite weiterleiten
		session.setAttribute("warenkorb", new HashMap<Integer, Integer>());
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite&bestellt=true");
	}
	else
	{
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
	}
%>