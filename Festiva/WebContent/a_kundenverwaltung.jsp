<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" 
    session="false"	%>
 <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kundenverwaltung.jsp
	# JSP-Aktionen: Der Admin kann Kunden suchen, anzeigen, anlegen, ändern und löschen.
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
else {
	List<Benutzer> listBenutzer = (List<Benutzer>)request.getSession(false).getAttribute("listBenutzer");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
<div id="webseite">
	<jsp:include page="a_headerAdmin.jsp">
   		<jsp:param name="active" value="kundenverwaltung"/>
  	</jsp:include>	
    <div id="main">
    	<form action="kundenverwaltung.jsp" id="kundenverwaltung">
			<label class="h2" form="kundenverwaltung">Kundenverwaltung</label>
			<div id="spaltelinks">
				<button type="button" id="anlegen" onClick="window.location.href='a_kundenAnlegen.jsp'">Neuen Kunden anlegen </button>
			</div>
			<div id="spaltetabelle">
			<p>
				<table class="table">
					<tr><th>ID</th><th>Nachname</th><th>Vorname</th><th>E-Mail-Adresse</th><th>Gesperrt</th><th>Gelöscht</th></tr>
					<%for (Benutzer benutzer : listBenutzer) { %>
					<tr>
								
								<td><a href="/Festiva/Kundenverwaltung?aktion=aendern&kundenid=<%=benutzer.id%>"><%=benutzer.id%></a></td>
								<%if (benutzer.nachname == null) { %>
								<td><%=""%></td>
								<% } else { %>
								<td><%=benutzer.nachname%></td>
								<% } %>
								<%if (benutzer.vorname == null) { %>
								<td><%=""%></td>
								<% } else { %>
								<td><%=benutzer.vorname%></td>
								<% } %>
								<td><%=benutzer.eMailAdresse%></td>
								<%if (benutzer.istGesperrt == false) { %>
								<td><%="nein"%></td>
								<% } else { %>
								<td><%="ja"%></td>
								<% } %>
								<%if (benutzer.istGelöscht == false) { %>
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
<% request.getSession().removeAttribute("listBenutzer");}%>