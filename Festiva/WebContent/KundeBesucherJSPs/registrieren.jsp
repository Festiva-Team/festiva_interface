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
	<title>Mein Konto</title>
	<link rel="stylesheet" type="text/css" href="../CSS/design.css">
	<link rel="stylesheet" type="text/css" href="../CSS/eingaben.css">
</head>
<body>
	<div id="webseite">
		<jsp:include page="header.jsp">
    		<jsp:param name="active" value="registrieren"/>
   	 	</jsp:include>
		<div id="main">
			<form action="Registrieren.jsp" id="registrieren">
				<label class="h2" form="registrieren">Registrieren</label>
				<label for="email">Email</label>
				<input type="email" name="email" id="email" maxlength="30">
				<label for="emailwh">Email wiederholen</label>
				<input type="email" name="email" id="email" maxlength="30">
				<label for="passwort">Passwort</label>
				<input type="password" name="passwort" id="passwort" maxlength="40">
				<label for="passwortwh">Passwort wiederholen</label>
				<input type="password" name="passwort" id="passwort" maxlength="40"><br>
				<button type="button">Registrieren</button>
			</form>
		</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>