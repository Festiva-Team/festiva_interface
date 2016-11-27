/**
 * Funktionen zur Durchf�hrung rund um Bestellungen und das in den Warenkorb legen
 * 
 * @author Alina Fankh�nel
 * 
 */

// Ein festival�bergreifender Artikel wird dem Warenkorb hinzugef�gt
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
		if(confirm("Dieser Artikel befindet sich bereits in Ihrem Warenkorb. Soll die ausgew�hlte Menge trotzdem hinzugef�gt werden?") == true)
		  post('/Festiva/Warenkorbverwaltung', {aktion: 'aktualisieren', artikelid: id, menge: menge});	
		} else {	
			post('/Festiva/Warenkorbverwaltung', {aktion: 'hinzufuegen', artikelid: id, menge: menge});	
		}	
	}
}

// Ein Festivalticket wird dem Warenkorb hinzugef�gt
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
			if(confirm("Dieser Artikel befindet sich bereits in Ihrem Warenkorb. Soll die ausgew�hlte Menge trotzdem hinzugef�gt werden?") == true)
		
				post('/Festiva/Warenkorbverwaltung', {aktion: 'aktualisieren', artikelid: id, menge: menge, festivalid: festivalid, maxpreis: maxpreis});	
				
			} else {
			
				post('/Festiva/Warenkorbverwaltung', {aktion: 'hinzufuegen', artikelid: id, menge: menge, festivalid: festivalid, maxpreis: maxpreis});
							
			}	
	}
}

// Die Anzahl eines Warenkorbelements wird im Warenkorb ge�ndert
function anzahlAendern(objekt, id) {
    var x = document.getElementById(objekt.id).value;
    document.location.href='/Festiva/Warenkorbverwaltung?aktion=aendern&elementid=' + id + '&menge=' + x;
}

// Die Versandmethoden (Mail & Post) werden gewechselt
function versenden(objRadio){
// Falls der Radiobutton gesetzt ist und ein neuer Radiobutton gew�hlt wurde
if((objRadio.checked == true) && (objRadio != arrObjRadio[objRadio.name])){
// Aktuelles Objekt merken
arrObjRadio[objRadio.name] = objRadio;
// �nderungen durchf�hren
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