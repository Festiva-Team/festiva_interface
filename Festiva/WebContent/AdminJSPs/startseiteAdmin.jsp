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
<link rel="stylesheet" type="text/css" href="../CSS/home.css">
	<title>Festiva - Adminstartseite</title>
</head>
<body>
	<div id="webseite">
	<jsp:include page="headerAdmin.jsp">
		<jsp:param name="active" value="startseiteAdmin"/>
	</jsp:include>
	<div id="main">
		<h1>Adminbereich</h1>
	</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>