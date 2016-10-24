<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAnlegen.jsp
	# JSP-Aktionen: Der Admin kann eine neue Kategorie anlegen.
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
    	<jsp:param name="active" value="festivalAnlegen"/>
    </jsp:include>
	<div id="main">
		<form action="festivalAnlegen.jsp" id="festivalAnlegen">
			<label class="h2">Festival anlegen</label>
			<div id="zeile">
				<div id="spaltelinks">
					<label for="festivalname">Festivalname</label>
					<input type="text" id="name" maxlength="30">
				</div>
				<div id="spalterechts">
					<label for="kategorie">Kategorie</label>
					<input type="text" id="kategorie" maxlength="30">
				</div>
			</div>
			<div id="zeile">
			    <div id="spaltelinks">
					<label for="name">Ort</label>
					<input type="text" id="ort" maxlength="30">	
				</div>
				<div id="spalterechts">
					<label for="bild">Bild</label>
					<input type="file" id="bild" accept="image/*">
				</div>
			</div>	
			<div id="zeile">
				<div id="spaltelinks">
					<label for="datum">Startdatum</label>
					<input type="date" id="datum" maxlength="30">
				</div>
				<div id="spalterechts">
					<label for="datum">Enddatum</label>
					<input type="date" id="datum" maxlength="30">
				</div>
			</div>				
			<div id="zeile">
				<div id="spaltelinks">
					<label for="name">Kurzbeschreibung</label>
					<textarea rows="5" cols="25"></textarea>
				</div>
				<div id="spalterechts">			
					<label for="name">Langbeschreibung</label>
					<textarea rows="10" cols="25"></textarea>
					<button type="button" id="links">Speichern</button>
				</div>
			</div>
		</form>			
	<div id="leer"></div>			
	</div>
	<div id="footer">
	</div>
</div>	
</body>
</html>