package standardPackage;

public class DatenbankException extends Exception
{
    /**
	 * Exception, die geworfen wird, wenn die Kommunikation mit der Datenbank nicht m�glich ist (Datenbank ist nicht erreichbar)
	 */
	private static final long serialVersionUID = 1L;

	DatenbankException()
    {
        super("Kommunikation mit der Datenbank ist nicht m�glich.");
    }
}