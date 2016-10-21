/**
 * Klasse für einen Benutzer (Kunde oder Administrator) des Webshops
 * 
 * @author Alina Fankhänel
 *
 */
public class Benutzer {
	public int id;
	public String vorname;
	public String nachname;
	public String eMailAdresse;
	public String passwortHash;
	public String strasse;
	public String hausnummer;
	public int plz;
	public String ort;
	public boolean istGesperrt;
	public String iban;
	public String bic;
	public boolean einzugsermächtigungErteilt;
	public boolean istGelöscht;
	public int gruppenID;
	
	
	/**
	 * Konstruktor zur Erstellung eines Benutzer-Objekts mit den nachfolgenden Parametern
	 * 
	 * @param p_id: eindeutige ID des Benutzers
	 * @param p_vorname: Vorname des Benutzers
	 * @param p_nachname: Nachname des Benutzers
	 * @param p_eMailAdresse: E-Mail-Adresse des Benutzers
	 * @param p_passwortHash: Passwort des Benutzers als SHA-1-Hash
	 * @param p_strasse: Strasse des Benutzers
	 * @param p_hausnummer: Hausnummer des Benutzers
	 * @param p_plz: Postleitzahl des Benutzers
	 * @param p_ort: Wohnort des Benutzers
	 * @param p_istGesperrt: zeigt, ob der Benutzer gesperrt ist
	 * @param p_iban: IBAN des Benutzers
	 * @param p_bic: BIC des Benutzers
	 * @param p_einzugsermächtigungErteilt: zeigt, ob der Benutzer die Einzugsermächtigung erteilt hat
	 * @param p_istGelöscht: zeigt, ob der Benutzer logisch gelöscht ist
	 * @param p_gruppenID: eindeutige ID der Gruppe, der der Benutzer zugeordnet wurde
	 */
	public Benutzer(int p_id, String p_vorname, String p_nachname, String p_eMailAdresse, String p_passwortHash, String p_strasse, String p_hausnummer, int p_plz,
			String p_ort, boolean p_istGesperrt, String p_iban, String p_bic, boolean p_einzugsermächtigungErteilt, boolean p_istGelöscht, int p_gruppenID)
	{
		this.id = p_id;
		this.vorname = p_vorname;
		this.nachname = p_nachname;
		this.eMailAdresse = p_eMailAdresse;
		this.passwortHash = p_passwortHash;
		this.strasse = p_strasse;
		this.hausnummer = p_hausnummer;
		this.plz = p_plz;
		this.ort = p_ort;
		this.istGesperrt = p_istGesperrt;
		this.iban = p_iban;
		this.bic = p_bic;
		this.einzugsermächtigungErteilt = p_einzugsermächtigungErteilt;
		this.istGelöscht = p_istGelöscht;
		this.gruppenID = p_gruppenID;
	}
}
