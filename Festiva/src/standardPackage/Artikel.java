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
	public String details;
	public float preis;
	public boolean istGel�scht;
	public String bildpfad;
	public int festivalID;

	
	/**
	 * Konstruktor zur Erstellung eines Artikel-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id eindeutige ID des Artikels
	 * @param p_beschreibung Beschreibung des Artikels
	 * @param p_details Details zum Artikel
	 * @param p_preis Preis des Artikels
	 * @param p_istGel�scht zeigt, ob der Artikel logisch gel�scht wurde
	 * @param p_bildpfad gibt den Bildpfad f�r das Bild zur�ck
	 * @param p_festivalID eindeutige ID des Festivals, zu dem der Artikel geh�rt
	 */
	public Artikel(int p_id, String p_beschreibung, String p_details, float p_preis, boolean p_istGel�scht, String p_bildpfad, int p_festivalID) {
		this.id = p_id;
		this.beschreibung = p_beschreibung;
		this.details = p_details;
		this.preis = p_preis;
		this.istGel�scht = p_istGel�scht;
		this.bildpfad = p_bildpfad;
		this.festivalID = p_festivalID;
	}
	

}
