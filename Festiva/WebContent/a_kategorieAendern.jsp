<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
 <%
 /** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: a_kategorieAendern.jsp
	# JSP-Aktionen: (1) Anzeige der aktuellen Kategoriendaten
	#				(2) Möglichkeit zum Ändern der Daten
	# 				(3) Möglichkeit zum Löschen der Kategorie, wenn ID > 5 (keine Stammkategorien)
	#				(4) Weitergabe der Daten an das Servlet "Kategorienverwaltung.java" 
	#				(5) Anzeige der Antwort aus dem Servlet
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");}
else {
	Kategorie kategorie = (Kategorie)request.getSession(false).getAttribute("kategorie"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kategorienverwaltung</title>
</head>
<body>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
	<jsp:param name="active" value="kategorieAendern"/>
</jsp:include>
	<div id="main">
	<form action="/Festiva/Kategorienverwaltung?aktion=datenaendern&kategorienid=<%=kategorie.id%>" method="POST" enctype="multipart/form-data">
		<div class="zeile">
			<h1>Kategorie ändern</h1>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
			<% if (request.getSession().getAttribute("antwort") != null) 
			{ %>
			<p id="antwort"><%= request.getSession().getAttribute("antwort") %></p>
			<% request.getSession().removeAttribute("antwort");}  %>
			<div class="spaltelinks">
				<label for="name">Kategorienname*</label>
				<input type="text" name="name" maxlength="30" title="Bitte wählen Sie einen passenden Namen!" required="required" value="<%=kategorie.name%>">
				<label for="beschreibung">Beschreibung*</label>
				<textarea rows="5" name="beschreibung" title="Bitte geben Sie eine Beschreibung ein!" required="required"><%=kategorie.beschreibung%></textarea>
				<label for="bild">Neues Bild</label>
				<input type="file" name="bild" accept="image/*">
				<output id="list"></output>	
				<% if(kategorie.id != 1 && kategorie.id != 2 && kategorie.id != 3 && kategorie.id != 4) { %>
				<label for="geloescht">Ist Gelöscht</label>
				<input type="checkbox" disabled="disabled" id="geloescht" name="geloescht" value="<%=kategorie.istGelöscht%>"
			    <% if (kategorie.istGelöscht == true) {%>
			    checked=<%="checked"%> title="Die Kategorie ist gelöscht."<%} else {%><%=""%>title="Die Kategorie ist nicht gelöscht."<%} %> ><br/>
      			<% } %>
				<button type="submit">Änderungen speichern</button>
			</div>
			<div class="spalterechts">
				<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg").exists()) { %>
				<figure class="bild1">
				<img src="/Festiva/Bilder/<%=kategorie.bildpfad%>.jpg" name="bild" width=150 />
				</figure>
				<% } else { %>
					<p>Kein Bild vorhanden</p>
				<% } %>
			</div> 	
		</div>
	</form>
	<% if(kategorie.id != 1 && kategorie.id != 2 && kategorie.id != 3 && kategorie.id != 4) { if(new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg").exists()) {%>
		<button type="submit" onClick="window.location.href='/Festiva/Kategorienverwaltung?aktion=b_loeschen&kategorienid=<%=kategorie.id%>'">Aktuelles Bild löschen</button>
	<% } %>
	<button type="submit" onclick="del(<%=kategorie.id%>)" <% if (kategorie.istGelöscht == true) { %> disabled="disabled" <% } %>>Kategorie löschen</button>
	<% } %>
	<div id="leer"></div>
	</div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
<script>
/* 	function dateiauswahl(evt) {
			var dateien = evt.target.files; // FileList object
			// Auslesen der gespeicherten Dateien durch Schleife
			for (var i = 0, f; f = dateien[i]; i++) {
				// nur Bild-Dateien
				if (!f.type.match('image.*')) {
					continue;
				}
				var reader = new FileReader();
				reader.onload = (function (theFile) {
					return function (e) {
						// erzeuge Thumbnails.
						var vorschau = document.createElement('img');
						vorschau.className = 'vorschau';
						vorschau.src = e.target.result;
						vorschau.title = theFile.name;
						document.getElementById('list')
							.insertBefore(vorschau, null);
					};
				})(f);
				// Bilder als Data URL auslesen.
				reader.readAsDataURL(f);
				vorschau.width = 50;
				dateien.appendChild(img);
			}
		}
	
	
		// Auf neue Auswahl reagieren und gegebenenfalls Funktion dateiauswahl neu ausführen.
	document.getElementById('bild')
		.addEventListener('change', dateiauswahl, false); */

function del(id){
	   if(confirm("Möchten Sie die Kategorie wirklich löschen?") == true) {
		   document.location.href='/Festiva/Kategorienverwaltung?aktion=loeschen&kategorienid=' + id;
	      } else {
	    	 document.location.href='/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=' + id;
	      }

}
</script>
</html>
<% request.getSession().removeAttribute("kategorie");}%>