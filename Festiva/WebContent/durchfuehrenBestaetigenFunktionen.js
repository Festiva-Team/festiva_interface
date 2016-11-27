/**
 * Funktionen zur Best�tigung von Nutzereingaben bei wichtigen Aktionen (l�schen, Bestellung durchf�hren,..)
 * 
 * @author Alina Fankh�nel
 * 
 */

function artikelLoeschen(id){
	   if(confirm("M�chten Sie den Artikel wirklich l�schen?") == true) {
			document.location.href='/Festiva/Artikelverwaltung?aktion=loeschen&artikelid=' + id;
	   } else {
	   		document.location.href='/Festiva/Artikelverwaltung?aktion=aendern&artikelid=' + id;
	   }
}

function festivalLoeschen(id){
	   if(confirm("Achtung! Wenn Sie das Festival l�schen, werden automatisch alle dazugeh�rigen Artikel gel�scht. M�chten Sie fortfahren?") == true) {
		   document.location.href='/Festiva/Festivalverwaltung?aktion=loeschen&festivalid=' + id;
    } else {
 	   document.location.href='/Festiva/Festivalverwaltung?aktion=aendern&festivalid=' + id;
    }
}

function kategorieLoeschen(id){
	   if(confirm("M�chten Sie die Kategorie wirklich l�schen?") == true) {
		   document.location.href='/Festiva/Kategorienverwaltung?aktion=loeschen&kategorienid=' + id;
	      } else {
	    	 document.location.href='/Festiva/Kategorienverwaltung?aktion=aendern&kategorienid=' + id;
	      }

}

function kundenLoeschen(id){
	   if(confirm("M�chten Sie den aktuellen Kunden wirklich l�schen?") == true) {
	   		document.location.href='/Festiva/Kundenverwaltung?aktion=loeschen&kundenid=' + id;
	   } else {
	    	document.location.href='/Festiva/Kundenverwaltung?aktion=aendern&kundenid=' + id;
	   }
}

function kontoLoeschen(id){
	   if(confirm("Achtung! Ihr Konto wird dauerhaft gel�scht. M�chten Sie wirklich fortfahren?") == true) {
		   document.location.href='/Festiva/Benutzerdaten?aktion=loeschen';
	      } else {
	    	 document.location.href='/Festiva/Benutzerdaten?aktion=anzeigen';
	      }
}