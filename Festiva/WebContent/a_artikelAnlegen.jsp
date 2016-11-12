<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.text.DecimalFormat"
    session="false"	%>
    
<%	
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_artikelAnlegen.jsp
	# JSP-Aktionen: (1) Anlage eines neuen Artikels mit Beschreibung und Preis für Zubehörartikel
					(2) Anlage eines neuen Artikels mit Beschreibung, Preis und Bild für Festivalartikel
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
			
			<div id="spaltelinks">
			<h2>Artikel anlegen</h2>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<label for="beschreibung">Beschreibung*</label>
			<input type="text" id="beschreibung" name="beschreibung" title="Bitte geben Sie eine Beschreibung ein!" required="required" maxlength="100">
			<label for="preis">Preis in Euro*</label>
			<input type="number" step="0.01" min="0" id="preis" name="preis" placeholder="0,00" title="Bitte geben Sie einen Preis ein!" required="required" maxlength="7"><br>
			<% if(festivalid == 0) { %>
			<label for="bild">Bild</label>
			<input type="file" id = "bild" name = "bild" accept="image/*"><br>
			<% } %>
			<button type="submit" id="links">Anlegen</button>
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
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>
<% } %>