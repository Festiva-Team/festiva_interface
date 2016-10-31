<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: festivalverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Festival und die dazugehörigen Artikel suchen, anzeigen, anlegen, ändern und löschen.
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
  		<form action="festivalverwaltung.jsp" id="festivalverwaltung">
			<label class="h2">Festivalverwaltung</label>
			<div id="spaltelinks">
				<button type="button" id="anlegen" onClick="window.location.href='a_festivalAnlegen.jsp'">Neues Festival anlegen</button>
			</div>
				<div id="spaltetabelle">
				<table class="table">
					<tr><th>ID</th><th>Name</th><th>Startdatum</th><th>Enddatum</th><th>Ort</th><th>Kategorie</th><th>Bild</th><th>Gelöscht</th></tr>
					<%  SimpleDateFormat date = new SimpleDateFormat(" E, dd.MM.yy");
						for (Festival festival : listFestivals) { %>
					<tr>		
								<td><a href="/Festiva/Festivalverwaltung?aktion=aendern&festivalid=<%=festival.id%>"><%=festival.id%></a></td>
								<td><%=festival.name%></td>
								<td><%=date.format(festival.startDatum)%></td>
								<td><%=date.format(festival.endDatum)%></td>
								<td><%=festival.ort%></td>
								<td><%=(KategorienAdministration.selektiereKategorie(festival.kategorienID)).name%></td>
								<%if (festival.bildpfad == null || (festival.bildpfad).equals("")) { %>
								<td><%="nein"%></td>
								<% } else { %>
								<td><%="ja"%></td>
								<% } %>
								<%if (festival.istGelöscht == false) { %>
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
<% request.getSession().removeAttribute("listFestivals");}%>