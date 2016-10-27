<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: registrieren.jsp
	# JSP-Aktionen: Hier kann ein Besucher, sich mit seiner Email und einem Passwort registrieren, um mit der nächsten Anmeldung einkaufen zu können. 	
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Festiva - Mein Konto</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
</head>
<body>
	<div id="webseite">
		<jsp:include page="k_header.jsp">
    		<jsp:param name="active" value="registrieren"/>
   	 	</jsp:include>
		<div id="main">
			<div id="zeile1">
			<div id="spaltelinks">
				<label class="h2">Registrieren</label>
				<label for="email">Email</label>
				<input type="email" name="email" id="email" maxlength="30"><br>
				<label for="emailwh">Email bestätigen</label>
				<input type="email" name="email" id="email" maxlength="30"><br>
				<label for="passwort">Passwort</label>
				<input type="password" name="passwort" id="passwort" maxlength="40"><br>
				<label for="passwortwh">Passwort bestätigen</label>
				<input type="password" name="passwort" id="passwort" maxlength="40"><br>
				<button type="button" id="links">Registrieren</button>
			</div>	
			</div>
			<div id="leer"></div>
		</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>