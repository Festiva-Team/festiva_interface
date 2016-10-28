<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kundenAendern.jsp
	# JSP-Aktionen: Der Admin kann die Kundendaten ändern.
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1 || request.getSession(false).getAttribute("benutzer") == null) {
	response.sendRedirect("k_anmelden.jsp");} 
else {
	Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
			<form action="/Festiva/Kundenverwaltung?aktion=datenaendern&kundenid=<%=benutzer.id%>" method="post">
				<label class="h2">Kunden ändern</label>
	<div id="zeile">
					<div id="spaltelinks">
					<label for="vorname">Vorname</label>
					<input type="text" id="vorname" name="vorname" maxlength="30" value=<%=benutzer.vorname%>>
					</div>
					<div id="spalterechts">
					<label for="iban">IBAN</label>
					<input type="text" id="iban" name="iban" minlength="22" maxlength="22" value=<%=benutzer.iban%>>
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="nachname">Nachname</label>
					<input type="text" id="nachname" name="nachname" maxlength="40" value=<%=benutzer.nachname%>>
					</div>
					<div id="spalterechts">
					<label for="bic">BIC</label>
					<input type="text" id="bic" name="bic" minlength="9" maxlength="11" value=<%=benutzer.bic%>>
					</div>
				</div>
				<div id="zeile">
					<div id="spalterechts">
					<label for="strasse">Straße</label>
					<input type="text" id="strasse" name="strasse" maxlength="50" value=<%=benutzer.strasse%>>
					<div id="spaltelinks">
					<label for="email">E-Mail</label>
					<input type="email" id="email" name="email" maxlength="50" value=<%=benutzer.eMailAdresse%>>
					</div>
					</div>
					
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="hausnummer">Hausnummer</label>
					<input type="text" id="hausnummer" name="hausnummer" minlength="1" maxlength="5" value=<%=benutzer.hausnummer%>>
					</div>
					<div id="spalterechts">
					<label for="einzugsermächtigungErteilt">Einzugsermächtigung erteilt</label>
	      				<input type="checkbox" id="einzugsermächtigungErteilt" name="einzugsermächtigungErteilt" value=
	      					   <%=benutzer.einzugsermächtigungErteilt%>
	      					   <% if (benutzer.einzugsermächtigungErteilt == true) {%>
	      					   checked=<%="checked"%><%} else {%><%=""%><%} %> ><br>
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="plz">PLZ</label>
					<input type="text" id="plz" name="plz" minlength="5" maxlength="5" value=<%=benutzer.plz%>>
					</div>
					<div id="spalterechts">
					<label for="gesperrt">Ist Gesperrt</label>
	      				<input type="checkbox" id="gesperrt" name="gesperrt" value=
	      					   <%=benutzer.istGesperrt%>
	      					   <% if (benutzer.istGesperrt == true) {%>
	      					   checked=<%="checked"%><%} else {%><%=""%><%} %> ><br>
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="ort">Ort</label>
					<input type="text" id="ort" name="ort" maxlength="30" value=<%=benutzer.ort%>>
					</div>
					<div id="spalterechts">
					<button type="submit" id="links">Änderungen speichern</button>
					</div>
				</div>
			</form>
			<form action="/Festiva/Kundenverwaltung?aktion=pw_aendern&kundenid=<%=benutzer.id%>" method="post">
					<div id="spaltelinks">
					<label for="passwortneu">Neues Passwort</label>
					<input type="password" id="passwortneu" name="passwortneu" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="passwortbestätigung">Neues Passwort bestätigen</label>
					<input type="password" id="passwortbestätigung" name="passwortbestätigung" maxlength="30">
					</div>
					<div id="spalterechts">
					<button type="submit" id="links">Passwort ändern</button>
					</div>
					</form>
			<form action="/Festiva/Kundenverwaltung?aktion=loeschen&kundenid=<%=benutzer.id%>" method="post">
			<div id="spalterechts">
					<button type="submit" id="links">Kunden löschen</button>
					</div>
					</form>
					<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>	
		<div id="leer"></div>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>
<% request.getSession().removeAttribute("benutzer");}%>