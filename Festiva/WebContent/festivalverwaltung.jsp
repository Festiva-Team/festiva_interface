<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: festivalverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Festival und die dazugeh�rigen Artikel suchen, anzeigen, anlegen, �ndern und l�schen.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="headerAdmin.jsp">
    		<jsp:param name="active" value="festivalverwaltung"/>
   		</jsp:include>
   		<div id="footer">
		</div>
	</div>
</body>
</html>