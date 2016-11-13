<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: a_startseiteAdmin.jsp
	# JSP-Aktionen: Anzeige der Startseite des Admins
*/


if (request.getSession(false) == null || request.getSession(false).getAttribute("gruppenid") == null || Integer.parseInt(request.getSession(false).getAttribute("gruppenid").toString()) != 1) {
response.sendRedirect("k_anmelden.jsp");}
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/design.css">
	<title>Festiva - Adminstartseite</title>
</head>
<body>
<div id="webseite">
<jsp:include page="a_headerAdmin.jsp">
	<jsp:param name="active" value="startseiteAdmin"/>
</jsp:include>
	<div id="main">
		<h1>Adminbereich</h1>
		<%= request.getSession().getAttribute("begrüßung") %>
	</div>
	<div id="leer"></div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>
