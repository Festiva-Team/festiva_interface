<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<link rel="stylesheet" type="text/css" href="CSS/eingaben.css">
<title>Festiva - Kunden anlegen</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="headerAdmin.jsp">
    	<jsp:param name="active" value="kundenAnlegen"/>
    </jsp:include>
		<div id="main">
			<form action="kundenAnlegen.jsp" id="anmelden">
				<label class="h2" form="kundenAnlegen">Kunden anlegen</label>
				<label for="name">Kategorienname</label>
				<input type="text" name="name" id="name" maxlength="30">
				<label for="beschreibung">Beschreibung</label>
				<input type="text" name="beschreibung" id="beschreibung" maxlength="100">
<%/** Bild einfügen!*/ %>
				<button type="button">anlegen</button>
			</form>
		</div>
		<div id="footer">
		</div>
	</div>	
</body>
</html>