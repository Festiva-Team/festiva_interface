<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kundenAendern.jsp
	# JSP-Aktionen: Der Admin kann die Kundendaten �ndern.
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
				<label class="h2">Kunden �ndern</label>
				<div id="zeile">
					<div id="spaltelinks">
						<label for="vorname">Vorname</label>
						<input type="text" id="vorname" maxlength="30">
						<label for="nachname">Nachname</label>
						<input type="text" id="nachname" maxlength="40">
						<label for="email">Email</label>
						<input type="email" id="email" maxlength="50">
						<label for="stra�e">Stra�e</label>
						<input type="text" id="stra�e" maxlength="50">
						<label for="hausnummer">Hausnummer</label>
						<input type="text" id="hausnummer" minlength="1" maxlength="5">
						<label for="plz">PLZ</label>
						<input type="text" id="plz" minlength="5" maxlength="5">
					</div>
					<div id="spalterechts">
						<label for="iban">IBAN</label>
						<input type="text" id="iban" minlength="22" maxlength="22">
						<label for="bic">BIC</label>
						<input type="text" id="bic" minlength="9" maxlength="12">
						<label for="passwort">neues Passwort</label>
						<input type="password" id="email" maxlength="30">
						<label for="passwort">neues Passwort best�tigen</label>
						<input type="password" id="email" maxlength="30">
						<label for="einzugserm�chtigungErteilt">Einzugserm�chtigung erteilt</label>
	      				<input type="checkbox" id="einzugserm�chtigungErteilt">
						<label for="gesperrt">gesperrt</label>
	      				<input type="checkbox" id="gesperrt"><br>
					</div>
				</div>
				<div id="leer"></div>
			</form>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>