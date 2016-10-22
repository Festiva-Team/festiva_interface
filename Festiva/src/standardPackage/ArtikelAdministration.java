package standardPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 * Klasse zur Administration von Artikeln
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Artikeln aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class ArtikelAdministration {
	
	/**
	 * Erstellt für das übergebene Artikel-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_artikel: Artikel-Objekt, das erstellt werden soll
	 */
	public static void erstelleArtikel(Artikel p_artikel)
	{		
		String insertBefehl = "INSERT INTO festiva.artikel" +
							   "(beschreibung, preis, festival_id)" +
							   "VALUES ('%s', '%f', '%d')";
		insertBefehl = String.format(insertBefehl, p_artikel.beschreibung, p_artikel.preis, p_artikel.festivalID);
		p_artikel.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	}
	
	/**
	 * Aktualisiert für das übergebene Artikel-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_artikel: Artikel-Objekt, das in der Datenbank aktualisiert werden soll
	 */
	public static void aktualisiereArtikel(Artikel p_artikel)
	{	
		String updateBefehl = "UPDATE festiva.artikel " +
							  "SET beschreibung = '%s', preis = '%f', festival_id = '%d'" +
							  "WHERE id = %d";
		updateBefehl = String.format(updateBefehl, p_artikel.beschreibung, p_artikel.preis, p_artikel.festivalID, p_artikel.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	/**
	 * Löscht das übergebene Artikel-Objekt logisch in der Datenbank.
	 * 
	 * @param p_artikel: Artikel-Objekt, das in der Datenbank logisch gelöscht werden soll
	 */
	public static void löscheArtikel(Artikel p_artikel)
	{
		String updateBefehl = "UPDATE festiva.artikel SET istgelöscht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_artikel.istGelöscht?1:0, p_artikel.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	/**
	 * Selektiert einen Artikel anhand der ID aus der Datenbank.
	 * @param p_artikelID: ID des gewünschten Artikels
	 * @return artikel: gewünschter Artikel, falls kein Artikel gefunden wurde, wird null zurück gegeben
	 */
	public static Artikel selektiereArtikel(int p_artikelID)
	{
		Artikel artikel = null;
		String selectBefehl = "SELECT beschreibung, preis, istgelöscht, festival_id " + 
							  "FROM festiva.artikel " + 
							  "WHERE id = " + p_artikelID;
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			if(ergebnismenge.next())
			{
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				int festivalID = ergebnismenge.getInt("festival_id");
				
				artikel = new Artikel(p_artikelID, beschreibung, preis, istGelöscht, festivalID);
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
	 * Gibt alle Artikel, die zu einem bestimmen Festival gehören zurück (alphabetisch sortiert)
	 * @param p_festivalID: ID des gewünschten Festivals
	 * @return listArtikel: Liste aller Artikel, die zum gewünschten Festival gehören
	 */
	public static List<Artikel> gibArtikelVonFestival(int p_festivalID)
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgelöscht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festival_id = %d ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				
				listArtikel.add(new Artikel(id, beschreibung, preis, istGelöscht, p_festivalID));
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