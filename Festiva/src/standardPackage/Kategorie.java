package standardPackage;
/**
 * Klasse f�r eine Kategorie innerhalb des Webshops
 * 
 * @author Alina Fankh�nel
 *
 */
public class Kategorie {

	public int id;
	public String name;
	public String beschreibung;
	public String bildpfad;
	public boolean istGel�scht;
	
	/**
	 * Konstruktor zur Erstellung eines Kategorie-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id eindeutige ID der Kategorie
	 * @param p_name Name der Kategorie
	 * @param p_beschreibung Beschreibung der Kategorie
	 * @param p_bildpfad Pfad zum Bild der Kategorie
	 * @param p_istGel�scht zeigt, ob die Kategorie logisch gel�scht ist
	 */
	public Kategorie(int p_id, String p_name, String p_beschreibung, String p_bildpfad, boolean p_istGel�scht) {
		this.id = p_id;
		this.name = p_name;
		this.beschreibung = p_beschreibung;
		this.bildpfad = p_bildpfad;
		this.istGel�scht = p_istGel�scht;
	}
}
