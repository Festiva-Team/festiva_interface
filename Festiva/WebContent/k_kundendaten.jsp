<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>	

<%
Benutzer benutzer = null;
if (request.getSession(false) != null && request.getSession(false).getAttribute("benutzer") != null) {
	benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Festiva - Meine Daten</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="k_header.jsp">
    	<jsp:param name="active" value="kundendaten"/>
    </jsp:include>
		<div id="main">
			<form action="/Festiva/Kundendaten?aktion=aendern" method="post">
				<label class="h2">Meine persönlichen Daten</label>
				<div id="zeile">
					<div id="spaltelinks">
						<label for="vorname">Vorname</label>
						<input type="text" id="vorname" name="vorname" maxlength="30" value=<%=benutzer.vorname%>>
						<label for="nachname">Nachname</label>
						<input type="text" id="nachname" name="nachname" maxlength="40" value=<%=benutzer.nachname%>>
						<label for="email">Email</label>
						<input type="email" id="email" name="email" maxlength="50" required="required" value=<%=benutzer.eMailAdresse%>>					
						<label for="iban">IBAN</label>
						<input type="text" id="iban" name="iban" minlength="22" maxlength="22" pattern="DE[0-9]{20}" value=<%=benutzer.iban%>>
						<label for="bic">BIC</label>
						<input type="text" id="bic" name="bic" minlength="9" maxlength="11" value=<%=benutzer.bic%>>
					</div>
					<div id="spalterechts">
						<label for="strasse">Straße</label>
						<input type="text" id="strasse" name="strasse" maxlength="50" value=<%=benutzer.strasse%>>
						<label for="hausnummer">Hausnummer</label>
						<input type="text" id="hausnummer" name="hausnummer" minlength="1" maxlength="5" value=<%=benutzer.hausnummer%>>
						<label for="plz">PLZ</label>
						<input type="text" id="plz" name="plz" pattern="[0-9]{5}" value=<%=benutzer.plz%>>
						<label for="ort">Ort</label>
						<input type="text" id="ort" name="ort" maxlength="30" value=<%=benutzer.ort%>>
						<label for="einzugsermächtigungErteilt">Einzugsermächtigung erteilt</label>
	      				<input type="checkbox" id="einzugsermächtigungErteilt" name="einzugsermächtigungErteilt" value=
	      					   <%=benutzer.einzugsermächtigungErteilt%>
	      					   <% if (benutzer.einzugsermächtigungErteilt == true) {%>
	      					   checked=<%="checked"%><%} else {%><%=""%><%} %> ><br>
						<button type="submit" id="rechts">Änderungen speichern</button>
					</div>
				</div>
			</form>
			
			<form action="/Festiva/Kundendaten?aktion=p_aendern" method="POST">
				<div id="zeile">
				<div id="spaltelinks">
					<label class="h2">Mein Passwort</label>
					<label for="passwortalt">Altes Passwort</label>
					<input type="password" name="passwortalt" id="passwortalt" maxlength="40">
					<label for="passwortneu">Neues Passwort</label>
					<input type="password" name="passwortneu" id="passwortneu" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
					<label for="passwortbestätigung">Neues Passwort bestätigen</label>
					<input type="password" name="passwortbestätigung" id="passwortbestätigung" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
					<button type="submit" id="links">Passwort ändern</button>	
				</div>
				<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% } request.getSession().removeAttribute("antwort"); 
					     request.getSession().removeAttribute("benutzer");%>
				</div>
				</div>
				
				<div id="leer"></div>
			</form>
		<div id="leer"></div>
		</div>
		<footer></footer>
</div>	
</body>
</html>
<%}	else { response.sendRedirect("k_anmelden.jsp");	} %>