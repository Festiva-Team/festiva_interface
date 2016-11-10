<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorienverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Kategorien suchen, anzeigen, anlegen, ändern und löschen.
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
<div id="webseite">
	<jsp:include page="a_headerAdmin.jsp">
   		<jsp:param name="active" value="kategorienverwaltung"/>
  	</jsp:include>
  	<div id="main">
	    	<h2>Kategorienverwaltung</h2>
	    		<div id="spaltelinks">
				<button type="button" id="anlegen" onClick="window.location.href='a_kategorieAnlegen.jsp'"> Neue Kategorie anlegen </button>
				</div>
				<div id="zeile">
				<table>
				<thead><tr><th>ID</th><th>Name</th><th>Beschreibung</th><th>Bild</th><th>Gelöscht</th></tr></thead>	
					<%for (Kategorie kategorie : listKategorien) { %>
				<tbody><tr>
								
								<th data-label="Kategorie: "><a href="/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=<%=kategorie.id%>"><%=kategorie.id%></a></td>
								<td data-label="Name: "><%=kategorie.name%></td>
								<td data-label="Beschreibung: "><%=kategorie.beschreibung%></td>
								<%if (kategorie.bildpfad == null || (kategorie.bildpfad).equals("")) { %>
								<td data-label="Bild: "><%="Nein"%></td>
								<% } else { %>
								<td data-label="Bild: "><%="Ja"%></td>
								<% } %>
								<%if (kategorie.istGelöscht == false) { %>
								<td data-label="Gelöscht: "><%="nein"%></td>
								<% } else { %>
								<td data-label="gelöscht: "><%="ja"%></td>
								<% } %>
					</tr></tbody>	
					<% } %>
				</table>
			</div>
	<div id="leer"></div>
	</div>  	
	<footer></footer>
</div>
</body>
</html>
<% request.getSession().removeAttribute("listKategorien");}%>