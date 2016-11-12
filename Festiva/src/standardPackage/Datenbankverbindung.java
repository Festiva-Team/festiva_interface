package standardPackage;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Klasse zum Aufbau einer Verbindung zu der Datenbank "festiva" inkl.
 * Bereitstellung von Methoden um auf die Datenbank zugreifen zu k�nnen
 * 
 * @author Alina Fankh�nel
 *
 */

public class Datenbankverbindung {
	Connection verbindung;
	private static Datenbankverbindung datenbankVerbindung = null;

	/**
	 * Aufbau der Verbindung zur Datenbank "festiva"
	 */
	private Datenbankverbindung() {
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			this.verbindung = DriverManager.getConnection("jdbc:mysql://localhost/festiva", "root", "admin");
		} catch (ClassNotFoundException e) {
			this.verbindung = null;
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			this.verbindung = null;
			System.out.println(e.getMessage());
		}
	}

	/**
	 * Erstellung einer Datenbankverbindung
	 * 
	 * @return Datenbankverbindung Verbindung, um mit der Datenbank kommunizieren zu k�nnen
	 */
	public static Datenbankverbindung erstelleDatenbankVerbindung() {
		if (datenbankVerbindung == null)
			datenbankVerbindung = new Datenbankverbindung();
		return datenbankVerbindung;
	}

	/**
	 * Trennung der Datenbankverbindung
	 * 
	 * @throws SQLException Ausnahme, die auftritt, wenn ein Fehler im SQL vorliegt
	 */
	public static void trenneDatenbankVerbindung() throws SQLException {
		if (datenbankVerbindung != null) {
			datenbankVerbindung.verbindung.close();
			datenbankVerbindung = null;
		}
	}

	/**
	 * Durchf�hrung eines Update-Befehls
	 * 
	 * @param p_update_befehl Update-Befehl in SQL
	 * @return erfolgreich R�ckmeldung, ob Update durchgef�hrt werden konnte
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht m�glich ist
	 *         
	 */
	public boolean aktualisiereInDatenbank(String p_update_befehl) throws DatenbankException {
		boolean erfolgreich = false;

		if (this.verbindung != null) {
			try {
				Statement statement = this.verbindung.createStatement();
				statement.executeUpdate(p_update_befehl);
				erfolgreich = true;
			} catch (SQLException e) {
				System.out.println(e.getMessage());
				throw new DatenbankException();
			}
		} else {
			throw new DatenbankException();
		}
		return erfolgreich;
	}

	/**
	 * Durchf�hrung eines Insert-Befehls
	 * 
	 * @param p_insert_befehl Insert-Befehl in SQL
	 * @return neuerSchl�ssel ID, um erstellten Datensatz eindeutig identifizieren zu k�nnen (wenn kein Datensatz eingef�gt werden konnte, wird -1 zur�ckgeliefert) 
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht m�glich ist
	 */
	public int f�geInDatenbankEin(String p_insert_befehl) throws DatenbankException {
		int neuerSchl�ssel = -1;

		if (this.verbindung != null) {
			try {
				Statement statement = this.verbindung.createStatement();
				statement.executeUpdate(p_insert_befehl, Statement.RETURN_GENERATED_KEYS);
				ResultSet schl�sselSet = statement.getGeneratedKeys();

				if (schl�sselSet.next())
					neuerSchl�ssel = schl�sselSet.getInt(1);
			} catch (SQLException e) {
				System.out.println(e.getMessage());
				throw new DatenbankException();
			}
		} else {
			throw new DatenbankException();
		}
		return neuerSchl�ssel;
	}

	/**
	 * Durchf�hrung eines Select-Befehls
	 * 
	 * @param p_select_befehl Select-Befehl in SQL
	 * @return ergebnismenge Ergebnismenge des Selects
	 * @throws DatenbankException wird geworfen, wenn die Kommunikation mit der Datenbank nicht m�glich ist
	 */
	public ResultSet selektiereVonDatenbank(String p_select_befehl) throws DatenbankException {
		ResultSet ergebnismenge = null;

		if (this.verbindung != null) {
			try {
				Statement statement = this.verbindung.createStatement();
				ergebnismenge = statement.executeQuery(p_select_befehl);
			} catch (SQLException e) {
				System.out.println(e.getMessage());
				throw new DatenbankException();
			}
		} else {
			throw new DatenbankException();
		}
		return ergebnismenge;
	}

}