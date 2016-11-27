<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_startseite.jsp
	#               (1) Anzeige der Startseite des Kunden
*/
if (request.getSession(false) != null) {
	List<Kategorie> listKategorien = (List<Kategorie>)request.getSession(false).getAttribute("listKategorien");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
	<title>Festiva</title>
</head>
<body>
<script type="text/javascript" src="slideshowFunktionen.js"></script>
<div id="webseite">
<jsp:include page="k_header.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
	<div id="main">
    <div class="zeile">
	    <% if (request.getSession().getAttribute("begrüßung") != null) 
		{ %>
		<h1><%= request.getSession().getAttribute("begrüßung") %></h1>
		<% }  
		%>
	</div>
	<div class="slideshow-container" id="container">
		<% for (Kategorie kategorie : listKategorien) { 
		   if( new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\" + kategorie.bildpfad + ".jpg").exists()) { %>
		<div class="mySlides fade">
			<figure class="cap-bot">
				 <a href="/Festiva/Ticketverwaltung?aktion=t_anzeigen&kategorie=<%=kategorie.id%>"><img src="/Festiva/Bilder/<%=kategorie.bildpfad%>.jpg" id="img"></a>
				<figcaption>
		       		<%=kategorie.beschreibung%>
				</figcaption>
			</figure>
		</div>
		<% } }%>
		<div id="left_holder">
			<img onClick="plusSlides(-1)" class="left" src="/Festiva/Bilder/pfeil_links.jpg"/>
		</div>
		<div id="right_holder">
			<img onClick="plusSlides(1)" class="right" src="/Festiva/Bilder/pfeil_rechts.jpg"/>
		</div>
	</div>
	<div id="leer"></div>
	</div>
	<br> 
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>
</body>
<script>
var timer = 0;
var slideIndex = 0;
drehe();
</script>
</html> 
<%  } request.getSession(false).removeAttribute("listKategorien"); %>