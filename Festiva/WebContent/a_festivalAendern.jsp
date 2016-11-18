<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
    
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_festivalAendern.jsp
	# JSP-Aktionen: (1) Anzeige der aktuellen Festivaldaten
	#				(2a) Möglichkeit zum Ändern der Daten oder Löschen des Festivals
	#				(2b) Möglichkeit zum Anlegen neuer Artikel zu dem Festival
	#				(3a) Weitergabe der Daten an das Servlet "Festivalverwaltung.java" 
	#				(3b) Weiterleitung zum Servet "Artikelverwaltung.java"
	#				(4) Anzeige der Antwort aus dem Servlet
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
   	<jsp:param name="active" value="festivalAendern"/>
   </jsp:include>
	<div id="main">	
	<div class="zeile">
		<h1>Festival ändern</h1>
		<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
		<% if (request.getSession().getAttribute("antwort") != null) 
		{ %>
		<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
		<% request.getSession().removeAttribute("antwort");}  %>
	</div>	
		<div class="bild">
			<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg").exists()) { %>
				<img src="/Festiva/Bilder/<%=festival.bildpfad%>.jpg" id="imgAdministration" name="bild" width=150 />
				<button type="submit" id="bild" onClick="window.location.href='/Festiva/Festivalverwaltung?aktion=b_loeschen&festivalid=<%=festival.id%>'">Aktuelles Bild löschen</button>
			<% } else { %>
				<p>Kein Bild vorhanden</p>
			<% } %>
		</div>
		<form action="/Festiva/Festivalverwaltung?aktion=datenaendern&festivalid=<%=festival.id%>" method="POST" enctype="multipart/form-data">
		<div class="zeile">
			<div class="spaltelinks">
				<label for="bild">Neues Bild</label>
				<input type="file" name="bild" accept="image/*">
				<label for="name">Festivalname*</label>
				<input type="text" name="name" title="Bitte wählen Sie einen passenden Namen!" maxlength="30" required="required" value="<%=festival.name%>">	
				<label for="kategorie">Kategorie*</label>	
				<select id="kategorie" name="kategorie" title="Bitte ordnen Sie das Festival einer Kategorie zu!"> 
				<%for (Kategorie kategorie : listKategorien) { 
					if(kategorie.id == festival.kategorienID) { %>
					<option selected="selected" value="<%=kategorie.id%>"><%=kategorie.name%></option>
					<% } else { %>
				<option value="<%=kategorie.id%>"><%=kategorie.name%></option>
				<% } } %>
				</select><label for="ort">Ort*</label>
				<input type="text" name="ort" maxlength="30" title="Bitte geben Sie den Ort, an dem das Festival stattfindet, an!" required="required" value="<%=festival.ort%>">				
				<label for="startdatum">Startdatum*</label>
				<input type="text" name="startdatum" maxlength="30" placeholder="TT.MM.JJJJ" title="Bitte geben Sie das Datum im Format TT.MM.JJJJ ein!" required="required" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" value="<%=date.format(festival.startDatum)%>">
				<label for="enddatum">Enddatum*</label>
				<input type="text" name="enddatum" maxlength="30" placeholder="TT.MM.JJJJ" title="Bitte geben Sie das Datum im Format TT.MM.JJJJ ein!" required="required" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" value="<%=date.format(festival.endDatum)%>">
			</div>
			<div class="spalterechts">
				<label for="kurzbeschreibung">Kurzbeschreibung*</label>
				<textarea rows="4" name="kurzbeschreibung" title="Bitte geben Sie eine Kurzbeschreibung ein!" required="required" cols="25"><%=festival.kurzbeschreibung%></textarea>
				<label for="langbeschreibung">Langbeschreibung*</label>
				<textarea rows="6" name="langbeschreibung" title="Bitte geben Sie eine Langbeschreibung ein!" required="required" cols="25"><%=festival.langbeschreibung%></textarea>
				<label for="geloescht">Ist Gelöscht</label>
				<input type="checkbox" disabled="disabled" id="geloescht" name="geloescht" value="<%=festival.istGelöscht%>"
 					<% if (festival.istGelöscht == true) {%>
 					checked=<%="checked"%>title="Das Festival ist gelöscht."<%} else {%><%=""%>title="Das Festival ist nicht gelöscht."<%} %> >
				<button type="submit">Änderungen speichern</button>
			</div>
		</div>
			<div class="zeile">
				<div class="spaltelinks">
				<h1>Artikel</h1>
				<div class="spaltelinks">
					<button type="button" id="anlegen" <% if (festival.istGelöscht == true) {%> disabled="disabled" <% } %> onClick="window.location.href='a_artikelAnlegen.jsp?festivalid=<%=festival.id%>'">Neuen Artikel anlegen</button>
				</div>
				<table class="tabelle">
					<thead>
						<tr><th>ID</th><th>Beschreibung</th><th>Details</th><th>Preis</th><th>Gelöscht</th></tr></thead>
					<%for (Artikel artikel : listArtikel) { %>
					<tbody>	
					<tr>		
						<th data-label="Artikel: "><a href="/Festiva/Artikelverwaltung?aktion=aendern&artikelid=<%=artikel.id%>"><%=artikel.id%></a></th>
						<td data-label="Beschreibung: "><%=artikel.beschreibung%></td>
						<td data-label="Details: "><%=artikel.details%></td>
						<td data-label="Preis: " class="preis" width="10%"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
						<%if (artikel.istGelöscht == false) { %>
						<td data-label="Gelöscht: "><%="nein"%></td>
						<% } else { %>
						<td data-label="Gelöscht: "><%="ja"%></td>
						<% } %>
					</tr>
					</tbody>
					<% } %>
				</table>
				</div>		
			</div>					
		</form>	 
			<button type="submit"  onclick="del(<%=festival.id%>)" <% if (festival.istGelöscht == true) { %> disabled="disabled" <% } %>>Festival löschen</button>	
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
<script type="text/javascript">

function del(id){
	   if(confirm("Achtung! Wenn Sie das Festival löschen, werden automatisch alle dazugehörigen Artikel gelöscht. Möchten Sie fortfahren?") == true) {
		   document.location.href='/Festiva/Festivalverwaltung?aktion=loeschen&festivalid=' + id;
       } else {
    	   document.location.href='/Festiva/Festivalverwaltung?aktion=aendern&festivalid=' + id;
       }
}
</script>
</html>
<% request.getSession().removeAttribute("festival"); request.getSession().removeAttribute("listArtikel"); request.getSession().removeAttribute("listKategorien");}%>