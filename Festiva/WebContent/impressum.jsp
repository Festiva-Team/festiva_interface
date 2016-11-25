<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="standardPackage.*" import="java.util.*" import="java.text.*" import="java.io.File"
    session="false"	%>
<%
/** 
	# Autor: Nicola Kloke
	# JSP-Name: impressum.jsp
	#              (1) Anzeige des Impressums
**/ %>
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
<jsp:include page="k_header.jsp">
	<jsp:param name="active" value="startseiteAdmin"/>
</jsp:include>
	<div id="main">
		<h1>Impressum</h1>
	<h2>Angaben gemäß § 5 TMG:</h2>
	<p id="text">Festiva GmbH<br />
				 Fürstenallee, 5<br />
	             33102 Paderborn
	</p>
	<h2>Kontakt:</h2>
		<table class="tabelle">
		<tbody>
		<tr>
			<td>Telefon:</td>
			<td>05251123456789</td></tr>
			<tr><td>Telefax:</td>
			<td>05251123456780</td></tr>
			<tr><td>E-Mail:</td>
			<td>info@festiva.de</td>
		</tr>
		</tbody>
		</table>
	<p> </p>
	<p id="text">Quelle: <em><a href="https://www.e-recht24.de/artikel/datenschutz/209.html">https://www.e-recht24.de</a></em></p>
	
	<h1>Datenschutzerklärung</h1>
	<div class="zeile">
		<p id="text"><strong>Datenschutzerklärung für die Nutzung von etracker</strong></p> 
		<p id="text">Unsere Webseite nutzt den Analysedienst etracker. Anbieter ist die etracker GmbH, Erste Brunnenstraße 1, 20459 Hamburg Germany. Aus den Daten können unter einem Pseudonym Nutzungsprofile erstellt werden. Dazu können Cookies eingesetzt werden. Bei Cookies handelt es sich um kleine Textdateien, die lokal im Zwischenspeicher Ihres Internet-Browsers gespeichert werden. Die Cookies ermöglichen es, Ihren Browser wieder zu erkennen. Die mit den etracker-Technologien erhobenen Daten werden ohne die gesondert erteilte Zustimmung des Betroffenen nicht genutzt, Besucher unserer Website persönlich zu identifizieren und werden nicht mit personenbezogenen Daten über den Träger des Pseudonyms zusammengeführt.</p> <p id="text">Der Datenerhebung und -speicherung können Sie jederzeit mit Wirkung für die Zukunft widersprechen. Um einer Datenerhebung und -speicherung Ihrer Besucherdaten für die Zukunft zu widersprechen, können Sie unter nachfolgendem Link ein Opt-Out-Cookie von etracker beziehen, dieser bewirkt, dass zukünftig keine Besucherdaten Ihres Browsers bei etracker erhoben und gespeichert werden: <a href="http://www.etracker.de/privacy?et=V23Jbb">http://www.etracker.de/privacy?et=V23Jbb</a></p> <p id="text">Dadurch wird ein Opt-Out-Cookie mit dem Namen "cntcookie" von etracker gesetzt. Bitte löschen Sie diesen Cookie nicht, solange Sie Ihren Widerspruch aufrecht erhalten möchten. Weitere Informationen finden Sie in den Datenschutzbestimmungen von etracker: <a href="http://www.etracker.com/de/datenschutz.html">http://www.etracker.com/de/datenschutz.html</a></p><p> </p>
		<p id="text"><strong>Auskunft, Löschung, Sperrung</strong></p> 
		<p id="text">Sie haben jederzeit das Recht auf unentgeltliche Auskunft über Ihre gespeicherten personenbezogenen Daten, deren Herkunft und Empfänger und den Zweck der Datenverarbeitung sowie ein Recht auf Berichtigung, Sperrung oder Löschung dieser Daten. Hierzu sowie zu weiteren Fragen zum Thema personenbezogene Daten können Sie sich jederzeit unter der im Impressum angegebenen Adresse an uns wenden.</p><p> </p>
		<p id="text"><strong>Cookies</strong></p> 
		<p id="text">Die Internetseiten verwenden teilweise so genannte Cookies. Cookies richten auf Ihrem Rechner keinen Schaden an und enthalten keine Viren. Cookies dienen dazu, unser Angebot nutzerfreundlicher, effektiver und sicherer zu machen. Cookies sind kleine Textdateien, die auf Ihrem Rechner abgelegt werden und die Ihr Browser speichert.</p> <p id="text">Die meisten der von uns verwendeten Cookies sind so genannte „Session-Cookies“. Sie werden nach Ende Ihres Besuchs automatisch gelöscht. Andere Cookies bleiben auf Ihrem Endgerät gespeichert, bis Sie diese löschen. Diese Cookies ermöglichen es uns, Ihren Browser beim nächsten Besuch wiederzuerkennen.</p> <p id="text">Sie können Ihren Browser so einstellen, dass Sie über das Setzen von Cookies informiert werden und Cookies nur im Einzelfall erlauben, die Annahme von Cookies für bestimmte Fälle oder generell ausschließen sowie das automatische Löschen der Cookies beim Schließen des Browser aktivieren. Bei der Deaktivierung von Cookies kann die Funktionalität dieser Website eingeschränkt sein.</p><p> </p>
		<p id="text"><strong>Server-Log-Files</strong></p> 
		<p id="text">Der Provider der Seiten erhebt und speichert automatisch Informationen in so genannten Server-Log Files, die Ihr Browser automatisch an uns übermittelt. <p id="text"><br />Diese Daten sind nicht bestimmten Personen zuordenbar. Eine Zusammenführung dieser Daten mit anderen Datenquellen wird nicht vorgenommen. Wir behalten uns vor, diese Daten nachträglich zu prüfen, wenn uns konkrete Anhaltspunkte für eine rechtswidrige Nutzung bekannt werden.</p><p> </p>
	</div>
	</div>
	<div id="leer"></div>
<jsp:include page="k_footer.jsp">
	<jsp:param name="active" value="startseite"/>
</jsp:include>
</div>	
</body>
</html>
