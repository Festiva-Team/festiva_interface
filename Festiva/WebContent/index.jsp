<html> 
<head>
<title>JSP forward</title>
</head>
<body> 
<p align="center">Main JSP page</p>
<jsp:forward page="/Produktverwaltung">
<jsp:param name="aktion" value="s_anzeigen" ></jsp:param>
</jsp:forward>

</body> 
</html>