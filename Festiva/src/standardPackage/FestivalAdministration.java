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
 * @author Alina Fankh�nel
 *
 */
public class FestivalAdministration {
	
	/**
	 * Erstellt f�r das �bergebene Festival-Objekt den Datensatz in der Datenbank.
	 * 
	 * @param p_festival: Festival-Objekt, das erstellt werden soll
	 */
	public static void erstelleFestival(Festival p_festival)
	{		
		String insertBefehl = "INSERT INTO festiva.festivals " +
							   "(name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, bildpfad, kategorien_id) " +
							   "VALUES ('%s', '%s', '%s', '%s', '%tY-%tm-%td', '%tY-%tm-%td', '%s', '%d')";
		insertBefehl = String.format(insertBefehl, p_festival.name, p_festival.ort, p_festival.kurzbeschreibung, p_festival.langbeschreibung, p_festival.startDatum, p_festival.startDatum, p_festival.startDatum, p_festival.endDatum, p_festival.endDatum, p_festival.endDatum, p_festival.bildpfad, p_festival.kategorienID);
		p_festival.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
	}
	
	
	/**
	 * Aktualisiert f�r das �bergebene Festival-Objekt den Datensatz in der Datenbank.
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
	 * L�scht das �bergebene Festival-Objekt logisch in der Datenbank.
	 * 
	 * @param p_festival: Festival-Objekt, das in der Datenbank logisch gel�scht werden soll
	 */
	public static void l�scheFestival(Festival p_festival)
	{
		String updateBefehl = "UPDATE festiva.festivals SET istgel�scht = '%d' WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_festival.istGel�scht?1:0, p_festival.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);
	}
	
	
	/**
	 * Selektiert ein Festival anhand der ID aus der Datenbank.
	 * @param p_festivalID: ID des gew�nschten Festivals
	 * @return Festival: gew�nschtes Festival, falls kein Festival gefunden wurde, wird null zur�ck gegeben
	 */
	public static Festival selektiereFestival(int p_festivalID)
	{
		Festival festival = null;
		String selectBefehl = "SELECT name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, istgel�scht, bildpfad, kategorien_id " + 
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
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				int kategorienID = ergebnismenge.getInt("kategorien_id");
				
				festival = new Festival(p_festivalID, name, ort, kurzbeschreibung, langbeschreibung, startDatum, endDatum, bildpfad, istGel�scht, kategorienID);
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
	 * Selektiert alle Festivals aus der Datenbank.
	 * @return List<Festival>: Liste mit Festival-Objekten, die alle verf�gbaren Daten beinhalten
	 */
	public static List<Festival> selektiereAlleFestival()
	{
		List<Festival> listFestivals = new ArrayList<Festival>();;
		String selectBefehl = "SELECT id, name, ort, kurzbeschreibung, langbeschreibung, startdatum, enddatum, istgel�scht, bildpfad, kategorien_id " + 
							  "FROM festiva.festivals " + 
							  "ORDER BY id ASC";
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int festivalID = ergebnismenge.getInt("id");
				String name = ergebnismenge.getString("name");
				String ort = ergebnismenge.getString("ort");
				String kurzbeschreibung = ergebnismenge.getString("kurzbeschreibung");
				String langbeschreibung = ergebnismenge.getString("langbeschreibung");
				Date startDatum = ergebnismenge.getDate("startdatum");
				Date endDatum = ergebnismenge.getDate("enddatum");
				boolean istGel�scht = ergebnismenge.getBoolean("istgel�scht");
				String bildpfad = ergebnismenge.getString("bildpfad");
				int kategorienID = ergebnismenge.getInt("kategorien_id");
				
				listFestivals.add(new Festival(festivalID, name, ort, kurzbeschreibung, langbeschreibung, startDatum, endDatum, bildpfad, istGel�scht, kategorienID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listFestivals;
	}
	
	
	/**
	 * Selektiert alle Festivals, die zu einer bestimmen Kategorie geh�ren (nach Startdatum absteigend sortiert)
	 * @param p_kategorienID: ID der gew�nschten Kategorie
	 * @return listFestivals: Liste aller Festivals, die zu der gew�nschten Kategorie geh�ren (nach Startdatum absteigend sortiert)
	 */
	public static List<FestivalSuchobjekt> selektiereFestivalsVonKategorie(int p_kategorienID)
	{
		List<FestivalSuchobjekt> listFestivals = new ArrayList<FestivalSuchobjekt>();
		String selectBefehl = "select f.id, f.name, f.ort, f.kurzbeschreibung, f.startDatum, f.endDatum, f.kategorien_id, " +
							  "(select min(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) \"vonPreis\" , " +
							  "(select max(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) \"bisPreis\" " +
							  "from festivals f left join artikel ao on ao.festivals_id = f.id " +
							  "where f.kategorien_id = '%d' AND f.istgel�scht = 0 ORDER BY f.startdatum, f.name DESC ";
		
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
				Date startDatum = ergebnismenge.getDate("startdatum");
				Date endDatum = ergebnismenge.getDate("enddatum");
				int kategorienID = ergebnismenge.getInt("kategorien_id");
				float vonPreis = ergebnismenge.getFloat("vonPreis");
				float bisPreis = ergebnismenge.getFloat("bisPreis");
				
				listFestivals.add(new FestivalSuchobjekt(id, name, ort, kurzbeschreibung, startDatum, endDatum, vonPreis, bisPreis, kategorienID));
		
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return listFestivals;
	}
	
	
	/**
	 * Selektiert alle Festivals, die den �bergebenen Kriterien gerecht werden (nach Startdatum absteigend sortiert)
	 * @param p_kategorienID: ID der gew�nschten Kategorie
	 * @param p_vonDatum: Beginn des gew�nschten Zeitraums (erwartet wird ein String in dem Format "yyyy-MM-dd", wenn kein Datum �bergeben werden soll wird null erwartet)
	 * @param p_bisDatum: Ende des gew�nschten Zeitraums (erwartet wird ein String in dem Format "yyyy-MM-dd", wenn kein Datum �bergeben werden soll wird null erwartet)
	 * @param p_bisPreis: oberer Wert der gew�nschten Preisspanne
	 * @param p_ort: Ort der gew�nschten Festivals
	 * @param p_name: Name des gew�nschten Festivals
	 * @return listFestivals: Liste aller Festivals, die zu den gew�nschten Kriterien passen (nach Startdatum absteigend sortiert)
	 */
	public static List<FestivalSuchobjekt> selektiereFestivalsInSuche(int p_kategorienID, String p_ort, String p_name,
															String p_vonDatum, String p_bisDatum, float p_bisPreis)
	{
		boolean where = false;
		List<FestivalSuchobjekt> listFestivals = new ArrayList<FestivalSuchobjekt>();
		
		String selectBefehl = "select f.id, f.name, f.ort, f.kurzbeschreibung, f.startDatum, f.endDatum, f.kategorien_id, " +
							  "(select min(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) \"vonPreis\" , " +
							  "(select max(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) \"bisPreis\" " +
							  "from festivals f left join artikel ao on ao.festivals_id = f.id ";
		
		
		// Bedingung zum Einschr�nken �ber die Kategorie
		if (p_kategorienID != 0 ) {
		  	selectBefehl = selectBefehl + "WHERE f.kategorien_id = " + p_kategorienID + " ";
		  	where = true;
		  	}
		
		// Bedingung zum Einschr�nken �ber den Ort
		if (p_ort != null && p_ort != "") {
			if (where == true) {
				selectBefehl = selectBefehl + "AND UPPER(f.ort) = '" + p_ort.toUpperCase() + "' ";
			}
			else {
				selectBefehl = selectBefehl + "WHERE UPPER(f.ort) = '" + p_ort.toUpperCase() + "' ";
				where = true;
			}
			}
		
		// Bedingung zum Einschr�nken �ber den Festivalnamen
		if (p_name != null && p_name != "") {
			if (where == true) {
				selectBefehl = selectBefehl + "AND UPPER(f.name) = '" + p_name.toUpperCase() + "' ";
			}
			else {
				selectBefehl = selectBefehl + "WHERE UPPER(f.name) = '" + p_name.toUpperCase() + "' ";
				where = true;
			}
		}
		
		// Bedingung zum Einschr�nken �ber das Startdatum des Festivals
		if (p_vonDatum != null && p_bisDatum == null) {
			
			if (where == true) {
				selectBefehl = selectBefehl + "AND f.endDatum >= '" + p_vonDatum + "' ";
			}
			else {
				selectBefehl = selectBefehl + "WHERE f.endDatum >= '" + p_vonDatum + "' ";
				where = true;
			}
		}
		
		// Bedingung zum Einschr�nken �ber das Enddatum des Festivals
		if (p_bisDatum != null && p_vonDatum == null) {
			if (where == true) {
				selectBefehl = selectBefehl + "AND f.startDatum <= '" + p_bisDatum + "' ";
			}
			else {
				selectBefehl = selectBefehl + "WHERE f.startDatum <= '" + p_bisDatum + "' ";
				where = true;
			}
		}
		
		// Bedingung zum Einschr�nken �ber Start- & Enddatum des Festivals (Auch Festivals, die:
		// - innerhalb des angegebenen Zeitraums beginnen und �ber diesen hinausgehen 
		// - vor dem angegebenen Zeitraum beginnen und innerhalb des Zeitraums enden
		// - vor dem angegebenen Zeitraum beginngen und nach dem angegebenen Zeitraum enden
		// ...werden angezeigt)
				if (p_bisDatum != null && p_vonDatum != null) {
					if (where == true) {
						selectBefehl = selectBefehl + "AND ((f.startDatum >= '" + p_vonDatum + "' OR f.endDatum <= '" + p_bisDatum + "') "
													+ "OR (f.startDatum < '" + p_vonDatum + "' AND f.endDatum > '" + p_bisDatum + "')) ";
					}
					else {
						selectBefehl = selectBefehl + "WHERE ((f.startDatum >= '" + p_vonDatum + "' OR f.endDatum <= '" + p_bisDatum + "') "
													+ "OR (f.startDatum < '" + p_vonDatum + "' AND f.endDatum > '" + p_bisDatum + "')) ";
						where = true;
					}
				}
				
				// Bedingung zum Einschr�nken �ber den Maximalpreis
				if (p_bisPreis != 0.0) {
					if (where == true) {
						selectBefehl = selectBefehl + "AND (((select min(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) <= " + p_bisPreis + 
													  ") OR ((select min(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) is null)) ";
						
					}
					else {
						selectBefehl = selectBefehl + "WHERE (((select min(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) <= " + p_bisPreis + 
													  ") OR ((select min(ai.preis) from artikel ai where ai.festivals_id = ao.festivals_id) is null)) ";
						where = true;
					}
					}
			
				//Ausschluss von Festivals, die gel�scht wurden
				if (where == true) {
					selectBefehl = selectBefehl + "AND f.istgel�scht = 0 ";
				} else {
					selectBefehl = selectBefehl + "WHERE f.istgel�scht = 0 ";
				}
				
		selectBefehl = selectBefehl	+ "GROUP BY f.id ORDER BY f.startdatum, f.name DESC";
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		
		try
		{
			while(ergebnismenge.next())
			{
				int id = ergebnismenge.getInt("id");				
				String name = ergebnismenge.getString("name");
				String ort = ergebnismenge.getString("ort");
				String kurzbeschreibung = ergebnismenge.getString("kurzbeschreibung");
				Date startDatum = ergebnismenge.getDate("startdatum");
				Date endDatum = ergebnismenge.getDate("enddatum");
				int kategorienID = ergebnismenge.getInt("kategorien_id");
				float vonPreis = ergebnismenge.getFloat("vonPreis");
				float bisPreis = ergebnismenge.getFloat("bisPreis");
				
				listFestivals.add(new FestivalSuchobjekt(id, name, ort, kurzbeschreibung, startDatum, endDatum, vonPreis, bisPreis, kategorienID));
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
