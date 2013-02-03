
import java.io.IOException;
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
 * Servlet implementation class CheckUserName
 */
@WebServlet("/CheckUserName")
public class CheckUserName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckUserName() 
    {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		method(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		method(request,response);
	}

	private void method(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		Function.print("checking");
		response.setContentType("text/html");
		String userName = request.getParameter("userName");
		if(userName == null )
		{
			return;
		}
		Connection con = Connections.DataBase.getConnecton();
		if(con == null )
		{
			return;
		}
		ServletOutputStream out = response.getOutputStream();
		if( out ==null)
		{
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		}
		
		try
		{
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("Select id From user where userName="+userName);
			
			if(rs.next())
			{
				out.print("exist");
			}
			else
			{
				out.print("NoExist");
			}
			out.flush();
			out.close();
			
			rs.close();
			st.close();
			con.close();
		} 
		catch (SQLException e) 
		{
		}
	}
}
