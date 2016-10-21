<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kundenAnlegen.jsp
	# JSP-Aktionen: Der Admin kann einen neuen Kunden anlegen.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="../CSS/design.css">
	<link rel="stylesheet" type="text/css" href="../CSS/eingaben.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="headerAdmin.jsp">
    	<jsp:param name="active" value="kundenAnlegen"/>
    </jsp:include>
		<div id="main">
			<form action="kundenAnlegen.jsp" id="anmelden">
				<label class="h2" form="kundenAnlegen">Kunden anlegen</label>
				<label for="vorname">Vorname</label>
				<input type="text" id="vorname" maxlength="30">
				<label for="nachname">Nachname</label>
				<input type="text" id="nachname" maxlength="40">
				<label for="email">Email</label>
				<input type="email" id="email" maxlength="50">
				<label for="passwort">Passwort</label>
				<input type="password" id="email" maxlength="30">
				<label for="passwort">Passwort bestätigen</label>
				<input type="password" id="passwortBestätigen" maxlength="40">
				<label for="straße">Straße</label>
				<input type="text" id="straße" maxlength="50">
				<label for="hausnummer">Hausnummer</label>
				<input type="text" id="hausnummer" minlength="1" maxlength="5">
				<label for="plz">PLZ</label>
				<input type="number" id="plz" minlength="5" maxlength="5">
				<label for="ort">Ort</label>
				<input type="text" id="ort" maxlength="30"><br>
				<label for="gesperrt">gesperrt</label>
      			<input type="checkbox" id="gesperrt"><br>
      			<label for="einzugsermächtigungErteilt">Einzugsermächtigung erteilt</label>
      			<input type="checkbox" id="einzugsermächtigungErteilt"><br>
				<button type="button">speichern</button>
			</form>
		</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>