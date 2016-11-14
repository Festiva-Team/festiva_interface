<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    session="false"
	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_registrieren.jsp
	# JSP-Aktionen: 1) Erzeugung von Eingabefeldern zur Registrierung von neuen Kunden
					2) Weitergabe der Daten an das Servlet "Registrierung.java" 
					3) Anzeige der Antwort aus dem Servlet
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
   		<jsp:param name="active" value="registrieren"/>
  	 	</jsp:include>
	<div id="main">
	<form action="/Festiva/Registrierung" method="post">
		<div class="zeile">
			<h1>Registrierung</h1>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<% if (request.getSession().getAttribute("antwort") != null) 
			{ %>
			<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
			<% request.getSession().removeAttribute("antwort");}  %>
		<div class="spaltelinks">
			<label for="email">E-Mail*</label>
			<input type="email" name="email" id="email" maxlength="30" title="Bitte geben Sie eine gültige E-Mail Adresse ein!" required="required" autofocus>
			<label for="emailbestätigung">E-Mail bestätigen*</label>
			<input type="email" name="emailbestätigung" id="emailbestätigung" title="Bitte geben Sie eine gültige E-Mail Adresse ein!" maxlength="30" required="required">
			<label for="passwort">Passwort*</label>
			<input type="password" name="passwort" id="passwort" maxlength="40" title="Bitte beachten Sie bei der Wahl Ihres Passworts den rechtsstehenden Hinweis!" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required"/>
			<label for="passwortbestätigung">Passwort bestätigen*</label>
			<input type="password" name="passwortbestätigung" id="passwortbestätigung" title="Bitte beachten Sie bei der Wahl Ihres Passworts den rechtsstehenden Hinweis!" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required" />
			<button type="submit">Registrieren</button>
		</div>
		<div class="spalterechts">
			<p id="text"><b>Hinweis:</b> Ihr Passwort muss aus mindestens einem Klein- und Großbuchstaben sowie einer Zahl und einem Sonderzeichen bestehen. Die Mindestlänge des Passworts beträgt 8 Zeichen.</p>
		</div>		
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