import java.util.Date;

/**
 * Fachklasse f�r einen Benutzer (Kunde oder Administrator) des Webshops
 * 
 * @author Alina Fankh�nel
 *
 */
public class Benutzer {
	public int benutzerID;
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
	public boolean einzugserm�chtigungErteilt;
	public boolean istGel�scht;
	public int gruppenID;
}
