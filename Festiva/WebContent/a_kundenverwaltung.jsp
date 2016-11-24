<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" 
    session="false"	%>
 <%
 /** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_kundenverwaltung.jsp
	# JSP-Aktionen: (1) Button zum Anlegen von neuen Kunden
	#				(2) Suchfeld zur Kundensuche über Nachname
	#				(3) Abrufen einer Liste von allen Kunden
	#				(4) Tabellarische Darstellung der Kundendaten (Id, Nachname, Vorname, E-Mail, Gesperrt, Gelöscht)
	#				(5) Möglichkeit zur Administration (ändern, sperren, löschen) eines Kunden über ID-Link
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
else {
	List<Benutzer> listBenutzer = (List<Benutzer>)request.getSession(false).getAttribute("listBenutzer");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
	<jsp:param name="active" value="kundenverwaltung"/>
</jsp:include>	
    <div id="main">
  	<h1>Kundenverwaltung</h1>
		<button type="button" class="anlegen" onClick="window.location.href='a_kundenAnlegen.jsp'">Neuen Kunden anlegen </button>
	<div class="zeile">	
		<input type="text" id="myInput" onkeyup="sucheNachNamen()" placeholder="Suche nach Nachnamen..." title="Geben Sie einen Nachnamen ein!">
	</div>
	<div class ="zeile">
			<table id="myTable" class="tabelle" cellpadding="0"cellspacing="0" >
		<thead><tr><th>ID</th><th>Nachname</th><th>Vorname</th><th>E-Mail-Adresse</th><th>Gesperrt</th><th>Gelöscht</th></tr></thead>
		<%for (Benutzer benutzer : listBenutzer) { %>
		<tbody>
		<tr>	
			<th data-label="Kunde: "><a href="/Festiva/Kundenverwaltung?aktion=aendern&kundenid=<%=benutzer.id%>"><%=benutzer.id%></a></th>
			<%if (benutzer.nachname == null) { %>
			<td data-label="Nachname: "><%=""%></td>
			<% } else { %>
			<td data-label="Nachname: "><%=benutzer.nachname%></td>
			<% } %>
			<%if (benutzer.vorname == null) { %>
			<td data-label="Vorname: "><%=""%></td>
			<% } else { %>
			<td data-label="Vorname: "><%=benutzer.vorname%></td>
			<% } %>
			<td data-label="E-Mail: "><%=benutzer.eMailAdresse%></td>
			<%if (benutzer.istGesperrt == false) { %>
			<td data-label="Gesperrt: "><%="Nein"%></td>
			<% } else { %>
			<td data-label="Gesperrt: "><%="Ja"%></td>
			<% } %>
			<%if (benutzer.istGelöscht == false) { %>
			<td data-label="Gelöscht: "><%="Nein"%></td>
			<% } else { %>
			<td data-label="Gelöscht: "><%="Ja"%></td>
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
<% request.getSession().removeAttribute("listBenutzer");}%>