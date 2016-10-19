<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Festiva</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<link rel="stylesheet" type="text/css" href="CSS/home.css">
</head>
<body>
	<div id="webseite">
		<div id="header">
			<img src="Bilder/HeaderMitLogo.png" width="980"/>
		</div>
			<nav>
	  			<ul>
				      <li><a href="Startseite.jsp">Home</a></li>
				      <li><a href="Shop.jsp">Shop</a></li>
				      <li><a href="#">Mein Konto</a>
				      	<ul>
					      <li><a href="Anmelden.jsp">Anmelden</a></li>
					      <li><a href="Registrieren.jsp">Registrieren</a></li>
				      	</ul>
				      </li>	
			  	</ul>
			</nav>
			<div id="oben">
			<!-- Erste Fotozeile -->
				<div id="olinks">
					<a href="Shop.jsp">
					<img src="Bilder/Rock.jpg" width="200" height="200"/>
					</a>
				</div>
				<div id="orechts">
					<a href="Shop.jsp">
					<img src="Bilder/Metal.jpg" width="200" height="200"/>
					</a>
				</div>
			</div>
			<div id="unten">
			<!-- Zweite Fotozeile -->
				<div id="ulinks">
					 <a href="Shop.jsp">
					 <img src="Bilder/Electro.jpg" width="200" height="200"/>
					 </a>
				</div>
				<div id="urechts">
					 <a href="Shop.jsp">
					 <img src="Bilder/Schlager.jpg" width="200" height="200"/>
					 </a>
				</div> 
			</div>
		<div id="footer">
			<a href="#">Admin login</a>
		</div>
	</div>	
</body>
</html>