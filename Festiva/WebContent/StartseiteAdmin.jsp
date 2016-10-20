<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: startseiteAdmin.jsp
	# JSP-Aktionen: Die Startseite des Admins wird angezeigt.
	# 				Von hier aus kann er die Verwaltung der Kunden, Kategorien und Festivals vornehmen.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<title>Festiva - Adminstartseite</title>
</head>
<body>
	<div id="webseite">
		<div id="header">
			<img src="Bilder/HeaderMitLogo.png" width="980"/>
		</div>
			<nav>
	  			<ul>
				      <li><a href="startseiteAdmin.jsp">Home</a></li>
				      <li><a href="kategorienverwaltung.jsp">Kategorienverwaltung</a></li>
				      <li><a href="festivalverwaltung.jsp">Festivalverwaltung</a></li>
				      <li><a href="kundenverwaltung.jsp">Kundenverwaltung</a></li>
				      <li><a href="#">Mein Konto</a></li>	
			  	</ul>
			</nav>
		<div id="footer">
		</div>
	</div>	
</body>
</html>