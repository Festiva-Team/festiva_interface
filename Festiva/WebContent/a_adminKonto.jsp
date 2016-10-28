<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>	

<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1 || request.getSession(false).getAttribute("benutzer") == null) {
		response.sendRedirect("k_anmelden.jsp");}  
	else {
		Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Adminkonto</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="adminKonto"/>
    </jsp:include>
	<div id="main">
		<form action="/Festiva/Kundendaten?aktion=p_aendern" method="post">
			<label class="h2" form="adminKonto">Mein Konto</label>
			<div id="spaltelinks">
				<label for="email">E-Mail</label>
				<input type="email" id="email" name="email" maxlength="50" disabled="disabled" value=<%=benutzer.eMailAdresse%>>
				<label for="passwortalt">Altes Passwort</label>
				<input type="password" name="passwortalt" id="passwortalt" maxlength="40">
				<label for="passwortneu">Neues Passwort</label>
				<input type="password" name="passwortneu" id="passwortneu" maxlength="40">
				<label for="passwortbestätigung">Neues Passwort bestätigen</label>
				<input type="password" name="passwortbestätigung" id="passwortbestätigung" maxlength="40"> 
				<button type="submit" id="links">Änderungen speichern</button>
			</div>
			<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% } request.getSession().removeAttribute("antwort"); %>
				</div>
		</form>
	<div id="leer"></div>
	</div>
	<div id="footer">
	</div>
</div>	
</body>
</html>
<% request.getSession().removeAttribute("benutzer");}%>
