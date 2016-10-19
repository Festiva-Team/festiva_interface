package standard;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.*;

/**
 * Bietet statische Methoden zum Erstellen, Aktualisieren und Selektieren von Anwendern aus der Datenbank
 * 
 * @author Nico Dübeler
 *
 */
public class AnwenderVerwaltung {

	/**
	 * Erstellt für das übergebene Anwenderobjekt die Einträge in der Datenbank.
	 * Angesprochene Tabellen: anwender, adresse, logindaten, zahlungsinformation
	 * 
	 * @param p_aufruferID 	Identität des Aufrufers der Methoden
	 * @param p_anwender 	Anwenderobjekt, welches in die Datenbank geschrieben wird
	 */
	public static void erstelleAnwenderInDB(int p_aufruferID, Anwender p_anwender)
	{		
		//In Anwender
		String sql = "INSERT INTO grillzone.anwender" +
					 "(GruppeID, _ErstelltAm, _ErstelltVon, _GeaendertAm, _GeaendertVon, _IstGeloescht," +
					 "Vorname, Nachname, IstGesperrt) " +
					 "VALUES (1, now(), %d, null, null, FALSE, '%s', '%s', FALSE) ";
		sql = String.format(sql, p_aufruferID, p_anwender.vorname, p_anwender.nachname);
		p_anwender.anwenderID = DBVerbindung.gibDBVerbindung().erstelleInDB(sql);
		
		//In Logindaten
		sql = "INSERT INTO grillzone.logindaten" +
				"(AnwenderID, _ErstelltAm, _ErstelltVon, _GeaendertAm, _GeaendertVon, _IstGeloescht, " +
				"EMailAdresse, PasswortHash) " +
				"VALUES (%d, now(), %d, null, null, FALSE, '%s', '%s')";
		sql = String.format(sql, p_anwender.anwenderID, p_aufruferID, p_anwender.eMail, p_anwender.passwortHash);
		DBVerbindung.gibDBVerbindung().erstelleInDB(sql);
		
		//In Adresse
		sql = "INSERT INTO grillzone.adresse" +
				"(AnwenderID, _ErstelltAm, _ErstelltVon, _GeaendertAm, _GeaendertVon, _IstGeloescht," +
				"Strasse, Hausnummer, PLZ, Ort) " +
				"VALUES (%d, now(), %d, null, null, FALSE, '%s', '%s', %d, '%s')";
		sql = String.format(sql, p_anwender.anwenderID, p_aufruferID, p_anwender.strasse, p_anwender.hausnummer, p_anwender.postleitzahl, p_anwender.ort);
		DBVerbindung.gibDBVerbindung().erstelleInDB(sql);
		
		//In Zahlungsinformationen
		SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy");
		String gueltigkeit = "STR_TO_DATE('" + format.format(p_anwender.kartenGueltigkeit) + "', '%d.%m.%Y')";
		sql = "INSERT INTO grillzone.zahlungsinformation " +
				"(AnwenderID, _ErstelltAm, _ErstelltVon, _GeaendertAm, _GeaendertVon, _IstGeloescht, " +
				"Kartennummer, Gueltigkeit, Kreditkartenfirma) " +
				"VALUES (%d, now(), %d, null, null, FALSE, %d, %s, '%s')";
		sql = String.format(sql, p_anwender.anwenderID, p_aufruferID, p_anwender.kartennummer, gueltigkeit, p_anwender.kreditFirma);			
		DBVerbindung.gibDBVerbindung().erstelleInDB(sql);
	}

