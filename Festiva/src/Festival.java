import java.sql.Date;
/**
 * Klasse für ein Festival innerhalb des Webshops
 * 
 * @author Alina Fankhänel
 *
 */
public class Festival {

	public int id;
	public String name;
	public String ort;
	public String kurzbeschreibung;
	public String langbeschreibung;
	public Date startDatum;
	public Date endDatum;
	public String bildpfad;
	public boolean istGelöscht;
	public int kategorienID;
	
	/**
	 * Konstruktor zur Erstellung eines Festival-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID des Festivals
	 * @param p_name: Name des Festivals
	 * @param p_ort: Ort des Festivals
	 * @param p_kurzbeschreibung: Kurzbeschreibung des Festivals
	 * @param p_langebeschreibung: Langbeschreibung des Festivals
	 * @param p_startDatum: Startdatum des Festivals
	 * @param p_endDatum: Enddatum des Festivals
	 * @param p_bildpfad: Pfad zum Bild des Festivals
	 * @param p_istGelöscht: zeigt, ob das Festival logisch gelöscht ist
	 * @param p_kategorienID: eindeutige ID der Kategorie, der das Festival zugeordnet wurde
	 */
	public Festival(int p_id, String p_name, String p_ort, String p_kurzbeschreibung, String p_langbeschreibung, 
			        Date p_startDatum, Date p_endDatum, String p_bildpfad, boolean p_istGelöscht, int p_kategorienID) {
		
		this.id = p_id;
		this.name = p_name;
		this.ort = p_ort;
		this.kurzbeschreibung = p_kurzbeschreibung;
		this.langbeschreibung = p_langbeschreibung;
		this.startDatum = p_startDatum;
		this.endDatum = p_endDatum;
		this.bildpfad = p_bildpfad;
		this.istGelöscht = p_istGelöscht;
		this.kategorienID = p_kategorienID;
	}
	
}
