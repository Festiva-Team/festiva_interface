package standard;

import java.sql.*;
import java.util.*;

/**
 * Verwaltet den Artikelstamm, gibt Artikel zurück und sucht Artikel in der DB
 * 
 * @author Nico Dübeler
 *
 */
public class ArtikelVerwaltung 
{
	/**
	 * Gibt einen Artikel aus der DB anhand der ArtikelID zurück
	 * @param p_artikelID ArtikelID des geforderten Artikels, null wenn kein Artikel gefunden
	 * @return Geforderter Artikel
	 */
	public static Artikel gibArtikelVonDB(int p_artikelID)
	{
		Artikel artikel = null;
		String sql = "SELECT KategorieID, Beschreibung, Name, Einzelpreis, Bildpfad " + 
						"FROM grillzone.artikel " + 
						"Where ArtikelID = " + p_artikelID;
		ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
		
		try
		{
			if(ergebnis.next())
			{
				String name = ergebnis.getString("Name");
				String beschreibung = ergebnis.getString("Beschreibung");
				float einzelpreis = ergebnis.getFloat("Einzelpreis");
				String bildpfad = ergebnis.getString("Bildpfad");
				int kategorieID = ergebnis.getInt("KategorieID");
				
				artikel = new Artikel(p_artikelID, name, beschreibung, einzelpreis, bildpfad, kategorieID);
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
	 * Sucht Artikel anhand von Artikelname und -beschreibung in der DB
	 * @param p_suche Begriff, nach dem gesucht werden soll
	 * @param p_sortierePreis Falls true, wird das Ergebnis nach dem Preis sortiert. Falls false, Sortierung nach dem Namen
	 * @return Liste mit Artikeln, die zu dem Suchmuster passen
	 */
	public static List<Artikel> sucheArtikelInDB(String p_suche, boolean p_sortierePreis)
	{
		List<Artikel> lstArtikel = new ArrayList<Artikel>();
		String sql = "SELECT ArtikelID, KategorieID, Beschreibung, Name, Einzelpreis, Bildpfad " + 
					 "FROM grillzone.artikel " + 
					 "Where Beschreibung like '%%%s%%' or Name like '%%%s%%' ";
		sql = String.format(sql, p_suche, p_suche);
		
		if(p_sortierePreis)
			sql += "ORDER BY Einzelpreis ASC";			
		else
			sql += "ORDER BY Name ASC";
	
		ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
		
		try
		{	
			while(ergebnis.next())
			{
				int artikelID = ergebnis.getInt("ArtikelID");				
				String name = ergebnis.getString("Name");
				String beschreibung = ergebnis.getString("Beschreibung");
				float einzelpreis = ergebnis.getFloat("Einzelpreis");
				String bildpfad = ergebnis.getString("Bildpfad");
				int kategorieID = ergebnis.getInt("KategorieID");
				
				lstArtikel.add(new Artikel(artikelID, name, beschreibung, einzelpreis, bildpfad, kategorieID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		return lstArtikel;
	}
	
	/**
	 * Gibt alle Artikel einer Kategorie zurück
	 * @param p_kategorieID ID der angeforderten Kategorie
	 * @param p_sortierePreis Falls true, wird das Ergebnis nach dem Preis sortiert. Falls false, Sortierung nach dem Namen
	 * @return Liste aller Artikel, die zur übergebenen Kategorie gehören
	 */
	public static List<Artikel> gibArtikelNachKategorieVonDB(int p_kategorieID, boolean p_sortierePreis)
	{
		List<Artikel> lstArtikel = new ArrayList<Artikel>();
		String sql = "SELECT ArtikelID, Beschreibung, Name, Einzelpreis, Bildpfad " + 
						"FROM grillzone.artikel " + 
						"Where KategorieID = %d ";
		sql = String.format(sql, p_kategorieID);
		if(p_sortierePreis)
			sql += "ORDER BY Einzelpreis ASC";			
		else
			sql += "ORDER BY Name ASC";
		ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
		
		try
		{
			while(ergebnis.next())
			{
				int artikelID = ergebnis.getInt("ArtikelID");				
				String name = ergebnis.getString("Name");
				String beschreibung = ergebnis.getString("Beschreibung");
				float einzelpreis = ergebnis.getFloat("Einzelpreis");
				String bildpfad = ergebnis.getString("Bildpfad");
				int kategorieID = p_kategorieID;
				
				lstArtikel.add(new Artikel(artikelID, name, beschreibung, einzelpreis, bildpfad, kategorieID));
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return lstArtikel;
	}
	
	/**
	 * Gibt ein Objekt der Klasse Kategorie zurück
	 * @param p_kategorieID ID der geforderten Kategorie
	 * @return Angeforderte Kategorie
	 */
	public static Kategorie gibKategorieVonDB(int p_kategorieID)
	{
		Kategorie kategorie = null;
		String sql = "SELECT Name, Beschreibung, Bildpfad " +
						"FROM grillzone.kategorie " +
						"WHERE KategorieID = %d";
		sql = String.format(sql, p_kategorieID);
		ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
		
		try 
		{
			if(ergebnis.next())
			{
				String name = ergebnis.getString("Name");
				String beschreibung = ergebnis.getString("Beschreibung");
				String bildpfad = ergebnis.getString("Bildpfad");
				
				kategorie = new Kategorie(p_kategorieID, name, beschreibung, bildpfad);
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return kategorie;
	}

	
}