	/**
	 * Erneuert für das übergebene Anwenderobjekt die Einträge in der Datenbank.
	 * Angesprochene Tabellen: anwender, adresse, logindaten, zahlungsinformation
	 * 
	 * @param p_aufruferID 	Identität des Aufrufers der Methoden
	 * @param p_anwender 	Anwenderobjekt, welches in der Datenbank aktualisiert wird
	 */
	public static void aktualisiereAnwenderInDB(int p_aufruferID, Anwender p_anwender)
	{	
		//In Anwender
		String sql = "UPDATE grillzone.anwender " +
						"SET _GeaendertAm = now(), _GeaendertVon = %d, Vorname = '%s', Nachname = '%s' " +
						"WHERE AnwenderID = %d";
		sql = String.format(sql, p_aufruferID, p_anwender.vorname, p_anwender.nachname, p_anwender.anwenderID);
		DBVerbindung.gibDBVerbindung().aktualisiereInDB(sql);
		
		//In Logindaten
		sql = "Update grillzone.logindaten" +
				" SET _GeaendertAm = now(), _GeaendertVon = %d, EMailAdresse = '%s', PasswortHash = '%s'" +
				" WHERE AnwenderID = %d";
		sql = String.format(sql, p_aufruferID, p_anwender.eMail, p_anwender.passwortHash, p_anwender.anwenderID);
		DBVerbindung.gibDBVerbindung().aktualisiereInDB(sql);
		
		//In Adresse
		sql = "UPDATE grillzone.adresse" +
				" SET _GeaendertAm = now(), _GeaendertVon = %d, Strasse = '%s', " +
				"Hausnummer = '%s', PLZ = %d, Ort = '%s'" +
				"WHERE AnwenderID = %d";
		sql = String.format(sql, p_aufruferID, p_anwender.strasse, p_anwender.hausnummer, p_anwender.postleitzahl, p_anwender.ort, p_anwender.anwenderID);
		DBVerbindung.gibDBVerbindung().aktualisiereInDB(sql);
		
		//In Zahlungsinformationen
		SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy");
		String gueltigkeit = "STR_TO_DATE('" + format.format(p_anwender.kartenGueltigkeit) + "', '%d.%m.%Y')";
		sql = "UPDATE grillzone.zahlungsinformation " +
				" SET _GeaendertAm = now(), _GeaendertVon = %d, Kartennummer =  %d, " +
				"Gueltigkeit = %s, Kreditkartenfirma = '%s' " +
				"WHERE AnwenderID = %d";
		sql = String.format(sql, p_aufruferID, p_anwender.kartennummer, gueltigkeit, p_anwender.kreditFirma, p_anwender.anwenderID);		
		DBVerbindung.gibDBVerbindung().aktualisiereInDB(sql);	
	}

	/**
	 * Sperrt oder Entsperrt den Anwender mit der übergebenen ID
	 * Angesprochene Tabellen: anwender
	 * 
	 * @param p_aufruferID 	Identität des Aufrufers der Methoden
	 * @param p_anwenderID 	ID des Ziel-Anwenders
	 * @param p_istGesperrt Flag zur Unterscheidung von Sperrung und Entsperrung
	 */
	public static void aktualisiereSperrungInDB(int p_aufruferID, int p_anwenderID, boolean p_istGesperrt)
	{
		//In Anwender
		String sql = "UPDATE grillzone.anwender " +
						"SET _GeaendertAm = now(), _GeaendertVon = %d, IstGesperrt = %b " +
						"WHERE AnwenderID = %d";
		sql = String.format(sql, p_aufruferID, p_istGesperrt, p_anwenderID);
		DBVerbindung.gibDBVerbindung().aktualisiereInDB(sql);
	}
	
	/**
	 * Aktualisiert die Gruppe des Anwenders mit der übergebenen ID
	 * Angesprochene Tabellen: anwender
	 * 
	 * @param p_aufruferID 	Identität des Aufrufers der Methoden
	 * @param p_anwenderID 	ID des Ziel-Anwenders
	 * @param p_gruppeID	ID der Gruppe
	 */
	public static void aktualisiereGruppeInDB(int p_aufruferID, int p_anwenderID, int p_gruppeID)
	{
		//In Anwender
		String sql = "UPDATE grillzone.anwender " +
						"SET _GeaendertAm = now(), _GeaendertVon = %d, GruppeID = %d " +
						"WHERE AnwenderID = %d";
		sql = String.format(sql, p_aufruferID, p_gruppeID, p_anwenderID);
		DBVerbindung.gibDBVerbindung().aktualisiereInDB(sql);
	}
	
