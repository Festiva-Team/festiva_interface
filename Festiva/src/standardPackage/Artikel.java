package standardPackage;
/**
 * Klasse f�r einen Artikel innerhalb des Webshops
 * 
 * @author Alina Fankh�nel
 *
 */
public class Artikel {
	
	public int id;
	public String beschreibung;
	public float preis;
	public boolean istGel�scht;
	public int festivalID;
	
	/**
	 * Konstruktor zur Erstellung eines Artikel-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID des Artikels
	 * @param p_beschreibung: Beschreibung des Artikels
	 * @param p_preis: Preis des Artikels
	 * @param p_istGel�scht: zeigt, ob der Artikel logisch gel�scht wurde
	 * @param p_festivalID: eindeutige ID des Festivals, zu dem der Artikel geh�rt
	 */
	public Artikel(int p_id, String p_beschreibung, float p_preis, boolean p_istGel�scht, int p_festivalID) {
		this.id = p_id;
		this.beschreibung = p_beschreibung;
		this.preis = p_preis;
		this.istGel�scht = p_istGel�scht;
		this.festivalID = p_festivalID;
	}
	

}
