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
				<label class="h2">Shop</label>
				<div id="zeile">
					<div id="spaltelinks">
						<label for="name">Name</label>
						<input type="search" id="name" name="name" maxlength="30">
					</div>
					<div id="spalterechts">
						<label for="ort">Ort</label>
						<input type="text" id="ort" name="ort" maxlength="30">
					</div>
				</div>
				<div id="zeile">
					<div id="spaltelinks">		
						<label for="kategorie">Kategorie
						<select><option value="Kategorie.name"></option></select>	
						</label>					
					</div>	
					<div id="spalterechts">
						<button type="submit" id="rechts">suchen</button>
					</div>
				</div>		
			<div id="content">
				<table>
					<tr>
						<th>Festival</th><th>Datum</th><th>Ort</th><th>Kateorie</th><th>Preis</th>
					</tr>
					<% 
					String sucheOrt= "";
					String sucheName = "";
					if (request.getSession().getAttribute("ort") != null)
						{ 
							sucheOrt = request.getSession().getAttribute("ort").toString();
						}
					
					if (request.getSession().getAttribute("name") != null)
					{
						 sucheName = request.getSession().getAttribute("name").toString();
					}
					
											
						List<FestivalSuchobjekt> festivalliste = FestivalAdministration.selektiereFestivalsInSuche(0, sucheOrt, sucheName, null, null, 0);
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
					%>
				</table>
			</div>
			</form>
		<div id="leer"></div>
		</div>
			<div id="footer"></div>
	</div>
</body>
</html> 