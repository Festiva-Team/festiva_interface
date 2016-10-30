package servletPackage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


/**
*
* @author Alina Fankhänel
*/
@WebServlet("/Upload")
@MultipartConfig
public class Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Upload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 
		    Part filePart = request.getPart("bild"); 
	
		    int kategorienid = Integer.parseInt(request.getSession(false).getAttribute("kategorienid").toString());
		    File file = new File(System.getenv("myPath") + "Festiva\\festiva_interface\\Festiva\\WebContent\\Bilder\\Kategorie" + kategorienid + ".jpg");

		    request.getSession(false).removeAttribute("kategorienid");
		    try (InputStream input = filePart.getInputStream()) {
		        Files.copy(input, file.toPath());
		    }
		    request.getRequestDispatcher("a_startseiteAdmin.jsp").include(request, response);
		  
	}
	
	

}
