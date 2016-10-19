<%@page
	import="standard.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: logout.jsp
	# JSP-Aktionen: 1) L�scht die aktuelle Session, falls vorhanden. 
					2) Weiterleitung zur Startseite.
	# Aufgerufen durch: header.jsp
	# Sicherheit: Aufruf nur mit g�ltige Session
	*/

	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	//Session l�schen
    HttpSession session = request.getSession(false);
    if (session != null) 
          session.invalidate();
       
    //Zur Startseite weiterleiten
    response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
%>

