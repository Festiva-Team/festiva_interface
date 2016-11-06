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
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
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
			<div id="zeile">
				<div id="spaltelinks">
					<h2>Kategorie anlegen</h2>		
					<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
					<label for="name">Kategorienname*</label>
					<input type="text" id="name" name="name" maxlength="30" required="required">
					<label for="beschreibung">Beschreibung*</label>
					<textarea rows="5" id="beschreibung" name="beschreibung" required="required"></textarea>
					<label for="bild">Bild</label>
					<input type="file" id = "bild" name = "bild" accept="image/*"><br>
					<button type="submit">Anlegen</button>
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
	<footer></footer>
</div>	
</body>
</html>