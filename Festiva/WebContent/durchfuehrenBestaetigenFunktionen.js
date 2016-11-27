/**
 * Funktionen zur Bestätigung von Nutzereingaben bei wichtigen Aktionen (löschen, Bestellung durchführen,..)
 * 
 * @author Alina Fankhänel
 * 
 */

function artikelLoeschen(id){
	   if(confirm("Möchten Sie den Artikel wirklich löschen?") == true) {
			document.location.href='/Festiva/Artikelverwaltung?aktion=loeschen&artikelid=' + id;
	   } else {
	   		document.location.href='/Festiva/Artikelverwaltung?aktion=aendern&artikelid=' + id;
	   }
}

function festivalLoeschen(id){
	   if(confirm("Achtung! Wenn Sie das Festival löschen, werden automatisch alle dazugehörigen Artikel gelöscht. Möchten Sie fortfahren?") == true) {
		   document.location.href='/Festiva/Festivalverwaltung?aktion=loeschen&festivalid=' + id;
    } else {
 	   document.location.href='/Festiva/Festivalverwaltung?aktion=aendern&festivalid=' + id;
    }
}

function kategorieLoeschen(id){
	   if(confirm("Möchten Sie die Kategorie wirklich löschen?") == true) {
		   document.location.href='/Festiva/Kategorienverwaltung?aktion=loeschen&kategorienid=' + id;
	      } else {
	    	 document.location.href='/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=' + id;
	      }

}

function kundenLoeschen(id){
	   if(confirm("Möchten Sie den aktuellen Kunden wirklich löschen?") == true) {
	   		document.location.href='/Festiva/Kundenverwaltung?aktion=loeschen&kundenid=' + id;
	   } else {
	    	document.location.href='/Festiva/Kundenverwaltung?aktion=aendern&kundenid=' + id;
	   }
}

function kontoLoeschen(id){
	   if(confirm("Achtung! Ihr Konto wird dauerhaft gelöscht. Möchten Sie wirklich fortfahren?") == true) {
		   document.location.href='/Festiva/Benutzerdaten?aktion=loeschen';
	      } else {
	    	 document.location.href='/Festiva/Benutzerdaten?aktion=anzeigen';
	      }
}