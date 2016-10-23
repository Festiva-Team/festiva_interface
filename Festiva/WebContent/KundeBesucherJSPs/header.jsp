<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: header.jsp
	# JSP-Aktionen: Definiert den Header und die Navigation f�r einen Besucher und einen Kunden.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Header</title>
</head>
<body>
	<div id="header">
		<img src="../Bilder/HeaderMitLogo.png" width="980"/>
	</div>
		<nav>
		<ul>
			<li><a href="startseite.jsp">Home</a></li>
			<li><a href="shop.jsp">Shop</a></li>
			<li><a href="#">Mein Konto</a>
			<ul>
				<li><a href="anmelden.jsp">Anmelden</a></li>
				<li><a href="registrieren.jsp">Registrieren</a></li>
				<li><a href="kundendaten.jsp">Meine Daten</a></li> 
				<li><a href="bestellungen.jsp">Meine Bestellungen</a></li> 
				<li><a href="#">Abmelden</a></li>
			</ul>
			</li>					      
			<li><a href="warenkorb.jsp">Warenkorb</a></li> 
		</ul>
		</nav>
</body>
</html>