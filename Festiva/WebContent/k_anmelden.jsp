<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    session="false"
	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankh�nel
	# JSP-Name: k_anmelden.jsp
	#               (1) Erzeugung von Eingabefeldern f�r die Anmeldung eines Kunden
	#				(2) Validieren der Eingabedaten durch Input-Typen
^	#				(3) Button zum Senden der Daten
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
			<div class="zeile">
			<h1>Anmelden</h1>
			<div class="spaltelinks">
				<label for="email">E-Mail</label>
				<input type="email" name="email" id="email" title="Bitte geben Sie Ihre E-Mail-Adresse ein!" maxlength="30" required="required" autofocus>
				<label for="passwort">Passwort</label>
				<input type="password" name="passwort" id="passwort" title="Bitte geben Sie Ihr Passwort ein!" maxlength="40" required="required">
				<button type="submit">Anmelden</button>	
			</div>
			<div class="spalterechts">
				<% if (request.getSession().getAttribute("antwort") != null) 
				{ %>
				<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
				<%if((request.getSession().getAttribute("antwort")).equals("Sie m�ssen sich erst anmelden, bevor Sie Artikel in Ihren Warenkorb legen k�nnen.")) { %>
				<p id="antwort">Sie sind noch nicht registriert? Dann klicken Sie bitte <a href="k_registrieren.jsp"> hier</a> !</p>
				<% } request.getSession().removeAttribute("antwort");}  %>
			</div>
			</div>		
			<div id="leer"></div>
		</form>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>