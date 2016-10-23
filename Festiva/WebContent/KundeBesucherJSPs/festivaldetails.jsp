<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Festivaldetails</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="header.jsp">
    		<jsp:param name="active" value="shop"/>
    	</jsp:include>
    	<div id="main">
    		<div id="zeile"><h1>"Festivalname"</h1>
				<div id="spalte1">Foto
				</div>
				<div id="spalte2">
					<table class= "festival">
						<tr><td><b>Zeitraum:</b></td><td>TT.MM.JJJJ</td><td>TT.MM.JJJJ</td></tr>
						<tr><td><b>Ort:</b></td><td>Scheessel</td></tr>
						<tr><td><b>Beschreibung:</b></td><td>blabliblub</td></tr>
					</table>
				</div>
			</div>
			<form id="table">
				<label class="h2">Artikel</label>
				<table class= "artikel">
					<tr><th>Beschreibung</th><th>Preis</th><th>Anzahl</th></tr>
					<tr><td>Beschreibung selektieren</td><td>Preis selektieren</td><td><select><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td><td><button>In den Warenkorb</button></td></tr>
				</table>
				<div id="spalterechts">
						<button type="button" onClick="window.location.href='warenkorb.jsp'">Zum Warenkorb</button>
				</div>
			</form>
			<div id="leer"></div>
		</div>
	<div id="footer"></div>
	</div>	
</body>
</html>