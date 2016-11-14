<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
    
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_festivalAnlegen.jsp
	# JSP-Aktionen: (1) Erzeugung von Eingabefeldern zum Anlegen von neuen Festivals
	#				(2) Weitergabe der Daten an das Servlet "Festivalverwaltung.java" 
	#				(3) Anzeige der Antwort aus dem Servlet
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
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="festivalAnlegen"/>
    </jsp:include>
	<div id="main">
	<form action="/Festiva/Festivalverwaltung?aktion=anlegen" method="POST" enctype="multipart/form-data">
	<div class="zeile">
		<h1>Festival anlegen</h1>
		<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
		<% if (request.getSession().getAttribute("antwort") != null) 
		{ %>
		<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
		<% request.getSession().removeAttribute("antwort");}  %>
		<div class="spaltelinks">
			<label for="bild">Bild</label>
			<input type="file" name="bild" accept="image/*">
			<label for="name">Festivalname*</label>
			<input type="text" name="name" title="Bitte wählen Sie einen passenden Namen!" required="required" maxlength="30">
			<label for="ort">Ort*</label>
			<input type="text" name="ort" required="required" title="Bitte geben Sie den Ort, an dem das Festival stattfindet, an!" maxlength="30">	
			<label for="kategorie">Kategorie*</label>	
				<select id="kategorie" name="kategorie" title="Bitte ordnen Sie das Festival einer Kategorie zu!">
				<%for (Kategorie kategorie : listKategorien) { %>
				<option value="<%=kategorie.id%>"><%=kategorie.name%></option>
				<% } %>
				</select>
			<label for="startdatum">Startdatum*</label>
			<input type="text" name="startdatum" placeholder="TT.MM.JJJJ" title="Bitte geben Sie das Datum im Format TT.MM.JJJJ ein!" required="required" maxlength="30" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}">		
			<label for="enddatum">Enddatum*</label>
			<input type="text" name="enddatum" placeholder="TT.MM.JJJJ" title="Bitte geben Sie das Datum im Format TT.MM.JJJJ ein!" required="required" maxlength="30" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}">
		</div>
		<div class="spalterechts">		
			<label for="kurzbeschreibung">Kurzbeschreibung*</label>
			<textarea rows="4" cols="25" name="kurzbeschreibung" title="Bitte geben Sie eine Kurzbeschreibung ein!" required="required"></textarea>
			<label for="langbeschreibung">Langbeschreibung*</label>
			<textarea rows="6" cols="25" name="langbeschreibung" title="Bitte geben Sie eine Langbeschreibung ein!" required="required" ></textarea>
			<button type="submit">Anlegen</button>
		</div>
	</div>	
	</form>						
	<div id="leer"></div>			
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>
<% request.getSession().removeAttribute("listKategorien");} %>