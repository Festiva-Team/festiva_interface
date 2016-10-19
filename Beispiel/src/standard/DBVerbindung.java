package standard;

import java.sql.*;

/**
 * Stellt über das Singelton-Prinzip maximal eine Verbindung zur Datenbank grillzone her und
 * bietet Methoden zum Zugriff auf die Datenbank
 * 
 * @author Nico Dübeler
 *
 */
public class DBVerbindung 
{
	private Connection Verbindung;
	private static DBVerbindung dBVerbindung = null;

	/**
	 * Initialisiert eine neue DBVerbindung
	 */
	private DBVerbindung()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			this.Verbindung = DriverManager.getConnection("jdbc:mysql://localhost/grillzone", "root", "");
		}
		catch(ClassNotFoundException fehler)
		{
			this.Verbindung = null;
		}
		catch(SQLException fehler)
		{
			this.Verbindung = null;
		}
	}
	
	/**
	 * Führt eine Select-Abfrage in der Datenbank durch
	 * 
	 * @param p_sql Select-Befehl (SQL)
	 * @return ResultSet mit dem selektierten Ergebnis
	 */
	public ResultSet gibVonDB(String p_sql)
	{
		ResultSet ergebnis = null;
		
		if(this.Verbindung != null)
		{
			try
			{
				Statement statement = this.Verbindung.createStatement();
				ergebnis = statement.executeQuery(p_sql);
			}
			catch(SQLException e)
			{
				System.out.println(e.getMessage());
			}
		}
		return ergebnis;
	}
	
	/**
	 * Führt einen Update-Befehl in der Datenbank durch
	 * 
	 * @param p_sql Update-Befehl (SQL)
	 * @return boolean, ob erfolgreich
	 */
	public boolean aktualisiereInDB(String p_sql)
	{
		boolean erfolg = false;
		
		if(this.Verbindung != null)
		{
			try
			{
				Statement statement = this.Verbindung.createStatement();
				statement.executeUpdate(p_sql);
				erfolg = true;
			}
			catch(SQLException e)
			{
				System.out.println(e.getMessage());
			}
		}
		return erfolg;
	}
	
	/**
	 * Führt einen Insert-Befehl in der Datenbank durch
	 * 
	 * @param p_sql Insert-Befehl (SQL)
	 * @return Schlüssel des neu erstellten Datensatzes (int)
	 */
	public int erstelleInDB(String p_sql)
	{
		int schluesselNeu = -1;
		
		if(this.Verbindung != null)
		{
			try
			{
				Statement statement = this.Verbindung.createStatement();
				statement.executeUpdate(p_sql, Statement.RETURN_GENERATED_KEYS);
				ResultSet schluessel = statement.getGeneratedKeys();
				
				if(schluessel.next())
					schluesselNeu = schluessel.getInt(1);
			}
			catch(SQLException e)
			{
				System.out.println(e.getMessage());
			}
		}
		return schluesselNeu;
	}

	/**
	 * Gibt eine DB-Verbindung zurück
	 * 
	 * @return angefragte DB-Verbindung
	 */
	public static DBVerbindung gibDBVerbindung()
	{
		if(dBVerbindung == null)
			dBVerbindung = new DBVerbindung();
		return dBVerbindung;
	}

	/**
	 * Trennt die Verbindung mit der Datenbank
	 * @throws SQLException
	 */
	public static void trenneDBVerbindung() throws SQLException
	{
		if(dBVerbindung != null)
		{
			dBVerbindung.Verbindung.close();
			dBVerbindung = null;
		}
	}
}
