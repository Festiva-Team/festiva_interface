<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="headerAdmin.jsp">
    	<jsp:param name="active" value="artikelAnlegen"/>
    </jsp:include>
	<div id="main">
		<form>
			<label class="h2">Artikel anlegen</label>
			<div id="spaltelinks">
			<label for="beschreibung">Beschreibung</label>
			<input type="text" id="beschreibung" maxlength="100">
			<label for="preis">Preis</label>
			<input type="text" id="preis" maxlength="7"><br>
			<button type="button" id="links">Anlegen</button>
			</div>
		</form>		
	<div id="leer"></div>
	</div>
	<div id="footer">
	</div>
</div>	
</body>
</html>