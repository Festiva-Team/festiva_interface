package standardPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Klasse zur Administration von Kategorien
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Kategorien aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class KategorienAdministration {

	/**
	 * Erstellt für das übergebene Kategorie-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_kategorie: Kategorie-Objekt, das erstellt werden soll
	 */
	public static void erstelleKategorie(Kategorie p_kategorie) throws DatenbankException
	{		
		String insertBefehl = "INSERT INTO festiva.kategorien " +
							   "(name, beschreibung, bildpfad) " +
							   "VALUES ('%s', '%s', '%s')";
		insertBefehl = String.format(insertBefehl, p_kategorie.name, p_kategorie.beschreibung, p_kategorie.bildpfad);
		p_kategorie.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	}
	
	
	/**
	 * Aktualisiert für das übergebene Kategorie-Objekt den Datensatz in der Datenbank.
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
	 * Löscht das übergebene Kategorie-Objekt logisch in der Datenbank.
	 * 
	 * @param p_kategorie: Kategorie-Objekt, das in der Datenbank logisch gelöscht werden soll
	 */
	public static void löscheKategorie(Kategorie p_kategorie) throws DatenbankException
	{
		String updateBefehl = "UPDATE festiva.kategorien SET istgelöscht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_kategorie.istGelöscht?1:0, p_kategorie.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Selektiert eine Kategorie anhand der ID aus der Datenbank.
	 * @param p_kategorieID: ID der gewünschten Kategorie
	 * @return kategorie: gewünschte Kategorie, falls keine Kategorie gefunden wurde, wird null zurück gegeben
	 */
	public static Kategorie selektiereKategorie(int p_kategorieID) throws DatenbankException
	{
		Kategorie kategorie = null;
		String selectBefehl = "SELECT name, beschreibung, istgelöscht, bildpfad " + 
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
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				kategorie = new Kategorie(p_kategorieID, name, beschreibung, bildpfad, istGelöscht);
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
	 * @return List<Kategorie>: Liste mit allen verfügbaren Kategorien und deren zugehörigen Daten
	 */
	public static List<Kategorie> selektiereAlleKategorien() throws DatenbankException
	{
		List<Kategorie> listKategorien = new ArrayList<Kategorie>();
		String selectBefehl = "SELECT id, name, beschreibung, istgelöscht, bildpfad " + 
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
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listKategorien.add(new Kategorie(kategorienID, name, beschreibung, bildpfad, istGelöscht));
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
	 * Selektiert alle Kategorien für die Slightshow aus der Datenbank (sortiert nach ID aufsteigend).
	 * @return List<Kategorie>: Liste mit allen Kategorien, die ein Bild haben und nicht gelöscht sind mit deren zugehörigen Daten
	 */
	public static List<Kategorie> selektiereAlleKategorienFuerSlideshow() throws DatenbankException
	{
		List<Kategorie> listKategorien = new ArrayList<Kategorie>();
		String selectBefehl = "SELECT id, name, beschreibung, istgelöscht, bildpfad " + 
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
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listKategorien.add(new Kategorie(kategorienID, name, beschreibung, bildpfad, istGelöscht));
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
	 * Selektiert alle verfügbaren Kategorien aus der Datenbank (sortiert nach ID aufsteigend).
	 * @return List<Kategorie>: Liste mit allen verfügbaren Kategorien und deren zugehörigen Daten
	 */
	public static List<Kategorie> selektiereAlleAktivenKategorien() throws DatenbankException
	{
		List<Kategorie> listKategorien = new ArrayList<Kategorie>();
		String selectBefehl = "SELECT id, name, beschreibung, istgelöscht, bildpfad " + 
							  "FROM festiva.kategorien WHERE istgelöscht = 0 " + 
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
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listKategorien.add(new Kategorie(kategorienID, name, beschreibung, bildpfad, istGelöscht));
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
