<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: festivalverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Festival und die dazugeh�rigen Artikel suchen, anzeigen, anlegen, �ndern und l�schen.
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
else {
	List<Festival> listFestivals = (List<Festival>)request.getSession(false).getAttribute("listFestivals");
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
   		<jsp:param name="active" value="festivalverwaltung"/>
	</jsp:include>
 	<div id="main">
			<h2>Festivalverwaltung</h2>
			<div id="spaltelinks">
				<button type="button" id="anlegen" onClick="window.location.href='a_festivalAnlegen.jsp'">Neues Festival anlegen</button>
			</div>
			<div id="zeile">
				<table>
					<thead><tr><th>ID</th><th>Name</th><th>Startdatum</th><th>Enddatum</th><th>Ort</th><th>Kategorie</th><th>Bild</th><th>Gel�scht</th></tr></thead>
					<%  SimpleDateFormat date = new SimpleDateFormat(" E, dd.MM.yy");
						for (Festival festival : listFestivals) { %>
					<tbody><tr>		
								<th data-label="Festival"><a href="/Festiva/Festivalverwaltung?aktion=aendern&festivalid=<%=festival.id%>"><%=festival.id%></a></td>
								<td data-label="Name"><%=festival.name%></td>
								<td data-label="Startdatum"><%=date.format(festival.startDatum)%></td>
								<td data-label="Enddatum"><%=date.format(festival.endDatum)%></td>
								<td data-label="Ort"><%=festival.ort%></td>
								<td data-label="Kategorie"><%=(KategorienAdministration.selektiereKategorie(festival.kategorienID)).name%></td>
								<%if (festival.bildpfad == null || (festival.bildpfad).equals("")) { %>
								<td data-label="Bild"><%="nein"%></td>
								<% } else { %>
								<td data-label="Bild"><%="ja"%></td>
								<% } %>
								<%if (festival.istGel�scht == false) { %>
								<td data-label="Gel�scht"><%="nein"%></td>
								<% } else { %>
								<td data-label="Gel�scht"><%="ja"%></td>
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
<% request.getSession().removeAttribute("listFestivals");}%>