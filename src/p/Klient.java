package p;

public class Klient 
{
	public Klient()
	{
		loggedIn = false;
	}
	
	public void log(boolean log)
	{
		loggedIn = log;
	}
	
	public boolean getLoggedIn()
	{
		return loggedIn;
	}
	
	private boolean loggedIn;
}

