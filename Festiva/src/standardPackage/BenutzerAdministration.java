package standardPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * Klasse zur Administration von Benutzern
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Benutzern (Kunden und/oder Administratoren) aus der Datenbank
 * 
 * @author Alina Fankh�nel
 *
 */
public class BenutzerAdministration {

	/**
	 * Erstellt f�r das �bergebene Benutzer-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_benutzer: Benutzer-Objekt, das erstellt werden soll
	 */
	public static void erstelleKunden(Benutzer p_benutzer)
	{		
		String insertBefehl = "INSERT INTO festiva.benutzer " +
							   "(vorname, nachname, strasse, hausnummer, plz, ort, emailadresse, passworthash, iban, bic, gruppen_id) " +
							   "VALUES ('%s', '%s', '%s', '%s', '%d', '%s', '%s', '%s', '%s', '%s', '%d')";
		
		insertBefehl = String.format(insertBefehl, p_benutzer.vorname, p_benutzer.nachname, p_benutzer.strasse, p_benutzer.hausnummer, p_benutzer.plz, p_benutzer.ort, p_benutzer.eMailAdresse, p_benutzer.passwortHash, p_benutzer.iban, p_benutzer.bic, p_benutzer.gruppenID);
		p_benutzer.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
	}
	
	
	/**
	 * Aktualisiert f�r das �bergebene Benutzer-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_benutzer: Benutzer-Objekt, das in der Datenbank aktualisiert werden soll
	 */
	public static void aktualisiereBenutzer(Benutzer p_benutzer)
	{	
		String updateBefehl = "UPDATE festiva.benutzer " +
							  "SET vorname = '%s', nachname = '%s', strasse = '%s', hausnummer = '%s', plz = '%d', ort = '%s', "
							  + "emailadresse = '%s', passworthash = '%s', istgesperrt = '%d', einzugserm�chtigungerteilt = '%d', iban = '%s', bic = '%s' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_benutzer.vorname, p_benutzer.nachname, p_benutzer.strasse, p_benutzer.hausnummer, p_benutzer.plz, p_benutzer.ort, 
												   p_benutzer.eMailAdresse, p_benutzer.passwortHash, p_benutzer.istGesperrt?1:0, p_benutzer.einzugserm�chtigungErteilt?1:0, 
												   p_benutzer.iban, p_benutzer.bic, p_benutzer.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * L�scht das �bergebene Benutzer-Objekt logisch in der Datenbank.
	 * 
	 * @param p_benutzer: Benutzer-Objekt, das in der Datenbank logisch gel�scht werden soll
	 */
	public static void l�scheBenutzer(Benutzer p_benutzer)
	{
		String updateBefehl = "UPDATE festiva.benutzer SET istgel�scht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_benutzer.istGel�scht?1:0, p_benutzer.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Selektiert die Daten eines Benutzers aus der Datenbank
	 * und liefert ein Benutzer-Objekt zur�ck
	 * 
	 * @param p_eMailAdresse: Mailadresse des Zielanwenders in der Datenbank 
	 * @return benutzer: Benutzer-Objekt mit allen verf�gbaren Daten
	 * 					 Falls der Benutzer nicht existiert wird null zur�ckgeliefert
	 */
	public static Benutzer selektiereBenutzer(String p_eMailAdresse)
	{
		Benutzer benutzer = null;
		String selectBefehl = 
		"SELECT id, vorname, nachname, strasse, hausnummer, plz, ort, passworthash, " +
		"istgesperrt, istgel�scht, iban, bic, einzugserm�chtigungerteilt, gruppen_id " +
		"FROM festiva.benutzer WHERE emailadresse = '%s'";			
		selectBefehl = String.format(selectBefehl, p_eMailAdresse);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		try
		{
			if(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");
				String vorname = ergebnismenge.getString("vorname");
				String nachname = ergebnismenge.getString("nachname");
				String strasse = ergebnismenge.getString("strasse");
				String hausnummer = ergebnismenge.getString("hausnummer");
				int plz = ergebnismenge.getInt("plz");
				String ort = ergebnismenge.getString("ort");
				String passwortHash = ergebnismenge.getString("PasswortHash");
				boolean istGesperrt = ergebnismenge.getBoolean("istgesperrt");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String iban = ergebnismenge.getString("iban");
				String bic = ergebnismenge.getString("bic");
				boolean einzugserm�chtigungErteilt = ergebnismenge.getBoolean("einzugserm�chtigungerteilt");
				int gruppenID = ergebnismenge.getInt("gruppen_id");
				benutzer = new Benutzer(id, vorname, nachname, p_eMailAdresse, passwortHash, strasse, hausnummer, plz, ort,
										istGesperrt, iban, bic, einzugserm�chtigungErteilt, istGel�scht, gruppenID);
			}
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}

		return benutzer;
	}
	
	
	/**
	 * Selektiert die Daten eines Benutzers aus der Datenbank
	 * und liefert ein Benutzer-Objekt zur�ck
	 * 
	 * @param p_benutzerID: eindeutige ID des Benutzers
	 * @return benutzer: Benutzer-Objekt mit allen verf�gbaren Daten
	 * 					 Falls der Benutzer nicht existiert wird null zur�ckgeliefert
	 */
	public static Benutzer selektiereBenutzerMitID(int p_benutzerID)
	{
		Benutzer benutzer = null;
		String selectBefehl = 
		"SELECT vorname, nachname, emailadresse, strasse, hausnummer, plz, ort, passworthash, " +
		"istgesperrt, istgel�scht, iban, bic, einzugserm�chtigungerteilt, gruppen_id " +
		"FROM festiva.benutzer WHERE id = '%d'";			
		selectBefehl = String.format(selectBefehl, p_benutzerID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		try
		{
			if(ergebnismenge.next())
			{
				String vorname = ergebnismenge.getString("vorname");
				String nachname = ergebnismenge.getString("nachname");
				String eMailAdresse = ergebnismenge.getString("emailadresse");
				String strasse = ergebnismenge.getString("strasse");
				String hausnummer = ergebnismenge.getString("hausnummer");
				int plz = ergebnismenge.getInt("plz");
				String ort = ergebnismenge.getString("ort");
				String passwortHash = ergebnismenge.getString("PasswortHash");
				boolean istGesperrt = ergebnismenge.getBoolean("istgesperrt");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String iban = ergebnismenge.getString("iban");
				String bic = ergebnismenge.getString("bic");
				boolean einzugserm�chtigungErteilt = ergebnismenge.getBoolean("einzugserm�chtigungerteilt");
				int gruppenID = ergebnismenge.getInt("gruppen_id");
				benutzer = new Benutzer(p_benutzerID, vorname, nachname, eMailAdresse, passwortHash, strasse, hausnummer, plz, ort,
										istGesperrt, iban, bic, einzugserm�chtigungErteilt, istGel�scht, gruppenID);
			}
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}

		return benutzer;
	}
	
}
