<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>	
<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 2) {
	response.sendRedirect("k_anmelden.jsp");
	} else {
	Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Festiva - Meine Daten</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="k_header.jsp">
    	<jsp:param name="active" value="kundendaten"/>
    </jsp:include>
		<div id="main">
			<form action="/Festiva/Benutzerdaten?aktion=aendern" method="post">
			<h2>Meine persönlichen Daten</h2>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<h5>Achtung: Wenn Sie eine Bestellung durchführen möchten, müssen Sie alle Ihre Daten (außer der BIC) angeben!</h5>
				<div id="zeile">
					<div id="spaltelinks">				
						<label for="vorname">Vorname</label>
						<input type="text" id="vorname" name="vorname" title="Hier können Sie Ihren Vornamen eingeben." maxlength="30" value="<%=benutzer.vorname%>">
						<label for="nachname">Nachname</label>
						<input type="text" id="nachname" name="nachname" title="Hier können Sie Ihren Nachnamen eingeben." maxlength="40" value="<%=benutzer.nachname%>">
						<label for="email">E-Mail*</label>
						<input type="email" id="email" name="email" title="Bitte geben Sie eine gültige E-Mail Adresse ein!" maxlength="50" required="required" value="<%=benutzer.eMailAdresse%>">					
						<label for="iban">IBAN</label>
						<input type="text" id="iban" name="iban" title="Hier können Sie Ihre IBAN eingeben." minlength="22" maxlength="22" pattern="DE[0-9]{20}" value="<%=benutzer.iban%>">
						<label for="bic">BIC</label>
						<input type="text" id="bic" name="bic" title="Hier können Sie Ihre BIC eingeben." minlength="9" maxlength="11" value="<%=benutzer.bic%>">
					</div>
					<div id="spalterechts">
						<label for="strasse">Straße</label>
						<input type="text" id="strasse" name="strasse" maxlength="50" title="Hier können Sie Ihre Straße eingeben." value="<%=benutzer.strasse%>">
						<label for="hausnummer">Hausnummer</label>
						<input type="text" id="hausnummer" name="hausnummer" minlength="1" title="Hier können Sie Ihre Hausnummer eingeben." maxlength="5" value="<%=benutzer.hausnummer%>">
						
						<label for="plz">PLZ</label>
						<%if(benutzer.plz == 0) { %>
						<input type="text" id="plz" name="plz" pattern="[0-9]{5}" title="Hier können Sie Ihre Postleitzahl eingeben." value="">
						<% } else { %>
						<input type="text" id="plz" name="plz" pattern="[0-9]{5}" title="Hier können Sie Ihre Postleitzahl eingeben." value="<%=benutzer.plz%>">
						<% } %>
						<label for="ort">Ort</label>
						<input type="text" id="ort" name="ort" maxlength="30" title="Hier können Sie Ihren Wohnort eingeben." value="<%=benutzer.ort%>">
						<label for="einzugsermächtigungErteilt">Einzugsermächtigung erteilt</label>
	      				<input type="checkbox" id="einzugsermächtigungErteilt" name="einzugsermächtigungErteilt" value=
	      					   "<%=benutzer.einzugsermächtigungErteilt%>"
	      					   <% if (benutzer.einzugsermächtigungErteilt == true) {%>
	      					   checked=<%="checked"%>title="Sie haben uns die Einzugsermächtigung erteilt."<%} else {%><%=""%>title="Sie haben uns die Einzugsermächtigung noch nicht erteilt."<%} %> >
						<button type="submit">Änderungen speichern</button>
					</div>
				</div>
			</form>
			<% if (request.getSession(false).getAttribute("anforderer_k") != null) {%>
			<button type="submit" onClick="window.location.href='<%=request.getSession(false).getAttribute("anforderer_k")%>'">Zurück zur Kasse</button>
			<% request.getSession(false).removeAttribute("anforderer_k");} %>
			
			<form action="/Festiva/Benutzerdaten?aktion=p_aendern" method="POST">
				<div id="zeile">
				<h2>Mein Passwort</h2>
				<div id="spaltelinks">
					<label for="passwortalt">Altes Passwort*</label>
					<input type="password" name="passwortalt" id="passwortalt" title="Bitte geben Sie Ihr altes Passwort ein!" maxlength="40" required="required">
					<label for="passwortneu">Neues Passwort*</label>
					<input type="password" name="passwortneu" id="passwortneu" maxlength="40" title="Bitte beachten Sie bei der Wahl Ihres Passworts den rechtsstehenden Hinweis!" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
					<label for="passwortbestätigung">Neues Passwort bestätigen*</label>
					<input type="password" name="passwortbestätigung" id="passwortbestätigung" maxlength="40" title="Bitte beachten Sie bei der Wahl Ihres Passworts den rechtsstehenden Hinweis!" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
					<button type="submit">Passwort ändern</button>	
				</div>
				<div id="spalterechts">
					<p id="text"><b>Hinweis:</b> Ihr Passwort muss aus mindestens einem Klein- und Großbuchstaben sowie einer Zahl und einem Sonderzeichen bestehen. Die Mindestlänge des Passworts beträgt 8 Zeichen.</p>
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p id="antwort"><b><%= request.getSession().getAttribute("antwort") %></b></p>
					<% } request.getSession().removeAttribute("antwort"); 
					     request.getSession().removeAttribute("benutzer");%>
				</div>	
				<button type="submit" onclick="del(<%=benutzer.id%>)" <% if (benutzer.istGelöscht == true) { %> disabled="disabled" <% } %>>Mein Benutzerkonto löschen</button>
				</div>
			</form>
		<div id="leer"></div>
		</div>
		<footer></footer>
</div>	
</body>
<script type="text/javascript">

function del(id){
	   if(confirm("Achtung! Ihr Konto wird dauerhaft gelöscht. Möchten Sie wirklich fortfahren?") == true) {
		   document.location.href='/Festiva/Benutzerdaten?aktion=loeschen';
	      } else {
	    	 document.location.href='/Festiva/Benutzerdaten?aktion=anzeigen';
	      }
}
</script>
</html>
<% }  %>