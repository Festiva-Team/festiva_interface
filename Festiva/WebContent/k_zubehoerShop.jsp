<%@ page import = "standardPackage.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_zubehoerShop.jsp
	# JSP-Aktionen: (1) Anzeige aller Zubehörartikel
	 				(2) Möglichkeit max. 10 Einheiten eines Artikel in den Warenkorb zu legen 
					(2a) Aufruf des Servlet "Warenkorbverwaltung.java"
	 				(3) Weiterleitung zur Anmeldung, falls Besucher noch nicht angemeldet ist
*/ 
if (request.getSession(false) != null) {
	List<Integer> listArtikelID = null;
	List<Artikel> listArtikel = null;
	if(request.getSession(false).getAttribute("listArtikel") != null) {
	listArtikel = (List<Artikel>)request.getSession(false).getAttribute("listArtikel");
	}
	
	if(request.getSession(false).getAttribute("listArtikelID") != null) {
	listArtikelID = (List<Integer>)request.getSession(false).getAttribute("listArtikelID");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta charset="ISO-8859-1">
	<title>Festiva - Festival Zubehör</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
</head>
<body>
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<div id="webseite">
<jsp:include page="k_header.jsp">
	<jsp:param name="active" value="merchandiseShop"/>
</jsp:include>
	<div id="main">
	<h1>Festival Zubehör</h1>
	<input type="text" id="myInput" onkeyup="sucheNachZubehoer()" placeholder="Suche nach Artikel..." title="Geben Sie einen Namen ein!">
	<div class="zeile">
		<% if (request.getSession().getAttribute("antwort") != null) 		
		{ %> 
		<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>	
		<% request.getSession().removeAttribute("antwort");}  %>
	</div> 
		<div class="zeile">
			<table id="myTable" class="tabelle">	
					
				<%if(listArtikel != null && !listArtikel.isEmpty()) {									
					for (Artikel artikel : listArtikel)
					{%>
					<tbody>	
					<tr>
						<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg").exists()) { %>
						<td><a href="/Festiva/Produktverwaltung?aktion=a_anzeigen&artikelid=<%=artikel.id%>"><img src="/Festiva/Bilder/<%=artikel.bildpfad%>.jpg" name="bild" width=150 /></td>
						<% } else { %>
						<td data-label="">Kein Bild verfügbar</td>
						<% }	%>
						<td data-label="Beschreibung: "><a href="/Festiva/Produktverwaltung?aktion=a_anzeigen&artikelid=<%=artikel.id%>"><%=artikel.beschreibung%></a></td>
						<td data-label="Preis: " class="preis"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
						</tr>
					</tbody>
					<% } }%>
			</table>
		</div>	
		<div id="leer"></div>
		</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
	</div>
</body>
</html> 
<% request.getSession().removeAttribute("listArtikel"); request.getSession().removeAttribute("listArtikelID"); } %>