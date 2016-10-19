<%@page
	import="standard.*"
	import="java.text.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: profil.jsp
	# JSP-Aktionen: 1) Möglichkeit zum Ändern der eigenen Adress- und Bezahlinformationen
					2) JavaScript-Validierung aller Eingabefelder
					3) Weitergabe der Daten an "speicherAnwender.jsp"
	# Sicherheit: Aufruf nur mit gültige Session
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	int MIN_PASSWORT_LAENGE = Konfiguration.gibMinPasswortLaenge();
	
	Anwender anwender = null;
	
	if (request.getSession(false) != null)
	{
		HttpSession session = request.getSession(false);
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
    <meta charset="ISO-8859-1">
    <title>Profil</title>
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
			var allesok = true;
			
			//Persönliche Daten prüfen
			if ($('#inputVorname').val().length == 0 || $('#inputNachname').val().length == 0)
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
				document.profil.button.style.display = "";
			else 
				document.profil.button.style.display = "none";
		}
			
		function encryptPasswords()
		{
			document.profil.inputPasswortHash.value = Sha1.hash(document.profil.inputPasswort.value); 
			document.profil.inputPasswort.value='';
		}
	// -->
	</script>
</head>

<body>

    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="profil"/>
    </jsp:include>
  
    <div class="container">
        <form class="form-horizontal" action="<%=PFAD_ZUM_CONTROLLER%>?seite=speicherAnwender&action=aendern" method="POST" name="profil"
        onsubmit="encryptPasswords()">
  
            <h1>Profil</h1>
            <p>Bitte gib deine neuen Daten ein und bestätige sie mit einem Klick auf "Speichern".</p>
            
            <div id="eingabeFehler" class="alert alert-block alert-error fade in">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<p>Es wurden nicht alle erforderlichen Felder gefüllt oder es wurden ungültige Werte eingegeben.</p>
			</div>

            <h3>Persönliche Daten</h3>

            <div class="control-group">
                <label class="control-label" for="inputVorname">Vorname *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputVorname" name="inputVorname" placeholder="Vorname" value="<%=anwender.vorname%>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputNachname">Nachname *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputNachname" name="inputNachname" placeholder="Nachname" value="<%=anwender.nachname%>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputEMail">E-Mail *</label>
                <div class="controls">
                	<input readonly class="uneditable-input" type="text" id="inputEmail" name="inputEMail" value="<%=anwender.eMail%>">
                </div>
            </div>

            <h3>Adresse</h3>
                        
            <div class="control-group">
                <label class="control-label" for="inputStrasse">Straße *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputStrasse" name="inputStrasse" placeholder="Straße" value="<%=anwender.strasse%>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputHausnummer">Hausnummer *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputHausnummer" name="inputHausnummer" placeholder="Hausnummer" value="<%=anwender.hausnummer%>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputPostleitzahl">Postleitzahl *</label>
                <div class="controls">
                    <input maxlength="5" onkeyup="check()" type="text" id="inputPostleitzahl" name="inputPostleitzahl" placeholder="Postleitzahl" value="<%=anwender.postleitzahl%>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputOrt">Ort *</label>
                <div class="controls">
                    <input onkeyup="check()" type="text" id="inputOrt" name="inputOrt" placeholder="Ort" value="<%=anwender.ort%>">
                </div>
            </div>
            
            <h3>Bezahlinformationen</h3>

            <div class="control-group">
                <label class="control-label" for="inputKartentyp">Kartentyp *</label>
                <div class="controls">
                    <label class="radio inline">
                        <input type="radio" name="inputKartentyp" id="inputKartentyp" value="MasterCard" <%if (anwender.kreditFirma.equals("MasterCard")) {%>checked<%} %>>MasterCard
                    </label>
                    <label class="radio inline">
                        <input type="radio" name="inputKartentyp" id="inputKartentyp" value="Visa" <%if (anwender.kreditFirma.equals("Visa")) {%>checked<%} %>>Visa
                    </label>
                    <label class="radio inline">
                        <input type="radio" name="inputKartentyp" id="inputKartentyp" value="AmericanExpress" <%if (anwender.kreditFirma.equals("AmericanExpress")) {%>checked<%} %>>American Express
                    </label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputKartennummer">Kartennummer *</label>
                <div class="controls">
                    <input  maxlength="8" onkeyup="check()" id="inputKartennummer" type="text" name="inputKartennummer" placeholder="Kartennummer" value="<%=anwender.kartennummer%>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputKartenGueltigkeit">Gültigkeit (Format dd.MM.yyyy)*</label>
                <div class="controls">
                    <input onkeyup="check()" id="inputKartenGueltigkeit" type="text" name="inputKartenGueltigkeit" placeholder="Gültigkeit" value="<%String d = ((new SimpleDateFormat("dd.MM.yyyy").format(anwender.kartenGueltigkeit)));%><%=d%>">
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
            <div class="form-actions">
                <a href="<%=PFAD_ZUM_CONTROLLER%>?seite=startseite" role="button" class="btn">Abbrechen</a>
                <button type="submit" id="button" style="display:none" class="btn btn-primary">Daten speichern</button>
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
