

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Blob;
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
import paczka.Function;

/**
 * Servlet implementation class image
 */
@WebServlet("/image")
public class image extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public image() 
    {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
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
		response.setContentType("image"); 
		
		if( id == null)
		{
			response.setContentType("text");
			out.print("http://slawus91.s16.eatj.com/img/BrakFoty.jpg");
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

				response.setContentType("text");
				out.print("http://slawus91.s16.eatj.com/img/BrakFoty.jpg");
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
		ResultSet resPhoto = stmt2.executeQuery("Select Photo From photos Where idGatunek="+ request.getParameter("id")+ "  LIMIT "+ whichNo +",1");
		
		if(resPhoto.next())
		{
			Blob img = resPhoto.getBlob(1);
			byte[] imgData = img.getBytes(1,(int)img.length());
			out.write(imgData);
			out.flush();
		}
		else
		{
			response.setContentType("text");
			out.print("http://slawus91.s16.eatj.com/img/BrakFoty.jpg");
			out.flush();
		}
		
		resPhoto.close();
		stmt2.close();
		connection.close();
	}
}
