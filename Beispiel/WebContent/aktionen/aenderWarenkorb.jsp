<%@page
	import="standard.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: aenderWarenkorb.jsp
	# JSP-Aktionen: 1) Prüfung des Parameters "aktion".
					2) Hinzufügen eines Artikel zum Warenkorb (falls "aktion" == "hinzufuegen").
					3) Löschen eines Artikel aus den Warenkorb (falls "aktion" == "loeschen").
	# Aufgerufen durch: artikeldetails.jsp oder warenkorb.jsp
	# Sicherheit: Aufruf nur mit gültige Session
	*/
	
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	if (request.getParameter("artikelid") != null && request.getSession(false) != null)
	{
		Integer artikelid = Integer.parseInt(request.getParameter("artikelid"));
		HttpSession session = request.getSession(false);
		HashMap<Integer, Integer> warenkorb = (HashMap<Integer, Integer>) session.getAttribute("warenkorb");
		if (request.getParameter("aktion").equals("hinzufuegen"))
		{
			//Artikel in Warenkorb legen
			if (!warenkorb.containsKey(artikelid))
			{
				//Artikel liegt noch nicht im Warenkorb
				Integer anzahl = Integer.parseInt(request.getParameter("anzahl"));
				warenkorb.put(artikelid, anzahl);
				session.setAttribute("warenkorb", warenkorb);
				response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=artikeldetails&artikelid="+artikelid+"&gespeichert=true");
			}
			else
			{
				//Artikel ist schon im Warenkorb vorhanden
				response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=artikeldetails&artikelid="+artikelid+"&vorhanden=true");
			}
		}
		else if (request.getParameter("aktion").equals("loeschen"))
		{
			//Artikel aus Warenkorb entfernen
			if (warenkorb.containsKey(artikelid))
				warenkorb.remove(artikelid);
			response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=warenkorb&geloescht=true");
		}
	}
	else
	{
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
	}
%>