	/**
	 * Factory-Methode: Selektiert die Daten eines Anwenders aus der Datenbank
	 * und erstellt aus diesen ein Anwenderobjekt
	 * Angesprochene Tabellen: anwender, adresse, logindaten, zahlungsinformation
	 * 
	 * @param p_EMailAdresse Mailadresse des Zielanwenders in der Datenbank 
	 * @return Neues Anwenderobjekt; null falls der Zielanwender nicht existiert.
	 */
	public static Anwender gibAnwender(String p_EMailAdresse)
	{
		Anwender anwender = null;
		String sql = 
		"SELECT an.AnwenderID, an.GruppeID, an.Vorname, an.Nachname, ad.Strasse, ad.Hausnummer, an.IstGesperrt, " + 
		"ad.PLZ, ad.Ort, lo.EMailAdresse, lo.PasswortHash, za.Kartennummer, za.Gueltigkeit, za.Kreditkartenfirma " +
		"FROM grillzone.anwender AS an " +
		"JOIN grillzone.adresse AS ad ON an.AnwenderID = ad.AnwenderID " +
		"JOIN grillzone.logindaten AS lo ON an.AnwenderID = lo.AnwenderID " +
		"JOIN grillzone.zahlungsinformation AS za ON an.AnwenderID = za.AnwenderID " +
		"Where lo.EMailAdresse = '%s'";			
		sql = String.format(sql, p_EMailAdresse);
		
		ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
		try
		{
			if(ergebnis.next())
			{
				int anwenderID = ergebnis.getInt("AnwenderID");
				int gruppeID = ergebnis.getInt("GruppeID");
				String vorname = ergebnis.getString("Vorname");
				String nachname = ergebnis.getString("Nachname");
				String eMail = p_EMailAdresse;
				String strasse = ergebnis.getString("Strasse");
				String hausnummer = ergebnis.getString("Hausnummer");
				int postleitzahl = ergebnis.getInt("PLZ");
				String ort = ergebnis.getString("Ort");
				int kartennummer = ergebnis.getInt("Kartennummer");
				Date kartenGueltigkeit = ergebnis.getTimestamp("Gueltigkeit");
				String kreditFirma = ergebnis.getString("Kreditkartenfirma");
				String passwortHash = ergebnis.getString("PasswortHash");
				boolean istGesperrt = ergebnis.getBoolean("IstGesperrt");
				anwender = new Anwender(anwenderID, gruppeID, vorname, nachname, eMail, strasse, hausnummer, postleitzahl, ort, kartennummer, kartenGueltigkeit, kreditFirma, passwortHash, istGesperrt);
			}
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}

		return anwender;
	}

