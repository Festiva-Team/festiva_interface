<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.text.DecimalFormat"
    session="false"	%>
    
<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");} 
else {
	DecimalFormat df = new DecimalFormat("0.00");
	Artikel artikel = (Artikel)request.getSession(false).getAttribute("artikel");
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="artikelAendern"/>
    </jsp:include>
	<div id="main">
		<form action="/Festiva/Artikelverwaltung?aktion=datenaendern&artikelid=<%=artikel.id%>" method="post">
			<label class="h2">Artikel ändern</label>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<div id="spaltelinks">
				<label for="beschreibung">Beschreibung*</label>
				<input type="text" id="beschreibung" name="beschreibung" maxlength="100" value="<%=artikel.beschreibung%>">
				<label for="preis">Preis in Euro*</label>
				<input type="number" step="0.01" min="0" id="preis" name="preis" maxlength="7" value="<%=artikel.preis%>"><br>				
				<button type="submit" id="links">Änderungen speichern</button>
			</div>
		</form>
		<form action="/Festiva/Artikelverwaltung?aktion=loeschen&artikelid=<%=artikel.id%>" method="post">
		<button type="submit" id="links">Artikel löschen</button>
		</form>
		<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>		
	</div>
	<div id="leer"></div>
	<div id="footer">
	</div>
</div>
</body>
</html>
<% request.getSession().removeAttribute("festival"); }%>