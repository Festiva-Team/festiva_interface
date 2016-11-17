<%@ page import = "standardPackage.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ page import="java.io.File" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_ticketShop.jsp
	# JSP-Aktionen: (1) Anzeige aller Festivals
	# 				(2) Möglichkeit zur Beschränkung der Anzeige durch Suche nach Name, Ort, Kategorie, Von- und Bis-Datum und Preis
	#				(3) Weiterleitung zum Servlet "Ticketverwaltung" bei Klick auf den Festivalnamen zur Anzeige der Festivaldetails und der zugehörigen Artikel		
*/
if (request.getSession(false) != null) {
	SimpleDateFormat datum = new SimpleDateFormat("dd.MM.yyyy");
	List<FestivalSuchobjekt> listFestivals = (List<FestivalSuchobjekt>)request.getSession(false).getAttribute("listFestivals");
	List<Kategorie> listKategorien = (List<Kategorie>)request.getSession(false).getAttribute("listKategorien");
	FestivalSuchobjekt suchKriterien = suchKriterien = (FestivalSuchobjekt)request.getSession(false).getAttribute("suchKriterien");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta charset="ISO-8859-1">
	<title>Festiva - Shop</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
</head>
<body>
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<div id="webseite">
<jsp:include page="k_header.jsp">
  	<jsp:param name="active" value="shop"/>
</jsp:include>
	<div id="main">
	<form action="/Festiva/Ticketverwaltung?aktion=t_anzeigen" method="post">
		<div class="zeile">
		<h1>Ticket Shop</h1>
			<div class="spaltelinks">					
				<label for="name">Name</label>
				<input type="search" id="name" maxlength="30" title="Hier können Sie den Namen des gesuchten Festivals angeben." name="name" <% if(suchKriterien.name != null) { %> value="<%=suchKriterien.name%>" <% } %>>
				<label for="kategorie">Kategorie</label>
				<select id="kategorie" name="kategorie" title="Hier können Sie nach den verfügbaren Kategorien selektieren.">
				<option value=0></option>
				<%for (Kategorie kategorie : listKategorien) { 
					if(suchKriterien.kategorienID != 0 && kategorie.id == suchKriterien.kategorienID) { %>
					<option selected="selected" value="<%=kategorie.id%>"><%=kategorie.name%></option>
					<% } else { %>
				<option value="<%=kategorie.id%>"><%=kategorie.name%></option>
				<% } } %>
				</select>	
				<label for="name">Ort</label>
				<input type="search" id="ort" maxlength="30" name="ort" title="Hier können Sie den Ort des gesuchten Festivals angeben." <% if(suchKriterien.ort != null) { %> value="<%=suchKriterien.ort%>" <% } %>>
			</div>
			<div class="spalterechts">						
				<label for="startdatum">Im Zeitraum von</label>
				<input type="text" id="startdatum" maxlength="30" title="Bitte geben Sie das Datum im Format TT.MM.JJJJ ein!" placeholder="TT.MM.JJJJ" name="startdatum" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" <% if(suchKriterien.startDatum != null) { %> value="<%=datum.format(suchKriterien.startDatum)%>" <% } %>>
											
				<label for="enddatum">bis</label>
				<input type="text" id="enddatum" maxlength="30" title="Bitte geben Sie das Datum im Format TT.MM.JJJJ ein!" placeholder="TT.MM.JJJJ" name="enddatum" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" <% if(suchKriterien.endDatum != null) { %> value="<%=datum.format(suchKriterien.endDatum)%>" <% } %>>
					
				<label for="preis">Maximaler Preis</label>
				<input type="number" step="0.01" min="0" title="Hier können Sie festlegen, wie viel Geld Sie maximal ausgeben möchten." maxlength="8" placeholder="0,00" name="maxpreis" <% if(suchKriterien.bisPreis != 0) { %> value="<%=suchKriterien.bisPreis%>" <% } %>>
				
				<button type="submit">Suchen</button>
			</div>
		</div>		
		<table class="tabelle">
			<thead>
			<tr><th></th><th>Festival</th><th>Datum</th><th>Ort</th><th id="kategorie">Kategorie</th><th>Preis</th></tr></thead>
			<tbody>
			<% 	if(listFestivals != null && !listFestivals.isEmpty()) {
				SimpleDateFormat sd = new SimpleDateFormat(" E, dd.MM.yy");
				for (FestivalSuchobjekt festival : listFestivals)
				{%>
				<tr>
				 <% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg").exists()) { %>
					<td><a href="/Festiva/Ticketverwaltung?aktion=f_anzeigen&festivalid=<%=festival.id%>&maxpreis=<%=suchKriterien.bisPreis%>"><img src="/Festiva/Bilder/<%=festival.bildpfad%>.jpg" name="bild" width=150 /></a></td>
					<% } else { %>
					<td data-label="">Kein Bild verfügbar</td>
					<% }	%>
				
			<td><a href="/Festiva/Ticketverwaltung?aktion=f_anzeigen&festivalid=<%=festival.id%>&maxpreis=<%=suchKriterien.bisPreis%>"><%=festival.name%></a></td> 
				<%-- <td><a href="javascript:zeigeDetails(<%=festival.id%>, <%=suchKriterien.bisPreis%>)"><%=festival.name%></a></td> --%>
				<% if (festival.startDatum.compareTo(festival.endDatum) == 0)
				{%>
				<td><%=sd.format(festival.startDatum)%></td>
				<%}
				else
				{%>
				<td data-label="Zeit: "><%=sd.format(festival.startDatum)%> - <%=sd.format(festival.endDatum)%></td>
				<%} %>
				<td data-label="Ort: "><%=festival.ort%></td>
				<%for(Kategorie kategorie : listKategorien){
 							  if(kategorie.id == festival.kategorienID){ %>
  							<td data-label="Kategorie: "><%=kategorie.name%></td>       
							<%  } } %>
				<% if (festival.vonPreis == 0)
				{%>
				<td data-label="Artikel: ">keine Tickets verfügbar</td>
				<%}
				else
				{%>
				<td data-label="Artikel: "> ab <%=String.format("%.2f",festival.vonPreis)%> &#8364;</td>
				<%} %>
				</tr>
				<%} }%>
			</tbody>
		</table>
	</form>
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>
</body>
<script type="text/javascript">
/* function zeigeDetails(id, preis) {
post('/Festiva/Ticketverwaltung', {aktion: 'f_anzeigen', festivalid: id, maxpreis: preis});	
} */
</script>
</html>
<% request.getSession().removeAttribute("listKategorien"); request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("suchKriterien");} %>