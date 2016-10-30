<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
 <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAendern.jsp
	# JSP-Aktionen: Der Admin kann eine Kategorie ändern.
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");}
else {
	Kategorie kategorie = (Kategorie)request.getSession(false).getAttribute("kategorie"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kategorienverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="kategorieAendern"/>
    </jsp:include>
	<div id="main">
		<form action="/Festiva/Kategorienverwaltung?aktion=datenaendern&kategorienid=<%=kategorie.id%>" method="POST" enctype="multipart/form-data">
			<div id="zeile">
			<h2>Kategorie ändern</h2>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
				<div id="spaltelinks">
					<label for="name">Kategorienname*</label>
					<input type="text" id="name" name="name" maxlength="30" value="<%=kategorie.name%>">
					<label for="beschreibung">Beschreibung*</label>
					<textarea rows="5" id="beschreibung" name="beschreibung"><%=kategorie.beschreibung%></textarea>
					<label for="bild">Neues Bild</label>
					<input type="file" id = "bild" name = "bild" accept="image/*"><br>
					<button type="submit">Änderungen speichern</button>
				</div>
			</div>
		</form>
		<form action="/Festiva/Kategorienverwaltung?aktion=loeschen&kategorienid=<%=kategorie.id%>" method="post">
			<div id="spaltelinks">
					<button type="submit" id="links">Kategorie löschen</button>
					</div>
					</form>
					<form action="/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=<%=kategorie.id%>&t=<%=new Date().getTime()%>" method="post">
					<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg").exists()) { %>
					<figure class="bild1">
					<img src="/Festiva/Bilder/<%=kategorie.bildpfad%>.jpg" name="bild" width=150 />
					<h5>Das aktuellste Bild wird noch nicht angezeigt? Bitte aktualisieren Sie die Seite.</h5>
					<button type="submit">Aktualisieren</button>
					</figure>
					<%} %>
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
<% request.getSession().removeAttribute("kategorie");}%>