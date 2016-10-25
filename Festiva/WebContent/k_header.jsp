<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: header.jsp
	# JSP-Aktionen: Definiert den Header und die Navigation f�r einen Besucher und einen Kunden.
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Header</title>

	
	 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
      <script type="text/javascript">
      function einblenden(){
         $("#myArticle").fadeIn('slow', function() {
            $("#myArticle").show();
         });
      }
       
      function ausblenden(){
         $("#1").fadeOut('slow', function() {
            $("#1").hide();
         });
      }
      </script>

</head>
<body>
	<div id="header">
		<img src="/Festiva/Bilder/HeaderMitLogo.png" width="980"/>
	</div>
		<nav>
		<ul>
			<li><a href="k_startseite.jsp">Home</a></li>
			<li><a href="k_shop.jsp">Shop</a></li>
			<li><a href="#">Mein Konto</a>
			<ul>
				<li><a href="k_anmelden.jsp">Anmelden</a></li>
				<li><a href="k_registrieren.jsp">Registrieren</a></li>
				<li><a href="k_kundendaten.jsp">Meine Daten</a></li> 
				<li><a href="k_bestellungen.jsp">Meine Bestellungen</a></li> 
				<li><a href="#">Abmelden</a></li>
			</ul>
			</li>					      
			<li><a href="k_warenkorb.jsp">Warenkorb</a></li> 
		</ul>
		</nav>
</body>
</html>