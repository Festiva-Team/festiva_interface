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
	List<String> listBildpfade = (List<String>)request.getSession(false).getAttribute("listBildpfade");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
	<title>Festiva</title>
<script type="text/javascript">
var i = 0;
var path = new Array();
 
// LIST OF IMAGES
path[0] = "image_1.gif";
path[1] = "image_2.gif";
path[2] = "image_3.gif";
function swapImage()
{
   document.slide.src = path[i];
   if(i < path.length - 1) i++; else i = 0;
   setTimeout("swapImage()",3000);
}
window.onload=swapImage;
</script>
</head>
<body>
<div id="webseite">
	    <jsp:include page="k_header.jsp">
	    	<jsp:param name="active" value="startseite"/>
	    </jsp:include>
			<div id="container">
			<a href="/Festiva/Ticketverwaltung?aktion=t_anzeigen"><img src="/Festiva/Bilder/Kategorie_1_1478601263477.jpg" id="img"/></a>
			<div id="left_holder"><img onClick="slide(-1), " class="left" src="/Festiva/Bilder/pfeil_links.jpg"/></div>
			<div id="right_holder"><img onClick="slide(1)" class="right" src="/Festiva/Bilder/pfeil_rechts.jpg"/></div>
			</div>
			<div id="leer"></div>
		<footer></footer>
	</div>	
</body>
</html>
<% request.getSession().removeAttribute("listBildpfade"); } %>