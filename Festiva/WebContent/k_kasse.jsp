<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" 
    session="false"	%>
  
<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 2) {
		response.sendRedirect("k_anmelden.jsp");}
	else {
		Warenkorb warenkorb = (Warenkorb)request.getSession(false).getAttribute("warenkorb");
		List<Festival> listFestivals = (List<Festival>)request.getSession(false).getAttribute("listFestivals");
		Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); 
		int id = 1; 
		float gesamtsumme = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<title>Festiva - Kasse</title>
</head>
<body>
<div id="webseite">
	<jsp:include page="k_header.jsp">
   		<jsp:param name="active" value="warenkorb"/>
   	</jsp:include>
   	<div id="main">
			<div id="zeile">
				<div id="spaltelinks">
				<h2>Kasse</h2>
				<fieldset id="Lieferungsdaten" disabled>		
					<h2>Lieferdaten</h2><br/>
				    <label for="input2">Vorname</label> 
				    <input name="vorname" id="vorname" value="<%=benutzer.vorname%>"><br/> 
				    <label for="input2">Nachname</label> 
				    <input name="nachname" id="nachname" value="<%=benutzer.nachname%>"><br/>
				    <label for="input2">Straße</label> 
				    <input name="strasse" id="strasse" value="<%=benutzer.strasse%>"><br/>
				    <label for="input2">Hausnummer</label> 
				    <input name="hausnummer" id="hausnummer" value="<%=benutzer.hausnummer%>"><br/>
				    <label for="input2">PLZ</label> 
				    <input name="plz" id="plz" value="<%=benutzer.plz%>"><br/>
				    <label for="input2">Ort</label> 
				    <input name="ort" id="ort" value="<%=benutzer.ort%>"><br/>
				  </fieldset>
				</div>
				<div id="spalterechts">
					<fieldset id="Zahlungsdaten" disabled>
					  	<h2>Zahlungsdaten</h2><br/>
					    <label for="input2">IBAN:</label> <input name="iban" id="iban" value="<%=benutzer.iban%>"><br/> 
					    <label for="input2">BIC:</label> <input name="bic" id="bic" value="<%=benutzer.bic%>"><br/>
					</fieldset>
				</div>
			</div>
			 
			<div id="zeile">
			<h2>Bestellpositionen</h2><br/>
								<table class= "artikel">
					<thead><tr><th>ID</th><th>Festival</th><th>Artikelbeschreibung</th><th>Preis</th><th>Anzahl</th><th>Gesamtpreis</th></tr></thead>
					  <%for (Warenkorbelement warenkorbelement : warenkorb.listElemente) { %>
					<tbody><tr>
								<td data-label="ID"><%=id%></td>
								<% for (Festival festival : listFestivals) { 
									if (festival.id == warenkorbelement.artikel.festivalID) { %>
								<td data-label="Festival"><%=festival.name%></td>
								<% } } %>
								<td data-label="Artikelbeschreibung"><%=warenkorbelement.artikel.beschreibung%></td>
								<td data-label="Preis"><%=String.format("%.2f",warenkorbelement.artikel.preis)%> </td>
								<td data-label="Anzahl"><%=warenkorbelement.menge%></td>
								<td data-label="Gesamtpreis"><%=String.format("%.2f",(warenkorbelement.menge * warenkorbelement.artikel.preis))%> &#8364;</td>
								
					</tr></tbody>
					<% id++; gesamtsumme = gesamtsumme + (warenkorbelement.menge * warenkorbelement.artikel.preis); } %>
					<tr><td></td><td></td><td></td><td></td><td></td><td><%=String.format("%.2f", gesamtsumme)%> &#8364;</td>
					</tr>
				</table>
				<h2>Versand</h2><br/>
				<form action="">
 			 <input type="radio" id="mail" name="mail" value="mail" required="required" checked="checked" onchange="versenden()"> Per Mail <br>
 			 <input type="radio" id="post" name="post" value="post" required="required" onchange="versenden()"> Per Post (+2,50 &#8364;)
 			 <button type="button">Verbindlich bestellen</button>
			 </form>
				
			</div>
			</div>
	<div id="leer"></div>
	</div>
	<footer></footer>
</div>
</body>
<script type="text/javascript">
	function versenden(objekt) {
	    var x = document.getElementById(objekt.id).value;
	    
	    if(x == "post") {
	    	document.location.href='/Festiva/Warenkorbverwaltung?aktion=aendern&elementid=' + id + '&menge=' + x;
	    } else {
	    	
	    }
	}

</script>
</html>
<% request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("warenkorb"); request.getSession().removeAttribute("benutzer");}%>