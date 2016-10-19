<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Shop</title>
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<link rel="stylesheet" type="text/css" href="CSS/registrieren.css">
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
			<form action="Registrieren.jsp" id="registrieren">
				<label class="h2" form="registrieren">Registrieren</label>
				<label for="email">Email</label>
				<input type="email" name="email" id="email" maxlength="30">
				<label for="emailwh">Email wiederholen</label>
				<input type="email" name="email" id="email" maxlength="30">
				<label for="passwort">Passwort</label>
				<input type="password" name="passwort" id="passwort" maxlength="40">
				<label for="passwortwh">Passwort wiederholen</label>
				<input type="password" name="passwort" id="passwort" maxlength="40">
				<button type="button">Registrieren</button>
			</form>
		</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>