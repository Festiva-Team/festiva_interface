<%@ page import = "standardPackage.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: shop.jsp
	# JSP-Aktionen: Besucher: kann Festivals suchen und sich anzeigen lassen
							  kann sich die Artikel zu einem Festival anzeigen lasen
	      angemeldeter Kunde: kann Festivals suhen und sich anzeigen lassen
	      					  kann sich die Artikel zu einem Festval anzeigen lassen und in den Warenkorb legen oder aus dem Warenkorb löschen.
	      					  kann die Artikelanzahl ändern
	      					  kann einen Artikel kaufen
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
	<div id="webseite">
		<jsp:include page="k_header.jsp">
    		<jsp:param name="active" value="shop"/>
    	</jsp:include>
		<div id="main">
			<form action="/Festiva/Ticketverwaltung?aktion=t_anzeigen" method="post">
				<div id="zeile1">
				<h2>Ticket Shop</h2>
					<div id="spaltelinks">					
						<label for="name">Name</label>
						<input type="search" id="name" maxlength="30" name="name" <% if(suchKriterien.name != null) { %> value="<%=suchKriterien.name%>" <% } %>>
						<label for="kategorie">Kategorie</label>
						<select id="kategorie" name="kategorie">
						<option value=0></option>
						<%for (Kategorie kategorie : listKategorien) { 
							if(suchKriterien.kategorienID != 0 && kategorie.id == suchKriterien.kategorienID) { %>
							<option selected="selected" value="<%=kategorie.id%>"><%=kategorie.name%></option>
							<% } else { %>
						<option value="<%=kategorie.id%>"><%=kategorie.name%></option>
						<% } } %>
						</select>	
						<label for="name">Ort</label>
						<input type="text" id="ort" maxlength="30" name="ort" <% if(suchKriterien.ort != null) { %> value="<%=suchKriterien.ort%>" <% } %>>
						
						</div>
					<div id="spalterechts">						
						<label for="startdatum">Startdatum</label>
						<input type="text" id="startdatum" maxlength="30" placeholder="TT.MM.JJJJ" name="startdatum" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" <% if(suchKriterien.startDatum != null) { %> value="<%=datum.format(suchKriterien.startDatum)%>" <% } %>>
													
						<label for="enddatum">Enddatum</label>
						<input type="text" id="enddatum" maxlength="30" placeholder="TT.MM.JJJJ" name="enddatum" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" <% if(suchKriterien.endDatum != null) { %> value="<%=datum.format(suchKriterien.endDatum)%>" <% } %>>
						
						
						<label for="preis">Maximaler Preis</label>
						<input type="number" step="0.01" min="0" id="preis" maxlength="8" placeholder="0,00" name="maxpreis" <% if(suchKriterien.bisPreis != 0) { %> value="<%=suchKriterien.bisPreis%>" <% } %>>
						
						<button type="submit">Suchen</button>
					</div>
				</div>		
				<table>
					<thead>
					<tr><th>Festival</th><th>Datum</th><th>Ort</th><th id="kategorie">Kateorie</th><th>Preis</th></tr></thead>
					<tbody>
					<% 	SimpleDateFormat sd = new SimpleDateFormat(" E, dd.MM.yy");
						for (FestivalSuchobjekt festival : listFestivals)
						{%>
							<tr>
							<td><a href="/Festiva/Ticketverwaltung?aktion=f_anzeigen&festivalid=<%=festival.id%>&maxpreis=<%=suchKriterien.bisPreis%>"><%=festival.name%></a></td>
								<% if (festival.startDatum.compareTo(festival.endDatum) == 0)
								{%>
								<td><%=sd.format(festival.startDatum)%></td>
								<%}
								else
								{%>
								<td><%=sd.format(festival.startDatum)%> - <%=sd.format(festival.endDatum)%></td>
								<%} %>
								<td><%=festival.ort%></td>
								<%for(Kategorie kategorie : listKategorien){
     							  if(kategorie.id == festival.kategorienID){ %>
      							<td><%=kategorie.name%></td>       
   								<%  } } %>
								<% if (festival.vonPreis == 0)
								{%>
								<td>keine Tickets verfügbar</td>
								<%}
								else
								{%>
								<td> ab <%=String.format("%.2f",festival.vonPreis)%> &#8364;</td>
								<%} %>
							</tr><%
							}%>
					</tbody>
				</table>
				</table>
			</form>
		<div id="leer"></div>
		</div>
			<footer></footer>
	</div>
</body>
</html>
<% request.getSession().removeAttribute("listKategorien"); request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("suchKriterien");} %>