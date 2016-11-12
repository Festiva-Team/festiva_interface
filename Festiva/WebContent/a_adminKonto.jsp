<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>	

<%  /** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_adminKonto.jsp
	# JSP-Aktionen: (1) Anzeige des Adminkontos
	# 				(2) Möglichkeit zur Passwortänderung
	*/

if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1 || request.getSession(false).getAttribute("benutzer") == null) {
	response.sendRedirect("k_anmelden.jsp");}  
else {
	Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
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
		<h2>Mein Konto</h2>
		<form action="/Festiva/Benutzerdaten?aktion=p_aendern" method="post">
			<div id="spaltelinks">
				<label for="email">E-Mail</label>
				<input type="email" id="email" name="email" maxlength="50" disabled="disabled" value="<%=benutzer.eMailAdresse%>">
				<label for="passwortalt">Altes Passwort</label>
				<input type="password" name="passwortalt" id="passwortalt" title="Bitte geben Sie Ihr altes Passwort ein!" maxlength="40" required="required"> 
				<label for="passwortneu">Neues Passwort</label>
				<input type="password" name="passwortneu" id="passwortneu" maxlength="40" title="Bitte beachten Sie bei der Wahl Ihres Passworts den rechtsstehenden Hinweis!" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
				<label for="passwortbestätigung">Neues Passwort bestätigen</label>
				<input type="password" name="passwortbestätigung" id="passwortbestätigung" title="Bitte beachten Sie bei der Wahl Ihres Passworts den rechtsstehenden Hinweis!" maxlength="40" required="required" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"> 
				<button type="submit" id="links">Änderungen speichern</button>
			</div>
			<div id="spalterechts">
					<p id="text"><b>Hinweis:</b> Ihr Passwort muss aus mindestens einem Klein- und Großbuchstaben sowie einer Zahl und einem Sonderzeichen bestehen. Die Mindestlänge des Passworts beträgt 8 Zeichen.</p>
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
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>
<% request.getSession().removeAttribute("benutzer");}%>
