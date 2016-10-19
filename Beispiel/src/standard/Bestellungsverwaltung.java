package standard;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.sql.*;

/**
 * Bietet statische Methoden zum Erstellen eines Bestellungsobjektes und zur Erstellung einer Bestellung in der DB
 * 
 * @author Nico Dübeler
 *
 */
public class Bestellungsverwaltung 
{
	/**
	 * Erstellt eine fertige Bestellung mit einer Liste an Bestellpositionen
	 * 
	 * @param p_artikelMenge 	HashMap aus 2 Integern: Schlüssel = ArtikelID; Wert = Artikelmenge
	 * @param p_anwenderID		ID des Anwenders, der die Bestellung durchführt
	 * @return Objekt vom Typ Bestellung. ID ist standardmäßig = -1
	 */
	public static Bestellung erstelleBestellung(HashMap<Integer,Integer> p_artikelMenge, int p_anwenderID)
	{
		Bestellung bestellung = null;
		List<Bestellposition> lstBestellposition = new ArrayList<Bestellposition>();
		
		// Erstellung der einzelnen Bestellpositionen
		int position = 0;
		for (int artikelID : p_artikelMenge.keySet())
		{
			position++;
			int menge = p_artikelMenge.get(artikelID);
			
			Artikel artikel = ArtikelVerwaltung.gibArtikelVonDB(artikelID);
			if(artikel == null)
				continue;
	
			lstBestellposition.add(new Bestellposition(menge, position, artikel));
		}
		
		// Erstellung der Bestellung
		bestellung = new Bestellung(-1, new java.util.Date(), p_anwenderID, lstBestellposition);
		return bestellung;
	}
	
	/**
	 * Erstellt für das übergeben Bestellungsobjekt die Einträge in der Datenbank
	 * Angesprochene Tabellen: bestellung, bestellposition
	 * 
	 * @param p_bestellung Bestellungsobjekt, welches in die Datenbank geschrieben wird
	 * @param p_aufruferID Identität des Aufrufers der Methoden
	 */
	public static void erstelleBestellungInDB(Bestellung p_bestellung, int p_aufruferID)
	{
		// In Bestellung
		SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss");
		String bestelldatum = "STR_TO_DATE('" + format.format(new Date()) + "', '%d.%m.%Y %h:%i:%s')";
		String sql = "INSERT INTO grillzone.bestellung " +
						"(AnwenderID, _ErstelltAm, _ErstelltVon, _GeaendertAm, _GeaendertVon, _IstGeloescht, Bestelldatum) " +
						"VALUES (%d, now(), %d, null, null, 0, %s)";
		sql = String.format(sql, p_bestellung.anwenderID, p_aufruferID, bestelldatum);
		p_bestellung.bestellungID = DBVerbindung.gibDBVerbindung().erstelleInDB(sql);
		
		// In Bestellposition
		for(Bestellposition bestellposition : p_bestellung.lstBestellposition)
		{
			sql = "INSERT INTO grillzone.bestellposition " + 
					"(BestellungID, ArtikelID, _ErstelltAm, _ErstelltVon, " +
					"_GeaendertAm, _GeaendertVon, _IstGeloescht, Menge, Position) " +
					"VALUES (%d, %d, now(), %d, null, null, 0, %d, %d)";
			sql = String.format(sql, p_bestellung.bestellungID, bestellposition.artikel.artikelID, p_aufruferID,
									bestellposition.menge, bestellposition.position);
			DBVerbindung.gibDBVerbindung().erstelleInDB(sql);
		}
	}
	
	public static List<Bestellung> gibBestellungNachUserVonDB(int p_anwenderID)
	{
		List<Bestellung> lstBestellung = new ArrayList<Bestellung>();
		
		// In Bestellung
		String sql = "SELECT BestellungID, Bestelldatum " +
						"FROM grillzone.bestellung " +
						"WHERE AnwenderID = %d " +
						"ORDER BY Bestelldatum DESC";
		sql = String.format(sql, p_anwenderID);
		
		try 
		{
			ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
			
			while(ergebnis.next())
			{
				int bestellungID = ergebnis.getInt("BestellungID");
				Date bestelldatum = ergebnis.getTimestamp("Bestelldatum");
				List<Bestellposition> lstBestellposition = new ArrayList<Bestellposition>();
				
				sql = "SELECT ArtikelID, Menge, Position " +
						"FROM bestellposition " +
						"WHERE BestellungID = %d";
				sql = String.format(sql, bestellungID);
				
				try
				{
					ResultSet posErgebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
					
					while(posErgebnis.next())
					{
						int artikelID = posErgebnis.getInt("ArtikelID");
						int menge = posErgebnis.getInt("Menge");
						int position = posErgebnis.getInt("Position");
						Artikel artikel = ArtikelVerwaltung.gibArtikelVonDB(artikelID);
						lstBestellposition.add(new Bestellposition(menge, position, artikel));
					}
				}
				catch(SQLException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				lstBestellung.add(new Bestellung(bestellungID, bestelldatum, p_anwenderID, lstBestellposition));		
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return lstBestellung;
	}

	public static String gibBestellStatus(Date p_bestelldatum)
	{	
		HashMap<Integer, String> statusKonfiguration = Konfiguration.gibStatusKonfiguration();
		String status = (String)statusKonfiguration.values().toArray()[statusKonfiguration.values().size()-1];
		
		long differenz =  new Date().getTime() - p_bestelldatum.getTime();
		differenz /= 3600000 * 24;
		
		for(int tag : statusKonfiguration.keySet())
		{
			if(differenz >= tag)
				status = statusKonfiguration.get(tag);
			else
				break;
		}
		
		return status;
	}
}
