<%@page
	import="standard.*"
	import="java.util.*"
	import="java.text.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: kasse.jsp
	# JSP-Aktionen: 1) Darstellung aller Artikel im Warenkorb und der Gesamtsumme
					2) Darstellung der Benutzer-Details (Anschrift und Bezahlinformationen)
					3) Nach Sicherheitsabfrage Möglichkeit zum Abschicken der Bestellung
	# Sicherheit: Aufruf nur mit gültige Session
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	HashMap<Integer, Integer> warenkorb = new HashMap<Integer, Integer>();
	double gesamtsumme = 0;
	int position = 0;
	
	Anwender anwender = null;
	if (request.getSession(false) != null)
	{
		HttpSession session = request.getSession(false);
		warenkorb = (HashMap<Integer, Integer>) session.getAttribute("warenkorb");
		anwender = AnwenderVerwaltung.gibAnwender(Integer.parseInt(session.getAttribute("userid").toString()));
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
    <title>Kasse</title>
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
    
    <!-- JavaScript -->
    <script type="text/javascript">
	<!--
		function check(bool) 
		{
			//Button ein-/ausblenden
			if (bool)
				$('#bestellButton').show();
			else
				$('#bestellButton').hide();
		}
	// -->
	</script>
</head>

<body onload="$('#bestellButton').hide();">

    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="kasse"/>
    </jsp:include>

    <div class="container">
    
            <h1>Kasse</h1><hr>
            <div>
                <h3>Artikelliste</h3>
				<div class="row">
					<div class="span1"><b>Position</b></div>
					<div class="span2"><b>Artikel</b></div>
					<div class="span5"><b>Beschreibung</b></div>
					<div class="span1"><b>Einzelpreis</b></div>
					<div class="span1"><b>Menge</b></div>
					<div class="span1"><b>Summe</b></div>
				</div>
				<%
				for (Integer artikelid : warenkorb.keySet())	
				{
					Artikel artikel = ArtikelVerwaltung.gibArtikelVonDB(artikelid);
					int anzahl = warenkorb.get(artikelid);
					gesamtsumme += artikel.einzelpreis*anzahl;
					position++;	
				%>
				<div class="row">
					<div class="span1"># <%=position%></div>
					<div class="span2"><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=artikeldetails&artikelid=<%=artikel.artikelID%>"><%=artikel.name%></a></div>
					<div class="span5"><%=artikel.beschreibung%></div>
					<div class="span1"><%=String.format("%.2f",artikel.einzelpreis)%> &euro;</div>
					<div class="span1"><%=anzahl%></div>
					<div class="span1"><%=String.format("%.2f",artikel.einzelpreis*anzahl)%> &euro;</div>
				</div>
				<%}%>
				<div class="row">
						<div class="span8"></div>
						<div class="span2"><b>Gesamtsumme:</div>
						<div class="span1"><%=String.format("%.2f",gesamtsumme)%> &euro;</b></div>
				</div>
            </div>
            
            <div>
                <h3>Lieferadresse</h3>
                <p><b>Hinweis:</b> Die Lieferadresse können Sie im Bereich "<a href="<%=PFAD_ZUM_CONTROLLER%>?seite=profil">Mein Profil</a>" ändern.</p>
                <div class="control-group">
                    <label class="control-label">Straße</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input"><%=anwender.strasse%></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Hausnummer</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input"><%=anwender.hausnummer%></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Postleitzahl</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input"><%=anwender.postleitzahl%></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Ort</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input"><%=anwender.ort%></span>
                    </div>
                </div>
            </div>
            
            <div>
                <h3>Bezahlinformationen</h3>
                <p><b>Hinweis:</b> Die Bezahlinformationen können Sie im Bereich "<a href="<%=PFAD_ZUM_CONTROLLER%>?seite=profil">Mein Profil</a>" ändern.</p>
                <div class="control-group">
                    <label class="control-label" for="optionsRadios1">Kartentyp</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input"><%=anwender.kreditFirma %></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Kartennummer</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input"><%=anwender.kartennummer%></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Gültigkeit</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input"><% SimpleDateFormat f = new SimpleDateFormat("dd.MM.yyyy"); String d = ((f.format(anwender.kartenGueltigkeit)));%><%=d%></span>
                    </div>
                </div>
            </div>
            
            <div class="control-group">
                <div class="controls">
                    <label class="checkbox">
                        <input onclick="check(this.checked)" type="checkbox" value="false">Ich möchte diese Bestellung wirklich abschicken.
                    </label>
                </div>
            </div>
            
            <div class="form-actions">
                <a href="<%=PFAD_ZUM_CONTROLLER%>?seite=startseite" role="button" class="btn">Abbrechen</a>
                <a id="bestellButton" href="<%=PFAD_ZUM_CONTROLLER%>?seite=speicherBestellung" role="button" class="btn btn-primary">Bestellung abschicken</a>
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