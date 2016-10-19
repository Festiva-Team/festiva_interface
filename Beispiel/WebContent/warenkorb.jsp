<%@page
	import="standard.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: warenkorb.jsp
	# JSP-Aktionen: 1) Darstellung aller Artikel im Warenkorb
					2) Darstellung der Gesamtsumme
					3) Button zur Kasse anzeigen
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	Boolean geloescht = false;
	if (request.getParameter("geloescht") != null)
		if (request.getParameter("geloescht").equals("true"))
			geloescht = true;
	
	double gesamtsumme = 0;
	HashMap<Integer, Integer> warenkorb = new HashMap<Integer, Integer>();
	if (request.getSession(false) != null)
	{
		HttpSession session = request.getSession(false);
		//Warenkorb aus Session auslesen, jeweils Artikel-Objekt holen und zur Liste hinzufügen
		warenkorb = (HashMap<Integer, Integer>) session.getAttribute("warenkorb");
	}
	else
	{
		response.sendRedirect(PFAD_ZUM_CONTROLLER+"?seite=startseite");
	}
%>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="ISO-8859-15">
    <title>Warenkorb</title>
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

    <!-- IE8 Support fÃ¼r HTML5 -->
    <!--[if lt IE 9]>
      <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Favicon -->
    <link rel="shortcut icon" href="<%=PFAD_ZUM_WEBCONTENT%>/ico/favicon.ico">
</head>

<body>

    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="warenkorb"/>
    </jsp:include>

    <div class="container">
    
    <%if (geloescht) {%>
		<div id="registriert" class="alert alert-block alert-success fade in">
				<button class="close" data-dismiss="alert" type="button">x</button>
				<h4 class="alert-heading">Artikel entfernt</h4>
				<p>Der Artikel wurde erfolgreich aus dem Warenkorb entfernt.</p>
		</div>
	<%} %>
    <h1>Warenkorb</h1><hr>
    	<% if(warenkorb.size() > 0) 
    		{
    		for (Integer artikelid : warenkorb.keySet()) 
    			{
    			Artikel artikel = ArtikelVerwaltung.gibArtikelVonDB(artikelid);
    			int anzahl = warenkorb.get(artikelid);
    			gesamtsumme += artikel.einzelpreis*anzahl;
	        	%>
	        	
		        <div class="row">
		            <div class="span9">
		                <div class="row-fluid">
		                    <div class="span12"><h3><%=artikel.name%></h3></div>
		                </div>
		                <div class="row-fluid">
		                    <div class="span3"><b>Beschreibung</b></div>
		                    <div class="span9"><%=artikel.beschreibung%></div>
		                </div>
		                <div class="row-fluid">
		                    <div class="span3"><b>Einzelpreis:</b></div>
		                    <div class="span9"><%=String.format("%.2f",artikel.einzelpreis)%> &euro;</div>
		                </div>
		                <div class="row-fluid">
		                    <div class="span3"><b>Anzahl:</b></div>
		                    <div class="span9"><%=anzahl%></div>
		                </div>
		                <div class="row-fluid">
		                    <div class="span3"><b>Gesamtpreis:</b></div>
		                    <div class="span9"><b><%=String.format("%.2f",artikel.einzelpreis*anzahl)%> &euro;</b></div>
		                </div>
		                <div class="row-fluid">
		                    <div class="span12">
		                    	<a href="<%=PFAD_ZUM_CONTROLLER%>?seite=aenderWarenkorb&aktion=loeschen&artikelid=<%=artikel.artikelID%>" role="button" class="btn">Aus Warenkorb entfernen</a>
		                    </div>
		                </div>
		            </div>
		            <div class="span3">
		                <img src="<%=PFAD_ZUM_WEBCONTENT%>/img/artikel/<%=artikel.bildpfad%>" />
		            </div>
		        </div>
		        <hr />
				
				<%}%>
    		
    			<div class="row">
		            <div class="span2 pull-right">
		                <b>Gesamtsumme: <%=String.format("%.2f",gesamtsumme)%> &euro;</b>
		            </div>
		        </div>
		        <div class="row">
		            <div class="span10"></div>
		            <div class="span2">
		                <a href="<%=PFAD_ZUM_CONTROLLER%>?seite=kasse" role="button" class="btn btn-primary" data-toggle="modal">Zur Kasse gehen</a>
		            </div>
		            <div class="span1"></div>
		        </div>
        
        <%} else { %>
				<div id="WarenkorbLeer" class="alert alert-block alert-error fade in">
					<h4 class="alert-heading">Keine Artikel im Warenkorb</h4>
					<p>In Ihrem Warenkorb befinden sich keine Elemente!</p>
				</div>
		<%} %>
		
        <%@ include file="footer.jsp" %>

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