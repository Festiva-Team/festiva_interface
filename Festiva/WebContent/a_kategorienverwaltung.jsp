<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorienverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Kategorien suchen, anzeigen, anlegen, ändern und löschen.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kategorienverwaltung</title>
</head>
<body>
<div id="webseite">
	<jsp:include page="a_headerAdmin.jsp">
   		<jsp:param name="active" value="kategorienverwaltung"/>
  	</jsp:include>
  	<div id="main">
    	<form action="kategorienverwaltung.jsp" id="kategorienverwaltung">
	    	<label class="h2" form="kundenverwaltung">Kategorienverwaltung</label>
	    		<div id="spaltelinks">
				<button type="button" id="anlegen" onClick="window.location.href='a_kategorieAnlegen.jsp'">Anlegen </button>
				</div>
				<div id="spaltetabelle">
				<table class="table">
					<tr><th>Name</th><th>Beschreibung</th></tr>
				</table>	
			</div>
		</form> 
	<div id="leer"></div>
	</div>  	
	<div id="footer">
	</div>
</div>
</body>
</html>