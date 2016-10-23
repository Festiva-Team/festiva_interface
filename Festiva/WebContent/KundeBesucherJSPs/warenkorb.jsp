<%@page
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Warenkorb</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="header.jsp">
    		<jsp:param name="active" value="warenkorb"/>
    	</jsp:include>
    	<div id="main">
    		<form id="table">
				<label class="h2">Warenkorb</label>
				<table class= "artikel">
					<tr><th>Festival</th><th>Artikeleschreibung</th><th>Preis</th><th>Anzahl</th><th>Gesamtpreis</th></tr>
					<tr><td>Festival</td><td>Beschreibung</td><td>Preis</td><td><select><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td><td>Preis*Anzahl</td><td><button>löschen</button></td></tr>
				</table>
				<div id="spalterechts">
						<button type="button" onClick="window.location.href='kasse.jsp'">Zur Kasse</button>
				</div>
			</form>
			
		</div>
		<div id="leer"></div>
		<div id="footer"></div>
	</div>
</body>
</html>