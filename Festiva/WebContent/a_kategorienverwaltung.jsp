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
    	<form action="kategorienverwaltung.jsp" id="kategorienverwaltung">
	    	<label class="h2" form="kundenverwaltung">Kategorienverwaltung</label>
	    		<div id="spaltelinks">
				<button type="button" id="anlegen" onClick="window.location.href='a_kategorieAnlegen.jsp'"> Neue Kategorie anlegen </button>
				</div>
				<div id="spaltetabelle">
				<table class="table">
					<tr><th>ID</th><th>Name</th><th>Beschreibung</th><th>Bild</th><th>Gelöscht</th></tr>
					<%for (Kategorie kategorie : listKategorien) { %>
					<tr>
								
								<td><a href="/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=<%=kategorie.id%>"><%=kategorie.id%></a></td>
								<td><%=kategorie.name%></td>
								<td><%=kategorie.beschreibung%></td>
								<%if (kategorie.bildpfad == null || (kategorie.bildpfad).equals("")) { %>
								<td><%="nein"%></td>
								<% } else { %>
								<td><%="ja"%></td>
								<% } %>
								<%if (kategorie.istGelöscht == false) { %>
								<td><%="nein"%></td>
								<% } else { %>
								<td><%="ja"%></td>
								<% } %>
					</tr>
					<% } %>
				</table>
			</div>
		</form> 
	<div id="leer"></div>
	</div>  	
	<div id="footer">
	</div>
</div>
</body>
</html>
<% request.getSession().removeAttribute("listKategorien");}%>