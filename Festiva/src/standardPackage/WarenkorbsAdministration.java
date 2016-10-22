package standardPackage;
/**
 * Klasse zur Administration von Warenk�rben
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Warenk�rben mit den zugeh�rigen Warenkorbelementen aus der Datenbank
 * 
 * @author Alina Fankh�nel
 *
 */
public class WarenkorbsAdministration {
	
	/**
	 * Erstellt f�r das �bergeben Bestellungs-Objekt die Eintr�ge in der Datenbank
	 * verwendete Tabellen: bestellungen, bestellpositionen
	 * 
	 * @param p_bestellung: Bestellungs-Objekt, das in die Datenbanktabellen geschrieben werden soll
	 */
	public static void erstelleBestellung(Bestellung p_bestellung)
	{
		// Eintragungen in die Tabelle "bestellungen"
		String insertBefehl = "INSERT INTO festiva.bestellungen " +
							  "(perpost, benutzer_id) " +
							  "VALUES (%d, %d)";
		insertBefehl = String.format(insertBefehl, p_bestellung.perPost?1:0, p_bestellung.benutzerID);
		p_bestellung.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
		
		// Eintragungen in die Tabelle "bestellpositionen"
		for(Bestellposition bestellposition : p_bestellung.listPositionen)
		{
			insertBefehl = "INSERT INTO festiva.bestellpositionen " + 
						   "(menge, artikel_id, beschreibung, preis, bestellungen_id) " +
						   "VALUES (%d, %d, %s, %f, %d)";
			insertBefehl = String.format(insertBefehl, bestellposition.menge, bestellposition.artikelID, bestellposition.beschreibung, bestellposition.preis, p_bestellung.id);
			bestellposition.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
		}
	}

}
