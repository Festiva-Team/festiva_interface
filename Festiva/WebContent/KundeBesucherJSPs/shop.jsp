<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: shop.jsp
	# JSP-Aktionen: Besucher: kann Festivals suchen und sich anzeigen lassen
							  kann sich die Artikel zu einem Festival anzeigen lasen
	      angemeldeter Kunde: kann Festivals suhen und sich anzeigen lassen
	      					  kann sich die Artikel zu einem Festval anzeigen lassen und in den Warenkorb legen oder aus dem Warenkorb löschen.
	      					  kann die Artikelanzahl ändern
	      					  kann einen Artikel kaufen
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Festiva - Shop</title>
	<link rel="stylesheet" type="text/css" href="../CSS/design.css">
</head>
<body>
	<div id="webseite">
		<jsp:include page="header.jsp">
    		<jsp:param name="active" value="shop"/>
    	</jsp:include>
		<div id="main">
				<div id="zeile">
				<div id="spaltelinks">
					<label for="name">Festivalname</label>
					<input type="search" id="name" maxlength="30">
					<label for="kategorie">Kategorie</label>
					<datalist id="kategorie"><option value="Kategorie.name"></option></datalist>	
					<label for="name">Ort</label>
					<input type="text" id="ort" maxlength="30">

				</div>
				<div id="spalterechts">
					<label for="datum">Startdatum</label>
					<input type="date" id="datum" maxlength="30">
					<label for="datum">Enddatum</label>
					<input type="date" id="datum" maxlength="30">
					</div>
				</div>
						<button>Suchen</button>
					</div>			
			<div id="content">
				<table>
					<tr>
						<th>Festival</th><th>Datum</th><th>Ort</th><th>Kateorie</th><th>Preis</th>
					</tr>
				</table>
			</div>
			<div id="footer">
			</div>
		</div>

</body>
</html>