import java.util.List;
/**
 * Klasse f�r einen Warenkorb innerhalb des Webshops
 * 
 * @author Alina Fankh�nel
 *
 */
public class Warenkorb {
	
	public int id;
	public int benutzerID;
	public List<Warenkorbelement> listElemente;
	
	/**
	 * Konstruktor zur Erstellung eines Warenkorb-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID des Warenkorbs
	 * @param p_benutzerID: eindeutige ID des Benutzers dem der Warenkorb geh�rt
	 * @param p_listElemente: enth�lt alle Warenkorbelemente, die dem Warenkorb zugeordnet sind
	 */
	public Warenkorb(int p_id, int p_benutzerID, List<Warenkorbelement> p_listElemente) {
		this.id = p_id;
		this.benutzerID = p_benutzerID;
		this.listElemente = p_listElemente;
	}
	
}
