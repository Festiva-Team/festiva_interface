<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    	import="standardPackage.*"
	import="java.util.*"
	session="false"
%>
<%
int userid = 0;
String vorname ="";
String nachname ="";
String straße ="";
String iban = "";
String bic = "";
String hausnummer = "";
int plz = 00000;
String ort = "";
String email = "";

if (request.getSession(false) != null)
{
	HttpSession session = request.getSession(false);
	userid = Integer.parseInt(session.getAttribute("userid").toString());
	Benutzer benutzer = BenutzerAdministration.selektiereBenutzerMitID(userid); 
	vorname = benutzer.vorname;
	nachname = benutzer.nachname;
	straße = benutzer.strasse;
	iban = benutzer.iban;
	bic = benutzer.bic;
	hausnummer = benutzer.hausnummer;
	plz = benutzer.plz;
	ort = benutzer.ort;
	email = benutzer.eMailAdresse;
	} else {
		
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Festiva - Meine Daten</title>
</head>
<body>
<div id="webseite">
    <jsp:include page="k_header.jsp">
    	<jsp:param name="active" value="kundendaten"/>
    </jsp:include>
		<div id="main">
			<form action="/Festiva/Kundendaten" method="get">
				<label class="h2">Meine Daten</label>
				<div id="zeile">
					<div id="spaltelinks">
						<label for="vorname">Vorname</label>
						<input type="text" id="vorname" name="vorname" maxlength="30" value=<%=vorname%>>
						<label for="nachname">Nachname</label>
						<input type="text" id="nachname" name="nachname" maxlength="40" value=<%=nachname%>>
						<label for="email">Email</label>
						<input type="email" id="email" name="email" maxlength="50" value=<%=email%>>					
						<label for="iban">IBAN</label>
						<input type="text" id="iban" name="iban" minlength="22" maxlength="22" value=<%=iban%>>
						<label for="bic">BIC</label>
						<input type="text" id="bic" name="bic" minlength="9" maxlength="12" value=<%=bic%>>
					</div>
					<div id="spalterechts">
						<label for="strasse">Straße</label>
						<input type="text" id="strasse" name="strasse" maxlength="50" value=<%=straße%>>
						<label for="hausnummer">Hausnummer</label>
						<input type="text" id="hausnummer" name="hausnummer" minlength="1" maxlength="5" value=<%=hausnummer%>>
						<label for="plz">PLZ</label>
						<input type="text" id="plz" name="plz" minlength="5" maxlength="5" value=<%=plz%>>
						<label for="ort">Ort</label>
						<input type="text" id="ort" name="ort" maxlength="30" value=<%=ort%>>
						<label for="einzugsermächtigungErteilt">Einzugsermächtigung erteilt</label>
	      				<input type="checkbox" id="einzugsermächtigungErteilt"><br>
						<button type="submit" id="rechts">Änderungen speichern</button>
						<% if (request.getSession().getAttribute("antwort") != null) 
						{ %>
						<p><%= request.getSession().getAttribute("antwort") %></p>
						<% } request.getSession().removeAttribute("antwort"); %>
					</div>
				</div>
			</form>
		<div id="leer"></div>
		</div>
		<div id="footer">
		</div>
</div>	
</body>
</html>