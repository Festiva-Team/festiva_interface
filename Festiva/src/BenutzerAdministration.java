/**
 * Klasse zur Administration von Benutzern
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Benutzern (Kunden und/oder Administratoren) aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class BenutzerAdministration {

	/**
	 * Erstellt für das übergebene Benutzer-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_benutzer: Benutzer-Objekt, das erstellt werden soll
	 */
	public static void erstelleKunden(Benutzer p_benutzer)
	{		
		String insertBefehl = "INSERT INTO festiva.benutzer" +
							   "(vorname, nachname, emailadresse, passworthash, gruppen_id)" +
							   "VALUES ('%s', '%s', '%s', '%s','%d')";
		insertBefehl = String.format(insertBefehl, p_benutzer.vorname, p_benutzer.nachname, p_benutzer.eMailAdresse, p_benutzer.passwortHash, p_benutzer.gruppenID);
		p_benutzer.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	}
}
