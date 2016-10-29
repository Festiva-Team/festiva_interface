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
</head>
<body>

	<div id="webseite">
	    <jsp:include page="k_header.jsp">
	    	<jsp:param name="active" value="startseite"/>
	    </jsp:include>
	    <div id="zeile1">
	    <% if (request.getSession().getAttribute("begrüßung") != null) 
		{ %>
		<h1><%= request.getSession().getAttribute("begrüßung") %></h1>
		<% }  
		%>
		</div>
			<figure class="bildzeile">
				<figure class="bild1">
					<a href="k_shop.jsp">
					<img src="/Festiva/Bilder/Rock.jpg"/>
					</a>
					<a href="k_shop.jsp">
					<img src="/Festiva/Bilder/Metal.jpg"/>
					</a>
				</figure>
				<figure class="bild2">
					 <a href="k_shop.jsp">
					 <img src="/Festiva/Bilder/Electro.jpg"/>
					 </a>
					 <a href="k_shop.jsp">
					 <img src="/Festiva/Bilder/Schlager.jpg"/>
					 </a>
				</figure> 
			</figure>
		<footer></footer>
	</div>	
</body>
</html>