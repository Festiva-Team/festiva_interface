<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: footer.jsp
	# JSP-Aktionen: Definiert den Footer für einen Besucher und einen Kunden.
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
<title>Footer</title>
</head>
<body>
</body>
<footer>
	<div id="footer"><b id="footertext">&copy; 2016 Festiva - Developed by Alina Fankhänel, Timo Schlüter & Nicola Kloke &nbsp&nbsp&nbsp&nbsp&nbsp </b>      <a href="impressum.jsp" style="color: white">Impressum</a></div> 
</footer>
</html>

