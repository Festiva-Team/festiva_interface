<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"%>
    
<%  
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_festivaldetails.jsp
	# JSP-Aktionen: (1) Anzeige der Artikeldetails, des im Zubehörshop ausgewählten Zubehörs
	# 				(2) Möglichkeit max. 10 Einheiten eines Artikel in den Warenkorb zu legen 
	#				(2a) Aufruf des Servlet "Warenkorbverwaltung.java"
	# 				(3) Weiterleitung zur Anmeldung, falls Besucher noch nicht angemeldet ist
*/
List<Artikel> listArtikel = null;
List<Integer> listArtikelID = null;

if (request.getSession(false) != null) {
	listArtikel = (List<Artikel>)request.getSession(false).getAttribute("listArtikel");
}
if(request.getSession(false).getAttribute("listArtikelID") != null) {
	listArtikelID = (List<Integer>)request.getSession(false).getAttribute("listArtikelID");
	}
Artikel artikel = (Artikel)request.getSession(false).getAttribute("artikel");
 %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Artikeldetails</title>
</head>
<body>
<script type="text/javascript" src="uebergreifendeFunktionen.js"></script>
<div id="webseite">
<jsp:include page="k_header.jsp">
	<jsp:param name="active" value="shop"/>
</jsp:include>
   	<div id="main">
   		<div class="zeile">
   		<h1><%-- <%=artikel.name%>" --%></h1>
   			<div class="zeile">
				<% if (request.getSession().getAttribute("antwort") != null) 		
				{ %> 
				<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>	
				<% request.getSession().removeAttribute("antwort");}  %>
			</div> 
			<div class="spaltelinks">
				<%-- <%if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg").exists()) { %>
				<img src="/Festiva/Bilder/<%=artikel.bildpfad%>.jpg" name="bild" width=300/>
				<% } else { %> --%>
				<p>Kein Bild vorhanden</p>
		  		<%-- <% } %> --%>
			</div>
			<div class="spalterechts">
				<table class= "artikel">
					 <tr><td><b>Name:</b></td><%--<td><%=artikel.name%></td>--%></tr> 
					<tr><td><b>Beschreibung:</b></td><%--<td><%=artikel.beschreibung%></td>--%></tr>
				</table>
				<select width="25%" id="anzahl <%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select>
				<button type="submit" id="buttontabelle" onclick="einfuegen()">In den Warenkorb</button></td>
			</div>
		</div>				
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
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
			if(confirm("Dieser Artikel befindet sich bereits in Ihrem Warenkorb. Soll die ausgewählte Menge trotzdem hinzugefügt werden?") == true)
		
				post('/Festiva/Warenkorbverwaltung', {aktion: 'aktualisieren', artikelid: id, menge: menge, festivalid: festivalid, maxpreis: maxpreis});	
				//document.location.href='/Festiva/Warenkorbverwaltung?aktion=aktualisieren&artikelid=' + id + '&menge=' + menge + "&festivalid=" + festivalid + "&maxpreis=" + maxpreis;
			} else {
			
				post('/Festiva/Warenkorbverwaltung', {aktion: 'hinzufuegen', artikelid: id, menge: menge, festivalid: festivalid, maxpreis: maxpreis});
				//document.location.href='/Festiva/Warenkorbverwaltung?aktion=hinzufuegen&artikelid=' + id + '&menge=' + menge + "&festivalid=" + festivalid + "&maxpreis=" + maxpreis;
				
			}	
	}
}
</script>
</html>
<% request.getSession().removeAttribute("listArtikel"); %>
