<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"%>
    
<%  SimpleDateFormat sd = new SimpleDateFormat(" EEEE, dd.MM.yyyy");
	List<Artikel> listArtikel = null;
	List<Artikel> listArtikelMitMaxPreis = null;
	List<Artikel> listArtikelUeberMaxPreis = null;
	List<Integer> listArtikelID = null;
	
	if (request.getSession(false) != null) {
	if(request.getSession(false).getAttribute("listArtikel") == null) {
		listArtikelMitMaxPreis = (List<Artikel>)request.getSession(false).getAttribute("listArtikelMitMaxPreis");
		listArtikelUeberMaxPreis = (List<Artikel>)request.getSession(false).getAttribute("listArtikelUeberMaxPreis");
	} else {
		listArtikel = (List<Artikel>)request.getSession(false).getAttribute("listArtikel");
	}
	if(request.getSession(false).getAttribute("listArtikelID") != null) {
		listArtikelID = (List<Integer>)request.getSession(false).getAttribute("listArtikelID");
		}
	float maxPreis = Float.parseFloat(request.getSession(false).getAttribute("maxpreis").toString());
	Festival festival = (Festival)request.getSession(false).getAttribute("festival");

 %> 
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
    		<div id="zeile"><h1><%=festival.name%></h1>
				<div id="spaltelinks">
				<%if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg").exists()) { %>
						<img src="/Festiva/Bilder/<%=festival.bildpfad%>.jpg" name="bild" width=150/>
						<% } else { %>
						<p>Kein Bild vorhanden</p>
				  		<% } %>
				</div>
				<div id="spalterechts">
					<table class= "festival">
						<tr><td><b>Zeitraum:</b></td><td> <%=sd.format(festival.startDatum)%>  -  <%=sd.format(festival.endDatum)%></td></tr>
						<tr><td><b>Ort:</b></td><td><%=festival.ort%></td></tr>
						<tr><td width="20%"><b>Beschreibung:</b></td><td><%=festival.kurzbeschreibung%></td></tr>
					</table>
				</div>
			</div>
			<p id="text"><%=festival.langbeschreibung%></p>
			<% if (listArtikel != null && !(listArtikel.isEmpty())) { %>
					<label class="h2">Verf�gbare Tickets</label>
					<table class= "artikel">
						<thead><tr><th>Beschreibung</th><th>Preis</th><th></th><th></th></tr></thead>
						<%for (Artikel artikel : listArtikel) { %>
						<tbody>	<tr>		
						<td data-label="Beschreibung: "><%=artikel.beschreibung%></td>
						<td data-label="Preis: "><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
						<td data-label="" width="20%"><select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
						<td><button type="submit" id="Artikel in Warenkorb" onclick="einfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>, <%=festival.id%>, <%=maxPreis%>)">In den Warenkorb</button></td>
						</tr></tbody>
						<% } %>
					 </table> <% } else {
						 if(listArtikelMitMaxPreis != null && !(listArtikelMitMaxPreis.isEmpty())) {%>
					 <label class="h2">Diese Tickets passen zu Ihrem eingegebenen Maximalpreis von <%=String.format("%.2f",maxPreis)%> &#8364; :</label>
					 <table class= "artikel">
						<thead><tr><th>Beschreibung</th><th>Preis</th><th></th><th></th></tr></thead>
						<%for (Artikel artikel : listArtikelMitMaxPreis) { %>
						<tbody>	<tr>		
						<th data-label="Beschreibung: "><%=artikel.beschreibung%></th>
						<td data-label="Preis: "><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
						<td data-label=""><select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
						<td><button type="submit" id="Artikel in Warenkorb" onclick="einfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>, <%=festival.id%>, <%=maxPreis%>)">In den Warenkorb</button></td>
						</tr></tbody>
						<% } %>
						</table>
						<% } %>
						
						
						<%if(listArtikelUeberMaxPreis != null && !(listArtikelUeberMaxPreis.isEmpty())) { %>
						<label class="h2">Falls Sie doch etwas mehr Geld ausgeben m�chten, k�nnten Sie auch die folgenden Tickets interessieren:</label>
					 	<table class= "artikel">
						<thead><tr><th>Beschreibung</th><th>Preis</th><th></th><th></th></tr></thead>
						<%for (Artikel artikel : listArtikelUeberMaxPreis) { %>
						<tbody>	<tr>		
						<td data-label="Beschreibung: "><%=artikel.beschreibung%></td>
						<td data-label="Preis: "><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
						<td data-label=""><select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
						<td><button type="submit" id="Artikel in Warenkorb" onclick="einfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>, <%=festival.id%>, <%=maxPreis%>)">In den Warenkorb</button></td>
						</tr></tbody>
						<% } %>
						</table>
						<% } } %>
						
						<div id=spalterechts>
					<% if (request.getSession().getAttribute("antwort") != null) 		
					{ %> 
					<p><%= request.getSession().getAttribute("antwort") %></p>	
					<% request.getSession().removeAttribute("antwort");}  %>
				</div> 
			<div id="leer"></div>
		</div>
	<footer></footer>
	</div>	
</body>
<script type="text/javascript">

function einfuegen(id, elemente, festivalid, maxpreis){
	
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
			if(confirm("Dieser Artikel befindet sich bereits in Ihrem Warenkorb. Soll die ausgew�hlte Menge trotzdem hinzugef�gt werden?") == true)
		
				document.location.href='/Festiva/Warenkorbverwaltung?aktion=aktualisieren&artikelid=' + id + '&menge=' + menge + "&festivalid=" + festivalid + "&maxpreis=" + maxpreis;
			} else {
			
				document.location.href='/Festiva/Warenkorbverwaltung?aktion=hinzufuegen&artikelid=' + id + '&menge=' + menge + "&festivalid=" + festivalid + "&maxpreis=" + maxpreis;
				
			}	
	}
}
</script>
</html>
<% request.getSession().removeAttribute("listArtikel"); request.getSession().removeAttribute("listArtikelMitMaxPreis"); request.getSession().removeAttribute("listArtikelMitUeberPreis");} %>