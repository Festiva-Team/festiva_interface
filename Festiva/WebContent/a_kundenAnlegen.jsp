<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
 	# Autor: Nicola Kloke, Alina Fankhänel
 	# JSP-Name: a_kundenAnlegen.jsp
 	# JSP-Aktionen: (1) Erzeugung von Eingabefeldern zum Anlegen von neuen Kunden
 	#				(2) Validieren der Eingabedaten durch Input-Typen und Pattern
	#				(3) Button zum Senden der Daten
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="kundenAnlegen"/>
    </jsp:include>
	<div id="main">
	<form action="/Festiva/Registrierung" method="post">
		<div class="zeile">
			<h1>Kunden anlegen</h1>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
		<div class="zeile">
			<% if (request.getSession().getAttribute("antwort") != null) 
			{ %>
			<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
			<% request.getSession().removeAttribute("antwort");}  %>
		</div>
		<div class="spaltelinks">
			<label for="email">E-Mail*</label>
			<input type="email" name="email" id="email" title="Bitte geben Sie eine gültige E-Mail Adresse ein!" maxlength="30" required="required">
			<label for="emailbestätigung">E-Mail bestätigen*</label>
			<input type="email" name="emailbestätigung" id="emailbestätigung" title="Bitte geben Sie eine gültige E-Mail Adresse ein!" maxlength="30" required="required">
			<label for="passwort">Passwort*</label>
			<input type="password" name="passwort" id="passwort" title="Bitte beachten Sie bei der Wahl des Passworts den rechtsstehenden Hinweis!" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required"/>
			<label for="passwortbestätigung">Passwort bestätigen*</label>
			<input type="password" name="passwortbestätigung" title="Bitte beachten Sie bei der Wahl des Passworts den rechtsstehenden Hinweis!" id="passwortbestätigung" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required"/>
			<button type="submit">Anlegen</button>
		</div>
		<div class="spalterechts">
			<p id="text"><b>Hinweis:</b> Das Passwort muss aus mindestens einem Klein- und Großbuchstaben sowie einer Zahl und einem Sonderzeichen bestehen. Die Mindestlänge des Passworts beträgt 8 Zeichen.</p>	
		</div>	
		</div>
	</form>
	</div>
	<div id="leer"></div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
	</div>	
</body>
</html>