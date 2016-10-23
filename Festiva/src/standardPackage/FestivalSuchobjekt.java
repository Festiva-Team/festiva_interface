package standardPackage;
import java.util.Date;
/**
 * Klasse für ein Festival innerhalb des Webshops
 * 
 * @author Alina Fankhänel
 *
 */
public class FestivalSuchobjekt {

	public int id;
	public String name;
	public String ort;
	public String kurzbeschreibung;
	public Date startDatum;
	public Date endDatum;
	public float vonPreis;
	public float bisPreis;
	public int kategorienID;
	
	/**
	 * Konstruktor zur Erstellung eines Festival-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID des Festivals
	 * @param p_name: Name des Festivals
	 * @param p_ort: Ort des Festivals
	 * @param p_kurzbeschreibung: Kurzbeschreibung des Festivals
	 * @param p_startDatum: Startdatum des Festivals
	 * @param p_endDatum: Enddatum des Festivals
	 * @param p_vonPreis: günstigstes Ticket des Festivals
	 * @param p_bisPreis: teuerstes Ticket des Festivals
	 * @param p_kategorienID: eindeutige ID der Kategorie, der das Festival zugeordnet wurde
	 */
	public FestivalSuchobjekt(int p_id, String p_name, String p_ort, String p_kurzbeschreibung, Date p_startDatum, Date p_endDatum, 
			        		  float p_vonPreis, float p_bisPreis, int p_kategorienID) {
		
		this.id = p_id;
		this.name = p_name;
		this.ort = p_ort;
		this.kurzbeschreibung = p_kurzbeschreibung;
		this.startDatum = p_startDatum;
		this.endDatum = p_endDatum;
		this.vonPreis = p_vonPreis;
		this.bisPreis = p_bisPreis;
		this.kategorienID = p_kategorienID;
	}
	
}
