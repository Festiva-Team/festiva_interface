<%@ page import = "standardPackage.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
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
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta charset="ISO-8859-1">
	<title>Festiva - Festival Zubehör</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
</head>
<body>
	<div id="webseite">
		<jsp:include page="k_header.jsp">
    		<jsp:param name="active" value="merchandiseShop"/>
    	</jsp:include>
		<div id="main">
				<h2>Festival Zubehör</h2>
					<div>
					<% if (request.getSession().getAttribute("antwort") != null) 		
					{ %> 
					<p><%= request.getSession().getAttribute("antwort") %></p>	
					<% request.getSession().removeAttribute("antwort");}  %>
				</div> 
			<div id="zeile">
				<table>
								
					
					<%					
						for (Artikel artikel : listArtikel)
						{%>
						<tbody>	<tr>
						<%if(!(artikel.bildpfad).equals("")) { %>
						<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg").exists()) { %>
						<td><figure class="bild1">
						<img src="/Festiva/Bilder/<%=artikel.bildpfad%>.jpg" name="bild" width=150 />
						</figure></td>
						<% } else { %>
								<td data-label="Bild">Kein Bild verfügbar</td>
								<% } %>
						<% } else { %>
								<td data-label="Bild">Kein Bild verfügbar</td>
								<% }	%>
								<td data-label="Beschreibung"><%=artikel.beschreibung%></td>
								<td data-label="Preis"><%=String.format("%.2f",artikel.preis)%> &#8364;</td>
								<td data-label="Anzahl" width="20%">
								<select id="anzahl<%=artikel.id%>" name="anzahl"><%for (int i=1; i<=10; i++) {%><option><%=i%></option><%}%></select></td>
								<td><button type="submit" id="Artikel in Warenkorb" onclick="einfuegen(<%=artikel.id%>, <%if(listArtikelID != null){ %><%=listArtikelID%> <% }else { %> null<% } %>)">In den Warenkorb</button></td>
							</tr></tbody>
						<% }	%>
				</table>
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