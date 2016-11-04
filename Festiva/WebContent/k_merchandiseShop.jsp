<%@ page import = "standardPackage.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: merchandiseShop.jsp
*/
if (request.getSession(false) != null) {
	List<Artikel> listArtikel = (List<Artikel>)request.getSession(false).getAttribute("listArtikel");
	List<Integer> listArtikelID = null;
	if(request.getSession(false).getAttribute("listArtikelID") != null) {
	listArtikelID = (List<Integer>)request.getSession(false).getAttribute("listArtikelID");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Festiva - Merchandiseshop</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
</head>
<body>
	<div id="webseite">
		<jsp:include page="k_header.jsp">
    		<jsp:param name="active" value="merchandiseShop"/>
    	</jsp:include>
		<div id="main">
				<h2>Merchandise Shop</h2>
			<div id="zeile">
				<table>
								
					<thead><tr><th>Bild</th><th>Beschreibung</th><th>Preis</th></tr></thead>
					<%					
						for (Artikel artikel : listArtikel)
						{%>
						<tbody>	<tr>
								<td data-label="Bild">"artikel.bildpfad"</td>
								<td data-label="Beschreibung"><%=artikel.beschreibung%></td>
								<td data-label="Preis"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
								<td data-label="Anzahl">
								<select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
								<td><button type="submit" id="Artikel in Warenkorb" onclick="einfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>)">In den Warenkorb</button></td>
							</tr></tbody>
						<%}	%>

				</table>
				<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div> 
			</div>
		<div id="leer"></div>
		</div>
			<footer></footer>
	</div>
</body>
<script type="text/javascript">

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
<% request.getSession().removeAttribute("listArtikel"); request.getSession().removeAttribute("listArtikelID"); } %>