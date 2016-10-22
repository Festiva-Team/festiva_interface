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
<% /** 	Value Daten mit Daten aus Datenbank füllen.e
				<label for="name">Festivalname</label>
				<input type="text" id="name" maxlength="30">
				<label for="bild">Bild</label>
				<input type="file" id ="bild" accept="image/*"> 
				<label for="kategorie">Kategorie</label>
				<input type="text" id="kategorie" maxlength="30">
				<label for="startdatum">Startdatum</label>
				<input type="date" id="startdatum">
				<label for="enddatum">Enddatum</label>
				<input type="date" id="enddatum">
				<label for="straße">Straße</label>
				<input type="text" id="straße" maxlength="50">
				<label for="hausnummer">Hausnummer</label>
				<input type="text" id="hausnummer" minlength="1" maxlength="5">
				<label for="plz">PLZ</label>
				<input type="number" id="plz" minlength="5" maxlength="5">
				<label for="ort">Ort</label>
				<input type="text" id="ort" maxlength="30"><br>
				<label for="kurzbeschreibung">Kurzbeschreibung</label>
				<input type="text" id="beschreibung" maxlength="100">
				<label for="langeschreibung">Langbeschreibung</label>
				<input type="text" id="beschreibung" maxlength="200">		
*/	%>			<button>speichern</button>
			</form>
			 <form action="festivalAndern.jsp" id="artikelAnlegen">
				<label class="h2" form="artikelAnlegen">Artikel</label><br>
				<button type="button" onClick="window.location.href='artikelAnlegen.jsp'">Anlegen </button>
			</form>  
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>