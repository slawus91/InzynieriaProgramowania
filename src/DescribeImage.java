import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paczka.Connections;

/**
 * Servlet implementation class DescribeImage
 */
@WebServlet("/DescribeImage")
public class DescribeImage extends HttpServlet
{
	private static final long serialVersionUID = 1L;

    public DescribeImage() 
    {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			method(request,response);
		} 
		catch (InstantiationException | IllegalAccessException
				| ClassNotFoundException | SQLException | URISyntaxException e)
		{

		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			method(request,response);
		} 
		catch (InstantiationException | IllegalAccessException	| ClassNotFoundException | SQLException | URISyntaxException e)
		{
		}
	}
	

	private void method(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, URISyntaxException
	{
		ServletOutputStream out = response.getOutputStream();
		String id = request.getParameter("id");
		response.setContentType("text/plain");
		
		if( id == null)
		{
			out.print("");
			out.flush();
			return;
		}
		else
		{ 
			id = id.trim();
			try
			{
				Integer.parseInt(id);
			}
			catch(Exception e)
			{
				out.print("");
				out.flush();
				return;
			}
		}
		
		String which = request.getParameter("which");
		int whichNo = 0;
		if(which != null)
		{
			try
			{
				whichNo = Integer.parseInt(which);
			}
			catch(Exception e)
			{
				whichNo = 0;
			}
		}
		
		Connection connection = Connections.DataBase.getConnecton();
		Statement stmt2 = connection.createStatement(); 
		ResultSet resPhoto = stmt2.executeQuery("Select descriptionPhoto From photos Where idGatunek="+ request.getParameter("id")+ "  LIMIT "+ whichNo +",1");
		
		if(resPhoto.next())
		{
			String img = resPhoto.getString(1);
			out.print(img);
			out.flush();
		}
		else
		{
			out.print("");
			out.flush();
		}
		
		resPhoto.close();
		stmt2.close();
		connection.close();
	}

}
