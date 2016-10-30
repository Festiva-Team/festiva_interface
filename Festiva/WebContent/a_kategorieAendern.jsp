<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
 <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kategorieAendern.jsp
	# JSP-Aktionen: Der Admin kann eine Kategorie �ndern.
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
	response.sendRedirect("k_anmelden.jsp");}
else {
	Kategorie kategorie = (Kategorie)request.getSession(false).getAttribute("kategorie"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kategorienverwaltung</title>
 <script type="text/javascript">
var bildLaden = {
count : (new Date()).getTime(),
tu_es : function() {
document.images['bild'].src = '/Festiva/Bilder/' + kategorie.bildpfad + '.jpg' + bildLaden.count;
bildLaden.count++;
window.setTimeout(bildLaden.tu_es(),300000);
}
}
bildLaden.tu_es();
</script>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="kategorieAendern"/>
    </jsp:include>
	<div id="main">
		<form action="/Festiva/Kategorienverwaltung?aktion=datenaendern&kategorienid=<%=kategorie.id%>" method="POST" enctype="multipart/form-data">
			<div id="zeile">
			<h2>Kategorie �ndern</h2>
			<h5>Pflichtfelder sind mit * gekennzeichnet.</h5>
				<div id="spaltelinks">
					<label for="name">Kategorienname*</label>
					<input type="text" id="name" name="name" maxlength="30" value="<%=kategorie.name%>">
					<label for="beschreibung">Beschreibung*</label>
					<textarea rows="5" id="beschreibung" name="beschreibung"><%=kategorie.beschreibung%></textarea>
					<label for="bild">Bild</label>
					<figure class="bild1">
					<img src="/Festiva/Bilder/<%=kategorie.bildpfad%>.jpg" name="bild" width=150 />
					<output id="list"></output>
					</figure>
					<label for="bild">Neues Bild</label>
					<input type="file" id = "files" name = "files" accept="image/*"><br>
					<button type="submit">�nderungen speichern</button>
				</div>
			</div>
		</form>
		<form action="/Festiva/Kategorienverwaltung?aktion=loeschen&kategorienid=<%=kategorie.id%>" method="post">
			<div id="spaltelinks">
					<button type="submit" id="links">Kategorie l�schen</button>
					</div>
					</form>
					<form action="/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=<%=kategorie.id%>&t=<%=new Date().getTime()%>" method="post">
					<% if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg").exists()) { %>
					<figure class="bild1">
					<img src="/Festiva/Bilder/<%=kategorie.bildpfad%>.jpg" name="bild" width=150 />
					<h5>Das aktuellste Bild wird noch nicht angezeigt? Bitte aktualisieren Sie die Seite.</h5>
					<button type="submit">Aktualisieren</button>
					</figure>
					<%} %>
					</form>
					<div id="spalterechts">
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
<script>
	function dateiauswahl(evt) {
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
			}
		}
		// Auf neue Auswahl reagieren und gegebenenfalls Funktion dateiauswahl neu ausf�hren.
	document.getElementById('files')
		.addEventListener('change', dateiauswahl, false);

</script>
</html>
<% request.getSession().removeAttribute("kategorie");}%>