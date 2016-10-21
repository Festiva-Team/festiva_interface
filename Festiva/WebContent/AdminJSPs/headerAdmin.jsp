<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: headerAdmin.jsp
	# JSP-Aktionen: Definiert den Header und die Navigation für einen Admin.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<link rel="stylesheet" type="text/css" href="../CSS/eingaben.css">
<title>Header Admin</title>
</head>
<body>
	<div id="header">
			<img src="../Bilder/HeaderMitLogo.png" width="980"/>
	</div>
			<nav>
	  			<ul>
				      <li><a href="startseiteAdmin.jsp">Home</a></li>
				      <li><a href="kategorienverwaltung.jsp">Kategorienverwaltung</a></li>
				      <li><a href="festivalverwaltung.jsp">Festivalverwaltung</a></li>
				      <li><a href="kundenverwaltung.jsp">Kundenverwaltung</a></li>
				      <li><a href="adminKonto.jsp">Mein Konto</a></li>	
			  	</ul>
			</nav>
</body>
</html>