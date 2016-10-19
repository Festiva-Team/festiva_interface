<%@page
	import="standard.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: registrierung.jsp
	# JSP-Aktionen: 1) Erzeugung von Eingabefeldern zur Registrierung von neuen Nutzern
					2) JavaScript-Validierung der Eingabedaten
					3) Weitergabe der Daten an "speicherAnwender.jsp"
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	int MIN_PASSWORT_LAENGE = Konfiguration.gibMinPasswortLaenge();
	
	Boolean emailerror = false;
	if (request.getParameter("emailerror") != null)
		if (request.getParameter("emailerror").equals("true"))
			emailerror = true;
%>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="ISO-8859-1">
    <title>Registrierung</title>
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
		function check() 
		{
			var allesok = document.registrierung.inputAgbCheck.checked;
			
			//Persönliche Daten prüfen
			if ($('#inputVorname').val().length == 0 || $('#inputNachname').val().length == 0 || $('#inputEMail').val().length == 0 
				|| $('#inputEMail').val().indexOf("@") == -1 || $('#inputEMail').val().indexOf(".") == -1)
				allesok = false;
			
			//Adresse prüfen
			if ($('#inputStrasse').val().length == 0 || $('#inputHausnummer').val().length == 0 
					|| $('#inputPostleitzahl').val().length != 5 || !$.isNumeric($('#inputPostleitzahl').val()) 
					|| $('#inputOrt').val().length == 0)
				allesok = false;
			
			//Bezahlinfos prüfen
			if ($('#inputKartenGueltigkeit').val().length == 0 || $('#inputKartennummer').val().length == 0 
					|| !$.isNumeric($('#inputKartennummer').val()) || !Date.isValid($('#inputKartenGueltigkeit').val(),"dd.MM.yyyy"))
				allesok = false;
			
			//Passwörter prüfen
			var pass = $('#inputPasswort').val();
			var check = $('#inputPasswortCheck').val();
			if (pass == check && pass.length >= <%=MIN_PASSWORT_LAENGE%>)
					$('#passwortFehler').hide();
			else
				{
					allesok = false;
					$('#passwortFehler').show();
				}
			
			//Button ein-/ausblenden
			if (allesok)
				$('#eingabeFehler').hide();
			else
				$('#eingabeFehler').show();
			displayButton(allesok);
		}
	
		function displayButton(bool)
		{
			if (bool) 
				document.registrierung.button.style.display = "";
			else 
				document.registrierung.button.style.display = "none";
		}
			
		function encryptPasswords()
		{
			document.registrierung.inputPasswortHash.value = Sha1.hash(document.registrierung.inputPasswort.value); 
			document.registrierung.inputPasswort.value='';
		}
	// -->
	</script>
</head>

