package managerPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import standardPackage.*;
/**
 * Hilfsklasse zum Managen von Artikeln,
 * beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Artikeln aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class ArtikelManager {
	 
	
	/**
	 * Erstellt für das übergebene Artikel-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_artikel Artikel-Objekt, das erstellt werden soll
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static void erstelleArtikel(Artikel p_artikel) throws DatenbankException
	{	
		String insertBefehl = "";
		if(p_artikel.festivalID != 0) {
		insertBefehl = "INSERT INTO festiva.artikel " +
							   "(beschreibung, details, preis, festivals_id ) " +
							   "VALUES ('%s', '%s', '%s', '%d')";
		
		insertBefehl = String.format(insertBefehl, p_artikel.beschreibung, p_artikel.details, String.format("%.2f",p_artikel.preis).replace(',', '.'), p_artikel.festivalID);}
		else {
		insertBefehl = "INSERT INTO festiva.artikel " +
					   "(beschreibung, details, preis, bildpfad) " +
					   "VALUES ('%s', '%s', '%s', '%s')";

		insertBefehl = String.format(insertBefehl, p_artikel.beschreibung, p_artikel.details, String.format("%.2f",p_artikel.preis).replace(',', '.'), p_artikel.bildpfad);
		}
		p_artikel.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	}
	
	/**
	 * Aktualisiert für das übergebene Artikel-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_artikel Artikel-Objekt, das in der Datenbank aktualisiert werden soll
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static void aktualisiereArtikel(Artikel p_artikel) throws DatenbankException
	{	
		String updateBefehl = "";
		if(p_artikel.festivalID != 0) {
		   updateBefehl = "UPDATE festiva.artikel " +
							  "SET beschreibung = '%s', details = '%s', preis = '%s', festivals_id = '%d' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_artikel.beschreibung, p_artikel.details, String.format("%.2f",p_artikel.preis).replace(',', '.'), p_artikel.festivalID, p_artikel.id);}
		else {
			updateBefehl = "UPDATE festiva.artikel " +
					  "SET beschreibung = '%s', details= '%s', preis = '%s', bildpfad = '%s' " +
					  "WHERE id = '%d'";
			updateBefehl = String.format(updateBefehl, p_artikel.beschreibung, p_artikel.details, String.format("%.2f",p_artikel.preis).replace(',', '.'), p_artikel.bildpfad, p_artikel.id);
		}
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	/**
	 * Löscht das übergebene Artikel-Objekt logisch in der Datenbank.
	 * 
	 * @param p_artikel Artikel-Objekt, das in der Datenbank logisch gelöscht werden soll
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static void löscheArtikel(Artikel p_artikel) throws DatenbankException
	{
		String updateBefehl = "UPDATE festiva.artikel SET istgelöscht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_artikel.istGelöscht?1:0, p_artikel.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	/**
	 * Selektiert einen Artikel anhand der ID aus der Datenbank.
	 * @param p_artikelID ID des gewünschten Artikels
	 * @return artikel gewünschter Artikel, falls kein Artikel gefunden wurde, wird null zurück gegeben
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static Artikel selektiereArtikel(int p_artikelID) throws DatenbankException
	{
		Artikel artikel = null;
		String selectBefehl = "SELECT beschreibung, details, preis, istgelöscht, bildpfad, festivals_id " + 
							  "FROM festiva.artikel " + 
							  "WHERE id = " + p_artikelID;
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		if(ergebnismenge == null) {
			return artikel;
		} else {
		try
		{
			if(ergebnismenge.next())
			{
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				int festivalID = ergebnismenge.getInt("festivals_id");
				
				artikel = new Artikel(p_artikelID, beschreibung, details, preis, istGelöscht, bildpfad, festivalID);
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		return artikel;
		}
	}

	/**
	 * Selektiert alle Artikel, die zu einem bestimmen Festival gehören und nicht teurer als der vorgegebene Maximalpreis sind (alphabetisch sortiert)
	 * @param p_festivalID ID des gewünschten Festivals
	 * @param p_maxPreis maximaler Preis, den die zurückgegebenen Artikel haben dürfen
	 * @return listArtikel Liste aller Artikel, die zum gewünschten Festival gehören
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Artikel> selektiereArtikelVonFestivalMitMaxPreis(int p_festivalID, float p_maxPreis) throws DatenbankException
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, details, istgelöscht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' AND istgelöscht = 0 AND preis <= '%f' ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID, p_maxPreis);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		if(ergebnismenge == null) {
			return listArtikel;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				
				listArtikel.add(new Artikel(id, beschreibung, details, preis, istGelöscht, "", p_festivalID));
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
	
	
	/**
	 * Selektiert alle Artikel, die zu einem bestimmen Festival gehören und teurer als der vorgegebene Maximalpreis sind (alphabetisch sortiert)
	 * @param p_festivalID ID des gewünschten Festivals
	 * @param p_maxPreis maximaler Preis, den die zurückgegebenen Artikel übersteigen müssen
	 * @return listArtikel Liste aller Artikel, die zum gewünschten Festival gehören
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Artikel> selektiereArtikelVonFestivalÜberMaxPreis(int p_festivalID, float p_maxPreis) throws DatenbankException
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, details, preis, istgelöscht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' AND istgelöscht = 0 AND preis > '%f' ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID, p_maxPreis);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		if(ergebnismenge == null) {
			return listArtikel;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				
				listArtikel.add(new Artikel(id, beschreibung, details, preis, istGelöscht, "", p_festivalID));
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
	
	
	/**
	 * Selektiert alle Artikel, die zu einem bestimmen Festival gehören (alphabetisch sortiert)
	 * @param p_festivalID ID des gewünschten Festivals
	 * @return listArtikel Liste aller Artikel, die zum gewünschten Festival gehören
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Artikel> selektiereArtikelVonFestival(int p_festivalID) throws DatenbankException
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, details, preis, istgelöscht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' AND istgelöscht = 0 ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		if(ergebnismenge == null) {
			return listArtikel;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				
				listArtikel.add(new Artikel(id, beschreibung, details, preis, istGelöscht, "", p_festivalID));
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
	
	
	/**
	 * Selektiert alle Artikel (auch gelöschte), die zu einem bestimmen Festival gehören (nach ID sortiert)
	 * @param p_festivalID ID des gewünschten Festivals
	 * @return listArtikel Liste aller Artikel, die zum gewünschten Festival gehören
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Artikel> selektiereAlleArtikelVonFestival(int p_festivalID) throws DatenbankException
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, details, preis, istgelöscht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id = '%d' ORDER BY id ASC";
		selectBefehl  = String.format(selectBefehl, p_festivalID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		if(ergebnismenge == null) {
			return listArtikel;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				
				listArtikel.add(new Artikel(id, beschreibung, details, preis, istGelöscht, "", p_festivalID));
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
	
		
	/**
	 * Selektiert alle Artikel, die zu keinem Festival gehören (alphabetisch sortiert)
	 * @return listArtikel Liste aller Artikel, die zum gewünschten Festival gehören
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Artikel> selektiereUnabhaengigeArtikel() throws DatenbankException
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, preis, details, bildpfad, istgelöscht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id is null AND istgelöscht = 0 AND id != 6 ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		if(ergebnismenge == null) {
			return listArtikel;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				String bildpfad = ergebnismenge.getString("bildpfad");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				
				listArtikel.add(new Artikel(id, beschreibung, details, preis, istGelöscht, bildpfad, -1));
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
	
	
	/**
	 * Selektiert alle Artikel, die zu keinem Festival gehören (nach ID sortiert, auch gelöschte)
	 * @return listArtikel Liste aller Artikel, die zum gewünschten Festival gehören
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Artikel> selektiereAlleUnabhaengigenArtikel() throws DatenbankException
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, details, preis, bildpfad, istgelöscht " + 
							  "FROM festiva.artikel " + 
							  "WHERE festivals_id is null ORDER BY id ASC";
		selectBefehl  = String.format(selectBefehl);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return listArtikel;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listArtikel.add(new Artikel(id, beschreibung, details, preis, istGelöscht, bildpfad, -1));
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
	
	
	/**
	 * Selektiert alle Artikel (alphabetisch sortiert)
	 * @return listArtikel Liste aller Artikel
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
	 */
	public static List<Artikel> selektiereAlleArtikel() throws DatenbankException
	{
		List<Artikel> listArtikel = new ArrayList<Artikel>();
		String selectBefehl = "SELECT id, beschreibung, details, preis, istgelöscht, bildpfad, festivals_id " + 
							  "FROM festiva.artikel " + 
							  "ORDER BY beschreibung ASC";
		selectBefehl  = String.format(selectBefehl);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismenge == null) {
			return listArtikel;
		} else {
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String beschreibung = ergebnismenge.getString("beschreibung");
				String details = ergebnismenge.getString("details");
				float preis = ergebnismenge.getFloat("preis");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				int festivalid = ergebnismenge.getInt("festivals_id");
				
				listArtikel.add(new Artikel(id, beschreibung, details, preis, istGelöscht, bildpfad, festivalid));
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
	
}