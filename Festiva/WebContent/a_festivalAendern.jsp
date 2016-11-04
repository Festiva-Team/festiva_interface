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
	List<Kategorie> listKategorien = (List<Kategorie>)request.getSession(false).getAttribute("listKategorien");
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
			<h2>Festival ändern</h2>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
				 <div class="row">
						<div id="spaltelinks">
						<label for="bild">Bild</label>
						<figure class="bild1" >
						<img src="/Festiva/Bilder/<%=festival.bildpfad%>.jpg" name="bild" width=150/>
						</figure>	
						<label for="bild">Neues Bild</label>
						<input type="file" id="bild" name="bild" accept="image/*">
						<label for="name">Festivalname*</label>
						<input type="text" id="name" name="name" maxlength="30" required="required" value="<%=festival.name%>">	
						<label for="kategorie">Kategorie*</label>	
						<select id="kategorie" name="kategorie">
						<%for (Kategorie kategorie : listKategorien) { 
							if(kategorie.id == festival.kategorienID) { %>
							<option selected="selected" value="<%=kategorie.id%>"><%=kategorie.name%></option>
							<% } else { %>
						<option value="<%=kategorie.id%>"><%=kategorie.name%></option>
						<% } } %>
						</select><label for="ort">Ort*</label>
						<input type="text" id="ort" name="ort" maxlength="30" required="required" value="<%=festival.ort%>">				
						<label for="startdatum">Startdatum*</label>
						<input type="text" id="startdatum" name="startdatum" maxlength="30" required="required" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" value="<%=date.format(festival.startDatum)%>">
						<label for="enddatum">Enddatum*</label>
						<input type="text" id="enddatum" name="enddatum" maxlength="30" required="required" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" value="<%=date.format(festival.endDatum)%>">
						</div>
					<div id="spalterechts">
						<label for="kurzbeschreibung">Kurzbeschreibung*</label>
						<textarea rows="5" id="kurzbeschreibung" name="kurzbeschreibung" required="required" cols="25"><%=festival.kurzbeschreibung%></textarea>
						<label for="langbeschreibung">Langbeschreibung*</label>
						<textarea rows="10" id="langbeschreibung" name="langbeschreibung" required="required" cols="25"><%=festival.langbeschreibung%></textarea>
						<label for="geloescht">Ist Gelöscht</label>
					<input type="checkbox" disabled="disabled" id="geloescht" name="geloescht" value=
	      					   "<%=festival.istGelöscht%>"
	      					   <% if (festival.istGelöscht == true) {%>
	      					   checked=<%="checked"%><%} else {%><%=""%><%} %> >
						<button type="submit">Änderungen speichern</button>
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">
					<h2>Artikel</h2>
					<table class= "artikel">
					<thead>
						<tr><th>ID</th><th>Beschreibung</th><th>Preis</th><th>Gelöscht</th></tr></thead>
						<%for (Artikel artikel : listArtikel) { %>
					<tbody>	<tr>		
						<th data-label="Artikel"><a href="/Festiva/Artikelverwaltung?aktion=aendern&artikelid=<%=artikel.id%>"><%=artikel.id%></a></th>
						<td data-label="Beschreibung"><%=artikel.beschreibung%></td>
						<td data-label="Preis"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
						<%if (artikel.istGelöscht == false) { %>
						<td data-label="Gelöscht"><%="nein"%></td>
						<% } else { %>
						<td data-label="Gelöscht"><%="ja"%></td>
						<% } %>
			</tr></tbody>
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
					<button type="submit" <% if (festival.istGelöscht == true) { %> disabled="disabled" <% } %>>Festival löschen</button>
					</div>
					</form>
					<form action="/Festiva/Festivalverwaltung?aktion=aendern&festivalid=<%=festival.id%>&t=<%=new Date().getTime()%>" method="post">
					<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg").exists()) { %>
					<figure class="bild1">
					<h5>Das aktuellste Bild wird noch nicht angezeigt? Bitte aktualisieren Sie die Seite.</h5>
					<button type="submit">Aktualisieren</button>
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
<% request.getSession().removeAttribute("festival"); request.getSession().removeAttribute("listArtikel"); request.getSession().removeAttribute("listKategorien");}%>