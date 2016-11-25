<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: headerAdmin.jsp
	#               Definiert den Header und die Navigation für einen Admin.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Header Admin</title>
</head>
<body>
	<header>
		<img src="/Festiva/Bilder/HeaderMitLogo.png" width="100%"/>
	</header>
		<nav>
		<label for="show-menu" class="show-menu">Menü</label>
		<input type="checkbox" id="show-menu" role="button">
  			<ul id="menu">
		    	<li><a href="a_startseiteAdmin.jsp">Home</a></li>
		        <li><a href="/Festiva/Kategorienverwaltung?aktion=anzeigen">Kategorienverwaltung</a></li>
		        <li><a href="/Festiva/Festivalverwaltung?aktion=anzeigen">Festivalverwaltung</a></li>
		        <li><a href="/Festiva/Artikelverwaltung?aktion=anzeigen">Artikelverwaltung</a></li>
		        <li><a href="/Festiva/Kundenverwaltung?aktion=anzeigen">Kundenverwaltung</a></li>
		        <li><a href="#">Administration</a>	
		        	<ul class="hidden">
		        		<li><a href="/Festiva/Benutzerdaten?aktion=anzeigen">Mein Konto</a></li> 
		        		<li><a href="a_adminAnlegen.jsp">Admin anlegen</a></li> 
		        		<li><a href="/Festiva/Logout" accesskey="1" title="">Abmelden</a></li>
		        	</ul>
		        </li>
		  	</ul>
		</nav>
</body>
</html>