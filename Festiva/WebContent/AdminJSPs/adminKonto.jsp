<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<title>Insert title here</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="headerAdmin.jsp">
    	<jsp:param name="active" value="adminKonto"/>
    </jsp:include>
		<div id="main">
		<form action="adminKonto.jsp">
			<label class="h2" form="adminKonto">Mein Konto</label>
			<% /** Daten des Admins aus DB aufrufen und in value packen */ %>
			<label>Email</label>
			<input type="email" size="30" value="">
			<label>Passwort</label>
			<input type="password" size="30" value=""> 
			<label>Passwort best�tigen</label>
			<input type="password" size="30" value=""> 
			<button>speichern</button>
		</form>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>