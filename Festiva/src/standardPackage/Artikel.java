package standardPackage;
/**
 * Klasse für einen Artikel innerhalb des Webshops
 * 
 * @author Alina Fankhänel
 *
 */
public class Artikel {
	
	public int id;
	public String beschreibung;
	public float preis;
	public boolean istGelöscht;
	public int festivalID;
	
	/**
	 * Konstruktor zur Erstellung eines Artikel-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID des Artikels
	 * @param p_beschreibung: Beschreibung des Artikels
	 * @param p_preis: Preis des Artikels
	 * @param p_istGelöscht: zeigt, ob der Artikel logisch gelöscht wurde
	 * @param p_festivalID: eindeutige ID des Festivals, zu dem der Artikel gehört
	 */
	public Artikel(int p_id, String p_beschreibung, float p_preis, boolean p_istGelöscht, int p_festivalID) {
		this.id = p_id;
		this.beschreibung = p_beschreibung;
		this.preis = p_preis;
		this.istGelöscht = p_istGelöscht;
		this.festivalID = p_festivalID;
	}
	

}
