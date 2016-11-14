<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_startseite.jsp
	# JSP-Aktionen: Anzeige der Startseite des Kunden
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
			<%-- <a href="/Festiva/Ticketverwaltung?aktion=t_anzeigen&kategorie=<%=kategorie.id%>"><img title="test" onmouseover="zeigeBeschr(<%=kategorie.id%>)" onmouseout="entferneBeschr(<%=kategorie.id%>)" src="/Festiva/Bilder/<%=kategorie.bildpfad%>.jpg" id="img"></a>
			<div id="beschreibung<%=kategorie.id%>" style="visibility: hidden" class="numbertext"><%=kategorie.beschreibung%></div> --%>
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
carousel();


function zeigeBeschr(x) {
	document.getElementById('beschreibung'+x).style.visibility = "visible";
}

function entferneBeschr(x) {
	document.getElementById('beschreibung'+x).style.visibility = "hidden";
}

function plusSlides(n) {
    slideIndex = slideIndex + n;
    clearTimeout(timer);
    timer = 0;
    slide(slideIndex);
}

function slide(n) {
    var i;
    var x = document.getElementsByClassName("mySlides");
    if (n > x.length) {slideIndex = 1}
    if (n < 1) {slideIndex = x.length} ;
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    x[slideIndex-1].style.display = "block";
    timer = setTimeout("carousel()", 3000);
}

function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > x.length) {slideIndex = 1}
    x[slideIndex-1].style.display = "block";
    timer = setTimeout("carousel()", 3000); 
}
</script>
</html> 
<%  } request.getSession(false).removeAttribute("listKategorien"); %>