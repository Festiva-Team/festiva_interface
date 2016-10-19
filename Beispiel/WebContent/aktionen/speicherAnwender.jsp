<%@page
	import="standard.*"
	import="java.text.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: speicherAnwender.jsp
	# JSP-Aktionen: 1) Speichert einen Anwender (neu bei Registrierung oder bestehend bei Profiländerung).
					2) Weiterleitung zur Startseite mit einer entsprechenden Meldung.
	# Aufgerufen durch: registrierung.jsp oder profil.jsp
	*/

	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();

	String action = request.getParameter("action"); //neu oder ändern

	//Auslesen der Parameter, ggf. Konvertierung (Validierung ist clientseitig geschehen)
	String vorname = request.getParameter("inputVorname");
	String nachname = request.getParameter("inputNachname");
	String eMail = request.getParameter("inputEMail");
	String strasse = request.getParameter("inputStrasse");
	String hausnummer = request.getParameter("inputHausnummer");
	int postleitzahl = Integer.parseInt(request.getParameter("inputPostleitzahl"));
	String ort = request.getParameter("inputOrt");	
	int kartennummer = Integer.parseInt(request.getParameter("inputKartennummer"));
	Date kartenGueltigkeit = new SimpleDateFormat("dd.MM.yyyy").parse(request.getParameter("inputKartenGueltigkeit"));
	String kreditFirma = request.getParameter("inputKartentyp");
	String passwortHash = request.getParameter("inputPasswortHash");	
	
	if (action.equals("neu"))
	{
		//Prüfung, ob email bereits vergeben
		Anwender checkAnwender = AnwenderVerwaltung.gibAnwender(eMail);
		Boolean emailMoeglich = false;
		if (checkAnwender == null)
			emailMoeglich = true;
		
		if (emailMoeglich)
		{
			//Objekt erzeugen und in DB speichern
			Anwender anwender = new Anwender(-1, 1, vorname, nachname, eMail, strasse, hausnummer, postleitzahl, ort, kartennummer, kartenGueltigkeit, kreditFirma, passwortHash, false);
			AnwenderVerwaltung.erstelleAnwenderInDB(-1, anwender);
			response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite&registriert=true");
		}
		else
		{
			//E-Mail bereits vergeben ==> Weiterleiten des Nutzers zur Registrierungsseite mit Hinweis
			response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=registrierung&emailerror=true");
		}
	}
	else if (action.equals("aendern"))
	{
		//Anwender ändern
		HttpSession session = request.getSession(false);
		int userid = Integer.parseInt(session.getAttribute("userid").toString());
		Anwender anwender = new Anwender(userid, -1, vorname, nachname, eMail, strasse, hausnummer, postleitzahl, ort, kartennummer, kartenGueltigkeit, kreditFirma, passwortHash, false);
		AnwenderVerwaltung.aktualisiereAnwenderInDB(userid, anwender);
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite&geaendert=true");
	}
%>