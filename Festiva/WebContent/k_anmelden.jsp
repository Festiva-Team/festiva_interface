<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    session="false"
	%>
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
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta charset="ISO-8859-1">
	<title>Festiva - Mein Konto</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
</head>
<body>
<div id="webseite">
    <jsp:include page="k_header.jsp">
    	<jsp:param name="active" value="anmelden"/>
    </jsp:include>
		<div id="main">
			<form action="/Festiva/Login" method="POST">
				<div id="zeile">
				<div id="spaltelinks">
					<h2>Anmelden</h2>
					<label for="email">E-Mail</label>
					<input type="email" name="email" id="email" title="Bitte geben Sie Ihre E-Mail-Adresse ein!" maxlength="30" required="required" autofocus>
					<label for="passwort">Passwort</label>
					<input type="password" name="passwort" id="passwort" title="Bitte geben Sie Ihr Passwort ein!" maxlength="40" required="required">
					<button type="submit">Anmelden</button>	
				</div>
				<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>
				</div>
				
				<div id="leer"></div>
			</form>
		</div>
		<footer></footer>
	</div>	
</body>
</html>