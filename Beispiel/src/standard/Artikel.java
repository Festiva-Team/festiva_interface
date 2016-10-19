package standard;

/**
 * Fachklasse für einen Artikel des Webshops
 * 
 * @author Linus Hoppe
 *
 */

public class Artikel {
	public int artikelID;
	public String name;
	public String beschreibung;
	public double einzelpreis;
	public String bildpfad;
	public int kategorieID;
	
	
	/**
	 * Erstellt aus den Übergebenen Parametern ein Artikel-Objekt
	 * 
	 * @param p_artikelID ID des Artikels
	 * @param p_name Artikelname
	 * @param p_beschreibung Artikelbeschreibung
	 * @param p_einzelpreis Preis in € für eine Mengeneinheit des Artikels
	 * @param p_bildpfad Name der Bilddatei des Artikels
	 * @param p_kategorieID ID der Artikelkategorie
	 */
	public Artikel (int p_artikelID, String p_name, String p_beschreibung, double p_einzelpreis, String p_bildpfad, int p_kategorieID)
	{
		this.artikelID = p_artikelID;
		this.name = p_name;
		this.beschreibung = p_beschreibung;
		this.einzelpreis = p_einzelpreis;
		this.bildpfad = p_bildpfad;
		this.kategorieID = p_kategorieID;
	}
}
