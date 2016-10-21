/**
 * Klasse für ein Warenkorbelement innerhalb eines Warenkorbs
 * 
 * @author Alina Fankhänel
 *
 */
public class Warenkorbelement {
	
	public int id;
	public int menge;
	public Artikel artikel;
	
	/**
	 * Konstruktor zur Erstellung eines Warenkorbelement-Objekts mit den nachfolgenden Parametern
	 * (Verwendung einer aktuellen Referenz auf ein Artikel-Objekt, da immer ein aktueller Preis und eine aktuelle Beschreibung
	 *  mit dem Warenkorbelement verknüpft sein muss)
	 * 
	 * @param p_id: eindeutige ID des Warenkorbelements
	 * @param p_menge: gewünschte Menge des Warenkorbelements
	 * @param p_artikel: Artikel auf den sich das Warenkorbelement bezieht
	 */
	public Warenkorbelement(int p_id, int p_menge, Artikel p_artikel) {
		this.id = p_id;
		this.menge = p_menge;
		this.artikel = p_artikel;
	}

}
