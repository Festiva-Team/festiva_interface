<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
<meta charset="ISO-8859-1">
	<title>Shop</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<link rel="stylesheet" type="text/css" href="CSS/shop.css">
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
		<div id="main">
			<div id="search">
				<form>
					<label for="startdatum">Startdatumm</label>
					<input type="date" name="Datum"><br>
					<label for="Enddatum">Enddatum</label>
					<input type="date" name="Datum">
					<button type="button">Suchen"</button>
				</form>
  			</div>
			<div id="content">
				<table>
					<tr>
						<th>Festival</th><th>Datum</th><th>Ort</th><th>Kateorie</th><th>Preis</th>
					</tr>
				</table>
			</div>
		</div>
		<div id="footer">
		</div>
	</div>
</body>
</html>