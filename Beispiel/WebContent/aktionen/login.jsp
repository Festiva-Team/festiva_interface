<%@page
	import="standard.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: login.jsp
	# JSP-Aktionen: 1) Nimmt eMail und passwortHash entgegen und prüft auf Gültigkeit.
					2) Falls gültig: Session-Erstellung und Weiterleitung zur Startseite.
					3) Falls ungültig: Weiterleitung zur Startseite mit entsprechender Fehlermeldung.
	# Aufgerufen durch: header.jsp
	*/

	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	//Session erstellen	
	if (request.getParameter("email") != null && request.getParameter("passwortHash") != null)
	{
		String email = request.getParameter("email");
		String passwortHash = request.getParameter("passwortHash");
		
		Anwender anwender = AnwenderVerwaltung.gibAnwender(email);
		if (anwender != null)
		{
			//gültige Mail-Adresse
			if (email.equals(anwender.eMail) && passwortHash.equals(anwender.passwortHash))
			{
				//gültiges Passwort
				if (!anwender.istGesperrt)
				{
					//Benutzer nicht gesperrt
					HttpSession session = request.getSession(true);
					if (session.isNew()) 
					{
						session.setAttribute("userid", anwender.anwenderID);
						session.setAttribute("warenkorb", new HashMap<Integer, Integer>());
						session.setMaxInactiveInterval(3600);
					}
					//Weiterleitung, je nach Gruppe
					if (anwender.gruppeID == 1)
						response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
					else
						response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=benutzerverwaltung");
				}
				else
				{
					//Benutzer gesperrt
					response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite&gesperrt=true");
				}
			}
			else
			{
				//ungültiges Passwort
				response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite&loginerror=passwort");
			}
		}
		else
		{
			//ungültige Mail-Adresse
			response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite&loginerror=email");
		}
	} 
	else
	{
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
	}
%>

