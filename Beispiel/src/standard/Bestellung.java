package standard;

import java.util.*;

/**
 * Fachklasse einer Webshop-Bestellung
 * 
 * @author Linus Hoppe
 *
 */
public class Bestellung 
{
	public int bestellungID;
	public Date bestelldatum;
	public int anwenderID;
	public List<Bestellposition> lstBestellposition;
	
	/**
	 * Erstellt aus den �bergebenen Parametern ein Bestellungs-Objekt
	 * 
	 * @param p_bestellungID Id der Bestellung
	 * @param p_bestelldatum Datum, an dem die Bestellung ausgef�hrt wurde
	 * @param p_anwenderID ID des Anwenders, der die Bestellung get�tigt hat
	 * @param p_lstBestellposition Eine Liste von Objekten der Klasse Bestellposition
	 */
	public Bestellung(int p_bestellungID, Date p_bestelldatum, int p_anwenderID, List<Bestellposition> p_lstBestellposition)
	{
		this.bestellungID = p_bestellungID;
		this.bestelldatum = p_bestelldatum;
		this.anwenderID = p_anwenderID;
		this.lstBestellposition = p_lstBestellposition;
	}
}