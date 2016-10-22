<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAendern.jsp
	# JSP-Aktionen: Der Admin kann eine Kategorie �ndern.
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
				<label class="h2" form="festivalAendern">Festival �ndern</label>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="name">Festivalname</label>
					<input type="text" id="name" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="name">Ort</label>
					<input type="text" id="ort" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="bild">Bild</label>
					<input type="image" id="bild" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="datum">Startdatum</label>
					<input type="date" id="datum" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="kategorie">Kategorie</label>
					<input type="text" id="kategorie" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="datum">Enddatum</label>
					<input type="date" id="datum" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="name">Kurzbeschreibung</label>
					<input type="text" id="beschreibung" maxlength="200">
					</div>
					<div id="spalterechts">
					<label for="name">Langbeschreibung</label>
					<input type="text" id="beschreibung" maxlength="1000">
					</div>
				</div>
			</form>
			 <form action="festivalAndern.jsp" id="artikelAnlegen">
				<label class="h2" form="artikelAnlegen">Artikel</label><br>
				<button type="button" onClick="window.location.href='artikelAnlegen.jsp'">Anlegen </button>
			</form>  
			<table class= "artikel">
				<tr><th>Beschreibung</th><th>Preis</th></tr>
				<tr><td>Beschreibung selektieren</td><td>Preis selektieren</td></tr>
			</table>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>