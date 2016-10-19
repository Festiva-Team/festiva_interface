<%@page
	import="standard.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: benutzerverwaltung.jsp
	# JSP-Aktionen: 1) Abrufen einer Liste von allen Benutzern
					2) Tabellarische Darstellung der Benutzerdaten (Id, EMail, Name, Vorname, Gruppe, Gesperrt)
					3) M�glichkeit zur Administration (sperren, entsperren, bef�rdern, degradieren) eines Benutzers bieten
	# Sicherheit: Aufruf nur mit g�ltige Session und nur als Administrator
	*/
	
	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	List<Anwender> benutzerliste = new ArrayList<Anwender>();
	int userid = 0;
	if (request.getSession(false) != null)
	{
		HttpSession session = request.getSession(false);
		userid = Integer.parseInt(session.getAttribute("userid").toString());
		if (AnwenderVerwaltung.gibAnwender(userid).gruppeID == 1)
			response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");	
		else
		{
			benutzerliste = AnwenderVerwaltung.gibAnwender();
		}
	}
	else
	{
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
	}
%>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="ISO-8859-1">
    <title>Benutzerverwaltung</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Webshop">
    <meta name="author" content="Linus Hoppe">

    <!-- CSS -->
    <link href="<%=PFAD_ZUM_WEBCONTENT%>/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
    </style>
    <link href="<%=PFAD_ZUM_WEBCONTENT%>/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- IE8 Support f�r HTML5 -->
    <!--[if lt IE 9]>
      <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Favicon -->
    <link rel="shortcut icon" href="<%=PFAD_ZUM_WEBCONTENT%>/ico/favicon.ico">
</head>

<body>

    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="benutzerverwaltung"/>
    </jsp:include>
    
    <div class="container">
    	<h1>Benutzerverwaltung</h1>
    	
    	<div id="registriert" class="alert alert-block alert-info fade in">
				<h4 class="alert-heading">Hinweis</h4>
				<p>Sie k�nnen sich nicht selbst Administrator-Rechte enziehen oder sperren.</p>
		</div>
    	
		<table class="table">
			<tr>
				<th>Benutzer-ID</th>
				<th>EMail-Adresse</th>
				<th>Vorname</th>
				<th>Nachname</th>
				<th>Gruppe</th>
				<th>Gesperrt</th>
			</tr>
			<% for(Anwender anwender : benutzerliste) 
			{
				String gruppe = (anwender.gruppeID == 1) ? "Kunde" : "Administrator";
				String gesperrtAktion = (anwender.istGesperrt) ? "entsperren" : "sperren";
				String gruppenAktion = (anwender.gruppeID == 1) ? "zuAdmin" : "zuKunde";
			%>
			<tr>
				<td><%=anwender.anwenderID%></td>
				<td><%=anwender.eMail%></td>
				<td><%=anwender.vorname %></td>
				<td><%=anwender.nachname %></td>
				<td><%if (userid != anwender.anwenderID) {%><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=administriereAnwender&anwenderID=<%=anwender.anwenderID%>&aktion=<%=gruppenAktion%>"><%=gruppe%></a><%} else {%><%=gruppe%><%}%></td>
				<td><%if (userid != anwender.anwenderID) {%><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=administriereAnwender&anwenderID=<%=anwender.anwenderID%>&aktion=<%=gesperrtAktion%>"><%=anwender.istGesperrt%></a><%} else {%><%=anwender.istGesperrt%><%}%></td>
			</tr>
			<%} %>
		</table>
    </div>

    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/jquery.js"></script> 
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-transition.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-alert.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-modal.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-dropdown.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-scrollspy.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-tab.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-tooltip.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-popover.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-button.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-collapse.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-carousel.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/bootstrap-typeahead.js"></script>

</body>
</html>