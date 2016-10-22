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
	<link rel="stylesheet" type="text/css" href="../CSS/design.css">
</head>
<body>
	<div id="webseite">
	    <jsp:include page="header.jsp">
	    	<jsp:param name="active" value="startseite"/>
	    </jsp:include>
			<div id="bildzeile">
			<!-- Erste Fotozeile -->
				<div id="bildspalte">
					<a href="shop.jsp">
					<img src="../Bilder/Rock.jpg" width="200" height="200"/>
					</a>
				</div>
				<div id="bildspalte">
					<a href="shop.jsp">
					<img src="../Bilder/Metal.jpg" width="200" height="200"/>
					</a>
				</div>
			</div>
			<div id="bildzeile">
			<!-- Zweite Fotozeile -->
				<div id="bildspalte">
					 <a href="shop.jsp">
					 <img src="../Bilder/Electro.jpg" width="200" height="200"/>
					 </a>
				</div>
				<div id="bildspalte">
					 <a href="shop.jsp">
					 <img src="../Bilder/Schlager.jpg" width="200" height="200"/>
					 </a>
				</div> 
			</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>