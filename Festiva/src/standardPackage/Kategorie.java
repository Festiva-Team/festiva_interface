package standardPackage;
/**
 * Klasse für eine Kategorie innerhalb des Webshops
 * 
 * @author Alina Fankhänel
 *
 */
public class Kategorie {

	public int id;
	public String name;
	public String beschreibung;
	public String bildpfad;
	public boolean istGelöscht;
	
	/**
	 * Konstruktor zur Erstellung eines Kategorie-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id eindeutige ID der Kategorie
	 * @param p_name Name der Kategorie
	 * @param p_beschreibung Beschreibung der Kategorie
	 * @param p_bildpfad Pfad zum Bild der Kategorie
	 * @param p_istGelöscht zeigt, ob die Kategorie logisch gelöscht ist
	 */
	public Kategorie(int p_id, String p_name, String p_beschreibung, String p_bildpfad, boolean p_istGelöscht) {
		this.id = p_id;
		this.name = p_name;
		this.beschreibung = p_beschreibung;
		this.bildpfad = p_bildpfad;
		this.istGelöscht = p_istGelöscht;
	}
}
