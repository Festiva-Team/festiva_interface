<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.text.DecimalFormat" import="java.io.File" import="java.util.*" import="java.text.*"
    session="false"	%>
    
<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");} 
else {
	DecimalFormat df = new DecimalFormat("0.00");
	Artikel artikel = (Artikel)request.getSession(false).getAttribute("artikel");
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Festivalverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="artikelAendern"/>
    </jsp:include>
	<div id="main">
		<form action="/Festiva/Artikelverwaltung?aktion=datenaendern&artikelid=<%=artikel.id%>" method="post" enctype="multipart/form-data">
			<label class="h2">Artikel ändern</label>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<div id="spaltelinks">
				<label for="beschreibung">Beschreibung*</label>
				<input type="text" id="beschreibung" name="beschreibung" maxlength="100" required="required" value="<%=artikel.beschreibung%>">
				<label for="preis">Preis in Euro*</label>
				<input type="number" step="0.01" min="0" id="preis" name="preis" maxlength="7" required="required" value="<%=artikel.preis%>"><br>				
				<% if(artikel.festivalID == 0) { %>
				<label for="bild">Bild</label>
				<input type="file" id = "bild" name = "bild" accept="image/*"><br>
				<% } %>
				<label for="geloescht">Ist Gelöscht</label>
					<input type="checkbox" disabled="disabled" id="geloescht" name="geloescht" value=
	      					   "<%=artikel.istGelöscht%>"
	      					   <% if (artikel.istGelöscht == true) {%>
	      					   checked=<%="checked"%><%} else {%><%=""%><%} %> >
				<button type="submit" id="links">Änderungen speichern</button>
			</div>
		</form>
		<%if(artikel.festivalID == 0 ) { %>
		<form action="/Festiva/Artikelverwaltung?aktion=aendern&artikelid=<%=artikel.id%>&t=<%=new Date().getTime()%>" method="post">
					<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + artikel.bildpfad + ".jpg").exists()) { %>
					<figure class="bild1">
					<img src="/Festiva/Bilder/<%=artikel.bildpfad%>.jpg" name="bild" width=150 />
					<h5>Das aktuellste Bild wird noch nicht angezeigt? Bitte aktualisieren Sie die Seite.</h5>
					<button type="submit">Aktualisieren</button>
					</figure>
					<% } else { %>
						<p>Kein Bild vorhanden</p>
						<% } %>
					</form>
					<% } %>
		<button type="submit" onclick="del(<%=artikel.id%>)" <% if (artikel.istGelöscht == true) { %> disabled="disabled" <% } %>>Artikel löschen</button>
		<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>		
	</div>
	<div id="leer"></div>
	<div id="footer">
	</div>
</div>
</body>
<script type="text/javascript">

function del(id){
	   if(confirm("Möchten Sie den Artikel wirklich löschen?") == true) {
		   document.location.href='/Festiva/Artikelverwaltung?aktion=loeschen&artikelid=' + id;
	      } else {
	    	 document.location.href='/Festiva/Artikelverwaltung?aktion=aendern&artikelid=' + id;
	      }

}
</script>
</html>
<% request.getSession().removeAttribute("festival"); }%>