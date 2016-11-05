package standardPackage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Klasse zur Administration von Warenkörben
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Warenkörben mit den zugehörigen Warenkorbelementen aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class WarenkorbAdministration {
	
	/**
	 * Erstellt für das übergebene Warenkorb-Objekt die Einträge in der Datenbank
	 * verwendete Tabellen: warenkörbe, warenkorbelemente
	 * 
	 * @param p_warenkorb: Warenkorb-Objekt, das in die Datenbanktabellen geschrieben werden soll
	 */
	public static void erstelleWarenkorb(Warenkorb p_warenkorb) throws DatenbankException
	{
		// Eintragungen in die Tabelle "warenkörbe"
		String insertBefehl = "INSERT INTO festiva.warenkörbe " +
							  "(benutzer_id) " +
							  "VALUES ('%d')";
		insertBefehl = String.format(insertBefehl, p_warenkorb.benutzerID);
		p_warenkorb.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
		
		// Eintragungen in die Tabelle "warenkorbelemente"
		for(Warenkorbelement warenkorbelement : p_warenkorb.listElemente)
		{
			insertBefehl = "INSERT INTO festiva.bestellpositionen " + 
						   "(menge, artikel_id, warenkörbe_id) " +
						   "VALUES ('%d', '%d', '%d')";
			insertBefehl = String.format(insertBefehl, warenkorbelement.menge, warenkorbelement.artikel.id, p_warenkorb.id);
			warenkorbelement.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
		}
	}
	
	
	/**
	 * Selektiert das Warenkorb-Objekt, das zu einem bestimmten Kunden gehört aus der Datenbank
	 * 
	 * @param p_benutzerID: ID des Kunden, dessen Warenkorb-Objekt zurückgegeben werden soll
	 * @param p_inKasse: gibt an ob die Darstellung für die Kasse gewünscht ist
	 * @return Warenkorb: Warenkorb-Objekt, das zu dem gewünschten Kunden gehört
	 */
	public static Warenkorb selektiereWarenkorbVonKunden(int p_benutzerID, boolean p_inKasse) throws DatenbankException
	{
		Warenkorb warenkorb = null;
		
		int warenkorbID = selektiereWarenkorbID(p_benutzerID);
		if(warenkorbID == -1)  {
			return warenkorb;
		} else {				
				List<Warenkorbelement> listElemente = new ArrayList<Warenkorbelement>();
				
				// Selektiere von der Tabelle "warenkorbelemente"
				String selectBefehl = "SELECT id, menge, artikel_id " +
							   		  "FROM festiva.warenkorbelemente " +
							   		  "WHERE warenkörbe_id = '%d' " +
							   		  "ORDER BY id ASC";
				selectBefehl = String.format(selectBefehl, warenkorbID);
				
				
					ResultSet ergebnismengeElemente = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
					if(ergebnismengeElemente == null) {
						return warenkorb;
					} else {
					
						try
						{
					while(ergebnismengeElemente.next())
					{
						int elementID = ergebnismengeElemente.getInt("id");
						int menge = ergebnismengeElemente.getInt("menge");

						Artikel artikel = ArtikelAdministration.selektiereArtikel(ergebnismengeElemente.getInt("artikel_id"));
						
						if(p_inKasse == false && artikel.id == 6) {
							loescheWarenkorbelement(elementID);
						} else {
							if(artikel.istGelöscht == true) {
								loescheWarenkorbelement(elementID);
							} else {
								listElemente.add(new Warenkorbelement(elementID, menge, artikel));
							}	
						}						
					}
				}
				catch(SQLException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				// Warenkorb wird erst erstellt, wenn alle Warenkorbelemente ausgelesen wurden
				warenkorb = new Warenkorb(warenkorbID, p_benutzerID, listElemente);		
		}
					return warenkorb;
		}
	}
	
	
	/**
	 * Erstellt für den Kunden, der die übergebene ID hat, die Einträge für ein leeres Warenkorb-Objekt in der Datenbank
	 * 
	 * @param p_benutzerID: eindeutige ID des Benutzers, für den ein Warenkorb-Objekt in der Datenbank erstellt werden soll
	 */
	public static void erstelleLeerenWarenkorb(int p_benutzerID) throws DatenbankException
	{
		// Eintragungen in die Tabelle "warenkörbe"
		String insertBefehl = "INSERT INTO festiva.warenkörbe " +
							  "(benutzer_id) " +
							  "VALUES ('%d')";
		insertBefehl = String.format(insertBefehl, p_benutzerID);
		Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
		
	}
	
	
	/**
	 * Selektiert die ID des Warenkorbs, des Kunden dessen ID übergeben wurde, aus der Datenbank
	 * 
	 * @param p_benutzerID: eindeutige ID des Benutzers, dessen WarenkorbID ermittelt werden soll
	 * @return int: ID des gesuchten Warenkorbs, wenn keiner gefunden wird, wird -1 zurückgegeben
	 */
	public static int selektiereWarenkorbID(int p_benutzerID) throws DatenbankException
	{
		int warenkorbID = -1;
		String selectBefehl = "SELECT id " +
							  "FROM festiva.warenkörbe " +
							  "WHERE benutzer_id = '%d' ";
		selectBefehl = String.format(selectBefehl, p_benutzerID);
			
		
			ResultSet ergebnismengeWarenkörbe = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
			if(ergebnismengeWarenkörbe == null) {
				return warenkorbID;
			} else {
				try {
			while(ergebnismengeWarenkörbe.next())
			{
				warenkorbID = ergebnismengeWarenkörbe.getInt("id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return warenkorbID;}
	}
	
	
	/**
	 * Fügt das übergebene Warenkorbelement in der Datenbank ein und ordnet es dem Warenkorb des Kunden mit der übergebenen ID zu
	 * 
	 * @param Warenkorbelement: Warenkorbelement-Objekt, das in der Datenbank erstellt werden soll
	 * @param p_benutzerID: eindeutige ID des Benutzers, für den das Warenkorbelement in der Datenbank erstellt werden soll
	 */
	public static void fügeWarenkorbelementEin(Warenkorbelement p_warenkorbelement, int p_benutzerID) throws DatenbankException
	{
		int warenkorbID = selektiereWarenkorbID(p_benutzerID);
		
		if (warenkorbID != -1) {
		String insertBefehl = "INSERT INTO festiva.warenkorbelemente " +
							  "(menge, warenkörbe_id, artikel_id) " +
							  "VALUES ('%d', '%d', '%d')";
		insertBefehl = String.format(insertBefehl, p_warenkorbelement.menge, warenkorbID ,p_warenkorbelement.artikel.id);
		p_warenkorbelement.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
		}
		
	}

	
	/**
	 * Aktualisiert das übergebene Warenkorbelement in der Datenbank
	 * 
	 * @param Warenkorbelement: Warenkorbelement-Objekt, das in der Datenbank aktualisiert werden soll
	 */
	public static void aktualisiereWarenkorbelement(Warenkorbelement p_warenkorbelement) throws DatenbankException
	{		
		String updateBefehl = "UPDATE festiva.warenkorbelemente SET " +
							  "menge = '%d' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_warenkorbelement.menge, p_warenkorbelement.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);		
	}
	
	
	/**
	 * Selektiert das Warenkorbelement mit der übergebenen ID aus der Datenbank
	 * 
	 * @param p_ID: eindeutige ID des Warenkorbelements, das aus der Datenbank selektiert werden soll
	 * @return Warenkorbelement: Warenkorbelement-Objekt mit der vorgegebenen ID, gibt null zurück, wenn das Objekt mit der ID nicht existiert
	 */
	public static Warenkorbelement selektiereWarenkorbelement(int p_id) throws DatenbankException
	{	
		Warenkorbelement warenkorbelement = null;
		String selectBefehl = "SELECT id, menge, artikel_id " + 
							  "FROM festiva.warenkorbelemente " +
							  "WHERE id = '%d'";
		selectBefehl = String.format(selectBefehl, p_id);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);	
		if(ergebnismenge == null) {
			return warenkorbelement;
		} else {
		try
		{
			if(ergebnismenge.next())
			{
				int menge = ergebnismenge.getInt("menge");
				int artikelID = ergebnismenge.getInt("artikel_id");
				
				Artikel artikel = ArtikelAdministration.selektiereArtikel(artikelID);
								
				warenkorbelement = new Warenkorbelement(p_id, menge, artikel);
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return warenkorbelement;}
	}
	
	
	/**
	 * Löscht das Warenkorbelement mit der übergebenen ID in der Datenbank dauerhaft
	 * 
	 * @param p_id: ID des Warenkorbelement-Objekts, das in der Datenbank gelöscht werden soll
	 */
	public static void loescheWarenkorbelement(int p_id) throws DatenbankException
	{		
		String deleteBefehl = "DELETE FROM festiva.warenkorbelemente WHERE id = " + p_id;

		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(deleteBefehl);		
	}
	
	
	/**
	 * Selektiert das Warenkorbelement mit der übergebenen ID aus der Datenbank
	 * 
	 * @param p_ID: eindeutige ID des Artikels, den das Warenkorbelement, das aus der Datenbank selektiert werden soll, beinhalten soll
	 * @return Warenkorbelement: gewünschtes Warenkorbelement-Objekt, gibt null zurück, wenn es kein Objekt gibt, dass die Artikel-ID beinhaltet
	 */
	public static Warenkorbelement selektiereWarenkorbelementMitArtikelID(int p_id) throws DatenbankException
	{	
		Warenkorbelement warenkorbelement = null;
		String selectBefehl = "SELECT id, menge " + 
							  "FROM festiva.warenkorbelemente " +
							  "WHERE artikel_id = '%d'";
		selectBefehl = String.format(selectBefehl, p_id);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);	
		if(ergebnismenge == null) {
			return warenkorbelement;
		} else {
		try
		{
			if(ergebnismenge.next())
			{
				int menge = ergebnismenge.getInt("menge");
				int id = ergebnismenge.getInt("id");
				
				Artikel artikel = ArtikelAdministration.selektiereArtikel(p_id);
								
				warenkorbelement = new Warenkorbelement(id, menge, artikel);
			}
		}
		catch(SQLException e)
		{
			// TODO
			System.out.println(e.getMessage());
		}
		
		return warenkorbelement;}
	}
	
	
	/**
	 * Löscht den Inhalt des Warenkorbs mit der übergebenen ID in der Datenbank dauerhaft
	 * 
	 * @param p_id: ID des Warenkorb-Objekts, dessen Inhalt in der Datenbank gelöscht werden soll
	 */
	public static void loescheWarenkorbinhalt(int p_id) throws DatenbankException
	{		
		String deleteBefehl = "DELETE FROM festiva.warenkorbelemente WHERE warenkörbe_id = " + p_id;

		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(deleteBefehl);		
	}
}
