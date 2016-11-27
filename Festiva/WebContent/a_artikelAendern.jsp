<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.text.DecimalFormat" import="java.io.File" import="java.util.*" import="java.text.*"
    session="false"	%>
    
<%  
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_artikelAendern.jsp
	#               (1) Anzeige der aktuellen Artikeldaten
	#				(2) Möglichkeit zum Ändern der Daten oder Löschen des Artikels
*/

if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");} 
else {
	DecimalFormat df = new DecimalFormat("0.00");
	Artikel artikel = (Artikel)request.getSession(false).getAttribute("artikel");
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
<script type="text/javascript" src="durchfuehrenBestaetigenFunktionen.js"></script>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
	<jsp:param name="active" value="artikelAendern"/>
</jsp:include>
	<div id="main">		
	<h1>Artikel ändern</h1>
	<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
	<div class="zeile">
		<% if (request.getSession().getAttribute("antwort") != null) { %>
			<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
			<% request.getSession().removeAttribute("antwort");
			} %>
	</div>
	<form action="/Festiva/Artikelverwaltung?aktion=datenaendern&artikelid=<%=artikel.id%>" method="post" enctype="multipart/form-data">		
		<div class="spaltelinks">
			<label for="beschreibung">Beschreibung*</label>
			<input type="text" name="beschreibung" title="Bitte geben Sie eine Beschreibung ein!" maxlength="100" required="required" value="<%=artikel.beschreibung%>">
			<label for="details">Details*</label>
			<textarea rows="4" cols="25" name="details" title="Bitte geben Sie Artikeldetails ein!" required="required"><%=artikel.details%></textarea>
			<label for="preis">Preis in Euro*</label>
			<input type="number" step="0.01" min="0" name="preis" placeholder="0,00" title="Bitte geben Sie einen Preis ein!" maxlength="7" required="required" value="<%=artikel.preis%>"><br>				
			<% if(artikel.festivalID == 0 && artikel.id != 6) { %>
			<label for="bild">Bild</label>
			<input type="file" name = "bild" accept="image/*"><br>
			<% } if(artikel.id != 6) { %>
			<input type="checkbox" disabled="disabled" id="geloescht" name="geloescht" value="<%=artikel.istGelöscht%>"
		  	<% if (artikel.istGelöscht == true) {%>
		    checked=<%="checked"%> title="Der Artikel ist gelöscht." <%} else {%><%=""%>title="Der Artikel ist nicht gelöscht."<%} %> ><p id="checkbox">Ist Gelöscht</p>
		    <% } %>
			<button type="submit" id="links">Änderungen speichern</button>
		</div>
	</form>
		<%if(artikel.festivalID == 0 && artikel.id != 6) { %>
		<div class="spalterechts">
			<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg").exists()) { %>
			<img src="/Festiva/Bilder/<%=artikel.bildpfad%>.jpg" name="bild" width=150 />
			<% } else { %>
			<p>Kein Bild vorhanden</p>
			<% } %>
		</div>
			<% } if(artikel.festivalID == 0 && artikel.id != 6 && new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg").exists()) { %>
				<button type="submit" onClick="window.location.href='/Festiva/Artikelverwaltung?aktion=b_loeschen&artikelid=<%=artikel.id%>'">Aktuelles Bild löschen</button>
			<% } %> 
	<div class="zeile">
		<% if (artikel.id != 6) { %>
			<button type="submit" onclick="artikelLoeschen(<%=artikel.id%>)" <% if (artikel.istGelöscht == true) { %> disabled="disabled" <% } %>>Artikel löschen</button>
		<% } %>
	</div>
	<div id="leer"></div>	
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>
</body>
</html>
<% request.getSession().removeAttribute("festival"); }%>