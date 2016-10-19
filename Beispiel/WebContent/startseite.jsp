<%@page
	import="standard.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: startseite.jsp
	# JSP-Aktionen: 1) Darstellung der Startseite mit Begrüßung
					2) Darstellung der verschiedenen Produktkategorien
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();

	Boolean registriert = false;
	if (request.getParameter("registriert") != null)
		if (request.getParameter("registriert").equals("true"))
			registriert = true;
	
	Boolean geaendert = false;
	if (request.getParameter("geaendert") != null)
		if (request.getParameter("geaendert").equals("true"))
			geaendert = true;
	
	Boolean gesperrt = false;
	if (request.getParameter("gesperrt") != null)
		if (request.getParameter("gesperrt").equals("true"))
			gesperrt = true;
	
	Boolean bestellt = false;
	if (request.getParameter("bestellt") != null)
		if (request.getParameter("bestellt").equals("true"))
			bestellt = true;
	
	Boolean error = false;
	if (request.getParameter("error") != null)
		if (request.getParameter("error").equals("true"))
			error = true;
	
	String loginerror = "";
	if (request.getParameter("loginerror") != null)
		loginerror = request.getParameter("loginerror");
%>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="ISO-8859-1">
    <title>Startseite</title>
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
    	<jsp:param name="active" value="startseite"/>
    </jsp:include>

    <div class="container">
		<%if (registriert) {%>
		<div id="registriert" class="alert alert-block alert-success fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<h4 class="alert-heading">Registrierung abgeschlossen</h4>
				<p>Sie haben sich erfolgreich registriert. Sie können sich jetzt oben rechts anmelden.</p>
		</div>
		<%} %>
		
		<%if (error) {%>
		<div id="error" class="alert alert-block alert-error fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<h4 class="alert-heading">Ungültige Anfrage</h4>
				<p>Sie haben eine ungültige Anfrage an das System gestellt, eine Umleitung zur Startseite ist erfolgt.</p>
		</div>
		<%} %>
		
		<%if (loginerror.equals("passwort")) {%>
		<div id="loginerrorPasswort" class="alert alert-block alert-error fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<h4 class="alert-heading">Login fehlgeschlagen</h4>
				<p>Die Kombination aus EMail-Adresse und Passwort ist nicht korrekt.</p>
		</div>
		<%} %>
		
		<%if (loginerror.equals("email")) {%>
		<div id="loginerrorEmail" class="alert alert-block alert-error fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<h4 class="alert-heading">Login fehlgeschlagen</h4>
				<p>Diese EMail-Adresse ist nicht registriert.</p>
		</div>
		<%} %>
		
		<%if (gesperrt) {%>
		<div id="gesperrt" class="alert alert-block alert-error fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<h4 class="alert-heading">Benutzer gesperrt</h4>
				<p>Ihr Benutzer ist z. Z. gesperrt. Bitte wenden Sie sich an den Administrator.</p>
		</div>
		<%} %>
		
		<%if (bestellt) {%>
		<div id="bestellt" class="alert alert-block alert-success fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<h4 class="alert-heading">Bestellung abgeschickt</h4>
				<p>Ihre Bestellung wurde erfolgreich abgeschickt. Sie können den Status ihrer Bestellungen in der <a href="<%=PFAD_ZUM_CONTROLLER%>?seite=bestelluebersicht">Bestellübersicht</a> ansehen.</p>
		</div>
		<%} %>
		
		<%if (geaendert) {%>
		<div id="geaendert" class="alert alert-block alert-success fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<h4 class="alert-heading">Eigene Daten geändert</h4>
				<p>Ihre neuen Daten wurden erfolgreich gespeichert.</p>
		</div>
		<%} %>
		
        <!-- Willkommen -->
        <div class="hero-unit">
            <div class="row-fluid">
                <div class="span10">
                    <h1>Grillzone.de</h1>
                    <p>Wir bieten Grills, Beef und alles, was du an Zubehör benötigst. So schnell wie kein anderer. Und die Günstigsten sind wir sowieso.</p>
                    <p><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=produktsuche&suche=" class="btn btn-primary btn-large">Einkaufen &raquo;</a></p>
                </div>
                <div class="span2">
                    <img src="<%=PFAD_ZUM_WEBCONTENT%>/img/grillbaer.png" />
                </div>
            </div>
        </div>

        <!-- Kategorien -->
        <div class="row">
	        <% for (int i=1; i<=9; i++) 
	        {
	        	Kategorie kategorie = ArtikelVerwaltung.gibKategorieVonDB(i);
	        %>
            <div class="span4">
                <h2><%=kategorie.name%></h2>
                <div class="row-fluid">
                        <div class="span6">
                            <p><%=kategorie.beschreibung %></p>      
                        </div>
                        <div class="span6">
                            <img src="<%=PFAD_ZUM_WEBCONTENT%>/img/artikel/<%=kategorie.bildpfad %>" />
                        </div>
                </div>
                <p><a class="btn" href="<%=PFAD_ZUM_CONTROLLER%>?seite=produktsuche&kategorieId=<%=kategorie.kategorieID%>&sortierung=Name">Suchen &raquo;</a></p>
            </div>
            <%if (i%3==0 && i!=9) {
            %>
            </div><div class="row">
            <%}%>
            <%}%>
        </div>

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