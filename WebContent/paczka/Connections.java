package paczka;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connections
{
	public static class DataBase
	{
		private static boolean running = false;
		DataBase()
		{
			try 
			{
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				running = true;
			} 
			catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) 
			{
				running = false;
			} 
		}
		
		public static Connection getConnecton()
		{
			if(running)
			{
				try 
				{
					return DriverManager.getConnection("jdbc:mysql://192.96.219.129/akwakwiat?user=akwakwiat&password=hbWHgHbwhu3&autoReconnect=true");
				} 
				catch (SQLException e) 
				{
					return null;
				}
			}
			else
			{
				try 
				{
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					running = true;
				} 
				catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) 
				{
					running = false;
				} 
				try 
				{
					return DriverManager.getConnection("jdbc:mysql://192.96.219.129/akwakwiat?user=akwakwiat&password=hbWHgHbwhu3&autoReconnect=true");
				} 
				catch (SQLException e) 
				{
					return null;
				}
			}
		}
	}
}
