package standard;

/**
 * Fachklasse für eine Artikel-Kategorie
 * 
 * @author Nico Dübeler
 *
 */
public class Kategorie {
	public int kategorieID;
	public String name;
	public String beschreibung;
	public String bildpfad;
	
	/**
	 * Erstellt ein Kategorie-Objekt aus den übergebenen Parametern
	 * @param p_kategorieID ID der Kategorie
	 * @param p_name Name der Kategorie
	 * @param p_beschreibung Beschreibung der Kategorie
	 * @param p_bildpfad Pfad zum Kategorie-Bild
	 */
	public Kategorie(int p_kategorieID, String p_name, String p_beschreibung, String p_bildpfad)
	{
		this.kategorieID = p_kategorieID;
		this.name = p_name;
		this.beschreibung = p_beschreibung;
		this.bildpfad = p_bildpfad;
	}
}
