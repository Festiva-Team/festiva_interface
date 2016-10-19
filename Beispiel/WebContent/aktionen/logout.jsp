<%@page
	import="standard.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: logout.jsp
	# JSP-Aktionen: 1) Löscht die aktuelle Session, falls vorhanden. 
					2) Weiterleitung zur Startseite.
	# Aufgerufen durch: header.jsp
	# Sicherheit: Aufruf nur mit gültige Session
	*/

	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	//Session löschen
    HttpSession session = request.getSession(false);
    if (session != null) 
          session.invalidate();
       
    //Zur Startseite weiterleiten
    response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
%>

