package standardPackage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/**
 * Klasse zur Administration von Bestellungen
 * Beinhaltet Methoden zur Selektierung, Aktualisierung und Erstellung von Bestellungen mit den zugehörigen Bestellpositionen aus der Datenbank
 * 
 * @author Alina Fankhänel
 *
 */
public class BestellungsAdministration {

/**
 * Erstellt für das übergebene Bestellungs-Objekt die Einträge in der Datenbank
 * verwendete Tabellen: bestellungen, bestellpositionen
 * 
 * @param p_bestellung Bestellungs-Objekt, das in die Datenbanktabellen geschrieben werden soll
 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
 */
public static void erstelleBestellung(Bestellung p_bestellung) throws DatenbankException
{
	// Eintragungen in die Tabelle "bestellungen"
	String insertBefehl = "INSERT INTO festiva.bestellungen " +
						  "(perpost, benutzer_id) " +
						  "VALUES ('%d', '%d')";
	insertBefehl = String.format(insertBefehl, p_bestellung.perPost?1:0, p_bestellung.benutzerID);
	p_bestellung.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	
	// Eintragungen in die Tabelle "bestellpositionen"
	for(Bestellposition bestellposition : p_bestellung.listPositionen)
	{
		insertBefehl = "INSERT INTO festiva.bestellpositionen " + 
					   "(menge, artikel_id, beschreibung, preis, bestellungen_id) " +
					   "VALUES ('%d', '%d', '%s', '%s', '%d')";
		insertBefehl = String.format(insertBefehl, bestellposition.menge, bestellposition.artikelID, bestellposition.beschreibung, String.format("%.2f",bestellposition.preis).replace(',', '.'), p_bestellung.id);
		bestellposition.id = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin(insertBefehl);
	}
}


/**
 * Selektiert alle Bestellungs-Objekte, die zu einem bestimmten Kunden gehören aus der Datenbank
 * verwendete Tabellen: bestellungen, bestellpositionen
 * 
 * @param p_benutzerID ID des Kunden, dessen Bestellungs-Objekte zurückgegeben werden sollen
 * @return listBestellungen Liste mit den Bestellungs-Objekten, die zu dem gewünschten Kunden gehören (nach Bestelldatum absteigend sortiert)
 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht möglich ist
 */
public static List<Bestellung> selektiereBestellungenVonKunden(int p_benutzerID) throws DatenbankException
{
	List<Bestellung> listBestellungen = new ArrayList<Bestellung>();
	
	// Selektiere von der Tabelle "bestellungen"
	String selectBefehl = "SELECT id, datum, perpost, benutzer_id " +
						  "FROM festiva.bestellungen " +
						  "WHERE benutzer_id = '%d' " +
						  "ORDER BY datum DESC";
	selectBefehl = String.format(selectBefehl, p_benutzerID);
	

		ResultSet ergebnismengeBestellungen = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
		if(ergebnismengeBestellungen == null) {
			return listBestellungen;
		} else {
		
		try 
		{
		while(ergebnismengeBestellungen.next())
		{
			int bestellungsID = ergebnismengeBestellungen.getInt("id");
			Date datum = ergebnismengeBestellungen.getTimestamp("datum");
			Boolean perPost = ergebnismengeBestellungen.getBoolean("perpost");
			
			List<Bestellposition> listPositionen = new ArrayList<Bestellposition>();
			
			selectBefehl = "SELECT id, menge, artikel_id, beschreibung, preis " +
						   "FROM festiva.bestellpositionen " +
						   "WHERE bestellungen_id = '%d' " +
						   "ORDER BY id ASC";
			selectBefehl = String.format(selectBefehl, bestellungsID);
			
			try
			{
				ResultSet ergebnismengePositionen = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank(selectBefehl);
				
				while(ergebnismengePositionen.next())
				{
					int positionsID = ergebnismengePositionen.getInt("id");
					int menge = ergebnismengePositionen.getInt("menge");
					int artikelID = ergebnismengePositionen.getInt("artikel_id");
					String beschreibung = ergebnismengePositionen.getString("beschreibung");
					float preis = ergebnismengePositionen.getFloat("preis");
					
					listPositionen.add(new Bestellposition(positionsID, menge, artikelID, beschreibung, preis));
				}
			}
			catch(SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// Bestellung wird erst hinzugefügt, wenn alle Bestellpositionen ausgelesen wurden
			listBestellungen.add(new Bestellung(bestellungsID, datum, perPost, p_benutzerID, listPositionen));		
		}
	} 
	catch (SQLException e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
	}		
	
	return listBestellungen;
	}
}
}
