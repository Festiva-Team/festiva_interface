<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
    
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAendern.jsp
	# JSP-Aktionen: Der Admin kann eine Kategorie ändern.
*/


if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");}	
else {
	SimpleDateFormat date = new SimpleDateFormat("dd.MM.yyyy");
	List<Kategorie> listKategorien = KategorienAdministration.selektiereAlleKategorien();
	Festival festival = (Festival)request.getSession(false).getAttribute("festival");
	List<Artikel> listArtikel = (List<Artikel>)request.getSession(false).getAttribute("listArtikel");
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
    	<jsp:param name="active" value="festivalAendern"/>
    </jsp:include>
		<div id="main">
			<form action="/Festiva/Festivalverwaltung?aktion=datenaendern&festivalid=<%=festival.id%>" method="POST" enctype="multipart/form-data">
			<label class="h2">Festival ändern</label>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
				 <div class="row">
					<div id="spaltelinks">
						<label for="name">Festivalname*</label>
						<input type="text" id="name" name="name" maxlength="30" required="required" value="<%=festival.name%>">
						<label for="ort">Ort*</label>
						<input type="text" id="ort" name="ort" maxlength="30" required="required" value="<%=festival.ort%>">				
						<label for="startdatum">Startdatum*</label>
						<input type="date" id="startdatum" name="startdatum" maxlength="30" required="required" value="<%=date.format(festival.startDatum)%>">
						<label for="kurzbeschreibung">Kurzbeschreibung*</label>
						<textarea rows="5" id="kurzbeschreibung" name="kurzbeschreibung" required="required" cols="25"><%=festival.kurzbeschreibung%></textarea>
					</div>
					<div id="spalterechts">
						<label for="kategorie">Kategorie*</label>	
						<select id="kategorie" name="kategorie">
						<%for (Kategorie kategorie : listKategorien) { 
							if(kategorie.id == festival.kategorienID) { %>
							<option selected="selected" value="<%=kategorie.id%>"><%=kategorie.name%></option>
							<% } else { %>
						<option value="<%=kategorie.id%>"><%=kategorie.name%></option>
						<% } } %>
						</select>
						<label for="bild">Neues Bild</label>
						<input type="file" id="bild" name="bild" accept="image/*">
						<label for="enddatum">Enddatum*</label>
						<input type="date" id="enddatum" name="enddatum" maxlength="30" required="required" value="<%=date.format(festival.endDatum)%>">
						<label for="langbeschreibung">Langbeschreibung*</label>
						<textarea rows="10" id="langbeschreibung" name="langbeschreibung" required="required" cols="25"><%=festival.langbeschreibung%></textarea>
						<button type="submit" id="links">Änderungen speichern</button>
					</div>
				</div>
				<div id="zeile">
					<div id="spalterechts">
					<table class= "artikel"><h2>Artikel</h2>
						<tr><th>ID</th><th>Beschreibung</th><th>Preis</th><th>Gelöscht</th></tr>
						<%for (Artikel artikel : listArtikel) { %>
						<tr>		
						<td><a href="/Festiva/Artikelverwaltung?aktion=aendern&artikelid=<%=artikel.id%>"><%=artikel.id%></a></td>
						<td><%=artikel.beschreibung%></td>
						<td><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
						<%if (artikel.istGelöscht == false) { %>
						<td><%="nein"%></td>
						<% } else { %>
						<td><%="ja"%></td>
						<% } %>
			</tr>
			<% } %>
					</table>
					</div>		
				</div>					
			</form>	
			<div id="spaltelinks">
				<button type="button" id="anlegen" onClick="window.location.href='a_artikelAnlegen.jsp?festivalid=<%=festival.id%>'">Neuen Artikel anlegen</button>
			</div>
			<form action="/Festiva/Festivalverwaltung?aktion=loeschen&festivalid=<%=festival.id%>" method="post">
			<div id="spaltelinks">
					<button type="submit" id="links">Festival löschen</button>
					</div>
					</form>
					<form action="/Festiva/Festivalverwaltung?aktion=aendern&festivalid=<%=festival.id%>&t=<%=new Date().getTime()%>" method="post">
					<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg").exists()) { %>
					<figure class="bild1">
					<img src="/Festiva/Bilder/<%=festival.bildpfad%>.jpg" name="bild" width=150 />
					<h5>Das aktuellste Bild wird noch nicht angezeigt? Bitte aktualisieren Sie die Seite.</h5>
					<button type="submit" id="links">Aktualisieren</button>
					</figure>
					<%} %>
					</form>	
					<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>		
		<div id="leer"></div>
		</div>
		<div id="footer"></div>
</div>	
</body>
</html>
<% request.getSession().removeAttribute("festival"); request.getSession().removeAttribute("listArtikel");}%>