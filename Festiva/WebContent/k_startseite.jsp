<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: startseite.jsp
	# JSP-Aktionen:
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Festiva</title>
	<link rel="stylesheet" href="CSS/design.css" media="screen">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<% if (request.getSession().getAttribute("begrüßung") != null) 
{ %>
<p><%= request.getSession().getAttribute("begrüßung") %></p>
<% }  
%>

	<div id="webseite">
	    <jsp:include page="k_header.jsp">
	    	<jsp:param name="active" value="startseite"/>
	    </jsp:include>
			<figure class="bildzeile">
				<figure class="bild1">
					<a href="k_shop.jsp">
					<img src="/Festiva/Bilder/Rock.jpg"/>
					</a>
				</figure>
				<figure class="bild1">
					<a href="k_shop.jsp">
					<img src="/Festiva/Bilder/Metal.jpg"/>
					</a>
				</figure>
				<figure class="bild2">
					 <a href="k_shop.jsp">
					 <img src="/Festiva/Bilder/Electro.jpg"/>
					 </a>
				</figure>
				<figure class="bild2">
					 <a href="k_shop.jsp">
					 <img src="/Festiva/Bilder/Schlager.jpg"/>
					 </a>
				</figure> 
			</figure>
		<div id="footer"></div>
	</div>	
</body>
</html>