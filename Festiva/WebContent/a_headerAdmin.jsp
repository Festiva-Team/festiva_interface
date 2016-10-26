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
<title>Header Admin</title>
</head>
<body>
	<div id="header">
		<img src="/Festiva/Bilder/HeaderMitLogo.png" width="980"/>
	</div>
		<nav>
  			<ul>
		    	<li><a href="a_startseiteAdmin.jsp">Home</a></li>
		        <li><a href="a_kategorienverwaltung.jsp">Kategorienverwaltung</a></li>
		        <li><a href="a_festivalverwaltung.jsp">Festivalverwaltung</a></li>
		        <li><a href="a_kundenverwaltung.jsp">Kundenverwaltung</a></li>
		        <li><a href="#">Adminkonto</a>	
		        	<ul>
		        		<li><a href="a_adminKonto.jsp">Meine Daten</a></li> 
		        		<li><a href="/Festiva/Logout" accesskey="1" title="">Abmelden</a></li>
		        	</ul>
		        </li>
		  	</ul>
		</nav>
</body>
</html>