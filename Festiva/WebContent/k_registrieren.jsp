<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    session="false"
	%>
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
		<form action="/Festiva/Registrierung" method="post">
			<div id="zeile">
			<div id="spaltelinks">
				<h2>Registrierung</h2>
				<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
				<label for="email">E-Mail*</label>
				<input type="email" name="email" id="email" maxlength="30" required="required">
				<label for="emailbestätigung">E-Mail bestätigen*</label>
				<input type="email" name="emailbestätigung" id="emailbestätigung" maxlength="30" required="required">
				<label for="passwort">Passwort*</label>
				<input type="password" name="passwort" id="passwort" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required"/>
				<label for="passwortbestätigung">Passwort bestätigen*</label>
				<input type="password" name="passwortbestätigung" id="passwortbestätigung" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required" />
				<button type="submit">Registrieren</button>
			</div>
			<div id="spalterechts">
					<p>Hinweis: Ihr Passwort muss aus mindestens einem Klein- und Großbuchstaben sowie einer Zahl und einem Sonderzeichen bestehen. Die Mindestlänge des Passworts beträgt 8 Zeichen.</p>
				</div>	
			<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>	
				
			</div>
			</form>
			<div id="leer"></div>
		</div>
		<footer></footer>
	</div>	
</body>
</html>