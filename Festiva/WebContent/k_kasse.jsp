<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" 
    session="false"	%>
  
<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 2) {
		response.sendRedirect("k_anmelden.jsp");}
	else {
		Warenkorb warenkorb = (Warenkorb)request.getSession(false).getAttribute("warenkorb");
		List<Festival> listFestivals = (List<Festival>)request.getSession(false).getAttribute("listFestivals");
		Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); 
		Boolean kundendatenVollstaendig = (Boolean)request.getSession(false).getAttribute("kundendatenVollstaendig");
		int id = 1; 
		float gesamtsumme = 0;
		Boolean perPost = false;
		
		if(request.getSession(false).getAttribute("perPost") != null) {
			perPost = (Boolean)request.getSession(false).getAttribute("perPost");
		} 
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
				    <label for="input2">Vorname: <%=benutzer.vorname%></label><br/>
				    <label for="input2">Nachname: <%=benutzer.nachname%></label><br/>
				    <label for="input2">Straße: <%=benutzer.strasse%></label><br/>
				    <label for="input2">Hausnummer: <%=benutzer.hausnummer%></label><br/>
				    <label for="input2">PLZ: <%=benutzer.plz%></label><br/>
				    <label for="input2">Ort: <%=benutzer.ort%></label><br/>
				  </fieldset>
				</div>
				<div id="spalterechts">
					<fieldset id="Zahlungsdaten" disabled>
					  	<h2>Zahlungsdaten</h2><br/>
					    <label for="input2">IBAN: <%=benutzer.iban%><br/> 
					    <label for="input2">BIC: <%=benutzer.bic%><br/>
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
								<% if (warenkorbelement.artikel.festivalID == 0) { %>
								<td data-label="Festival"><%=""%></td>
								<% }  else { %>
								<% for (Festival festival : listFestivals) { 
									if (festival.id == warenkorbelement.artikel.festivalID) { %>
								<td data-label="Festival"><%=festival.name%></td>
								<% } } } %>

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
 			 <input type="radio" id="versand" name="versand" value="mail" required="required" <% if(perPost.equals(false)) { %> checked="checked" <% }%> onclick="versenden(this)"> Per Mail <br>
 			 <input type="radio" id="versand" name="versand" value="post" required="required" <% if(perPost.equals(true)) { %> checked="checked" <% }%> onclick="versenden(this)"> Per Post 
 			 <button type="button" id="Verbindlich bestellen" onClick="window.location.href='/Festiva/Bestellverwaltung?aktion=anlegen'" <%if(kundendatenVollstaendig.equals(false)) { %> disabled="disabled" <% } %>>Verbindlich bestellen</button>
			 </form>
			 <%if(kundendatenVollstaendig.equals(false)) { %>
			 <p> Sie können Ihre Bestellung erst abschließen, wenn Sie alle Ihre persönlichen Daten (außer der BIC) hinterlegt haben. Hier können Sie Ihre Kundendaten anpassen: </p>
			 <% } else { %>
			 <p> Bitte kontrollieren Sie Ihre Angaben auf dieser Seite bevor Sie die Bestellung abschließen. Sie möchten Ihre Kundendaten anpassen? Dann klicken Sie bitte hier: </p>
			 <% } %>
			 <button type="button" id="Kundendaten aendern" onClick="window.location.href='/Festiva/Benutzerdaten?aktion=anzeigen'">Meine Daten</button>
				
			</div>
			</div>
	<div id="leer"></div>
	</div>
	<footer></footer>
</div>
</body>
<script type="text/javascript">
	
<!--
var arrObjRadio = new Array();
function versenden(objRadio){
// Falls der Radiobutton gesetzt ist und ein neuer Radiobutton gewählt wurde
if((objRadio.checked == true) && (objRadio != arrObjRadio[objRadio.name])){
// Aktuelles Objekt merken
arrObjRadio[objRadio.name] = objRadio;

// Änderungen durchführen
switch(objRadio.value){
  case "post"  : document.location.href='/Festiva/Warenkorbverwaltung?aktion=p_versand';
                       break;
  case "mail" : document.location.href='/Festiva/Warenkorbverwaltung?aktion=m_versand';
                       break;
}
}
}
//-->

</script>
</html>
<% request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("warenkorb"); request.getSession().removeAttribute("benutzer"); request.getSession().removeAttribute("perPost"); request.getSession().removeAttribute("kundendatenVollstaendig");}%>