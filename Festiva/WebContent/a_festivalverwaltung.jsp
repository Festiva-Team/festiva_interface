<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankh�nel
	# JSP-Name: a_festivalverwaltung.jsp
	# JSP-Aktionen: (1) Anzeige aller Festivals
					(2) Button zum Anlegen von neuen Festivals
					(3) ID-Link f�hrt zum �nderungsmodus
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
else {
	List<Festival> listFestivals = (List<Festival>)request.getSession(false).getAttribute("listFestivals");
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
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
  	<jsp:param name="active" value="festivalverwaltung"/>
</jsp:include>
 	<div id="main">
	<h1>Festivalverwaltung</h1>
	<form action="/Festiva/Festivalverwaltung?aktion=anlegenanzeigen" method="post">
	<div class="spaltelinks">
		<button type="submit" id="anlegen">Neues Festival anlegen</button>
	</div>
	</form>
	<div class="zeile">
		<table class="tabelle">
			<thead><tr><th>ID</th><th>Name</th><th>Startdatum</th><th>Enddatum</th><th>Ort</th><th>Kategorie</th><th>Bild</th><th>Gel�scht</th></tr></thead>
			<%  SimpleDateFormat date = new SimpleDateFormat(" E, dd.MM.yy");
			for (Festival festival : listFestivals) { %>
			<tbody>
			<tr>		
				<th data-label="Festival: "><a href="/Festiva/Festivalverwaltung?aktion=aendern&festivalid=<%=festival.id%>"><%=festival.id%></a></td>
				<td data-label="Name: "><%=festival.name%></td>
				<td data-label="Startdatum: "><%=date.format(festival.startDatum)%></td>
				<td data-label="Enddatum: "><%=date.format(festival.endDatum)%></td>
				<td data-label="Ort: "><%=festival.ort%></td>
				<%for(Kategorie kategorie : listKategorien){
 							  if(kategorie.id == festival.kategorienID){ %>
  							<td data-label="Kategorie: "><%=kategorie.name%></td>       
							<%  } } %>
				<%if (festival.bildpfad == null || (festival.bildpfad).equals("")) { %>
				<td data-label="Bild: "><%="Nein"%></td>
				<% } else { %>
				<td data-label="Bild: "><%="Ja"%></td>
				<% } %>
				<%if (festival.istGel�scht == false) { %>
				<td data-label="Gel�scht: "><%="nein"%></td>
				<% } else { %>
				<td data-label="Gel�scht: "><%="ja"%></td>
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
<% request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("listKategorien");}%>