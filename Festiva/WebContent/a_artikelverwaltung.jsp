<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_artikelverwaltung.jsp
	# JSP-Aktionen: (1) Abrufen einer Liste von allen Benutzern
	#				(2) Tabellarische Darstellung der Benutzerdaten (Id, EMail, Name, Vorname, Gruppe, Gesperrt)
	#				(3) Möglichkeit zur Administration (sperren, entsperren, befördern, degradieren) eines Benutzers bieten

*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
else {
	List<Artikel> listArtikel = (List<Artikel>)request.getSession(false).getAttribute("listArtikel");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Artikelverwaltung</title>
</head>
<body>
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
  	<jsp:param name="active" value="artikelverwaltung"/>
</jsp:include>
 	<div id="main">
	<h1>Festivalübergreifende Artikelverwaltung</h1>
	<div class="spaltelinks">
		<button type="button" onClick="window.location.href='a_artikelAnlegen.jsp?'" id="anlegen">Neuen Artikel anlegen</button>
	</div>
		<input type="text" id="myInput" onkeyup="sucheNachNamen()" placeholder="Suche nach Namen..." title="Geben Sie einen Namen ein!">					
	<div class="zeile">
	<div class="spaltelinks">
		<table id="myTable" class="tabelle">
		<thead>
			<tr><th>ID</th><th>Beschreibung</th><th>Preis</th><th>Bild</th><th>Gelöscht</th></tr></thead>
			<%for (Artikel artikel : listArtikel) { %>
		<tbody>	
		<tr>		
			<th data-label="Artikel: "><a href="/Festiva/Artikelverwaltung?aktion=aendern&artikelid=<%=artikel.id%>"><%=artikel.id%></a></th>
			<td data-label="Beschreibung: "><%=artikel.beschreibung%></td>
			<td data-label="Preis: "><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
			<%if (artikel.bildpfad == null || (artikel.bildpfad).equals("")) { %>
			<td data-label="Bild: "><%="nein"%></td>
			<% } else { %>
			<td data-label="Bild: "><%="ja"%></td>
			<% } %>
			<%if (artikel.istGelöscht == false) { %>
			<td data-label="Gelöscht: "><%="nein"%></td>
			<% } else { %>
			<td data-label="Gelöscht: "><%="ja"%></td>
			<% } %>
		</tr>
		</tbody>
		<% } %>
		</table>
	</div>		
	</div>	
	<div id="leer"></div>
   	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>
</body>
</html>
<% request.getSession().removeAttribute("listArtikel"); }%>