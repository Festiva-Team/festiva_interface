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
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Festiva - Kategorienverwaltung</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="headerAdmin.jsp">
    		<jsp:param name="active" value="kategorienverwaltung"/>
   		</jsp:include>
   		 <div class="main">
	    	<form action="kategorienverwaltung.jsp" id="kategorienverwaltung">
				<label class="h2" form="kundenverwaltung">Kategorienverwaltung</label><br>
				<button type="button" onClick="window.location.href='kategorieAnlegen.jsp'">Anlegen </button>
			</form>   	
    	 </div>
			<div id="footer">
			</div>
	</div>
</body>
</html>