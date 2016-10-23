<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Festiva - Meine Daten</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="header.jsp">
    	<jsp:param name="active" value="kundendaten"/>
    </jsp:include>
		<div id="main">
			<form action="kundendaten.jsp" id="kundendaten">
				<label class="h2">Meine Daten</label>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="vorname">Vorname</label>
					<input type="text" id="vorname" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="straße">Straße</label>
					<input type="text" id="straße" maxlength="50">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="nachname">Nachname</label>
					<input type="text" id="nachname" maxlength="40">
					</div>
					<div id="spalterechts">
					<label for="hausnummer">Hausnummer</label>
					<input type="text" id="hausnummer" minlength="1" maxlength="5">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="email">Email</label>
					<input type="email" id="email" maxlength="50">
					</div>
					<div id="spalterechts">
					<label for="plz">PLZ</label>
					<input type="text" id="plz" minlength="5" maxlength="5">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="iban">IBAN</label>
					<input type="text" id="iban" minlength="22" maxlength="22">
					</div>
					<div id="spalterechts">
					<label for="ort">Ort</label>
					<input type="text" id="ort" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="bic">BIC</label>
					<input type="text" id="bic" minlength="9" maxlength="12">
					</div>
					<div id="spalterechts">
					<button type="button" id="rechts">speichern</button>
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