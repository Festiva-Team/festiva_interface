<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: header.jsp
	# JSP-Aktionen: Definiert den Header und die Navigation für einen Besucher und einen Kunden.
*/


HttpSession session = request.getSession(false);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css" media="screen">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Header</title>
</head>
<body>
	<header>
		<img src="/Festiva/Bilder/HeaderMitLogo.png" width="100%"/>
	</header>
	<nav>
		<label for="show-menu" class="show-menu">Menü</label>
		<input type="checkbox" id="show-menu" role="button">
		<ul id= menu>
			<li><a href="k_startseite.jsp">Home</a></li>
			<li><a href="k_shop.jsp">Ticket Shop</a></li>
			<li><a href="/Festiva/Produktverwaltung?aktion=z_anzeigen">Festival Zubehör</a></li>
			<li><a href="#">Mein Konto</a>
			<ul class ="hidden">
			<% if (session != null && session.getAttribute("begrüßung") != null && session.getAttribute("gruppenid") != null && Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) == 2) 
					{ %>
				
				<li><a href="/Festiva/Benutzerdaten?aktion=anzeigen">Meine Daten</a></li> 
				<li><a href="/Festiva/Bestellverwaltung?aktion=anzeigen">Meine Bestellungen</a></li> 
				<li><a href="/Festiva/Logout" accesskey="1" title="">Abmelden</a></li>
				</ul>
				</li>					      
				<li><a href="/Festiva/Warenkorbverwaltung?aktion=anzeigen">Warenkorb</a></li> 
				
					<% } else { %>
				
				<li><a href="k_anmelden.jsp">Anmelden</a></li>
				<li><a href="k_registrieren.jsp">Registrieren</a></li>
				<% } %>			
		</ul>
	</nav>
</body>
</html>