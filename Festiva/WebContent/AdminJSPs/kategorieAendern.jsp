<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAendern.jsp
	# JSP-Aktionen: Der Admin kann eine Kategorie ändern.
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
    	<jsp:param name="active" value="kategorieAendern"/>
    </jsp:include>
		<div id="main">
<% /** 			<form action="kategorieAendern.jsp" id="kategorieAendern">
				<label class="h2" form="kategorieAnlegen">Kategorie ändern</label>
				<label>Kategorienname</label>
				<input type="text" value="Kategorie.name" maxlength="30">
				<label>Beschreibung</label>
				<input type="text" value="Kategorie.beschreibung" maxlength="100">
				<label for="bild">Bild</label>
				<input type="file" value="Kategorie.bildpfad"> 
				<button>anlegen</button>
			</form>
		*/	%>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>