	/**
	 * Factory-Methode: Selektiert die Daten eines Anwenders aus der Datenbank
	 * und erstellt aus diesen ein Anwenderobjekt
	 * Angesprochene Tabellen: anwender, adresse, logindaten, zahlungsinformation
	 * 
	 * @param p_id Identität des Zielanwenders in der Datenbank 
	 * @return Neues Anwenderobjekt; null falls der Zielanwender nicht existiert.
	 */
	public static Anwender gibAnwender(int p_id)
	{
		Anwender anwender = null;
		
		String sql = 
		"SELECT an.AnwenderID, an.GruppeID, an.Vorname, an.Nachname, ad.Strasse, an.IstGesperrt, ad.Hausnummer, " + 
		"ad.PLZ, ad.Ort, lo.EMailAdresse, lo.PasswortHash, za.Kartennummer, za.Gueltigkeit, za.Kreditkartenfirma " +
		"FROM grillzone.anwender AS an " +
		"JOIN grillzone.adresse AS ad ON an.AnwenderID = ad.AnwenderID " +
		"JOIN grillzone.logindaten AS lo ON an.AnwenderID = lo.AnwenderID " +
		"JOIN grillzone.zahlungsinformation AS za ON an.AnwenderID = za.AnwenderID " +
		"Where an.AnwenderID = %d";			
		sql = String.format(sql, p_id);
		
		ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
		
		try
		{
			if(ergebnis.next())
			{
				int anwenderID = p_id;
				int gruppeID = ergebnis.getInt("GruppeID");
				String vorname = ergebnis.getString("Vorname");
				String nachname = ergebnis.getString("Nachname");
				String eMail = ergebnis.getString("EMailAdresse");
				String strasse = ergebnis.getString("Strasse");
				String hausnummer = ergebnis.getString("Hausnummer");
				int postleitzahl = ergebnis.getInt("PLZ");
				String ort = ergebnis.getString("Ort");
				int kartennummer = ergebnis.getInt("Kartennummer");
				Date kartenGueltigkeit = ergebnis.getTimestamp("Gueltigkeit");
				String kreditFirma = ergebnis.getString("Kreditkartenfirma");
				String passwortHash = ergebnis.getString("PasswortHash");
				boolean istGesperrt = ergebnis.getBoolean("IstGesperrt");
				anwender = new Anwender(anwenderID, gruppeID, vorname, nachname, eMail, strasse, hausnummer, postleitzahl, ort, kartennummer, kartenGueltigkeit, kreditFirma, passwortHash, istGesperrt);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
		}
		return anwender;
	}

	/**
	 * Factory-Methode: Erstellt eine Liste aller Anwender aus der Datenbank
	 * Angesprochene Tabellen: anwender, adresse, logindaten, zahlungsinformation
	 * 
	 * @return Liste mit Anwenderobjekten
	 */
	public static List<Anwender> gibAnwender()
	{
		List<Anwender> lstAnwender = new ArrayList<Anwender>();
		
		// Selektieren aus der Datenbank
		String sql = 
		"SELECT an.AnwenderID, an.GruppeID, an.Vorname, an.Nachname, ad.Strasse, ad.Hausnummer, an.IstGesperrt, " + 
		"ad.PLZ, ad.Ort, lo.EMailAdresse, lo.PasswortHash, za.Kartennummer, za.Gueltigkeit, za.Kreditkartenfirma " +
		"FROM grillzone.anwender AS an " +
		"JOIN grillzone.adresse AS ad ON an.AnwenderID = ad.AnwenderID " +
		"JOIN grillzone.logindaten AS lo ON an.AnwenderID = lo.AnwenderID " +
		"JOIN grillzone.zahlungsinformation AS za ON an.AnwenderID = za.AnwenderID";			
		
		ResultSet ergebnis = DBVerbindung.gibDBVerbindung().gibVonDB(sql);
		
		// Auslesen des ResultSets
		try
		{
			while (ergebnis.next())
			{				
				int anwenderID = ergebnis.getInt("AnwenderID");
				int gruppeID = ergebnis.getInt("GruppeID");
				String vorname = ergebnis.getString("Vorname");
				String nachname = ergebnis.getString("Nachname");
				String eMail = ergebnis.getString("EMailAdresse");
				String strasse = ergebnis.getString("Strasse");
				String hausnummer = ergebnis.getString("Hausnummer");
				int postleitzahl = ergebnis.getInt("PLZ");
				String ort = ergebnis.getString("Ort");
				int kartennummer = ergebnis.getInt("Kartennummer");
				Date kartenGueltigkeit = ergebnis.getTimestamp("Gueltigkeit");
				String kreditFirma = ergebnis.getString("Kreditkartenfirma");
				String passwortHash = ergebnis.getString("PasswortHash");
				boolean istGesperrt = ergebnis.getBoolean("IstGesperrt");
				lstAnwender.add(new Anwender(anwenderID, gruppeID, vorname, nachname, eMail, strasse, hausnummer, postleitzahl, ort, kartennummer, kartenGueltigkeit, kreditFirma, passwortHash, istGesperrt));
			}
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}
		return lstAnwender;
	}
}
