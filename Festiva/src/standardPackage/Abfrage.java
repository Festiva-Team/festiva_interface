package standardPackage;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

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
	
//	int pr�fe = Datenbankverbindung.erstelleDatenbankVerbindung().f�geInDatenbankEin("INSERT INTO `gruppen`(`bezeichnung`) VALUES ('Kunden')");
	
//	if (pr�fe == -1) {
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
//	Benutzer benutzer = new Benutzer(1, "Alina", "Fankh�nel", "alina.fankhaenel@festiva.de", "test", "Postweg", "5", 33333 , "G�tersloh", false, "", "", false, false, 2);
//	BenutzerAdministration.aktualisiereBenutzer(benutzer);
	//	BenutzerAdministration.erstelleKunden(benutzer);
	

//	Kategorie kategorie = new Kategorie(-1, "Rock", "Rock ist cool", "ichBinDerBildpfad", false);
//	KategorienAdministration.erstelleKategorie(kategorie);
	

		java.util.Date start = null;
		try {
			start = new SimpleDateFormat("yyyy-MM-dd").parse("2017-06-02");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		java.util.Date end = null;
		try {
			end = new SimpleDateFormat("yyyy-MM-dd").parse("2017-06-05");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		
		Festival festival = new Festival(-1, "Rock am Ring", "Eifel", "Rock am Ring ist ein sch�nes Festival", "Rock im Park ist ein sch�nes Festival und das hier ist die Langbeschreibung", start, end, "ichBinDerGe�nderteBildpfad", false, 1);
		FestivalAdministration.erstelleFestival(festival);
	
	
	
//	Festival festival = FestivalAdministration.selektiereFestival(1);
//
//	System.out.println(festival.id + " " + festival.name + " " + festival.ort + " " + festival.kurzbeschreibung + " " + festival.langbeschreibung + " " + festival.startDatum + " " + festival.endDatum + " " + festival.bildpfad + " " + festival.kategorienID + " " + festival.istGel�scht);
//	

	
	List<FestivalSuchobjekt> liste = FestivalAdministration.selektiereFestivalsInSuche(0, "", "", null, null, (float)0.0);

	Benutzer benutzer1 = BenutzerAdministration.selektiereBenutzer("alina.fankhaenel@festiva.de");
	System.out.println(benutzer1.vorname+ " " + benutzer1.nachname);}}
