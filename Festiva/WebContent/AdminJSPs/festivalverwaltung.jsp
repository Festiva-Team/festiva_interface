<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: festivalverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Festival und die dazugehörigen Artikel suchen, anzeigen, anlegen, ändern und löschen.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
<div id="webseite">
	<jsp:include page="headerAdmin.jsp">
   		<jsp:param name="active" value="festivalverwaltung"/>
	</jsp:include>
 	<div id="main">
  		<form action="festivalverwaltung.jsp" id="festivalverwaltung">
			<label class="h2">Festivalverwaltung</label>
			<div id="spaltelinks">
				<button type="button" id="verwaltung" onClick="window.location.href='festivalAnlegen.jsp'">Anlegen</button>
				<table class="table">
					<tr><th>Name</th><th>Startdatum</th><th>Enddatum</th><th>Ort</th><th>Kategorie</th><th>Kurzbeschreibung</th></tr>
				</table>	
			</div>		
		</form> 
	<div id="leer"></div>
   	</div>
  		<div id="footer">
	</div>
</div>
</body>
</html>