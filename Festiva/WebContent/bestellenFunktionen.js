/**
 * Funktionen zur Durchführung rund um Bestellungen und das in den Warenkorb legen
 * 
 * @author Alina Fankhänel
 * 
 */

// Ein festivalübergreifender Artikel wird dem Warenkorb hinzugefügt
function artikeldetailsEinfuegen(id, elemente){	
	if(elemente == null) {
		document.location.href='/Festiva/Warenkorbverwaltung?aktion=anmelden';
	} else {
		var vorhanden = false;
		for (var i = 0; i < elemente.length; i++) {
			if (elemente[i] == id) {
				vorhanden = true;
			}
		}
		
		var menge = document.getElementById('anzahl'+id).value;
		
		if(vorhanden == true) {
		if(confirm("Dieser Artikel befindet sich bereits in Ihrem Warenkorb. Soll die ausgewählte Menge trotzdem hinzugefügt werden?") == true)
		  post('/Festiva/Warenkorbverwaltung', {aktion: 'aktualisieren', artikelid: id, menge: menge});	
		} else {	
			post('/Festiva/Warenkorbverwaltung', {aktion: 'hinzufuegen', artikelid: id, menge: menge});	
		}	
	}
}

// Ein Festivalticket wird dem Warenkorb hinzugefügt
function festivaldetailsEinfuegen(id, elemente, festivalid, maxpreis){
	
	if(elemente == null) {
		document.location.href='/Festiva/Warenkorbverwaltung?aktion=anmelden';
	} else {
   
			var vorhanden = false;
			for (var i = 0; i < elemente.length; i++) {
				if (elemente[i] == id) {
					vorhanden = true;
				}
			}
			
			var menge = document.getElementById('anzahl'+id).value;
			
			if(vorhanden == true) {
			if(confirm("Dieser Artikel befindet sich bereits in Ihrem Warenkorb. Soll die ausgewählte Menge trotzdem hinzugefügt werden?") == true)
		
				post('/Festiva/Warenkorbverwaltung', {aktion: 'aktualisieren', artikelid: id, menge: menge, festivalid: festivalid, maxpreis: maxpreis});	
				
			} else {
			
				post('/Festiva/Warenkorbverwaltung', {aktion: 'hinzufuegen', artikelid: id, menge: menge, festivalid: festivalid, maxpreis: maxpreis});
							
			}	
	}
}

// Die Anzahl eines Warenkorbelements wird im Warenkorb geändert
function anzahlAendern(objekt, id) {
    var x = document.getElementById(objekt.id).value;
    document.location.href='/Festiva/Warenkorbverwaltung?aktion=aendern&elementid=' + id + '&menge=' + x;
}

// Die Versandmethoden (Mail & Post) werden gewechselt
function versenden(objRadio){
// Falls der Radiobutton gesetzt ist und ein neuer Radiobutton gewählt wurde
if((objRadio.checked == true) && (objRadio != arrObjRadio[objRadio.name])){
// Aktuelles Objekt merken
arrObjRadio[objRadio.name] = objRadio;
// Änderungen durchführen
switch(objRadio.value){
  case "post"  : 
	            
	            post('/Festiva/Warenkorbverwaltung', {aktion: 'p_versand'});
                       break;
  case "mail" : 
	  			
  				post('/Festiva/Warenkorbverwaltung', {aktion: 'm_versand'});	
                       break;
}
}
}