<%@page
	import="standard.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: artikeldetails.jsp
	# JSP-Aktionen: 1) Abrufen des gewünschten Artikels aus der DB (anhand des Parameters "artikelid").
					2) Darstellung der Details.
					3) Möglichkeit (Button) zum Hinzufügen des Artikels zum Warenkorb
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	int maxAnzahl = Konfiguration.gibMaxAnzahlProArtikel();
	Artikel artikel = null;
	if (request.getParameter("artikelid") != null)
		{
			artikel = ArtikelVerwaltung.gibArtikelVonDB(Integer.parseInt(request.getParameter("artikelid")));
		}
	
	Boolean gespeichert = false;
	if (request.getParameter("gespeichert") != null)
		if (request.getParameter("gespeichert").equals("true"))
			gespeichert = true;
	
	Boolean vorhanden = false;
	if (request.getParameter("vorhanden") != null)
		if (request.getParameter("vorhanden").equals("true"))
			vorhanden = true;
%>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="ISO-8859-1">
    <title>Artikeldetails</title>
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
    	<jsp:param name="active" value="artikeldetails"/>
    </jsp:include>

    <div class="container">
    	<%if (gespeichert) {%>
		<div id="registriert" class="alert alert-block alert-success fade in">
				<button class="close" data-dismiss="alert" type="button">x</button>
				<h4 class="alert-heading">Artikel in Warenkorb abgelegt</h4>
				<p>Der Artikel wurde erfolgreich im <a href="<%=PFAD_ZUM_CONTROLLER%>?seite=warenkorb">Warenkorb</a> abgelegt.</p>
		</div>
		<%} %>
		<%if (vorhanden) {%>
		<div id="registriert" class="alert alert-block alert-warning fade in">
				<button class="close" data-dismiss="alert" type="button">x</button>
				<h4 class="alert-heading">Artikel ist schon vorhanden</h4>
				<p>Der Artikel liegt bereits in Ihrem <a href="<%=PFAD_ZUM_CONTROLLER%>?seite=warenkorb">Warenkorb</a> und wurde nicht hinzugefügt.</p>
		</div>
		<%} %>
		<% if(artikel == null) {%>
	        	<div id="ungueltig" class="alert alert-block alert-error fade in">
				<h4 class="alert-heading">Ungültiger Request</h4>
				<p>Sie haben einen ungültigen Request getätigt. Bitte gehen Sie zurück zur Startseite.</p>
			</div>
	    <%}%>	    
        <div class="row">
            <div class="span8">
                <div class="row-fluid">
                    <div class="span12"><h1><%=artikel.name%></h1></div>
                </div>
                <div class="row-fluid">
                    <div class="span3"><b>Beschreibung:</b></div>
                    <div class="span9"><%=artikel.beschreibung%></div>
                </div>
                <div class="row-fluid">
                    <div class="span3"><b>Preis:</b></div>
                    <div class="span9"><%=String.format("%.2f",artikel.einzelpreis)%> &euro;</div>
                </div>
            </div>
            <div class="span4">
                <img src="<%=PFAD_ZUM_WEBCONTENT%>/img/artikel/<%=artikel.bildpfad%>" />
            </div>
        </div>
        <% if (request.isRequestedSessionIdValid()) {%>
	        <div class="row">
	        <form action="<%=PFAD_ZUM_CONTROLLER%>" method="GET">
	            <div class="span7"></div>
	            <div class="span1">
	            	<input type="hidden" name="seite" value="aenderWarenkorb">
	            	<input type="hidden" name="aktion" value="hinzufuegen">
	            	<input type="hidden" name="artikelid" value="<%=artikel.artikelID%>">
	            	<select name="anzahl" style="width:50px">
	            	<%for (int i=1; i<=maxAnzahl; i++) {%>
						<option><%=i%></option>
					<%}%>
					</select>
				</div>
				<div class="span2">
					<button class="btn btn-primary">In den Warenkorb</button>
	            </div>
	            <div class="span1"></div>
	       </form>
	        </div>
		<% }%>
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