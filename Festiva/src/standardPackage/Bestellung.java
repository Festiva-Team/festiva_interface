package standardPackage;
import java.util.Date;
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
	
	
	/**
	 * Konstruktor zur Erstellung eines Bestellung-Objekts aus einem Warenkorb-Objekt mit den nachfolgenden Parametern
	 * 
	 * @param p_warenkorb: Warenkorb-Objekt, das in ein Bestellungs-Objekt �berf�hrt werden soll
	 * @param p_perPost: zeigt, ob die Artikel per Post versendet werden sollen
	 */
	public Bestellung (Warenkorb p_warenkorb, boolean p_perPost) {
		this.id = -1;
		this.perPost = p_perPost;
		this.benutzerID = p_warenkorb.benutzerID;
		
		for(Warenkorbelement warenkorbelement : p_warenkorb.listElemente) {
			this.listPositionen.add(new Bestellposition(-1, warenkorbelement.menge, warenkorbelement.artikel.id, warenkorbelement.artikel.beschreibung, warenkorbelement.artikel.preis));
		}
		
	}
}
