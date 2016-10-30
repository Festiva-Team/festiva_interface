<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAnlegen.jsp
	# JSP-Aktionen: Der Admin kann eine neue Kategorie anlegen.
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
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
    	<jsp:param name="active" value="kategorieAnlegen"/>
    </jsp:include>
	<div id="main">
		<form action="/Festiva/Kategorienverwaltung?aktion=anlegen" method="POST" enctype="multipart/form-data">
			<label class="h2" form="kategorieAnlegen">Kategorie anlegen</label>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<div id="zeile">
				<div id="spaltelinks">
					<label for="name">Kategorienname*</label>
					<input type="text" id="name" name="name" maxlength="30">
					<label for="beschreibung">Beschreibung*</label>
					<input type="text" id="beschreibung" name="beschreibung" maxlength="100">
					<label for="bild">Bild</label>
					<input type="file" id = "bild" name = "bild" accept="image/*"><br>
					<button type="submit" id="links">Anlegen</button>
				</div>
			</div>
		</form>
		<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>	
	<div id="leer"></div>
	</div>
	<div id="footer">
	</div>
</div>	
</body>
</html>