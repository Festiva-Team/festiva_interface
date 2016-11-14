<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
    
<%  
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_bestellungen.jsp
	# JSP-Aktionen: (1) Anzeige aller vergangenen Bestellungen des Kunden               
*/
	if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 2) {
	response.sendRedirect("k_anmelden.jsp");}
	else {
	int id = 1; 
	float gesamtsumme = 0;
	SimpleDateFormat date = new SimpleDateFormat("dd.MM.yyyy HH:mm");
	List<Bestellung> listBestellungen = (List<Bestellung>)request.getSession(false).getAttribute("listBestellungen");
	List<Festival> listFestivals = (List<Festival>)request.getSession(false).getAttribute("listFestivals");
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
<title>Festiva - Meine Daten</title>
</head>
<body>
<div id="webseite">
<jsp:include page="k_header.jsp">
	<jsp:param name="active" value="warenkorb"/>
</jsp:include>
   	<div id="main">
		<h1>Meine vergangenen Bestellungen</h1>
		<br/><br/>
		<% for (Bestellung bestellung : listBestellungen) {%>
		<h4 id="h4Bestellung">Ihre Bestellung vom <%=date.format(bestellung.datum)%> Uhr:</h4>
		<table class= "tabelle">
			<thead><tr><th>Position</th><th>Festival</th><th>Artikelbeschreibung</th><th>Preis</th><th>Anzahl</th><th>Gesamtpreis</th></tr></thead>
			 <%for (Bestellposition bestellposition : bestellung.listPositionen) { %>
			<tbody>
			<tr>
				<td data-label="ID: "><%=id%></td>
				<% for(Artikel artikel : listArtikel) {
				   if (bestellposition.artikelID == artikel.id) {
					   if(artikel.festivalID == 0) { %>
			    <td data-label="Festival: "><%=""%></td>   
				<%} else {
				    for(Festival festival : listFestivals) {
					   if (festival.id == artikel.festivalID) { %>
				<td data-label="Festival: "><%=festival.name%></td>
					<% }}}}} %>
				<td data-label="Artikel: "><%=bestellposition.beschreibung%></td>
				<td data-label="Preis: "><%=String.format("%.2f",bestellposition.preis)%> &#8364;</td>
				<td data-label="Anzahl: "><%=bestellposition.menge%></td>
				<td data-label="Gesamtpreis: "><%=String.format("%.2f",(bestellposition.menge * bestellposition.preis))%> &#8364;</td>
			</tr>
			</tbody>
			<% id++; gesamtsumme = gesamtsumme + (bestellposition.menge * bestellposition.preis); } %>
			<tfoot><tr><th></th><th></th><th></th><th></th><th></th><th data-label="Gesamtsumme: "><%=String.format("%.2f", gesamtsumme)%> &#8364;</th></tr></tfoot>
		</table>
		<br/><br/><br/><br/>
		<% id = 1; gesamtsumme = 0;} %>
	</div>
	<div id="leer"></div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>
</body>
</html>
<% request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("listArtikel"); request.getSession().removeAttribute("listBestellungen"); } %>
