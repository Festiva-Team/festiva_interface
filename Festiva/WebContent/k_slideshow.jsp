<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke, Alina Fankhänel
	# JSP-Name: k_slideshow.jsp
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

</head>
<body>
<div id="webseite">
<jsp:include page="k_header.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
	<div id="container">
		<%-- <% for (String bildpfad : listBildpfade){
		int katId = Integer.parseInt(bildpfad.substring(10,11));%>
		<a href="/Festiva/Ticketverwaltung?aktion=t_anzeigen&kategorienid=<%=katId%>"><img src="/Festiva/Bilder/Kategorie_1_1478601263477.jpg" id="img"/></a>
			<div id="left_holder"><img onClick="slide(-1, <%=listBildpfade%>)" class="left" src="/Festiva/Bilder/pfeil_links.jpg"/></div>
		<div id="right_holder"><img onClick="slide(1, <%=listBildpfade%>)" class="right" src="/Festiva/Bilder/pfeil_rechts.jpg"/></div>
		<% } %> --%>
		<%-- Das erste Bild des Array für den Start anzeigen --%>
		<% String erstesElem = listBildpfade.get(0);  %>
		<img src="/Festiva/Bilder/'+erstesElem+'.jpg" id="img"/>
		<!-- <img src="/Festiva/Bilder/Kategorie_1_1478601263477 .jpg" id="img"/> -->
		<div id="left_holder">
			<img onClick="slide(-1, <%=listBildpfade%>)" class="left" src="/Festiva/Bilder/pfeil_links.jpg"/>
		</div>
		<div id="right_holder">
			<img onClick="slide(1, <%=listBildpfade%>)" class="right" src="/Festiva/Bilder/pfeil_rechts.jpg"/>
		</div>
	</div>
	<div id="leer"></div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
	</div>	
</body>
<script type="text/javascript">
var pfad;
var katId

var i = 1;
var total = 4;
function slide(x, pfade) {
	var bilder;
	i = i + x; 
	for (var j = 0; j < pfade.length; j++){
		var pfad = pfade[j];
		var katId = parseInt.pfad.substr(10,1);
		if(i > total) {
			i = 1;
			bilder.src = "/Festiva/Bilder/" + pfade[0] + ".jpg";
		} else if(i < 1) {
			i = total; 
			bilder.src = "/Festiva/Bilder/" + pfade[i-1] + ".jpg";
		} else if (katId == i){
			bilder.src = "/Festiva/Bilder/" + pfad + ".jpg";
		}
	}  
}
</script>
</html>
<% request.getSession().removeAttribute("listBildpfade"); } %>