<body>

    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="registrierung"/>
    </jsp:include>
  
    <div class="container">
        <form class="form-horizontal" action="<%=PFAD_ZUM_CONTROLLER%>?seite=speicherAnwender&action=neu" method="POST" name="registrierung"
        onsubmit="encryptPasswords()">
            
            <%if (emailerror) {%>
			<div id="registriert" class="alert alert-block alert-error fade in">
					<button class="close" data-dismiss="alert" type="button">×</button>
					<h4 class="alert-heading">E-Mail-Adresse bereits vergeben</h4>
					<p>Die angegebene E-Mail-Adresse ist bereits vergeben. Bitte wählen Sie eine andere Adresse.</p>
			</div>
			<%} %>
            
            <h1>Registrierung</h1>
            <p>Um dich zu registrieren, gib bitte die erforderlichen Daten ein und bestätige sie mit einem Klick auf "Registrieren".</p>
            
            <div id="eingabeFehler" class="alert alert-block alert-error fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<p>Es wurden nicht alle erforderlichen Felder gefüllt oder es wurden ungültige Werte eingegeben.</p>
			</div>

            <h3>Persönliche Daten</h3>

            <div class="control-group">
                <label class="control-label" for="inputVorname">Vorname *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputVorname" name="inputVorname" placeholder="Vorname">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputNachname">Nachname *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputNachname" name="inputNachname" placeholder="Nachname">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputEMail">E-Mail *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputEMail" name="inputEMail" placeholder="E-Mail">
                </div>
            </div>

            <h3>Adresse</h3>
                        
            <div class="control-group">
                <label class="control-label" for="inputStrasse">Straße *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputStrasse" name="inputStrasse" placeholder="Straße">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputHausnummer">Hausnummer *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputHausnummer" name="inputHausnummer" placeholder="Hausnummer">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputPostleitzahl">Postleitzahl *</label>
                <div class="controls">
                    <input maxlength="5" onkeyup="check()" type="text" id="inputPostleitzahl" name="inputPostleitzahl" placeholder="Postleitzahl">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputOrt">Ort *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputOrt" name="inputOrt" placeholder="Ort">
                </div>
            </div>
            
            <h3>Bezahlinformationen</h3>

            <div class="control-group">
                <label class="control-label" for="inputKartentyp">Kartentyp *</label>
                <div class="controls">
                    <label class="radio inline">
                        <input type="radio" name="inputKartentyp" id="inputKartentyp" value="MasterCard" checked>MasterCard
                    </label>
                    <label class="radio inline">
                        <input type="radio" name="inputKartentyp" id="inputKartentyp" value="Visa">Visa
                    </label>
                    <label class="radio inline">
                        <input type="radio" name="inputKartentyp" id="inputKartentyp" value="AmericanExpress">American Express
                    </label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputKartennummer">Kartennummer *</label>
                <div class="controls">
                    <input  maxlength="8" onkeyup="check()" id="inputKartennummer" type="text" name="inputKartennummer" placeholder="Kartennummer">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputKartenGueltigkeit">Gültigkeit (Format dd.MM.yyyy)*</label>
                <div class="controls">
                    <input onkeyup="check()" id="inputKartenGueltigkeit" type="text" name="inputKartenGueltigkeit" placeholder="Gültigkeit">
                </div>
            </div>

            <h3>Passwort</h3>
            
            <p>Bitte wählen  ein ausreichend sicheres Passwort (Klein- und Großbuchstaben, Zahlen und Sonderzeichen). Das Passwort muss aus mindestens 5 Zeichen bestehen.</p>
			<div id="passwortFehler" class="alert alert-block alert-error fade in" style="">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<p>Fehler: Die Passwörter stimmen nicht überein oder sind zu kurz.</p>
			</div>
			
            <div class="control-group">
                <label class="control-label" for="inputPasswort">Passwort *</label>
                <div class="controls">
                    <input type="hidden" id="inputPasswortHash" name="inputPasswortHash" value="">
                    <input onkeyup="check()" id="inputPasswort" type="password" id="inputPasswort" placeholder="Passwort">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputPasswortCheck">Passwort bestätigen *</label>
                <div class="controls">
                    <input onkeyup="check()" id="inputPasswortCheck" type="password" id="inputPasswortCheck" placeholder="Passwort">
                </div>
            </div>

            <h3>Bestätigung</h3>

            <div class="control-group">
                <div class="controls">
                    <label class="checkbox">
                        <input onclick="check()" type="checkbox" id="inputAgbCheck" value="true">Ich habe die AGBs gelesen und akzeptiert.
                    </label>
                </div>
            </div>
            <div class="form-actions">
                <a href="<%=PFAD_ZUM_CONTROLLER%>?seite=startseite" role="button" class="btn">Abbrechen</a>
                <button type="submit" id="button" style="display:none" class="btn btn-primary">Registrieren</button>
            </div>
        </form>

        <%@ include file="footer.jsp" %>

    </div>

    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/jquery.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/sha1.js"></script>
    <script src="<%=PFAD_ZUM_WEBCONTENT%>/js/date.js"></script>
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
