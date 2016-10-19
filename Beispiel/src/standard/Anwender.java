package standard;

import java.util.Date;

/**
 * Fachklasse für einen Anwender (Kunde oder Administrator) des Webshops
 * 
 * @author Nico Dübeler
 *
 */

public class Anwender {
	public int anwenderID;
	public int gruppeID;
	public String vorname;
	public String nachname;
	public String eMail;
	public String strasse;
	public String hausnummer;
	public int postleitzahl;
	public String ort;
	public int kartennummer;
	public Date kartenGueltigkeit;
	public String kreditFirma;
	public String passwortHash;
	public boolean istGesperrt;

	
	/**
	 * Erstellt aus den übergebenen Parametern ein Anwender-Objekt
	 * 
	 * @param p_ID ID des Anwenders
	 * @param p_gruppeID Gruppe des Anwenders
	 * @param p_vorname Vorname des Anwenders
	 * @param p_nachname Nachname des Anwenders
	 * @param p_eMail EMail-Adresse des Anwenders
	 * @param p_strasse Strasse des Anwenders
	 * @param p_hausnummer Hausnummer des Anwenders
	 * @param p_postleitzahl Postleitzahl des Anwenders
	 * @param p_ort Wohnort des Anwenders
	 * @param p_kartennummer Kreditkartennummer des Anwenders
	 * @param p_kartenGueltigkeit Gültigkeit der Kreditkarte des Anwenders
	 * @param p_kreditFirma Kreditkartenfirma des Anwenders
	 * @param p_passwortHash Passwort (SHA-1-Hash) des Anwenders
	 * @param p_istGesperrt Parameter, ob der Anwender gesperrt ist
	 */
	public Anwender(int p_ID, int p_gruppeID, String p_vorname, String p_nachname, String p_eMail, String p_strasse, String p_hausnummer, int p_postleitzahl,
			String p_ort, int p_kartennummer, Date p_kartenGueltigkeit, String p_kreditFirma, String p_passwortHash, boolean p_istGesperrt)
	{
		this.anwenderID = p_ID;
		this.gruppeID = p_gruppeID;
		this.vorname = p_vorname;
		this.nachname = p_nachname;
		this.eMail = p_eMail;
		this.strasse = p_strasse;
		this.hausnummer = p_hausnummer;
		this.postleitzahl = p_postleitzahl;
		this.ort = p_ort;
		this.kartennummer = p_kartennummer;
		this.kartenGueltigkeit = p_kartenGueltigkeit;
		this.kreditFirma = p_kreditFirma;
		this.passwortHash = p_passwortHash;
		this.istGesperrt = p_istGesperrt;
	}

}
