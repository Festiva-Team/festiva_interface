package standardPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 * Klasse zur Administration von Artikeln
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Artikeln aus der Datenbank
 * 
 * @author Alina Fankh�nel
 *
 */
public class ArtikelAdministration {
	 
	
	/**
	 * Erstellt f�r das �bergebene Artikel-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_artikel: Artikel-Objekt, das erstellt werden soll
	 */
	public static void erstelleArtikel(Artikel p_artikel)
	{	
		String insertBefehl = "";
		if(p_artikel.festivalID != 0) {
		insertBefehl = "INSERT INTO festiva.artikel " +
							   "(beschreibung, preis, festivals_id ) " +
							   "VALUES ('%s', '%s', '%d')";
		
		insertBefehl = String.format(insertBefehl, p_artikel.beschreibung, String.format("%.2f",p_artikel.preis).replace(',', '.'), p_artikel.festivalID);}
		else {
		insertBefehl = "INSERT INTO festiva.artikel " +
					   "(beschreibung, preis) " +
					   "VALUES ('%s', '%s')";

		insertBefehl = String.format(insertBefehl, p_artikel.beschreibung, String.format("%.2f",p_artikel.preis).replace(',', '.'));
		}
		p_artikel.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
	}
	
	/**
	 * Aktualisiert f�r das �bergebene Artikel-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_artikel: Artikel-Objekt, das in der Datenbank aktualisiert werden soll
	 */
	public static void aktualisiereArtikel(Artikel p_artikel)
	{	
		String updateBefehl = "";
		if(p_artikel.festivalID != 0) {
		   updateBefehl = "UPDATE festiva.artikel " +
							  "SET beschreibung = '%s', preis = '%s', festivals_id = '%d' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_artikel.beschreibung, String.format("%.2f",p_artikel.preis).replace(',', '.'), p_artikel.festivalID, p_artikel.id);}
		else {
			updateBefehl = "UPDATE festiva.artikel " +
					  "SET beschreibung = '%s', preis = '%s' " +
					  "WHERE id = '%d'";
			updateBefehl = String.format(updateBefehl, p_artikel.beschreibung, String.format("%.2f",p_artikel.preis).replace(',', '.'), p_artikel.id);
		}
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	/**
	 * L�scht das �bergebene Artikel-Objekt logisch in der Datenbank.
	 * 
	 * @param p_artikel: Artikel-Objekt, das in der Datenbank logisch gel�scht werden soll
	 */
	public static void l�scheArtikel(Artikel p_artikel)
	{
		String updateBefehl = "UPDATE festiva.artikel SET istgel�scht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_artikel.istGel�scht?1:0, p_artikel.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	/**
	 * Selektiert einen Artikel anhand der ID aus der Datenbank.
	 * @param p_artikelID: ID des gew�nschten Artikels
	 * @return artikel: gew�nschter Artikel, falls kein Artikel gefunden wurde, wird null zur�ck gegeben
	 */
	public static Artikel selektiereArtikel(int p_artikelID)
	{
		Artikel artikel = null;
		String selectBefehl = "SELECT beschreibung, preis, istgel�scht, festivals_id " + 
							  "FROM festiva.artikel " + 
							  "WHERE id = " + p_artikelID;
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			if(ergebnismenge.next())
			{
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				int festivalID = ergebnismenge.getInt("festivals_id");
				
				artikel = new Artikel(p_artikelID, beschreibung, preis, istGel�scht, festivalID);
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return artikel;
	}

	/**
	 * Selektiert alle Artikel, die zu einem bestimmen Festival geh�ren und nicht teurer als der vorgegebene Maximalpreis sind (alphabetisch sortiert)
	 * @param p_festivalID: ID des gew�nschten Festivals
	 * @param p_maxPreis: maximaler Preis, den die zur�ckgegebenen Artikel haben d�rfen
	 * @return listArtikel: Liste aller Artikel, die zum gew�nschten Festival geh�ren
	 */
	public static List<Artikel> selektiereArtikelVonFestivalMitMaxPreis(int p_festivalID, float p_maxPreis)
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgel�scht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' AND istgel�scht = 0 AND preis <= '%f' ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID, p_maxPreis);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				
				listArtikel.add(new Artikel(id, beschreibung, preis, istGel�scht, p_festivalID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listArtikel;
	}
	
	
	/**
	 * Selektiert alle Artikel, die zu einem bestimmen Festival geh�ren und teurer als der vorgegebene Maximalpreis sind (alphabetisch sortiert)
	 * @param p_festivalID: ID des gew�nschten Festivals
	 * @param p_maxPreis: maximaler Preis, den die zur�ckgegebenen Artikel �bersteigen m�ssen
	 * @return listArtikel: Liste aller Artikel, die zum gew�nschten Festival geh�ren
	 */
	public static List<Artikel> selektiereArtikelVonFestival�berMaxPreis(int p_festivalID, float p_maxPreis)
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgel�scht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' AND istgel�scht = 0 AND preis > '%f' ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID, p_maxPreis);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				
				listArtikel.add(new Artikel(id, beschreibung, preis, istGel�scht, p_festivalID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listArtikel;
	}
	
	
	/**
	 * Selektiert alle Artikel, die zu einem bestimmen Festival geh�ren (alphabetisch sortiert)
	 * @param p_festivalID: ID des gew�nschten Festivals
	 * @return listArtikel: Liste aller Artikel, die zum gew�nschten Festival geh�ren
	 */
	public static List<Artikel> selektiereArtikelVonFestival(int p_festivalID)
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgel�scht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' AND istgel�scht = 0 ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				
				listArtikel.add(new Artikel(id, beschreibung, preis, istGel�scht, p_festivalID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listArtikel;
	}
	
	
	/**
	 * Selektiert alle Artikel (auch gel�schte), die zu einem bestimmen Festival geh�ren (nach ID sortiert)
	 * @param p_festivalID: ID des gew�nschten Festivals
	 * @return listArtikel: Liste aller Artikel, die zum gew�nschten Festival geh�ren
	 */
	public static List<Artikel> selektiereAlleArtikelVonFestival(int p_festivalID)
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgel�scht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' ORDER BY id ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				
				listArtikel.add(new Artikel(id, beschreibung, preis, istGel�scht, p_festivalID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listArtikel;
	}
	
	
	
	
	//*********************************************************** Methoden f�r alle allgemeinen Artikel
		
	/**
	 * Selektiert alle Artikel, die zu keinem Festival geh�ren (alphabetisch sortiert)
	 * @return listArtikel: Liste aller Artikel, die zum gew�nschten Festival geh�ren
	 */
	public static List<Artikel> selektiereUnabhaengigeArtikel()
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgel�scht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id is null AND istgel�scht = 0 ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				
				listArtikel.add(new Artikel(id, beschreibung, preis, istGel�scht, -1));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listArtikel;
	}
	
	
	/**
	 * Selektiert alle Artikel, die zu keinem Festival geh�ren (nach ID sortiert, auch gel�schte)
	 * @return listArtikel: Liste aller Artikel, die zum gew�nschten Festival geh�ren
	 */
	public static List<Artikel> selektiereAlleUnabhaengigenArtikel()
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgel�scht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id is null ORDER BY id ASC";
		selectBefehl  = String.format(selectBefehl);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				
				listArtikel.add(new Artikel(id, beschreibung, preis, istGel�scht, -1));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listArtikel;
	}
	
}