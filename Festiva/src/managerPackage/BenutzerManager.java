package managerPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import standardPackage.*;
/**
 * Hilfsklasse zum Managen von Benutzern
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Benutzern (Kunden und/oder Administratoren) aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class BenutzerManager {

	/**
	 * Erstellt für das übergebene Benutzer-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_benutzer Benutzer-Objekt, das erstellt werden soll
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static void erstelleKunden(Benutzer p_benutzer) throws DatenbankException
	{		
		String insertBefehl = "INSERT INTO festiva.benutzer " +
							   "(vorname, nachname, strasse, hausnummer, plz, ort, emailadresse, passworthash, iban, bic, gruppen_id) " +
							   "VALUES ('%s', '%s', '%s', '%s', '%d', '%s', '%s', '%s', '%s', '%s', '%d')";
		
		insertBefehl = String.format(insertBefehl, p_benutzer.vorname, p_benutzer.nachname, p_benutzer.strasse, p_benutzer.hausnummer, p_benutzer.plz, p_benutzer.ort, p_benutzer.eMailAdresse, p_benutzer.passwortHash, p_benutzer.iban, p_benutzer.bic, p_benutzer.gruppenID);
		p_benutzer.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	}
	
	
	/**
	 * Aktualisiert für das übergebene Benutzer-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_benutzer Benutzer-Objekt, das in der Datenbank aktualisiert werden soll
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static void aktualisiereBenutzer(Benutzer p_benutzer) throws DatenbankException
	{	
		String updateBefehl = "UPDATE festiva.benutzer " +
							  "SET vorname = '%s', nachname = '%s', strasse = '%s', hausnummer = '%s', plz = '%d', ort = '%s', "
							  + "emailadresse = '%s', passworthash = '%s', istgesperrt = '%d', einzugsermächtigungerteilt = '%d', iban = '%s', bic = '%s' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_benutzer.vorname, p_benutzer.nachname, p_benutzer.strasse, p_benutzer.hausnummer, p_benutzer.plz, p_benutzer.ort, 
												   p_benutzer.eMailAdresse, p_benutzer.passwortHash, p_benutzer.istGesperrt?1:0, p_benutzer.einzugsermächtigungErteilt?1:0, 
												   p_benutzer.iban, p_benutzer.bic, p_benutzer.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Löscht das übergebene Benutzer-Objekt logisch in der Datenbank.
	 * 
	 * @param p_benutzer Benutzer-Objekt, das in der Datenbank logisch gelöscht werden soll
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static void löscheBenutzer(Benutzer p_benutzer) throws DatenbankException
	{
		String updateBefehl = "UPDATE festiva.benutzer SET istgelöscht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_benutzer.istGelöscht?1:0, p_benutzer.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Selektiert die Daten eines Benutzers aus der Datenbank
	 * und liefert ein Benutzer-Objekt zurück
	 * 
	 * @param p_eMailAdresse Mailadresse des Zielanwenders in der Datenbank 
	 * @return benutzer Benutzer-Objekt mit allen verfügbaren Daten (falls der Benutzer nicht existiert wird null zurückgeliefert)
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static Benutzer selektiereBenutzer(String p_eMailAdresse) throws DatenbankException
	{
		Benutzer benutzer = null;
		String selectBefehl = 
		"SELECT id, vorname, nachname, strasse, hausnummer, plz, ort, passworthash, " +
		"istgesperrt, istgelöscht, iban, bic, einzugsermächtigungerteilt, gruppen_id " +
		"FROM festiva.benutzer WHERE emailadresse = '%s'";			
		selectBefehl = String.format(selectBefehl, p_eMailAdresse);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return benutzer;
		} else {
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
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String iban = ergebnismenge.getString("iban");
				String bic = ergebnismenge.getString("bic");
				boolean einzugsermächtigungErteilt = ergebnismenge.getBoolean("einzugsermächtigungerteilt");
				int gruppenID = ergebnismenge.getInt("gruppen_id");
				benutzer = new Benutzer(id, vorname, nachname, p_eMailAdresse, passwortHash, strasse, hausnummer, plz, ort,
										istGesperrt, iban, bic, einzugsermächtigungErteilt, istGelöscht, gruppenID);
			}
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}

		return benutzer;
		}
	}
	
	
	/**
	 * Selektiert die Daten eines Benutzers aus der Datenbank
	 * und liefert ein Benutzer-Objekt zurück
	 * 
	 * @param p_benutzerID eindeutige ID des Benutzers
	 * @return benutzer Benutzer-Objekt mit allen verfügbaren Daten (falls der Benutzer nicht existiert, wird null zurückgeliefert)
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static Benutzer selektiereBenutzerMitID(int p_benutzerID) throws DatenbankException
	{
		Benutzer benutzer = null;
		String selectBefehl = 
		"SELECT vorname, nachname, emailadresse, strasse, hausnummer, plz, ort, passworthash, " +
		"istgesperrt, istgelöscht, iban, bic, einzugsermächtigungerteilt, gruppen_id " +
		"FROM festiva.benutzer WHERE id = '%d'";			
		selectBefehl = String.format(selectBefehl, p_benutzerID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		if(ergebnismenge == null) {
			return benutzer;
		} else {
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
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String iban = ergebnismenge.getString("iban");
				String bic = ergebnismenge.getString("bic");
				boolean einzugsermächtigungErteilt = ergebnismenge.getBoolean("einzugsermächtigungerteilt");
				int gruppenID = ergebnismenge.getInt("gruppen_id");
				benutzer = new Benutzer(p_benutzerID, vorname, nachname, eMailAdresse, passwortHash, strasse, hausnummer, plz, ort,
										istGesperrt, iban, bic, einzugsermächtigungErteilt, istGelöscht, gruppenID);
			}
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}

		return benutzer;
		}
	}
	
	
	/**
	 * Selektiert alle Kunden aus der Datenbank
	 * und liefert alle verfügbaren Daten zu den Kunden in Benutzer-Objekten
	 * 
	 * @return listBenutzer Liste mit Benutzer-Objekten, die alle verfügbaren Daten beinhalten
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Benutzer> selektiereAlleKunden() throws DatenbankException
	{
		List<Benutzer> listBenutzer = new ArrayList<Benutzer>();
		
		String selectBefehl = 
		"SELECT id, vorname, nachname, emailadresse, strasse, hausnummer, plz, ort, passworthash, " +
		"istgesperrt, istgelöscht, iban, bic, einzugsermächtigungerteilt, gruppen_id " +
		"FROM festiva.benutzer WHERE gruppen_id = 2 ORDER BY id ASC";			
			
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return listBenutzer;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");
				String vorname = ergebnismenge.getString("vorname");
				String nachname = ergebnismenge.getString("nachname");
				String eMailAdresse = ergebnismenge.getString("emailadresse");
				String strasse = ergebnismenge.getString("strasse");
				String hausnummer = ergebnismenge.getString("hausnummer");
				int plz = ergebnismenge.getInt("plz");
				String ort = ergebnismenge.getString("ort");
				String passwortHash = ergebnismenge.getString("PasswortHash");
				boolean istGesperrt = ergebnismenge.getBoolean("istgesperrt");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String iban = ergebnismenge.getString("iban");
				String bic = ergebnismenge.getString("bic");
				boolean einzugsermächtigungErteilt = ergebnismenge.getBoolean("einzugsermächtigungerteilt");
				int gruppenID = ergebnismenge.getInt("gruppen_id");
				
				listBenutzer.add(new Benutzer(id, vorname, nachname, eMailAdresse, passwortHash, strasse, hausnummer, plz, ort,
											  istGesperrt, iban, bic, einzugsermächtigungErteilt, istGelöscht, gruppenID));
				
			}
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}

		return listBenutzer;
	}}
	
	
	/**
	 * Ändert den Passwortzähler bei dem Benutzer mit der übergebenen ID auf den übergebenen Wert
	 * 
	 * @param p_benutzerID Benutzer, bei dem die Änderung am Passwortzähler durchgeführt werden soll
	 * @param p_zaehlerWert Wert, der als Zaehler gespeichert werden soll
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static void aktualisierePasswortZaehlerBeiKunde(int p_benutzerID, int p_zaehlerWert) throws DatenbankException
	{
		String updateBefehl = "";
		if( p_zaehlerWert >= 3 ) {
			updateBefehl = "UPDATE festiva.benutzer SET istgesperrt = 1, passwortzaehler = '%d' WHERE id = '%d'";
		} else {
			updateBefehl = "UPDATE festiva.benutzer SET passwortzaehler = '%d' WHERE id = '%d'";
		}

		updateBefehl = String.format(updateBefehl, p_zaehlerWert, p_benutzerID);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Selektiert den Passwortzähler des Benutzers mit der übergebenen ID 
	 * 
	 * @param p_benutzerID Benutzer, dessen Passwortzähler ermittelt werden soll
	 * @return zaehlerWert Zähler-Wert des Kunden
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static int selektierePasswortZaehlerVonKunde(int p_benutzerID) throws DatenbankException
	{
		int zaehlerWert = -1;
		String selectBefehl = "SELECT passwortzaehler FROM festiva.benutzer WHERE id = '%d'";
		selectBefehl = String.format(selectBefehl, p_benutzerID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return zaehlerWert;
		} else {
			try {
		while(ergebnismenge.next())
		{
			zaehlerWert = ergebnismenge.getInt("passwortzaehler");
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return zaehlerWert;}
		
	}
	
}
