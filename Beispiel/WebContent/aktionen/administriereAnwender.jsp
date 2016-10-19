<%@page
	import="standard.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: administriereAnwender.jsp
	# JSP-Aktionen: 1) Führt die Aktionen der Benutzerverwaltung (sperren, entsperren, befördern und degradieren) durch
	# Aufgerufen durch: benutzerverwaltung.jsp
	# Sicherheit: Aufruf nur mit gültige Session und nur als Administrator
	*/
	
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();

	HttpSession session = request.getSession(false);
	int adminID = Integer.parseInt(session.getAttribute("userid").toString());

	String aktion = "";
	if (request.getParameter("aktion") != null)
		aktion = request.getParameter("aktion");
	
	int anwenderID = 0;
	if (request.getParameter("anwenderID") != null)
		anwenderID = Integer.parseInt(request.getParameter("anwenderID"));
	
	if (aktion.equals("") || anwenderID == 0)
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=benutzerverwaltung");
	else
	{
		if (aktion.equals("sperren"))
		{
	AnwenderVerwaltung.aktualisiereSperrungInDB(adminID, anwenderID, true);
		}
		if (aktion.equals("entsperren"))
		{
	AnwenderVerwaltung.aktualisiereSperrungInDB(adminID, anwenderID, false);
		}
		if (aktion.equals("zuAdmin"))
		{
	AnwenderVerwaltung.aktualisiereGruppeInDB(adminID, anwenderID, 2);
		}
		if (aktion.equals("zuKunde"))
		{
	AnwenderVerwaltung.aktualisiereGruppeInDB(adminID, anwenderID, 1);
		}
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=benutzerverwaltung");
	}
%>