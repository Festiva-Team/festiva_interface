package standardPackage;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
//	ResultSet rs = Datenbankverbindung.erstelleDatenbankVerbindung().selektiereVonDatenbank("select * from benutzer");
//	
//	try {
//		while(rs.next()) {
//			System.out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getBoolean("istgesperrt")  +" " + rs.getString(11));
//			
//		}
//	} catch (SQLException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
//	
	Benutzer benutzer = new Benutzer(1, "Alina", "Fankhänel", "alina.fankhaenel@festiva.de", "test", "Postweg", "5", 33333 , "Gütersloh", false, "", "", false, false, 2);
	BenutzerAdministration.aktualisiereBenutzer(benutzer);
	//	BenutzerAdministration.erstelleKunden(benutzer);
	

//	Kategorie kategorie = new Kategorie(-1, "Rock", "Rock ist cool", "ichBinDerBildpfad", false);
//	KategorienAdministration.erstelleKategorie(kategorie);
	
//	try {
//		java.util.Date start = new SimpleDateFormat("yyyy-MM-dd").parse("2017-06-02");
//		java.util.Date end = new SimpleDateFormat("yyyy-MM-dd").parse("2017-06-05");
//		
//		Festival festival = new Festival(1, "Rock im Park", "Nürnberg", "Rock im Park ist ein schönes Festival", "Rock im Park ist ein schönes Festival und das hier ist die Langbeschreibung", start, end, "ichBinDerGeänderteBildpfad", false, 1);
//		FestivalAdministration.aktualisiereFestival(festival);
//	} catch (ParseException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
	
	
	Festival festival = FestivalAdministration.selektiereFestival(1);

	System.out.println(festival.id + " " + festival.name + " " + festival.ort + " " + festival.kurzbeschreibung + " " + festival.langbeschreibung + " " + festival.startDatum + " " + festival.endDatum + " " + festival.bildpfad + " " + festival.kategorienID + " " + festival.istGelöscht);
	
	Benutzer benutzer1 = BenutzerAdministration.selektiereBenutzer("alina.fankhaenel@festiva.de");
	System.out.println(benutzer1.vorname+ " " + benutzer1.nachname);

}}
//}
