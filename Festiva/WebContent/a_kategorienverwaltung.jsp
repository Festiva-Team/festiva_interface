<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankh�nel
	# JSP-Name: a_kategorienverwaltung.jsp
	# JSP-Aktionen: (1) Anzeige aller Kategorien
					(2) Button zum Anlegen von neuen Kategorien
					(3) ID-Link f�hrt zum �nderungsmodus
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
else {
	List<Kategorie> listKategorien = (List<Kategorie>)request.getSession(false).getAttribute("listKategorien");
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
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
  	<jsp:param name="active" value="kategorienverwaltung"/>
</jsp:include>
  	<div id="main">
   	<h1>Kategorienverwaltung</h1>
   		<div class="spaltelinks">
			<button type="button" id="anlegen" onClick="window.location.href='a_kategorieAnlegen.jsp'"> Neue Kategorie anlegen </button>
		</div>
		<input type="text" id="myInput" onkeyup="sucheNachNamen()" placeholder="Suche nach Namen..." title="Geben Sie einen Namen ein!">
		<div class="zeile">
		<table id="myTable" class="tabelle">
			<thead><tr><th>ID</th><th>Name</th><th>Beschreibung</th><th>Bild</th><th>Gel�scht</th></tr></thead>	
			<%for (Kategorie kategorie : listKategorien) { %>
			<tbody>
			<tr>		
				<th data-label="Kategorie: "><a href="/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=<%=kategorie.id%>"><%=kategorie.id%></a></td>
				<td data-label="Name: "><%=kategorie.name%></td>
				<td data-label="Beschreibung: "><%=kategorie.beschreibung%></td>
				<%if (kategorie.bildpfad == null || (kategorie.bildpfad).equals("")) { %>
				<td data-label="Bild: "><%="Nein"%></td>
				<% } else { %>
				<td data-label="Bild: "><%="Ja"%></td>
				<% } %>
				<%if (kategorie.istGel�scht == false) { %>
				<td data-label="Gel�scht: "><%="nein"%></td>
				<% } else { %>
				<td data-label="gel�scht: "><%="ja"%></td>
				<% } %>
			</tr>
			</tbody>	
			<% } %>
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
<% request.getSession().removeAttribute("listKategorien");}%>