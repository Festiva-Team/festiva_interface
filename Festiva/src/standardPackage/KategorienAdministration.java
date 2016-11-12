package standardPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Klasse zur Administration von Kategorien
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Kategorien aus der Datenbank
 * 
 * @author Alina Fankh�nel
 *
 */
public class KategorienAdministration {

	/**
	 * Erstellt f�r das �bergebene Kategorie-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_kategorie: Kategorie-Objekt, das erstellt werden soll
	 */
	public static void erstelleKategorie(Kategorie p_kategorie) throws DatenbankException
	{		
		String insertBefehl = "INSERT INTO festiva.kategorien " +
							   "(name, beschreibung, bildpfad) " +
							   "VALUES ('%s', '%s', '%s')";
		insertBefehl = String.format(insertBefehl, p_kategorie.name, p_kategorie.beschreibung, p_kategorie.bildpfad);
		p_kategorie.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
	}
	
	
	/**
	 * Aktualisiert f�r das �bergebene Kategorie-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_kategorie: Kategorie-Objekt, das in der Datenbank aktualisiert werden soll
	 */
	public static void aktualisiereKategorie(Kategorie p_kategorie) throws DatenbankException
	{	
		String updateBefehl = "UPDATE festiva.kategorien " +
							  "SET name = '%s', beschreibung = '%s', bildpfad = '%s' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_kategorie.name, p_kategorie.beschreibung, p_kategorie.bildpfad, p_kategorie.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * L�scht das �bergebene Kategorie-Objekt logisch in der Datenbank.
	 * 
	 * @param p_kategorie: Kategorie-Objekt, das in der Datenbank logisch gel�scht werden soll
	 */
	public static void l�scheKategorie(Kategorie p_kategorie) throws DatenbankException
	{
		String updateBefehl = "UPDATE festiva.kategorien SET istgel�scht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_kategorie.istGel�scht?1:0, p_kategorie.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Selektiert eine Kategorie anhand der ID aus der Datenbank.
	 * @param p_kategorieID: ID der gew�nschten Kategorie
	 * @return kategorie: gew�nschte Kategorie, falls keine Kategorie gefunden wurde, wird null zur�ck gegeben
	 */
	public static Kategorie selektiereKategorie(int p_kategorieID) throws DatenbankException
	{
		Kategorie kategorie = null;
		String selectBefehl = "SELECT name, beschreibung, istgel�scht, bildpfad " + 
							  "FROM festiva.kategorien " + 
							  "WHERE id = " + p_kategorieID;
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return kategorie;
		} else {
		try
		{
			if(ergebnismenge.next())
			{
				String name = ergebnismenge.getString("name");
				String beschreibung = ergebnismenge.getString("beschreibung");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				kategorie = new Kategorie(p_kategorieID, name, beschreibung, bildpfad, istGel�scht);
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return kategorie;}
	}
	
	
	/**
	 * Selektiert alle Kategorien aus der Datenbank (sortiert nach ID aufsteigend).
	 * @return List<Kategorie>: Liste mit allen verf�gbaren Kategorien und deren zugeh�rigen Daten
	 */
	public static List<Kategorie> selektiereAlleKategorien() throws DatenbankException
	{
		List<Kategorie> listKategorien = new ArrayList<Kategorie>();
		String selectBefehl = "SELECT id, name, beschreibung, istgel�scht, bildpfad " + 
							  "FROM festiva.kategorien " + 
							  "ORDER BY id ASC";
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return listKategorien;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int kategorienID = ergebnismenge.getInt("id");
				String name = ergebnismenge.getString("name");
				String beschreibung = ergebnismenge.getString("beschreibung");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listKategorien.add(new Kategorie(kategorienID, name, beschreibung, bildpfad, istGel�scht));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listKategorien;}
	}
	
	
	/**
	 * Selektiert alle Kategorien f�r die Slightshow aus der Datenbank (sortiert nach ID aufsteigend).
	 * @return List<Kategorie>: Liste mit allen Kategorien, die ein Bild haben und nicht gel�scht sind mit deren zugeh�rigen Daten
	 */
	public static List<Kategorie> selektiereAlleKategorienFuerSlideshow() throws DatenbankException
	{
		List<Kategorie> listKategorien = new ArrayList<Kategorie>();
		String selectBefehl = "SELECT id, name, beschreibung, istgel�scht, bildpfad " + 
							  "FROM festiva.kategorien WHERE id = 1 OR id = 2 OR id = 3 OR id = 4 " + 
							  "ORDER BY id ASC";
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return listKategorien;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int kategorienID = ergebnismenge.getInt("id");
				String name = ergebnismenge.getString("name");
				String beschreibung = ergebnismenge.getString("beschreibung");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listKategorien.add(new Kategorie(kategorienID, name, beschreibung, bildpfad, istGel�scht));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listKategorien;}
	}
	
	
	/**
	 * Selektiert alle verf�gbaren Kategorien aus der Datenbank (sortiert nach ID aufsteigend).
	 * @return List<Kategorie>: Liste mit allen verf�gbaren Kategorien und deren zugeh�rigen Daten
	 */
	public static List<Kategorie> selektiereAlleAktivenKategorien() throws DatenbankException
	{
		List<Kategorie> listKategorien = new ArrayList<Kategorie>();
		String selectBefehl = "SELECT id, name, beschreibung, istgel�scht, bildpfad " + 
							  "FROM festiva.kategorien WHERE istgel�scht = 0 " + 
							  "ORDER BY id ASC";
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return listKategorien;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int kategorienID = ergebnismenge.getInt("id");
				String name = ergebnismenge.getString("name");
				String beschreibung = ergebnismenge.getString("beschreibung");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listKategorien.add(new Kategorie(kategorienID, name, beschreibung, bildpfad, istGel�scht));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listKategorien;}
	}
}
