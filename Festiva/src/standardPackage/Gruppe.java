package standardPackage;
/**
 * Klasse für eine Gruppe innerhalb des Webshops
 * 
 * @author Alina Fankhänel
 *
 */
public class Gruppe {
	public int id;
	public String beschreibung;

	/**
	 * Konstruktor zur Erstellung eines Gruppen-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID der Gruppe
	 * @param p_beschreibung: Beschreibung der Gruppe
	 */
	public Gruppe(int p_id, String p_beschreibung){
		this.id = p_id;
		this.beschreibung = p_beschreibung;
	}
}
