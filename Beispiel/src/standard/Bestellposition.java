package standard;

/**
 * Fachklasse eine Bestellposition (innnerhalb einer Bestellung)
 * 
 * @author Nico Dübeler
 *
 */
public class Bestellposition 
{
	public int menge;
	public int position;
	public Artikel artikel;
	
	/**
	 * Erstellt aus den übergebenen Parametern ein Bestellpositions-Objekt
	 * 
	 * @param p_menge Artikelmenge
	 * @param p_position Position, an der die Bestellposition innerhalb der Bestellung steht
	 * @param p_artikel Artikel, auf den die Bestellposition verweist
	 */
	public Bestellposition(int p_menge, int p_position, Artikel p_artikel)
	{
		this.menge = p_menge;
		this.position = p_position;
		this.artikel = p_artikel;
	}
}
