<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: kundenAnlegen.jsp
	# JSP-Aktionen: Der Admin kann einen neuen Kunden anlegen.
*/
if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
<title>Festiva - Kundenverwaltung</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="a_headerAdmin.jsp">
    	<jsp:param name="active" value="kundenAnlegen"/>
    </jsp:include>
					<div id="main">
		<form action="/Festiva/Registrierung" method="post">
			<div id="zeile">
			<div id="spaltelinks">
				<h2>Kunden anlegen</h2>
				<label for="email">E-Mail</label>
				<input type="email" name="email" id="email" maxlength="30" required="required" placeholder="E-Mail">
				<label for="emailbestätigung">E-Mail bestätigen</label>
				<input type="email" name="emailbestätigung" id="emailbestätigung" maxlength="30" required="required" placeholder="E-Mail bestätigen">
				<label for="passwort">Passwort</label>
				<input type="password" name="passwort" id="passwort" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required" placeholder="Passwort"/>
				<label for="passwortbestätigung">Passwort bestätigen</label>
				<input type="password" name="passwortbestätigung" id="passwortbestätigung" maxlength="40" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" required="required" placeholder="Passwort bestätigen"/>
				<button type="submit" id="links">Anlegen</button>
			</div>
			<div id="spalterechts">
					<% if (request.getSession().getAttribute("antwort") != null) 
					{ %>
					<p><%= request.getSession().getAttribute("antwort") %></p>
					<% request.getSession().removeAttribute("antwort");}  %>
				</div>	
			</div>
			</form>
			<div id="leer"></div>
		</div>
		<div id="leer"></div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>