<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Festiva - Kasse</title>
</head>
<body>
<div id="webseite">
	<jsp:include page="header.jsp">
   		<jsp:param name="active" value="warenkorb"/>
   	</jsp:include>
   	<div id="main">
   		<form>
			<label class="h2">Kasse</label>
			<div id="zeile">
				<div id="spaltelinks">
				<fieldset id="Lieferungsdaten" disabled>				
					<label class="h2">Lieferungsdaten</label><br/>
				    <label for="input1">Vorname</label> <input value=""><br/> 
				    <label for="input2">Nachname</label> <input value=""><br/>
				    <label for="input2">Straße</label> <input value=""><br/>
				    <label for="input2">Hausnummer</label> <input value=""><br/>
				    <label for="input2">PLZ</label> <input value=""><br/>
				    <label for="input2">Ort</label> <input value=""><br/>
				  </fieldset>
				</div>
				<div id="spalterechts">
					<fieldset id="Zahlungsdaten" disabled>
					  	<label class="h2">Zahlungsdaten</label><br/>
					    <label for="input1">IBAN:</label> <input value=""><br/> 
					    <label for="input2">BIC:</label> <input value=""><br/>
					</fieldset>
				</div>
			</div>
			<div id="zeile">
			<div id="spaltetabelle">
	   		<form id="table">
				<table class= "artikel">
					<tr><th>Festival</th><th>Artikeleschreibung</th><th>Preis</th><th>Anzahl</th><th>Gesamtpreis</th></tr>			
				</table>
				<button type="button" id ="links">Kaufen</button>
			</form>
			</div>
			</div>
		</form>
	<div id="leer"></div>
	</div>
	<div id="footer"></div>
</div>
</body>
</html>