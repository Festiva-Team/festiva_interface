package standardPackage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Klasse zur Administration von Warenk�rben
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Warenk�rben mit den zugeh�rigen Warenkorbelementen aus der Datenbank
 * 
 * @author Alina Fankh�nel
 *
 */
public class WarenkorbAdministration {
	
	/**
	 * Erstellt f�r das �bergebene Warenkorb-Objekt die Eintr�ge in der Datenbank
	 * verwendete Tabellen: warenk�rbe, warenkorbelemente
	 * 
	 * @param p_warenkorb: Warenkorb-Objekt, das in die Datenbanktabellen geschrieben werden soll
	 */
	public static void erstelleWarenkorb(Warenkorb p_warenkorb)
	{
		// Eintragungen in die Tabelle "warenk�rbe"
		String insertBefehl = "INSERT INTO festiva.warenk�rbe " +
							  "(benutzer_id) " +
							  "VALUES ('%d')";
		insertBefehl = String.format(insertBefehl, p_warenkorb.benutzerID);
		p_warenkorb.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
		
		// Eintragungen in die Tabelle "warenkorbelemente"
		for(Warenkorbelement warenkorbelement : p_warenkorb.listElemente)
		{
			insertBefehl = "INSERT INTO festiva.bestellpositionen " + 
						   "(menge, artikel_id, warenk�rbe_id) " +
						   "VALUES ('%d', '%d', '%d')";
			insertBefehl = String.format(insertBefehl, warenkorbelement.menge, warenkorbelement.artikel.id, p_warenkorb.id);
			warenkorbelement.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
		}
	}
	
	
	/**
	 * Selektiert das Warenkorb-Objekt, das zu einem bestimmten Kunden geh�rt aus der Datenbank
	 * 
	 * @param p_benutzerID: ID des Kunden, dessen Warenkorb-Objekt zur�ckgegeben werden soll
	 * @return Warenkorb: Warenkorb-Objekt, das zu dem gew�nschten Kunden geh�rt
	 */
	public static Warenkorb selektiereWarenkorbVonKunden(int p_benutzerID)
	{
		Warenkorb warenkorb = null;
		
		int warenkorbID = selektiereWarenkorbID(p_benutzerID);
		
		if (warenkorbID != -1) {				
				List<Warenkorbelement> listElemente = new ArrayList<Warenkorbelement>();
				
				// Selektiere von der Tabelle "warenkorbelemente"
				String selectBefehl = "SELECT id, menge, artikel_id " +
							   		  "FROM festiva.warenkorbelemente " +
							   		  "WHERE warenk�rbe_id = '%d' " +
							   		  "ORDER BY id ASC";
				selectBefehl = String.format(selectBefehl, warenkorbID);
				
				try
				{
					ResultSet ergebnismengeElemente = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
					
					while(ergebnismengeElemente.next())
					{
						int elementID = ergebnismengeElemente.getInt("id");
						int menge = ergebnismengeElemente.getInt("menge");

						Artikel artikel = ArtikelAdministration.selektiereArtikel(ergebnismengeElemente.getInt("artikel_id"));
						if(artikel.istGel�scht == true) {
							loescheWarenkorbelement(elementID);
						} else {
							listElemente.add(new Warenkorbelement(elementID, menge, artikel));
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
	
	
	/**
	 * Erstellt f�r den Kunden, der die �bergebene ID hat, die Eintr�ge f�r ein leeres Warenkorb-Objekt in der Datenbank
	 * 
	 * @param p_benutzerID: eindeutige ID des Benutzers, f�r den ein Warenkorb-Objekt in der Datenbank erstellt werden soll
	 */
	public static void erstelleLeerenWarenkorb(int p_benutzerID)
	{
		// Eintragungen in die Tabelle "warenk�rbe"
		String insertBefehl = "INSERT INTO festiva.warenk�rbe " +
							  "(benutzer_id) " +
							  "VALUES ('%d')";
		insertBefehl = String.format(insertBefehl, p_benutzerID);
		Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
		
	}
	
	
	/**
	 * Selektiert die ID des Warenkorbs, des Kunden dessen ID �bergeben wurde, aus der Datenbank
	 * 
	 * @param p_benutzerID: eindeutige ID des Benutzers, dessen WarenkorbID ermittelt werden soll
	 * @return int: ID des gesuchten Warenkorbs, wenn keiner gefunden wird, wird -1 zur�ckgegeben
	 */
	public static int selektiereWarenkorbID(int p_benutzerID)
	{
		int warenkorbID = -1;
		String selectBefehl = "SELECT id " +
							  "FROM festiva.warenk�rbe " +
							  "WHERE benutzer_id = '%d' ";
		selectBefehl = String.format(selectBefehl, p_benutzerID);
			
		try {
			ResultSet ergebnismengeWarenk�rbe = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
			while(ergebnismengeWarenk�rbe.next())
			{
				warenkorbID = ergebnismengeWarenk�rbe.getInt("id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return warenkorbID;
	}
	
	
	/**
	 * F�gt das �bergebene Warenkorbelement in der Datenbank ein und ordnet es dem Warenkorb des Kunden mit der �bergebenen ID zu
	 * 
	 * @param Warenkorbelement: Warenkorbelement-Objekt, das in der Datenbank erstellt werden soll
	 * @param p_benutzerID: eindeutige ID des Benutzers, f�r den das Warenkorbelement in der Datenbank erstellt werden soll
	 */
	public static void f�geWarenkorbelementEin(Warenkorbelement p_warenkorbelement, int p_benutzerID)
	{
		int warenkorbID = selektiereWarenkorbID(p_benutzerID);
		
		if (warenkorbID != -1) {
		String insertBefehl = "INSERT INTO festiva.warenkorbelemente " +
							  "(menge, warenk�rbe_id, artikel_id) " +
							  "VALUES ('%d', '%d', '%d')";
		insertBefehl = String.format(insertBefehl, p_warenkorbelement.menge, warenkorbID ,p_warenkorbelement.artikel.id);
		p_warenkorbelement.id = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin(insertBefehl);
		}
		
	}

	
	/**
	 * Aktualisiert das �bergebene Warenkorbelement in der Datenbank
	 * 
	 * @param Warenkorbelement: Warenkorbelement-Objekt, das in der Datenbank aktualisiert werden soll
	 */
	public static void aktualisiereWarenkorbelement(Warenkorbelement p_warenkorbelement)
	{		
		String updateBefehl = "UPDATE festiva.warenkorbelemente SET " +
							  "menge = '%d' " +
							  "WHERE id = '%d'";
		updateBefehl = String.format(updateBefehl, p_warenkorbelement.menge, p_warenkorbelement.id);
		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(updateBefehl);		
	}
	
	
	/**
	 * Selektiert das Warenkorbelement mit der �bergebenen ID aus der Datenbank
	 * 
	 * @param p_ID: eindeutige ID des Warenkorbelements, das aus der Datenbank selektiert werden soll
	 * @return Warenkorbelement: Warenkorbelement-Objekt mit der vorgegebenen ID, gibt null zur�ck, wenn das Objekt mit der ID nicht existiert
	 */
	public static Warenkorbelement selektiereWarenkorbelement(int p_id)
	{	
		Warenkorbelement warenkorbelement = null;
		String selectBefehl = "SELECT id, menge, artikel_id " + 
							  "FROM festiva.warenkorbelemente " +
							  "WHERE id = '%d'";
		selectBefehl = String.format(selectBefehl, p_id);
		
		ResultSet ergebnismenge = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);	
		 
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
		
		return warenkorbelement;
	}
	
	
	/**
	 * L�scht das Warenkorbelement mit der �bergebenen ID in der Datenbank dauerhaft
	 * 
	 * @param p_id: ID des Warenkorbelement-Objekts, das in der Datenbank gel�scht werden soll
	 */
	public static void loescheWarenkorbelement(int p_id)
	{		
		String deleteBefehl = "DELETE FROM festiva.warenkorbelemente WHERE id = " + p_id;

		Datenbankverbindung.erstelleDatenbankVerbindung().aktualisiereInDatenbank(deleteBefehl);		
	}
	
}
