import java.sql.Date;
import java.util.List;

/**
 * Klasse f�r eine Bestellung innerhalb des Webshops
 * 
 * @author Alina Fankh�nel
 *
 */
public class Bestellung {

	public int id;
	public Date datum;
	public boolean perPost;
	public int benutzerID;
	public List<Bestellposition> listPositionen;
	
	/**
	 * Konstruktor zur Erstellung eines Bestellung-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID der Bestellung
	 * @param p_datum: Datum, an dem die Bestellung durchgef�hrt wurde
	 * @param p_perPost: zeigt, ob die Artikel per Post versendet werden sollen
	 * @param p_benutzerID: eindeutige ID des Benutzers, der die Bestellung durchgef�hrt hat
	 * @param p_listPositionen: enth�lt alle Bestellpositionen, die der Bestellung zugeordnet sind
	 */
	public Bestellung (int p_id, Date p_datum, boolean p_perPost, int p_benutzerID, List<Bestellposition> p_listPositionen) {
		this.id = p_id;
		this.datum = p_datum;
		this.perPost = p_perPost;
		this.benutzerID = p_benutzerID;
		this.listPositionen = p_listPositionen;
	}
}
