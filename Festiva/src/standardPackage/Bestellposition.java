package standardPackage;
/**
 * Klasse für eine Bestellposition innnerhalb einer Bestellung
 * 
 * @author Alina Fankhänel
 *
 */
public class Bestellposition {
	
	public int id;
	public int menge;
	public int artikelID;
	public String beschreibung;
	public float preis;
	
	/**
	 * Konstruktor zur Erstellung eines Bestellposition-Objekts mit den nachfolgenden Parametern
	 * (keine Verwendung einer aktuellen Referenz auf ein Artikel-Objekt, da sich Preis und Beschreibung im Laufe der Zeit verändern können
	 *  und in der Bestellhistorie immer die Werte, die bei Bestellungsabschluss aktuell waren, verfügbar bleiben sollen)
	 * 
	 * @param p_id eindeutige ID der Bestellposition
	 * @param p_menge bestellte Menge des Artikels
	 * @param p_artikelID eindeutige ID des Artikels, der bestellt wurde
	 * @param p_beschreibung Beschreibung des bestellten Artikels
	 * @param p_preis Preis des bestellten Artikels
	 */
	public Bestellposition(int p_id, int p_menge, int p_artikelID, String p_beschreibung, float p_preis) {
		this.id = p_id;
		this.menge = p_menge;
		this.artikelID = p_artikelID;
		this.beschreibung = p_beschreibung;
		this.preis = p_preis;
	}

}
