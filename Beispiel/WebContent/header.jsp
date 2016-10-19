<%@page
	import="standard.*"
	session="false"
%>
<%

	/** 
	# Autor: Linus Hoppe
	# JSP-Name: header.jsp
	# JSP-Aktionen: 1) Darstellung einer Kopfzeile (Menüleiste)
					2) Unterschiedliche Menü-Elemente je nach Session und Nutzerrolle
	*/

	String PFAD_ZUM_WEBCONTENT = Konfiguration.gibPfadZumWebContent();
	String PFAD_ZUM_CONTROLLER = Konfiguration.gibPfadZumController();
	
	String benutzerBezeichnung = "";
	int gruppenId = 1;
	if (request.getSession(false) != null)
	{
		HttpSession session = request.getSession(false);
		Anwender _anwender = AnwenderVerwaltung.gibAnwender(Integer.parseInt(session.getAttribute("userid").toString()));
		benutzerBezeichnung = _anwender.vorname + " " + _anwender.nachname;
		gruppenId = _anwender.gruppeID;
	}
	
	String active = request.getParameter("active");
%>

<script src="<%=PFAD_ZUM_WEBCONTENT%>/js/sha1.js"></script>

<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
        <%if (gruppenId == 1) {%>
            <div class="container">
                <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="brand" href="<%=PFAD_ZUM_CONTROLLER%>?seite=startseite">Grillzone.de</a>
                <div class="nav-collapse collapse">
                    <ul class="nav">
                        <li <%if (active.equals("startseite")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=startseite">Startseite</a></li>
                        <li <%if (active.equals("produktsuche")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=produktsuche&suche=">Produktsuche</a></li>
                    <% if (!request.isRequestedSessionIdValid()) {%>
                    	<li <%if (active.equals("registrierung")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=registrierung">Registrierung</a></li>
                    </ul>
                    <form class="navbar-form pull-right" name="login" onsubmit="document.login.passwortHash.value = Sha1.hash(document.login.passwort.value); document.login.passwort.value=''" 
                    		method="post" action="<%=PFAD_ZUM_CONTROLLER%>?seite=login">
                        <input class="span2" type="text" name="email" placeholder="E-Mail-Adresse">
                        <input class="span2" type="password" name="passwort" placeholder="Passwort">
                        <input type="hidden" name="passwortHash" value="">
                        <button type="submit" class="btn">Einloggen</button>
                        <!-- <a href="#" role="button" class="btn" data-toggle="modal">Einloggen</a> -->
                    </form>
                    <%} else {%>
                    </ul>
                    <ul class="nav pull-right">
                    	<li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Willkommen, <%=benutzerBezeichnung%><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li <%if (active.equals("warenkorb")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=warenkorb">Warenkorb</a></li>
                                <li <%if (active.equals("bestelluebersicht")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=bestelluebersicht">Bestellübersicht</a></li>
                                <li <%if (active.equals("profil")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=profil">Meine Daten</a></li>
                                <li><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=logout">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                    <%}%>
                </div>
            </div>
            <%} else {%>
        	<div class="container">
        		<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <span class="brand">Grillzone.de</span>
        		<div class="nav-collapse collapse">
        			<ul class="nav">
                        <li <%if (active.equals("benutzerverwaltung")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=benutzerverwaltung">Benutzerverwaltung</a></li>
                    </ul>
        		</div>
        		     <ul class="nav pull-right">
                    	<li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Willkommen, <%=benutzerBezeichnung%><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li <%if (active.equals("profil")) {%>class="active"<%}%>><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=profil">Meine Daten</a></li>
                                <li><a href="<%=PFAD_ZUM_CONTROLLER%>?seite=logout">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
        	</div>
        	<%}%>
        </div>
    </div>