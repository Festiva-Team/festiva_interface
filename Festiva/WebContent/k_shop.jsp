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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
			<form action="/Festiva/ShopSuche" method="post">
				<div id="zeile1">
				<h2>Shop</h2>
					<div id="spaltelinks">					
						<label for="name">Name</label>
						<%if (request.getSession().getAttribute("name") != null) 
						{%>
						<input type="search" id="name" maxlength="30" placeholder="Festivalname" name="name" value=<%=request.getSession().getAttribute("name").toString()%>>
						<%}
						else
						{%>
						<input type="search" id="name" maxlength="30" placeholder="Festivalname" name="name">
						<%}%>
						
						<label for="kategorie">Kategorie</label>	
						<select><option value="Kategorie.name"></option></select>
						<label for="name">Ort</label>
						<%if (request.getSession().getAttribute("ort") != null) 
						{%>
						<input type="text" id="ort" maxlength="30" name="ort" value=<%=request.getSession().getAttribute("ort").toString()%>>
						<%}
						else
						{%>
						<input type="text" id="ort" maxlength="30" name="ort">
						<%}%>
						</div>
					<div id="spalterechts">						
						<label for="datum">Startdatum</label>
						<%if (request.getSession().getAttribute("startdatum") != null) 
						{%>
						<input type="date" id="datum" maxlength="30" placeholder="Startdatum" name="startdatum" value=<%=request.getSession().getAttribute("startdatum").toString()%>>
						<%}
						else
						{%>
						<input type="date" id="datum" maxlength="30" placeholder="Startdatum" name="startdatum">
						<%}%>
							
						<label for="datum">Enddatum</label>
						<%if (request.getSession().getAttribute("enddatum") != null) 
						{%>
						<input type="date" id="datum" maxlength="30" name="enddatum" value=<%=request.getSession().getAttribute("enddatum").toString()%>>
						<%}
						else
						{%>
						<input type="date" id="datum" maxlength="30" name="enddatum">
						<%}%>
						
						<label for="preis">max Preis</label>
						<%if (request.getSession().getAttribute("maxPreis") != null) 
						{%>
						<input type="text" id="preis" maxlength="8" name="maxPreis" value=<%=request.getSession().getAttribute("maxPreis").toString()%>>
						<%}
						else
						{%>
						<input type="text" id="preis" maxlength="8" name="maxPreis">
						<%}%>
						
						<button type="submit">suchen</button>
					</div>
				</div>		
				<table>
					<thead>
					<tr><th>Festival</th><th>Datum</th><th>Ort</th><th id="kategorie">Kateorie</th><th>Preis</th></tr></thead>
					<tbody>
					<% 
					String sucheOrt= "";
					String sucheName = "";
					Date sucheStartdatum = null;
					Date sucheEnddatum = null;
					float sucheMaxPreis = 0;
					
					if (request.getSession().getAttribute("ort") != null)
						{ 
							sucheOrt = request.getSession().getAttribute("ort").toString();
						}
					
					if (request.getSession().getAttribute("name") != null)
					{
						 sucheName = request.getSession().getAttribute("name").toString();
					}
					
					if (request.getSession().getAttribute("startdatum") != null)
					{
						 //sucheStartdatum = Date.parse(request.getSession().getAttribute("startdatum").toString());
					}
					
					if (request.getSession().getAttribute("enddatum") != null)
					{
						 //sucheEnddatum = request.getSession().getAttribute("enddatum").toString();
					}
					
					if (request.getSession().getAttribute("maxPreis") != null)
					{
						 sucheMaxPreis = Float.parseFloat(request.getSession().getAttribute("maxPreis").toString());
					}
					
											
						List<FestivalSuchobjekt> festivalliste = FestivalAdministration.selektiereFestivalsInSuche(0, sucheOrt, sucheName, null, null, sucheMaxPreis);
						SimpleDateFormat sd = new SimpleDateFormat(" E, dd.MM.yy");
						for (FestivalSuchobjekt festival : festivalliste)
						{%>
							<tr>
								<td><%=festival.name%></td>
								<% if (festival.startDatum.compareTo(festival.endDatum) == 0)
								{%>
								<td><%=sd.format(festival.startDatum)%></td>
								<%}
								else
								{%>
								<td><%=sd.format(festival.startDatum)%> - <%=sd.format(festival.endDatum)%></td>
								<%} %>
								<td><%=festival.ort%></td>
								<td><%=festival.kategorienID%></td>
								<% if (festival.vonPreis == festival.bisPreis)
								{%>
								<td><%=String.format("%.2f",festival.vonPreis)%> &#8364;</td>
								<%}
								else
								{%>
								<td><%=String.format("%.2f",festival.vonPreis)%> &#8364; - <%=String.format("%.2f",festival.bisPreis)%> &#8364;</td>
								<%} %>
							</tr><%
							}
							request.getSession().removeAttribute("ort");
							request.getSession().removeAttribute("name");%>
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