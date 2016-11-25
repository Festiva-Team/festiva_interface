<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
  	# Autor: Nicola Kloke, Alina Fankhänel
  	# JSP-Name: a_kategorieAnlegen.jsp
  	#               (1) Erzeugung von Eingabefeldern zum Anlegen von neuen Kategorien
	#				(2) Button zum Senden der Daten
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
		<div class="zeile">
			<h1>Kategorie anlegen</h1>		
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<% if (request.getSession().getAttribute("antwort") != null) 
			{ %>
			<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
			<% request.getSession().removeAttribute("antwort");}  %>
		</div>	
		<div class="spaltelinks">
			<label for="name">Kategorienname*</label>
			<input type="text" name="name" title="Bitte wählen Sie einen passenden Namen!" maxlength="30" required="required">
			<label for="beschreibung">Beschreibung*</label>
			<textarea rows="5" name="beschreibung" title="Bitte geben Sie eine Beschreibung ein!" required="required"></textarea>
			<label for="bild">Bild</label>
			<input type="file" name = "bild" accept="image/*"><br>
			<button type="submit">Anlegen</button>
		</div>
	</form>
	</div>
	<div id="leer"></div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>