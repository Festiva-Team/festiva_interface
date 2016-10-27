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
// String rueckmeldung = " ";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Festiva - Mein Konto</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
</head>
<body>
<div id="webseite">
    <jsp:include page="k_header.jsp">
    	<jsp:param name="active" value="anmelden"/>
    </jsp:include>
		<div id="main">
			<form action="/Festiva/Login" method="GET">
				<div id="zeile1">
				<div id="spaltelinks">
					<label class="h2">Anmelden</label>
					<label for="email">E-Mail</label>
					<input type="email" name="email" id="email" maxlength="30"><br>
					<label for="passwort">Passwort</label>
					<input type="password" name="passwort" id="passwort" maxlength="40"><br>
					<button type="submit" id="links">Anmelden</button>
				</div>
				<div id="spalterechts">
					<% if (request.getSession().getAttribute("rueckmeldung") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("rueckmeldung") %></p>
					<% }  %>
				</div>
				</div>
				</form>
				<div id="leer"></div>
		</div>
		<div id="footer"></div>
	</div>	
</body>
</html>