<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.text.DecimalFormat"
    session="false"	%>
    
<%
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
		<form action="/Festiva/Artikelverwaltung?aktion=anlegen&festivalid=<%=festivalid%>" method="post">
			<label class="h2">Artikel anlegen</label>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<div id="spaltelinks">
			<label for="beschreibung">Beschreibung*</label>
			<input type="text" id="beschreibung" name="beschreibung" required="required" maxlength="100">
			<label for="preis">Preis in Euro*</label>
			<input type="number" step="0.01" min="0" id="preis" name="preis" required="required" maxlength="7"><br>
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
	<div id="footer">
	</div>
</div>	
</body>
</html>
<% } %>