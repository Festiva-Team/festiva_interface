<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: anmelden.jsp
	# JSP-Aktionen: Hier kann ein bereits registrierter Kunde, sich mit seinen Daten anmelden um einkaufen zu können.			
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Festiva - Mein Konto</title>
	<link rel="stylesheet" type="text/css" href="../CSS/design.css">
</head>
<body>
<div id="webseite">
    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="anmelden"/>
    </jsp:include>
		<div id="main">
			<form>
				<label class="h2" form="anmelden">Anmelden</label>
				<div id="spaltelinks">
					<label for="email">Email</label>
					<input type="email" name="email" id="email" maxlength="30">
					<label for="passwort">Passwort</label>
					<input type="password" name="passwort" id="passwort" maxlength="40">
					<button type="button" id="links">Anmelden</button>
				</div>
				<div id="leer"></div>
			</form>
		</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>