<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" 
    session="false"	%>
  
<%  
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_kasse.jsp
	# JSP-Aktionen: (1) Anzeige der Liefer- und Zahlungsdaten des angemeldeten Kunden 
					(1a) Möglichkeit zum Ändern der Daten, Weiterleitung an "Benutzerdaten.java"
					(2) Darstellung aller Artikel des Warenkorbs und der Gesamtsumme
					(3) Möglichkeit zum Ändern der Versandart, Defaultwert: Mail
					(3a) Ausnahme: Mailversand ist nicht möglich, wenn sich Zubehörartikel im Warenkorb befinden
					(4) Nach Sicherheitsabfrage Möglichkeit zum Abschicken der Bestellung          
					(5) Nach Abschicken der Bestellung Weiterleitung zum Servlet "Bestellverwaltung.java" zur Anzeige der vergangenen Bestellungen
*/
	if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 2) {
		response.sendRedirect("k_anmelden.jsp");}
	else {
		Warenkorb warenkorb = (Warenkorb)request.getSession(false).getAttribute("warenkorb");
		List<Festival> listFestivals = (List<Festival>)request.getSession(false).getAttribute("listFestivals");
		Benutzer benutzer = (Benutzer)request.getSession(false).getAttribute("benutzer"); 
		Boolean kundendatenVollstaendig = (Boolean)request.getSession(false).getAttribute("kundendatenVollstaendig");
		int id = 1; 
		float gesamtsumme = 0;
		Boolean perPost = false;
		Boolean disabled = false;
		
		if(request.getSession(false).getAttribute("perPost") != null) {
			perPost = (Boolean)request.getSession(false).getAttribute("perPost");
		} 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<title>Festiva - Kasse</title>
</head>
<body>
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<div id="webseite">
	<jsp:include page="k_header.jsp">
   		<jsp:param name="active" value="warenkorb"/>
   	</jsp:include>
   	<div id="main">
	<div id="zeile">			
		<h1>Kasse</h1>
		<div class="zeile">	
			<%if(kundendatenVollstaendig.equals(false)) { %>
			<p id="antwortkasse"> Sie können Ihre Bestellung erst abschließen, wenn Sie alle Ihre persönlichen Daten (außer der BIC) hinterlegt und uns die Einzugsermächtigung erteilt haben. Hier können Sie Ihre Kundendaten anpassen:
			<button type="button" id="Kundendaten aendern" onClick="window.location.href='/Festiva/Benutzerdaten?aktion=anzeigen'">Meine Daten</button></p>
			<% } else { %>
			<p id="text"> Bitte kontrollieren Sie Ihre Angaben auf dieser Seite bevor Sie die Bestellung abschließen. Sie möchten Ihre Kundendaten anpassen? Dann klicken Sie bitte hier: 					 
			<button type="button" id="Kundendaten aendern" onClick="window.location.href='/Festiva/Benutzerdaten?aktion=anzeigen'">Meine Daten</button></p>
			<% } %>
			</div>
		<div class="spaltelinks">		
		<fieldset>
			<h2>Lieferdaten</h2>
			<label class="kasse">Name</label><p class="kasse"><%=benutzer.vorname%> <%=benutzer.nachname%></p>
			<label class="kasse">Adresse</label><p class="kasse"><%=benutzer.strasse%> <%=benutzer.hausnummer%></p>
		    <label class="kasse"></label><p class="kasse"><% if (benutzer.plz == 0) { } else { %> <%=benutzer.plz%> <% } %> <%=benutzer.ort%>  </p>
		</fieldset>
		</div>
		<div class="spalterechts">
		<fieldset>
		  	<h2>Zahlungsdaten</h2>
		    <label class="kasse">IBAN</label> <p class="kasse"><%=benutzer.iban%></p>
		    <label class="kasse">BIC</label> <p class="kasse"><%=benutzer.bic%></p>
		    <% if(benutzer.einzugsermächtigungErteilt == true) {%>
		    <p class="kasse"><b>Die Einzugsermächtigung wurde erteilt.</b></p>
		    <% } else { %>
		    <p class="kasse"><b>Die Einzugsermächtigung wurde noch nicht erteilt.</b></p>
		    <% } %>
		</fieldset>
		</div>
	</div>	
		 
	<div class="zeile">
	<h1>Bestellpositionen</h1>
	<table class="tabelle">
		<thead><tr><th>ID</th><th>Festival</th><th>Artikelbeschreibung</th><th>Preis</th><th>Anzahl</th><th>Gesamtpreis</th></tr></thead>
		  <%for (Warenkorbelement warenkorbelement : warenkorb.listElemente) { %>
		<tbody>
		<tr>
			<td data-label="ID: "><%=id%></td>
			<% if (warenkorbelement.artikel.festivalID == 0) { %>
			<td><%=""%></td>
			<% if(warenkorbelement.artikel.id != 6) { disabled = true; } }  else { %>
			<% for (Festival festival : listFestivals) { 
				if (festival.id == warenkorbelement.artikel.festivalID) { %>
			<td><%=festival.name%></td>
			<% } } } %>
			<td data-label="Artikel: "><%=warenkorbelement.artikel.beschreibung%></td>
			<td data-label="Preis: " id="preis"><%=String.format("%.2f",warenkorbelement.artikel.preis)%> &#8364;</td>
			<td data-label="Anzahl: "><%=warenkorbelement.menge%></td>
			<td data-label="Gesamtpreis: " id="preis"><%=String.format("%.2f",(warenkorbelement.menge * warenkorbelement.artikel.preis))%> &#8364;</td>		
		</tr>
		</tbody>
			<% id++; gesamtsumme = gesamtsumme + (warenkorbelement.menge * warenkorbelement.artikel.preis); } %>
		<tfoot><tr><th></th><th></th><th></th><th></th><th></th><th data-label="Gesamtsumme: " id="preis"><%=String.format("%.2f", gesamtsumme)%> &#8364;</th>
		</tr></tfoot>
	</table>	
	</div>
	<div class="zeile">
			<h1>Versand</h1>
			<form action="/Festiva/Bestellverwaltung?aktion=anlegen" method="post">
				<p id="text"><b>Hinweis:</b> Wenn Sie einen oder mehrere Zubehör-Artikel kaufen möchten, können Sie keinen Mail-Versand auswählen.</p>
				<div class="zeile"><input type="radio" id="versand" name="versand" value="mail" required="required" <% if(perPost.equals(false) && disabled.equals(false)) { %> checked="checked" <% }%> <% if(disabled.equals(true)) { %> readonly <% }%> onclick="versenden(this)" ><p id="checkbox">Per Mail</p></div>
				<div class="zeile"><input type="radio" id="versand" name="versand" value="post" required="required" <% if(perPost.equals(true) || disabled.equals(true)) { %> checked="checked" <% }%> <% if(disabled.equals(true)) { %> readonly <% }%> onclick="versenden(this)"><p id="checkbox">Per Post</p></div>
		   		<button type="submit" onclick="return confirm('Sind Sie sicher, dass alle Eingaben richtig sind und Sie die Bestellung endgültig abschließen möchten?')" <%if(kundendatenVollstaendig.equals(false) || warenkorb.listElemente.isEmpty() || (warenkorb.listElemente.size() == 1 && warenkorb.listElemente.get(0).artikel.id == 6) ) { %> disabled="disabled" <% } %>>Verbindlich bestellen</button>		
			</form>
		</div>
	
	<!--  			<form action="/Festiva/Bestellverwaltung?aktion=anlegen" method="post"> -->
								 
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>
</body>
<script type="text/javascript">
var arrObjRadio = new Array();
function versenden(objRadio){
// Falls der Radiobutton gesetzt ist und ein neuer Radiobutton gewählt wurde
if((objRadio.checked == true) && (objRadio != arrObjRadio[objRadio.name])){
// Aktuelles Objekt merken
arrObjRadio[objRadio.name] = objRadio;
// Änderungen durchführen
switch(objRadio.value){
  case "post"  : 
	            //document.location.href='/Festiva/Warenkorbverwaltung?aktion=p_versand';
	            post('/Festiva/Warenkorbverwaltung', {aktion: 'p_versand'});
                       break;
  case "mail" : 
	  			//document.location.href='/Festiva/Warenkorbverwaltung?aktion=m_versand';
  				post('/Festiva/Warenkorbverwaltung', {aktion: 'm_versand'});	
                       break;
}
}
}
</script>
</html>
<% request.getSession().removeAttribute("listFestivals"); request.getSession().removeAttribute("warenkorb"); request.getSession().removeAttribute("benutzer"); request.getSession().removeAttribute("perPost"); request.getSession().removeAttribute("kundendatenVollstaendig");}%>