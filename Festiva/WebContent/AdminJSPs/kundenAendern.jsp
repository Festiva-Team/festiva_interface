<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kundenAendern.jsp
	# JSP-Aktionen: Der Admin kann die Kundendaten ändern.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="headerAdmin.jsp">
    	<jsp:param name="active" value="kundenAendern"/>
    </jsp:include>
		<div id="main">
			<form action="kundenAendern.jsp" id="kundenAendern">
				<label class="h2" form="festivalAendern">Kunden ändern</label>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="name">Vorname</label>
					<input type="text" id="name" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="name">IBAN</label>
					<input type="text" id="ort" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="bild">Nachname</label>
					<input type="image" id="bild" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="datum">BIC</label>
					<input type="date" id="datum" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="kategorie">Email</label>
					<input type="text" id="kategorie" maxlength="30">
					</div>
					<div id="spalterechts">
					<label for="datum">Neues Passwort</label>
					<input type="date" id="datum" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="name">Straße</label>
					<input type="text" id="beschreibung" maxlength="200">
					</div>
					<div id="spalterechts">
					<label for="name">Neues Passwort bestätigen</label>
					<input type="text" id="beschreibung" maxlength="1000">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="name">Hausnummer</label>
					<input type="text" id="beschreibung" maxlength="200">
					</div>
					<div id="spalterechts">
					<label for="name">Einzugsermächtigung erteilt</label>
					<input type="text" id="beschreibung" maxlength="1000">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="name">PLZ</label>
					<input type="text" id="beschreibung" maxlength="200">
					</div>
					<div id="spalterechts">
					<label for="name">gesperrt</label>
					<input type="text" id="beschreibung" maxlength="1000">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<label for="name">Ort</label>
					<input type="text" id="beschreibung" maxlength="200">
					</div>
				</div>
			</form>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>