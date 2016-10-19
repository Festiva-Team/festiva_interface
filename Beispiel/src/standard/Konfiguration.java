package standard;

import java.util.*;

/**
 * Klasse mit statischen Methode zur Ausgabe von Konfigurationselementen
 * 
 * @author Nico D�beler
 *
 */

public class Konfiguration {
	private static String PFAD_ZUM_WEBCONTENT = "/Grillzone";
	private static String PFAD_ZUM_CONTROLLER = "/Grillzone/Grillzone";
	private static HashMap<Integer, String> statusKonfiguration = null;
	private static int MAX_ANZAHL_PRO_ARTIKEL = 10;
	private static int MIN_PASSWORT_LAENGE = 5;
	
	/**
	 * Gibt den Pfad zum WebContent-Ordner zur�ck
	 * @return Pfad zum WebContent-Ordner
	 */
	public static String gibPfadZumWebContent()
	{
		return PFAD_ZUM_WEBCONTENT;
	}
	
	/**
	 * Gibt den Pfad zum Controller zur�ck
	 * @return Pfad zum Controller
	 */
	public static String gibPfadZumController()
	{
		return PFAD_ZUM_CONTROLLER;
	}
	
	/**
	 * Gibt die maximale Anzahl zur�ck, die man pro Artikel in den Warenkorb legen kann
	 * @return maximale Anzahl
	 */
	public static int gibMaxAnzahlProArtikel()
	{
		return MAX_ANZAHL_PRO_ARTIKEL;
	}
	
	/**
	 * Gibt eine HashMap<Dauer, Bezeichnung> mit den verschiedenen Status zur�ck, die eine Bestellung annehmen kann
	 * @return HashMap mit Statuselementen
	 */
	public static HashMap<Integer, String> gibStatusKonfiguration()
	{
		if(statusKonfiguration == null)
		{
			statusKonfiguration = new HashMap<>();
			statusKonfiguration.put(0, "Bestellt");
			statusKonfiguration.put(1, "Bezahlt");
			statusKonfiguration.put(2, "Versendet");
			statusKonfiguration.put(5, "Geliefert");			
		}
		
		return statusKonfiguration;
	}

	/**
	 * Gibt die Mindestl�nge zur�ck, die ein Passwort haben muss
	 * 
	 * @return Mindestl�nge
	 */
	public static int gibMinPasswortLaenge ()
	{
		return MIN_PASSWORT_LAENGE;
	}
}