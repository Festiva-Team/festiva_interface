<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kundenverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Kunden suchen, anzeigen, anlegen, ändern und löschen.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="headerAdmin.jsp">
    		<jsp:param name="active" value="kundenverwaltung"/>
   		</jsp:include>	
    <div class="main">
    	<form action="kundenverwaltung.jsp" id="kundenverwaltung">
				<label class="h2" form="kundenverwaltung">Kundenverwaltung</label>
				<input type="button" name="anlegen" value="Anlegen" onClick="window.location.href='kundenAnlegen.jsp'" />
		</form>   	
		<table class="table">
			<tr>
				<th>Benutzer-ID</th>
				<th>EMail-Adresse</th>
				<th>Vorname</th>
				<th>Nachname</th>
				<th>Gruppe</th>
				<th>Gesperrt</th>
			</tr>
<% /** for(Anwender anwender : benutzerliste) 
			{
				String gruppe = (anwender.gruppeID == 1) ? "Kunde" : "Administrator";
				String gesperrtAktion = (anwender.istGesperrt) ? "entsperren" : "sperren";
				String gruppenAktion = (anwender.gruppeID == 1) ? "zuAdmin" : "zuKunde";   */ 
%>
		</table>
    	</div>
    	<div id="footer">
		</div>
    </div>

	
</body>
</html>