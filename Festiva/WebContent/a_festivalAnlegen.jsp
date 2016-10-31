<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
    
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAnlegen.jsp
	# JSP-Aktionen: Der Admin kann eine neue Kategorie anlegen.
*/

if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");} 
else {
	List<Kategorie> listKategorien = KategorienAdministration.selektiereAlleKategorien();	
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
    	<jsp:param name="active" value="festivalAnlegen"/>
    </jsp:include>
	<div id="main">
		<form action="/Festiva/Festivalverwaltung?aktion=anlegen" method="POST" enctype="multipart/form-data">
			<h2>Festival anlegen</h2>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<div id="zeile1">
				<div id="spaltelinks">
					<label for="name">Festivalname*</label>
					<input type="text" id="name" name="name" required="required" maxlength="30">
					<label for="ort">Ort*</label>
					<input type="text" id="ort"  name="ort" required="required" maxlength="30">	
					<label for="startdatum">Startdatum*</label>
					<input type="text" id="startdatum" name="startdatum" required="required" maxlength="30" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}">
					<label for="kurzbeschreibung">Kurzbeschreibung*</label>
					<textarea rows="5" cols="25" id="kurzbeschreibung" name="kurzbeschreibung" required="required"></textarea>
				</div>
				<div id="spalterechts">
					<label for="kategorie">Kategorie*</label>	
						<select id="kategorie" name="kategorie">
						<%for (Kategorie kategorie : listKategorien) { %>
						<option value="<%=kategorie.id%>"><%=kategorie.name%></option>
						<% } %>
						</select>
					<label for="bild">Bild</label>
					<input type="file" id="bild" name="bild" accept="image/*">
					<label for="enddatum">Enddatum*</label>
					<input type="text" id="enddatum" name="enddatum" required="required" maxlength="30" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}">
					<label for="langbeschreibung">Langbeschreibung*</label>
					<textarea rows="10" cols="25" id="langbeschreibung" name="langbeschreibung" required="required" ></textarea>
					<button type="submit">Anlegen</button>
				</div>
			</div>	
			</form>	
			<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>	
					
	<div id="leer"></div>			
	</div>
	<footer></footer>
</div>	
</body>
</html>
<% } %>