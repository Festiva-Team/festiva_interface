<%@page
	import="standard.*"
	import="java.util.*"
	import="java.text.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: bestelluebersicht.jsp
	# JSP-Aktionen: 1) Abrufen einer Liste von allen Bestellungen des Benutzers
					2) Tabellarische Darstellung der Bestellungsinformationen
	# Sicherheit: Aufruf nur mit gültige Session
	*/
	
	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	List<Bestellung> bestellungsliste = new ArrayList<Bestellung>();
	int userid = 0;
	if (request.getSession(false) != null)
	{
		HttpSession session = request.getSession(false);
		userid = Integer.parseInt(session.getAttribute("userid").toString());
		bestellungsliste = Bestellungsverwaltung.gibBestellungNachUserVonDB(userid);
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
    <title>Bestellübersicht</title>
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

    <!-- IE8 Support für HTML5 -->
    <!--[if lt IE 9]>
      <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Favicon -->
    <link rel="shortcut icon" href="<%=PFAD_ZUM_WEBCONTENT%>/ico/favicon.ico">
</head>

<body>

    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="bestelluebersicht"/>
    </jsp:include>
    
    <div class="container">
    	<h1>Bestellübersicht</h1>
    	  
    	<%if (bestellungsliste.size() != 0) {%>  	
			<table class="table">
				<tr>
					<th>Bestelldatum</th>
					<th>Artikelname</th>
					<th>Anzahl * Einzelpreis</th>
					<th>Gesamtsumme</th>
					<th>Status</th>
				</tr>
				<% for(Bestellung b : bestellungsliste) 
				{
					String status = Bestellungsverwaltung.gibBestellStatus(b.bestelldatum);
					double gesamtsumme = 0;
					String datum = ((new SimpleDateFormat("dd.MM.yyyy").format(b.bestelldatum)));
				%>
				<tr>
					<td><%=datum %></td>
					<td><% for (Bestellposition p: b.lstBestellposition) {gesamtsumme += (p.menge*p.artikel.einzelpreis);%><%=p.artikel.name%><br><%}%></td>
					<td><% for (Bestellposition p: b.lstBestellposition) {%><%=p.menge %> * <%=String.format("%.2f",p.artikel.einzelpreis)%> &euro;<br><%}%></td>
					<td><%=String.format("%.2f",gesamtsumme)%> &euro;</td>
					<td><%=status %></td>
				</tr>
				<%} %>
			</table>
		<%} else {%>
			<div id="keineBestellungen" class="alert alert-block alert-info fade in">
					<h4 class="alert-heading">Keine Bestellungen gefunden</h4>
					<p>Sie haben bisher keine Bestellungen getätigt.</p>
			</div>
		<%} %>
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