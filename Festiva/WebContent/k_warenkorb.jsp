<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" 
    session="false"	%>
    
<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 2) {
		response.sendRedirect("k_anmelden.jsp");} 
	else {
		Warenkorb warenkorb = (Warenkorb)request.getSession(false).getAttribute("warenkorb");
		List<Festival> listFestivals = (List<Festival>)request.getSession(false).getAttribute("listFestivals");
		int id = 1; 
		float gesamtsumme = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Warenkorb</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="k_header.jsp">
    		<jsp:param name="active" value="warenkorb"/>
    	</jsp:include>
    	<div id="main">
				<h2>Warenkorb</h2>
				<table class= "artikel">
					<thead><tr><th>ID</th><th>Festival</th><th>Artikelbeschreibung</th><th>Preis</th><th>Anzahl</th><th>Gesamtpreis</th></tr></thead>
					  <%for (Warenkorbelement warenkorbelement : warenkorb.listElemente) { %>
					<tbody><tr>
								<td data-label="ID"><%=id%></td>
								<% for (Festival festival : listFestivals) { 
									if (festival.id == warenkorbelement.artikel.festivalID) { %>
								<th data-label="Festival"><a href=""><%=festival.name%></a></td>
								<% } } %>
								<td data-label="Artikelbeschreibung"><%=warenkorbelement.artikel.beschreibung%></td>
								<td data-label="Preis"><%=String.format("%.2f",warenkorbelement.artikel.preis)%> &#8364;</td>
								<td data-label="Anzahl"> <select onchange="myFunction(this, <%=warenkorbelement.id%>);" id="menge<%=id%>" name="menge<%=id%>">
								<%for (int i=1; i<= 10; i++) { 
								  if(i == warenkorbelement.menge) { %>
								<option selected="selected" value="<%=i%>"><%=i%></option>
								<% } else { %>
								<option value="<%=i%>"><%=i%></option>
								<% } } %>
								</select></td>
								<td data-label="Gesamtpreis"><%=String.format("%.2f",(warenkorbelement.menge * warenkorbelement.artikel.preis))%> &#8364;</td>
								<td><button type="submit" id="Position löschen" onClick="window.location.href='/Festiva/Warenkorbverwaltung?aktion=loeschen&elementid=<%=warenkorbelement.id%>'">Position löschen</button>
								</td>
					</tr></tbody>
					<% id++; gesamtsumme = gesamtsumme + (warenkorbelement.menge * warenkorbelement.artikel.preis); } %>
					<tr><td></td><td></td><td></td><td></td><td></td><td><%=String.format("%.2f", gesamtsumme)%> &#8364;</td>
					</tr>
				</table>
				<div id="spalterechts">
						<button type="button" onClick="window.location.href='/Festiva/Warenkorbverwaltung?aktion=k_anzeigen'">Zur Kasse</button>
				</div>			
		</div>
		<div id="leer"></div>
		<footer></footer>
	</div>
</body>
<script type="text/javascript">
	function myFunction(objekt, id) {
	    var x = document.getElementById(objekt.id).value;
	    document.location.href='/Festiva/Warenkorbverwaltung?aktion=aendern&elementid=' + id + '&menge=' + x;
	}

</script>
</html>
<% request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("warenkorb");}%>