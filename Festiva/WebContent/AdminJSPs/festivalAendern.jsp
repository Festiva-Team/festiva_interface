<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAendern.jsp
	# JSP-Aktionen: Der Admin kann eine Kategorie ändern.
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
    	<jsp:param name="active" value="festivalAendern"/>
    </jsp:include>
		<div id="main">
			<form action="festivalAendern.jsp" id="festivalAendern">
				<label class="h2" form="festivalAendern">Festival ändern</label>
				<div id="zeile">
				<div id="spaltelinks">
					<label for="name">Festivalname</label>
					<input type="text" id="name" maxlength="30">
					<label for="kategorie">Kategorie</label>
					<input type="text" id="kategorie" maxlength="30">	
					<label for="name">Ort</label>
					<input type="text" id="ort" maxlength="30">
					<label for="datum">Startdatum</label>
					<input type="date" id="datum" maxlength="30">
					<label for="datum">Enddatum</label>
					<input type="date" id="datum" maxlength="30">
					<label for="bild">Bild</label>
					<input type="file" id="bild" accept="image/*">
				</div>
				<div id="spalterechts">
					<label for="name">Kurzbeschreibung</label>
					<textarea rows="5" cols="30"></textarea>			
					<label for="name">Langbeschreibung</label>
					<textarea rows="10" cols="30"></textarea>
					</div>
				</div>
			</form>
			<div id="zeile">
			<div id="spalte links">
			<table class= "artikel"><h2>Artikel</h2>
				<tr><th>Beschreibung</th><th>Preis</th></tr>
				<tr><td>Beschreibung selektieren</td><td>Preis selektieren</td></tr>
			</table>
			</div>
			</div>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>