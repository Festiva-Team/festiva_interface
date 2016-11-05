package standardPackage;

public class DatenbankException extends Exception
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	DatenbankException()
    {
        super("Kommunikation mit der Datenbank ist nicht möglich.");
    }
}