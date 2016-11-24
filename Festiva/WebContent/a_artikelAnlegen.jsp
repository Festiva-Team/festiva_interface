<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.text.DecimalFormat"
    session="false"	%>
    
<%	
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_artikelAnlegen.jsp
	# JSP-Aktionen: (1a) Erzeugung von Eingabefeldern zum Anlegen von neuen Artikeln für ein Festival
	#				(1b) Erzeugung von Eingabefeldern zum Anlegen von neuen Artikeln inkl. Bild für einen Zubehörartikel
	#				(2) Button zum Senden der Daten  
*/

if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");}
else {
	int festivalid = 0;
	if(request.getParameter("festivalid") != null) {
	festivalid = Integer.parseInt(request.getParameter("festivalid"));}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
	<jsp:param name="active" value="artikelAnlegen"/>
</jsp:include>
	<div id="main">
	<form action="/Festiva/Artikelverwaltung?aktion=anlegen&festivalid=<%=festivalid%>" method="post" enctype="multipart/form-data">		
	<div class="zeile">
		<h1>Artikel anlegen</h1>
		<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
		<% if (request.getSession().getAttribute("antwort") != null) 
		{ %>
		<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
		<% request.getSession().removeAttribute("antwort");}  %>
		<div class="spaltelinks">
			<label for="beschreibung">Beschreibung*</label>
			<input type="text" name="beschreibung" title="Bitte geben Sie eine Beschreibung ein!" required="required" maxlength="100">
			<label for="details">Details*</label>
			<textarea rows="4" cols="25" name="details" title="Bitte geben Sie Artikeldetails ein!" required="required"></textarea>
			<label for="preis">Preis in Euro*</label>
			<input type="number" step="0.01" min="0" name="preis" placeholder="0,00" title="Bitte geben Sie einen Preis ein!" required="required" maxlength="7"><br>
			<% if(festivalid == 0) { %>
			<label for="bild">Bild</label>
			<input type="file" name = "bild" accept="image/*"><br>
			<% } %>
			<button type="submit">Anlegen</button>
		</div>
	</div>
	</form>		
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>
<% } %>