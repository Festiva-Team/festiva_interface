package standardPackage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Klasse zur Administration von Festivals
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Festivals aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class FestivalAdministration {
	
	/**
	 * Erstellt für das übergebene Festival-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_festival: Festival-Objekt, das erstellt werden soll
	 */
	public static void erstelleFestival(Festival p_festival)
	{		
		String insertBefehl = "INSERT INTO festiva.festivals " +
							   "(name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, bildpfad, kategorien_id) " +
							   "VALUES ('%s', '%s', '%s', '%s', '%tY-%tm-%td', '%tY-%tm-%td', '%s', '%d')";
		insertBefehl = String.format(insertBefehl, p_festival.name, p_festival.ort, p_festival.kurzbeschreibung, p_festival.langbeschreibung, p_festival.startDatum, p_festival.startDatum, p_festival.startDatum, p_festival.endDatum, p_festival.endDatum, p_festival.endDatum, p_festival.bildpfad, p_festival.kategorienID);
		p_festival.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	}
	
	
	/**
	 * Aktualisiert für das übergebene Festival-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_festival: Festival-Objekt, das in der Datenbank aktualisiert werden soll
	 */
	public static void aktualisiereFestival(Festival p_festival)
	{	
		String updateBefehl = "UPDATE festiva.festivals " +
							  "SET name = '%s', ort = '%s', kurzbeschreibung = '%s', langbeschreibung = '%s', startdatum = '%tY-%tm-%td', enddatum = '%tY-%tm-%td', bildpfad = '%s', kategorien_id = '%d' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_festival.name, p_festival.ort, p_festival.kurzbeschreibung, p_festival.langbeschreibung, p_festival.startDatum, p_festival.startDatum, p_festival.startDatum, p_festival.endDatum, p_festival.endDatum, p_festival.endDatum, p_festival.bildpfad, p_festival.kategorienID, p_festival.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Löscht das übergebene Festival-Objekt logisch in der Datenbank.
	 * 
	 * @param p_festival: Festival-Objekt, das in der Datenbank logisch gelöscht werden soll
	 */
	public static void löscheFestival(Festival p_festival)
	{
		String updateBefehl = "UPDATE festiva.festivals SET istgelöscht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_festival.istGelöscht?1:0, p_festival.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Selektiert ein Festival anhand der ID aus der Datenbank.
	 * @param p_festivalID: ID des gewünschten Festivals
	 * @return Festival: gewünschtes Festival, falls kein Festival gefunden wurde, wird null zurück gegeben
	 */
	public static Festival selektiereFestival(int p_festivalID)
	{
		Festival festival = null;
		String selectBefehl = "SELECT name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, istgelöscht, bildpfad, kategorien_id " + 
							  "FROM festiva.festivals " + 
							  "WHERE id = " + p_festivalID;
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			if(ergebnismenge.next())
			{
				String name = ergebnismenge.getString("name");
				String ort = ergebnismenge.getString("ort");
				String kurzbeschreibung = ergebnismenge.getString("kurzbeschreibung");
				String langbeschreibung = ergebnismenge.getString("langbeschreibung");
				Date startDatum = ergebnismenge.getDate("startdatum");
				Date endDatum = ergebnismenge.getDate("enddatum");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				int kategorienID = ergebnismenge.getInt("kategorien_id");
				
				festival = new Festival(p_festivalID, name, ort, kurzbeschreibung, langbeschreibung, startDatum, endDatum, bildpfad, istGelöscht, kategorienID);
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return festival;
	}
	
	
	/**
	 * Gibt alle Festivals, die zu einer bestimmen Kategorie gehören zurück (alphabetisch sortiert)
	 * @param p_kategorienID: ID der gewünschten Kategorie
	 * @return listFestivals: Liste aller Festivals, die zu der gewünschten Kategorie gehören (nach Startdatum absteigend sortiert)
	 */
	public static List<Festival> selektiereFestivalsVonKategorie(int p_kategorienID)
	{
		List<Festival> listFestivals = new ArrayList<Festival>();
		String selectBefehl = "SELECT id, name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, istgelöscht, bildpfad " + 
							  "FROM festiva.festivals " + 
							  "WHERE kategorien_id = '%d' ORDER BY startdatum DESC";
		selectBefehl  = String.format(selectBefehl, p_kategorienID);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String name = ergebnismenge.getString("name");
				String ort = ergebnismenge.getString("ort");
				String kurzbeschreibung = ergebnismenge.getString("kurzbeschreibung");
				String langbeschreibung = ergebnismenge.getString("langbeschreibung");
				Date startDatum = ergebnismenge.getDate("startdatum");
				Date endDatum = ergebnismenge.getDate("enddatum");
				boolean istGelöscht = ergebnismenge.getBoolean("istgelöscht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				
				listFestivals.add(new Festival(id, name, ort, kurzbeschreibung, langbeschreibung, startDatum, endDatum, bildpfad, istGelöscht, p_kategorienID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listFestivals;
	}


}
