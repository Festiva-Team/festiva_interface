import java.sql.*;

// import com.mysql.jdbc.Connection;

public class Abfrage {
public static void main(String[] args) {
	
//	try{
//			Class.forName("com.mysql.jdbc.Driver").newInstance();
//			Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/festiva", "root", "admin");
//					con.setReadOnly(true);
//					Statement stmt = con.createStatement();
//					ResultSet rs = stmt.executeQuery("Select * from gruppen");
//						
//			while(rs.next()) {
//				System.out.println(rs.getInt(1) + " " + rs.getString(2));
//				
//			}
//			rs.close();
//			stmt.close();
//			con.close();
//	}catch(Exception e) {
//		System.out.println("Fehlermeldung");
//	}
	
//	int prüfe = Datenbankverbindung.erstelleDatenbankVerbindung().fügeInDatenbankEin("INSERT INTO `gruppen`(`bezeichnung`) VALUES ('Kunden')");
	
//	if (prüfe == -1) {
//		System.out.println("Datensatz konnte nicht erstellt werden");
//	}
//	else 
//	{
	ResultSet rs = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank("select * from gruppen");
	
	try {
		while(rs.next()) {
			System.out.println(rs.getInt(1) + " " + rs.getString(2));
			
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	Benutzer benutzer = new Benutzer(-1, "Alina", "Fankhänel", "alina.fankhaenel@festiva.de", "test", "", "", 0 , "", false, "", "", false, false, 2);
	BenutzerAdministration.erstelleKunden(benutzer);
	}


}
//}
