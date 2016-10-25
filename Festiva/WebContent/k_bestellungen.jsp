<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Festiva - Meine Daten</title>
</head>
<body>
<div id="webseite">
		<jsp:include page="k_header.jsp">
    		<jsp:param name="active" value="warenkorb"/>
    	</jsp:include>
    	<div id="main">
    		<form id="table">
				<label class="h2">Meine Bestellungen</label>
				<table class= "artikel">
					<tr><th>Festival</th><th>Artikelbeschreibung</th><th>Preis</th><th>Anzahl</th><th>Gesamtpreis</th></tr>
					<tr><td>Festival</td><td>Beschreibung</td><td>Preis</td><td>Anzahl</td><td>Preis*Anzahl</td></tr>
				</table>
			</form>
			
		</div>
		<div id="leer"></div>
		<div id="footer"></div>
	</div>
</body>
</html>