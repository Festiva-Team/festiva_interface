<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
 <%
 /** 
	# Autor: Nicola Kloke, Alina Fankh�nel
	# JSP-Name: a_kategorieAendern.jsp
	#               (1) Anzeige der aktuellen Kategoriendaten
	#				(2) M�glichkeit zum �ndern der Daten oder L�schen der Kategorie, wenn ID > 5 (keine Stammkategorie)
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");}
else {
	Kategorie kategorie = (Kategorie)request.getSession(false).getAttribute("kategorie"); %>

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
<script type="text/javascript" src="durchfuehrenBestaetigenFunktionen.js"></script>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
	<jsp:param name="active" value="kategorieAendern"/>
</jsp:include>
	<div id="main">
	<form action="/Festiva/Kategorienverwaltung?aktion=datenaendern&kategorienid=<%=kategorie.id%>" method="POST" enctype="multipart/form-data">
		<div class="zeile">
			<h1>Kategorie �ndern</h1>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<% if (request.getSession().getAttribute("antwort") != null) 
			{ %>
			<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
			<% request.getSession().removeAttribute("antwort");}  %>
		<div class="spaltelinks">
			<label for="name">Kategorienname*</label>
			<input type="text" name="name" maxlength="30" title="Bitte w�hlen Sie einen passenden Namen!" required="required" value="<%=kategorie.name%>">
			<label for="beschreibung">Beschreibung*</label>
			<textarea rows="5" name="beschreibung" title="Bitte geben Sie eine Beschreibung ein!" required="required"><%=kategorie.beschreibung%></textarea>
			<label for="bild">Neues Bild</label>
			<input type="file" name="bild" accept="image/*">
			<output id="list"></output>	
			<% if(kategorie.id != 1 && kategorie.id != 2 && kategorie.id != 3 && kategorie.id != 4) { %>
			<input type="checkbox" disabled="disabled" id="geloescht" name="geloescht" value="<%=kategorie.istGel�scht%>"
		    <% if (kategorie.istGel�scht == true) {%>
		    checked=<%="checked"%> title="Die Kategorie ist gel�scht."<%} else {%><%=""%>title="Die Kategorie ist nicht gel�scht."<%} %> ><p id="checkbox">Ist Gel�scht</p>
     			<% } %>
			<button type="submit">�nderungen speichern</button>
		</div>
		<div class="spalterechts">
			<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg").exists()) { %>
			<figure class="bild1">
			<img src="/Festiva/Bilder/<%=kategorie.bildpfad%>.jpg" name="bild" width=250 />
			</figure>
			<% } else { %>
				<p>Kein Bild vorhanden</p>
			<% } %>
		</div> 	
	</div>
	</form>
	<% if(kategorie.id != 1 && kategorie.id != 2 && kategorie.id != 3 && kategorie.id != 4) { if(new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg").exists()) {%>
		<button type="submit" onClick="window.location.href='/Festiva/Kategorienverwaltung?aktion=b_loeschen&kategorienid=<%=kategorie.id%>'">Aktuelles Bild l�schen</button>
	<% } %>
	<button type="submit" onclick="kategorieLoeschen(<%=kategorie.id%>)" <% if (kategorie.istGel�scht == true) { %> disabled="disabled" <% } %>>Kategorie l�schen</button>
	<% } %>
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>
<% request.getSession().removeAttribute("kategorie");}%>