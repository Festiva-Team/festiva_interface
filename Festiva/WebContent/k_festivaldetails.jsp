<%@ page import = "standardPackage.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festivaldetails</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="k_header.jsp">
    		<jsp:param name="active" value="shop"/>
    	</jsp:include>
    	<div id="main">
    		<div id="zeile"><h1><%=request.getSession().getAttribute("name").toString() %></h1>
				<div id="spalte1">
				<%if (request.getSession().getAttribute("bildpfad") != null){  %>
					<figure class="bild1" >
					<img src="/Festiva/Bilder/<%=request.getSession().getAttribute("bildpfad").toString() %>.jpg" name="bild" width=150/>
					</figure>
				<%} %>
				</div>
				<div id="spalte2">
					<table class= "festival">
						<%SimpleDateFormat sd = new SimpleDateFormat(" E, dd.MM.yy");%>
						<tr><td><b>Zeitraum:</b></td><td><%=sd.format(request.getSession().getAttribute("startDatum"))%> - <%=sd.format(request.getSession().getAttribute("endDatum"))%></td></tr>
						<tr><td><b>Ort:</b></td><td><%=request.getSession().getAttribute("ort").toString()%></td></tr>
						<tr><td><b>Beschreibung:</b></td><td><%=request.getSession().getAttribute("kurzbeschreibung").toString() %></td></tr>
					</table>
				</div>
			</div>
			<% int festivalid = Integer.parseInt(request.getSession().getAttribute("festivalid").toString());
			float maxPreis = 0;
			String hilfs = request.getSession().getAttribute("maxPreis").toString();
			if (hilfs != "")
			{
				maxPreis = Float.parseFloat(request.getSession().getAttribute("maxPreis").toString());
			}
			
			if (maxPreis == 0 || ArtikelAdministration.selektiereArtikelVonFestivalÜberMaxPreis(festivalid, maxPreis).isEmpty())
			{%>
				<label class="h2">Artikel</label>
					<table class= "artikel">
						<tr><th>Beschreibung</th><th>Preis</th><th>Anzahl</th></tr>
						<%List<Artikel> Artikelliste = ArtikelAdministration.selektiereAlleArtikelVonFestival(festivalid);
				for (Artikel artikel : Artikelliste)
				{%>

						<tr>
							<td><%=artikel.beschreibung %></td>
							<td><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
							<td><select name = "anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
							<td><button type="submit">In den Warenkorb</button></td>
						</tr>

				<%} %>
					</table>
				<%} else
				{%>
				
				<label class="h2">Artikel</label>
				<p>
				Folgende Artikel sind unter Ihrem angegebenen Maximalpreis von <%=String.format("%.2f",maxPreis)%> &#8364;:
				</p>
					<table class= "artikel">
						<tr><th>Beschreibung</th><th>Preis</th><th>Anzahl</th></tr>
						<%List<Artikel> ArtikellisteBisMaxPreis = ArtikelAdministration.selektiereArtikelVonFestivalMitMaxPreis(festivalid, maxPreis);
				for (Artikel artikel : ArtikellisteBisMaxPreis)
				{%>

						<tr>
							<td><%=artikel.beschreibung %></td>
							<td><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
							<td><select name = "anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
							<td><button type="submit">In den Warenkorb</button></td>
						</tr>

				<%} %>
					</table>
					<p>
					Sie haben als Maximalpreis <%=String.format("%.2f",maxPreis)%> &#8364; angegeben. Folgende Artikel stehen auch noch zur Verfügung:
					</p>
					<table class= "artikel">
						<tr><th>Beschreibung</th><th>Preis</th><th>Anzahl</th></tr>
						<%List<Artikel> ArtikellisteUeberMaxPreis = ArtikelAdministration.selektiereArtikelVonFestivalÜberMaxPreis(festivalid, maxPreis);
				for (Artikel artikel : ArtikellisteUeberMaxPreis)
				{%>

						<tr>
							<td><%=artikel.beschreibung %></td>
							<td><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
							<td><select name = "anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
							<td><button type="submit">In den Warenkorb</button></td>
						</tr>

				<%} %>
					</table>
				<%} %>
				<div id="spalterechts">
						<button type="button" onClick="window.location.href='k_warenkorb.jsp'">Zum Warenkorb</button>
				</div>
			<div id="leer"></div>
		</div>
	<footer></footer>
	</div>	
</body>
<script type="text/javascript">

function antworten(antwort) {
window.alert("hii");
}

function einfuegen(id, elemente){
	
	if(elemente == null) {
		document.location.href='/Festiva/Warenkorbverwaltung?aktion=anmelden';
	} else {
   
			var vorhanden = false;
			for (var i = 0; i < elemente.length; i++) {
				if (elemente[i] == id) {
					vorhanden = true;
				}
			}
			
			var menge = document.getElementById('anzahl'+id).value;
			
			if(vorhanden == true) {
			if(confirm("Dieser Artikel befindet sich bereits in Ihrem Warenkorb. Soll die ausgewählte Menge trotzdem hinzugefügt werden?") == true)
		
				document.location.href='/Festiva/Warenkorbverwaltung?aktion=aktualisieren&artikelid=' + id + '&menge=' + menge;
			} else {
			
				document.location.href='/Festiva/Warenkorbverwaltung?aktion=hinzufuegen&artikelid=' + id + '&menge=' + menge;
				
			}	
	}
}
</script>
</html>