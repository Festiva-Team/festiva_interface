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
			<form action="artikelAnlegen.jsp" id="artikelAnlegen">
				<label class="h2" form="kategorieAnlegen">Artikel anlegen</label>
				<label for="beschreibung">Beschreibung</label>
				<input type="text" id="beschreibung" maxlength="100">
				<label for="preis">Preis</label>
				<input type="number" id="preis" maxlength="100"><br>
				<button>speichern</button>
			</form>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>