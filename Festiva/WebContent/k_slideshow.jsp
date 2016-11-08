<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: startseite.jsp
	# JSP-Aktionen:
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
<script type="text/javascript">
	var imagecount =1;
	var total = 4;
	function slide(x){
	var Image = document.getElementById('img');
	imagecount = imagecount + x;
	if(imagecount > total) { imagecount = 1;}
	if(imagecount < 1) { imagecount = total;}
	Image.src = "/Festiva/Bilder/Kategorie_" + imagecount + ".jpg";
	}
	window.setInterval(	function slide(x){
	var Image = document.getElementById('img');
	imagecount = imagecount + x;
	if(imagecount > total) { imagecount = 1;}
	if(imagecount < 1) { imagecount = total;}
	Image.src = "/Festiva/Bilder/Kategorie_" + imagecount + ".jpg";
	},5000);
</script>
</head>
<body>
<div id="webseite">
	    <jsp:include page="k_header.jsp">
	    	<jsp:param name="active" value="startseite"/>
	    </jsp:include>
			<div id="container">
			<img src="/Festiva/Bilder/Kategorie_1_1478601263477.jpg" id="img"/>
			<div id="left_holder"><img onClick="slide(-1)" class="left" src="/Festiva/Bilder/pfeil_links.jpg"/></div>
			<div id="right_holder"><img onClick="slide(1)" class="right" src="/Festiva/Bilder/pfeil_rechts.jpg"/></div>
			</div>
			<div id="leer"></div>
		<footer></footer>
	</div>	
</body>
</html>
<% request.getSession().removeAttribute("listKategorien"); } %>