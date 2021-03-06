<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"%>
    
<%  
/** 
	# Autor: Nicola Kloke, Alina Fankh�nel
	# JSP-Name: k_festivaldetails.jsp
	#               (1) Anzeige der Festivaldetails, des im Ticketshop ausgew�hlten Festivals
	#				(2) Anzeige aller zugeh�rigen Artikel (bzw. Artikel die den Beschr�nkungen aus der Suche entsprechen)
	#				(4) Tabellarische Darstellung der Artikeldaten (Bild, Name, Preis)
	#				(4) M�glichkeit zur Betrachtung der Artikeldetails �ber Namen-Link oder Bild-Link
*/
	SimpleDateFormat sd = new SimpleDateFormat(" EEEE, dd.MM.yyyy");
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
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<script type="text/javascript" src="bestellenFunktionen.js"></script>
<div id="webseite">
<jsp:include page="k_header.jsp">
	<jsp:param name="active" value="shop"/>
</jsp:include>
   	<div id="main">
   		<div class="zeile">
   		<h1><%=festival.name%></h1>
   			<div class="zeile">
				<% if (request.getSession().getAttribute("antwort") != null) 		
				{ %> 
				<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>	
				<% request.getSession().removeAttribute("antwort");}  %>
			</div> 
			<div class="spaltelinks">
				<%if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + festival.bildpfad + ".jpg").exists()) { %>
				<img src="/Festiva/Bilder/<%=festival.bildpfad%>.jpg" name="bild" width="250"/>
				<% } else { %>
				<p>Kein Bild vorhanden</p>
		  		<% } %>
			</div>
			<div class="spalterechts">
				<table class= "festival">
					<tr class="tabellenzeile"><td><b>Zeitraum:</b></td><td> <%=sd.format(festival.startDatum)%>  -  <%=sd.format(festival.endDatum)%></td></tr>
					<tr class="tabellenzeile"><td><b>Ort:</b></td><td><%=festival.ort%></td></tr>
					<tr><td><b>Beschreibung:</b></td><td><%=festival.kurzbeschreibung%></td></tr>
				</table>
			</div>
		</div>
		<p id="langtext"><%=festival.langbeschreibung%></p>
		<% if (listArtikel != null && !(listArtikel.isEmpty())) { %>
		<h1>Verf�gbare Tickets</h1>
		<table class= "artikel">
			<thead><tr><th>Beschreibung</th><th>Details</th><th>Preis</th><th></th><th></th></tr></thead>
			<%for (Artikel artikel : listArtikel) { %>
			<tbody>	<tr>		
			<td data-label="Beschreibung: " ><%=artikel.beschreibung%></td>
			<td data-label="Details: " ><%=artikel.details%></td>
			<td data-label="Preis: " class="preis"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
			<td data-label="" class="anzahl"><select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
			<td><button type="submit" id="buttontabelle" onclick="festivaldetailsEinfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>, <%=festival.id%>, <%=maxPreis%>)">In den Warenkorb</button></td>
			</tr></tbody>
			<% } %>
		 </table> 
		 <% } else {
			if(listArtikelMitMaxPreis != null && !(listArtikelMitMaxPreis.isEmpty())) {%>
		 <h2>Diese Tickets passen zu Ihrem eingegebenen Maximalpreis von <%=String.format("%.2f",maxPreis)%> &#8364; :</h2>
		 <table class= "artikel">
			<thead><tr><th>Beschreibung</th><th>Details</th><th>Preis</th><th></th><th></th></tr></thead>
			<%for (Artikel artikel : listArtikelMitMaxPreis) { %>
			<tbody>	
			<tr>		
				<td data-label="Beschreibung: "><%=artikel.beschreibung%></td>
				<td data-label="Details: "><%=artikel.details%></td>
				<td data-label="Preis: " class="preis"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
				<td data-label="" class="anzahl"><select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
				<td><button type="submit" id="buttontabelle" onclick="festivaldetailsEinfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>, <%=festival.id%>, <%=maxPreis%>)">In den Warenkorb</button></td>
			</tr>
			</tbody>
			<% } %>
		</table>
		<% } %>
		
		<%if(listArtikelUeberMaxPreis != null && !(listArtikelUeberMaxPreis.isEmpty())) { %>
		<h2>Falls Sie doch etwas mehr Geld ausgeben m�chten, k�nnten Sie auch die folgenden Tickets interessieren:</h2>
	 	<table class="artikel">
			<thead><tr><th>Beschreibung</th><th>Details</th><th>Preis</th><th></th><th></th></tr></thead>
			<%for (Artikel artikel : listArtikelUeberMaxPreis) { %>
			<tbody>	
			<tr>		
				<td data-label="Beschreibung: "><%=artikel.beschreibung%></td>
				<td data-label="Details: "><%=artikel.details%></td>
				<td data-label="Preis: " class="preis"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
				<td data-label=""><select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
				<td><button type="submit" id="buttontabelle" onclick="festivaldetailsEinfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>, <%=festival.id%>, <%=maxPreis%>)">In den Warenkorb</button></td>
			</tr>
			</tbody>
			<% } %>
		</table>
		<% } } %>				
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
	</div>	
</body>
</html>
<% request.getSession().removeAttribute("listArtikel"); request.getSession().removeAttribute("listArtikelMitMaxPreis"); request.getSession().removeAttribute("listArtikelMitUeberPreis");} %>
