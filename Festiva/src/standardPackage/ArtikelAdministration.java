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
		String insertBefehl = "INSERT INTO festiva.artikel" +
							   "(beschreibung, preis, festival_id)" +
							   "VALUES ('%s', '%f', '%d')";
		insertBefehl = String.format(insertBefehl, p_artikel.beschreibung, p_artikel.preis, p_artikel.festivalID);
		p_artikel.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
	}
	
	/**
	 * Aktualisiert f�r das �bergebene Artikel-Objekt den Datensatz in der Datenbank.
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
		String selectBefehl = "SELECT beschreibung, preis, istgel�scht, festival_id " + 
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
				int festivalID = ergebnismenge.getInt("festival_id");
				
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
	 * Gibt alle Artikel, die zu einem bestimmen Festival geh�ren zur�ck (alphabetisch sortiert)
	 * @param p_festivalID: ID des gew�nschten Festivals
	 * @return listArtikel: Liste aller Artikel, die zum gew�nschten Festival geh�ren
	 */
	public static List<Artikel> gibArtikelVonFestival(int p_festivalID)
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, istgel�scht " + 
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
	
}