<%@page
	import="standard.*"
	import="java.util.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: produktsuche.jsp
	# JSP-Aktionen: 1) Darstellung von Suchergebnissen (Artikeln)
					2) Möglichkeit zum Starten einer neuen Suche (Suchfeld)
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	boolean sortierung = false;
	if (request.getParameter("sortierung") != null)
	{
		if (request.getParameter("sortierung").equals("Preis"))
		sortierung = true;
	}
	
	String suchbegriff = "";
	int kategorieId = -1;
	List<Artikel> artikelliste = null;
	if (request.getParameter("suche") != null)
	{
		suchbegriff = request.getParameter("suche");
		artikelliste = ArtikelVerwaltung.sucheArtikelInDB(suchbegriff, sortierung);
	}
	if (request.getParameter("kategorieId") != null)
	{
		kategorieId = Integer.parseInt(request.getParameter("kategorieId"));
		artikelliste = ArtikelVerwaltung.gibArtikelNachKategorieVonDB(kategorieId, sortierung);
	}
%>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="ISO-8859-15">
    <title>Produktsuche</title>
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
    	<jsp:param name="active" value="produktsuche"/>
    </jsp:include>

    <div class="container">
    	<h1>Produktsuche</h1>
        <div class="row">
             <form class="form-horizontal" action="<%=PFAD_ZUM_CONTROLLER%>" method="GET">
            	<div class="span8">
	                <input type="hidden" name="seite" value="produktsuche">
	                <input class="input-xlarge" type="text" name="suche" id="inputSearch" placeholder="Suchbegriff" value="<%=suchbegriff%>">
	                <button type="submit" class="btn btn-primary">Los!</button>
	            </div>
	            <div class="span4">
	            	<label for="selectSortierung">Sortieren nach:
	            	<select name="sortierung">
						<option <%if (!sortierung) {%>selected="selected"<%}%>>Name</option>
						<option <%if (sortierung) {%>selected="selected"<%}%>>Preis</option>
					</select>
					</label>
	            </div>
	         </form>
        </div>

        <hr />
        <div>
	        <% if(artikelliste != null) {%>
	        <div class="row">
	        	<%	for (int i=0; i<artikelliste.size(); i++) {
	        		Artikel artikel = artikelliste.get(i);
	        	%>
					<div class="span4">
		                <div class="row-fluid">
		                    <div class="span12">
		                        <h2><%=artikel.name%></h2>
		                    </div>
		                </div>
		                <div class="row-fluid">
		                    <div class="span6">
		                        <p><%=artikel.beschreibung%><br></p>
		                        <p><b>Preis:</b> <%=String.format("%.2f",artikel.einzelpreis)%> &euro;</p>
		                        <p><a class="btn" href="<%=PFAD_ZUM_CONTROLLER%>?seite=artikeldetails&artikelid=<%=artikel.artikelID%>">Details &raquo;</a></p>          
		                    </div>
		                    <div class="span6">
		                        <img src="<%=PFAD_ZUM_WEBCONTENT%>/img/artikel/<%=artikel.bildpfad%>" />
		                    </div>
		                </div>
			        </div>  
			<%if (i%3==2) {%>
	        	</div>
	        	<div class="row">
	        <%}%>
	        <%}%></div>
	        
	         <% if(artikelliste.size() == 0) {%>
	         	<div id="keineErgebnisse" class="alert alert-block alert-error fade in">
					<h4 class="alert-heading">Keine Artikel gefunden</h4>
					<p>Zu Ihrem Suchbegriff wurden keine Artikel gefunden. Bitte starten Sie eine neue Suche.</p>
				</div>
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
