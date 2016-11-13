<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_kundenAendern.jsp
	# JSP-Aktionen: (1) Anzeige der aktuellen Kundendaten
	#				(2) Möglichkeit zum Ändern der Daten oder Löschen des Kunden
	#				(3) Weitergabe der Daten an das Servlet "Kundenverwaltung.java" 
	#				(4) Anzeige der Antwort aus dem Servlet
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1 || request.getSession(false).getAttribute("benutzer") == null) {
	response.sendRedirect("k_anmelden.jsp");} 
else {
	Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
	<jsp:param name="active" value="kundenAendern"/>
</jsp:include>
	<div id="main">
	<div class="zeile">
	<h2>Kunden ändern</h2>
	<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
	<form action="/Festiva/Kundenverwaltung?aktion=datenaendern&kundenid=<%=benutzer.id%>" method="post">
		<div class="spaltelinks">
			<label for="vorname">Vorname</label>
			<input type="text" id="vorname" name="vorname" maxlength="30" title="Hier können Sie den Vornamen des Kunden hinterlegen." value="<%=benutzer.vorname%>">
			<label for="nachname">Nachname</label>
			<input type="text" id="nachname" name="nachname" maxlength="40" title="Hier können Sie den Nachnamen des Kunden hinterlegen." value="<%=benutzer.nachname%>">
			<label for="email">E-Mail*</label>
			<input type="email" id="email" name="email" maxlength="50" title="Hier können Sie die E-Mail-Adresse des Kunden hinterlegen." required="required" value="<%=benutzer.eMailAdresse%>">
			<label for="strasse">Straße</label>
			<input type="text" id="strasse" name="strasse" maxlength="50" title="Hier können Sie die Strasse des Kunden hinterlegen." value="<%=benutzer.strasse%>">
			<label for="hausnummer">Hausnummer</label>
			<input type="text" id="hausnummer" name="hausnummer" title="Hier können Sie die Hausnummer des Kunden hinterlegen." minlength="1" maxlength="5" value="<%=benutzer.hausnummer%>">
			<label for="plz">PLZ</label>
			<%if(benutzer.plz == 0) { %>
			<input type="text" id="plz" name="plz" minlength="5" title="Hier können Sie die Postleitzahl des Kunden hinterlegen." maxlength="5" value="">
			<% } else { %>
			<input type="text" id="plz" name="plz" minlength="5" title="Hier können Sie die Postleitzahl des Kunden hinterlegen." maxlength="5" value="<%=benutzer.plz%>">
			<% } %>
			<label for="ort">Ort</label>
			<input type="text" id="ort" name="ort" maxlength="30" title="Hier können Sie den Wohnort des Kunden hinterlegen." value="<%=benutzer.ort%>">
			<label for="iban">IBAN</label>
			<input type="text" id="iban" name="iban" minlength="22" maxlength="22" title="Hier können Sie die IBAN des Kunden hinterlegen." value="<%=benutzer.iban%>">
			<label for="bic">BIC</label>
			<input type="text" id="bic" name="bic" minlength="9" maxlength="11" title="Hier können Sie die BIC des Kunden hinterlegen." value="<%=benutzer.bic%>">
	    	<input type="checkbox" id="einzugsermächtigungErteilt" name="einzugsermächtigungErteilt" value="<%=benutzer.einzugsermächtigungErteilt%>"
	 			<% if (benutzer.einzugsermächtigungErteilt == true) {%>
	 			checked=<%="checked"%>title="Der Kunde hat die Einzugsermächtigung erteilt."<%} else {%><%=""%>title="Der Kunde hat die Einzugsermächtigung nicht erteilt."<%} %> > Einzugsermächtigung erteilt<br/>
			<input type="checkbox" id="gesperrt" name="gesperrt" value= "<%=benutzer.istGesperrt%>"
	    		<% if (benutzer.istGesperrt == true) {%>
	    		checked=<%="checked"%>title="Der Kunde ist gesperrt."<%} else {%><%=""%>title="Der Kunde ist nicht gesperrt."<%} %> >Ist Gesperrt<br/>
	    	<input type="checkbox" disabled="disabled" id="geloescht" name="geloescht" value="<%=benutzer.istGelöscht%>"
			    <% if (benutzer.istGelöscht == true) {%>
			    checked=<%="checked"%>title="Der Kunde ist gelöscht."<%} else {%><%=""%>title="Der Kunde ist nicht gelöscht."<%} %> >Ist Gelöscht<br/>
			<button type="submit">Änderungen speichern</button>
		</div>
	</form>	
	<form action="/Festiva/Kundenverwaltung?aktion=pw_aendern&kundenid=<%=benutzer.id%>" method="post">
		<div class="spalterechts">
			<h3>Passwort ändern</h3>
			<p id="text"><b>Hinweis:</b> Das Passwort muss aus mindestens einem Klein- und Großbuchstaben sowie einer Zahl und einem Sonderzeichen bestehen. Die Mindestlänge des Passworts beträgt 8 Zeichen.</p>	
			<label for="passwortneu">Neues Passwort</label>
			<input type="password" id="passwortneu" name="passwortneu" title="Bitte beachten Sie bei der Wahl des Passworts den obenstehenden Hinweis!" maxlength="40" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
			<label for="passwortbestätigung">Neues Passwort bestätigen</label>
			<input type="password" id="passwortbestätigung" name="passwortbestätigung" title="Bitte beachten Sie bei der Wahl des Passworts den obenstehenden Hinweis!" maxlength="40" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
			<button type="submit">Passwort ändern</button>
		</div>
	</form>
	</div>
	<button type="submit" onclick="del(<%=benutzer.id%>)" <% if (benutzer.istGelöscht == true) { %> disabled="disabled" <% } %>>Kunden löschen</button>	
	<div class="spalterechts">
		<% if (request.getSession().getAttribute("antwort") != null) 
		{ %>
		<p><%= request.getSession().getAttribute("antwort") %></p>
		<% request.getSession().removeAttribute("antwort");}  %>
	</div>	
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
<script type="text/javascript">

function del(id){
	   if(confirm("Möchten Sie den aktuellen Kunden wirklich löschen?") == true) {
	   		document.location.href='/Festiva/Kundenverwaltung?aktion=loeschen&kundenid=' + id;
	   } else {
	    	document.location.href='/Festiva/Kundenverwaltung?aktion=aendern&kundenid=' + id;
	   }
}
</script>
</html>
<% request.getSession().removeAttribute("benutzer");}%>