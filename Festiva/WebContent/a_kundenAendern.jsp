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
			<div id="zeile">
			<form action="/Festiva/Kundenverwaltung?aktion=datenaendern&kundenid=<%=benutzer.id%>" method="post">
					<div id="spaltelinks">
					<h2>Kunden ändern</h2>
					<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
					<label for="vorname">Vorname</label>
					<input type="text" id="vorname" name="vorname" maxlength="30" value="<%=benutzer.vorname%>">
					<label for="nachname">Nachname</label>
					<input type="text" id="nachname" name="nachname" maxlength="40" value="<%=benutzer.nachname%>">
					<label for="email">E-Mail*</label>
					<input type="email" id="email" name="email" maxlength="50" required="required" value="<%=benutzer.eMailAdresse%>">
					<label for="strasse">Straße</label>
					<input type="text" id="strasse" name="strasse" maxlength="50" value="<%=benutzer.strasse%>">
					<label for="hausnummer">Hausnummer</label>
					<input type="text" id="hausnummer" name="hausnummer" minlength="1" maxlength="5" value="<%=benutzer.hausnummer%>">
					<label for="plz">PLZ</label>
					<%if(benutzer.plz == 0) { %>
					<input type="text" id="plz" name="plz" minlength="5" maxlength="5" value="">
					<% } else { %>
					<input type="text" id="plz" name="plz" minlength="5" maxlength="5" value="<%=benutzer.plz%>">
					<% } %>
					<label for="ort">Ort</label>
					<input type="text" id="ort" name="ort" maxlength="30" value="<%=benutzer.ort%>">
					<label for="iban">IBAN</label>
					<input type="text" id="iban" name="iban" minlength="22" maxlength="22" value="<%=benutzer.iban%>">
					<label for="bic">BIC</label>
					<input type="text" id="bic" name="bic" minlength="9" maxlength="11" value="<%=benutzer.bic%>">
					<label for="einzugsermächtigungErteilt">Einzugsermächtigung erteilt</label>
	      			<input type="checkbox" id="einzugsermächtigungErteilt" name="einzugsermächtigungErteilt" value=
	      					   "<%=benutzer.einzugsermächtigungErteilt%>"
	      					   <% if (benutzer.einzugsermächtigungErteilt == true) {%>
	      					   checked=<%="checked"%><%} else {%><%=""%><%} %> >
					<label for="gesperrt">Ist Gesperrt</label>
					<input type="checkbox" id="gesperrt" name="gesperrt" value=
	      					   "<%=benutzer.istGesperrt%>"
	      					   <% if (benutzer.istGesperrt == true) {%>
	      					   checked=<%="checked"%><%} else {%><%=""%><%} %> >
					<button type="submit">Änderungen speichern</button>
					</div>
			</form>	
			<form action="/Festiva/Kundenverwaltung?aktion=pw_aendern&kundenid=<%=benutzer.id%>" method="post">
					<div id="spalterechts">
					<h2>Passwort ändern</h2>
					<label for="passwortneu">Neues Passwort</label>
					<input type="password" id="passwortneu" name="passwortneu" maxlength="40" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
					<label for="passwortbestätigung">Neues Passwort bestätigen</label>
					<input type="password" id="passwortbestätigung" name="passwortbestätigung" maxlength="40" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
					<button type="submit">Passwort ändern</button>
					</div>
					</form>
			</div>
			<form action="/Festiva/Kundenverwaltung?aktion=loeschen&kundenid=<%=benutzer.id%>" method="post">
				<div id="spalterechts">
					<button onclick="del()">Kunden löschen</button>
					</div>
					</form>
					<div id="spalterechts">
					<p>Hinweis: Das Passwort muss aus mindestens einem Klein- und Großbuchstaben sowie einer Zahl und einem Sonderzeichen bestehen. Die Mindestlänge des Passworts beträgt 8 Zeichen.</p>
				</div>	
					<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>	
		<div id="leer"></div>
		</div>
		<footer></footer>
</div>	
</body>
<script type="text/javascript">

function del(){
	app.alert("Hello World", 3);
   	// User Pressed Yes, Do submission //this.submitForm(...);
   }
}

</script>
</html>
<% request.getSession().removeAttribute("benutzer");}%>