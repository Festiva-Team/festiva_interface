<%@page
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../CSS/design.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div id="webseite">
		<jsp:include page="header.jsp">
    		<jsp:param name="active" value="warenkorb"/>
    	</jsp:include>
    	<div id="main">
		            <div class="span9">
		                <div class="zeile">
		                    <div class="span12"><h3>artikel.name%></h3></div>
		                </div>
		                <div class="zeile">
		                    <div class="spalte1"><b>Beschreibung</b></div>
		                    <div class="spalte2">artikel.beschreibung%></div>
		                </div>
		                <div class="zeile">
		                    <div class="spalte1"><b>Einzelpreis:</b></div>
		                    <div class="spalte2">artikel.einzelpreis)%> &euro;</div>
		                </div>
		                <div class="zeile">
		                    <div class="spalte1"><b>Anzahl:</b></div>
		                    <div class="spalte2">anzahl%></div>
		                </div>
		                <div class="zeile">
		                    <div class="spalte1"><b>Gesamtpreis:</b></div>
		                    <div class="spalte2"><b>artikel.einzelpreis*anzahl)%> &euro;</b></div>
		                </div>
		            </div>
		</div>
	</div>
</body>
</html>