<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="paczka.*"%>
<jsp:useBean id="klient" scope="session" class="p.Klient"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>AquaKwiat - Dziękujemy za dodanie wpisu</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<script type="text/JavaScript" src="adds/scripts.js"></script>
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />
		<%

			String LatinName = request.getParameter("LatinName");
			if(LatinName != null && !LatinName.trim().equals("") || !klient.getLoggedIn())
			{
				try
				{
					// co by się nie udało to musimy wyjść !  bo nie ma sensu tego ciągnąć jeślifragment się już nie udał
					Connection connection = Connections.DataBase.getConnecton();
					Statement stmt = connection.createStatement ();
					
					try
					{
						//czyli wiemy że to jednak zapytanie, a nie przypadkowe przyjście na tą stronkę :)
						String PolishName = request.getParameter("PolishName");
						String Europa = request.getParameter("Europa");
						String Azja = request.getParameter("Azja");
						String Australia = request.getParameter("Australia");
						String AmerykaPn = request.getParameter("AmerykaPn");
						String AmerykaPol = request.getParameter("AmerykaPol");
						String Afryka = request.getParameter("Afryka");
						String doCountry = request.getParameter("doCountry");
						String lodygowa = request.getParameter("lodygowa");
	
						//out.print("LatinName: " + LatinName + "<br>");
						//out.print("PolishName: " + PolishName + "<br>");
						//out.print("Europa: " + Europa + "<br>");
						//out.print("Azja: " + Azja + "<br>");
						//out.print("Australia: " + Australia + "<br>");
						//out.print("AmerykaPn: " + AmerykaPn + "<br>");
						//out.print("AmerykaPol: " + AmerykaPol + "<br>");
						//out.print("Afryka: " + Afryka + "<br>");
						//out.print("doCountry: " + doCountry + "<br>");
						//out.print("lodygowa: " + lodygowa + "<br>"); 
						
						int mech= -1;
	
						if (!lodygowa.equals("mech")) 
						{
							String listki = request.getParameter("listki");
							String kolor = request.getParameter("kolor");
	
							//out.print("listki: " + listki + "<br>");
							//out.print("kolor: " + kolor + "<br>");
							
							int lisc = -1;
	
							if (listki.equals("lisciaste")) 
							{
								String ksztalt = request.getParameter("ksztalt").trim();
								String kwiat = request.getParameter("kwiat");
								String korzen = request.getParameter("korzen");
								String wide_min = request.getParameter("wide_min");
								String wide_max = request.getParameter("wide_max");
	
								//out.print("ksztalt: " + ksztalt + "<br>");
								//out.print("kwiat: " + kwiat + "<br>");
								//out.print("korzen: " + korzen + "<br>");
								//out.print("wide_min: " + wide_min + "<br>");
								//out.print("wide_max: " + wide_max + "<br>");
								
								String query = "INSERT INTO `lisc` (`idLisc`, `kwiat`, `korzen`," + 
										"`Szerokosc_liscia_max`, `Szerokosc_liscia_min`, ` ksztaltLiscia`)"+
										"VALUES (NULL, " + ((kwiat==null)?"'0',":"'1',")+ ((korzen==null)?"'0',":"'1',")+
										"'"+wide_max+"','"+ wide_min+"','"+ksztalt +"');";
								
								//out.print(query+"<br>");
								//dodajemy wpis do tabeli lisc :)
								stmt.executeUpdate(query,Statement.RETURN_GENERATED_KEYS);
								
								ResultSet liscaa = stmt.getGeneratedKeys();
								
								if(liscaa==null)
								{
									//out.print("null <br>");
								}
								else
								{
									//i tak mamytylko jeden wynik
									if(liscaa.next())
									{
										//out.print(liscaa.getRow());
										lisc = liscaa.getInt(1);
										
									}
								}

							}
	
							String lenght_max = request.getParameter("lenght_max");
							String lenght_min = request.getParameter("lenght_min");
							String height_max = request.getParameter("height_max");
							String height_min = request.getParameter("height_min");
							String weight_max = request.getParameter("weight_max");
							String weight_min = request.getParameter("weight_min");
	
							//out.print("lenght_max: " + lenght_max + "<br>");
							//out.print("lenght_min: " + lenght_min + "<br>");
							//out.print("height_max: " + height_max + "<br>");
							//out.print("height_min: " + height_min + "<br>");
							//out.print("weight_max: " + weight_max + "<br>");
							//out.print("weight_min: " + weight_min + "<br>");
							
							String q="INSERT INTO `akwakwiat`.`wyglad`" +
									"(`idWyglad`,`idLisc`, `dlugosc_liscia_max`, `dlugosc_liscia_min`, `wysokosc_rosliny_max`,"+ 
									"`wysokosc_rosliny_min`, `szerokosc_rosliny_max`, `szerokosc_rosliny_min`," +
									"`kolorLiscia`, `rodzajLiscia`) VALUES" +"(NULL,"+ ((lisc==-1)?"NULL,":("'"+lisc+"',")) +
									"'"+lenght_max+"','"+lenght_min+"','"+height_max+"','"+height_min+"','"+
									weight_max+"','"+weight_min+"','"+kolor+"','"+listki+"');"; 
									
							stmt.executeUpdate(q,Statement.RETURN_GENERATED_KEYS);
							//out.print(q+ "<br>");
							
							ResultSet lisca = stmt.getGeneratedKeys();
							if(lisca==null)
							{
								//out.print("null <br>");
							}
							else
							{
								if(lisca.next())
								{
									//out.print(lisca.getRow());
									mech = lisca.getInt(1);
									
								}
							}
							//out.print("null <br>");
						}
	
						String rozmnazanie = request.getParameter("rozmnazanie").trim();
						String temperature_max = request.getParameter("temperature_max").trim();
						String temperature_min = request.getParameter("temperature_min").trim();
						String wymaganiaSw = request.getParameter("wymaganiaSw").trim();
						String szypkoscWzrostu = request.getParameter("szypkoscWzrostu").trim();
						String trudnoscUprawy = request.getParameter("trudnoscUprawy").trim();
						String CO2 = request.getParameter("CO2");
						String Fe = request.getParameter("Fe");
						String mikro = request.getParameter("mikro");
						String makro = request.getParameter("makro");
						String dodHodowla = request.getParameter("dodHodowla").trim();
						String dodRoslina = request.getParameter("dodRoslina").trim();
	
						//out.print("rozmnazanie: " + rozmnazanie + "<br>");
						//out.print("temperature_max: " + temperature_max+ "<br>");
						//out.print("temperature_min: " + temperature_min+ "<br>");
						//out.print("wymaganiaSw: " + wymaganiaSw + "<br>");
						//out.print("szypkoscWzrostu: " + szypkoscWzrostu+ "<br>");
						//out.print("trudnoscUprawy: " + trudnoscUprawy + "<br>");
						//out.print("CO2: " + CO2 + "<br>");
						//out.print("Fe: " + Fe + "<br>");
						//out.print("mikro: " + mikro + "<br>");
						//out.print("makro: " + makro + "<br>");
						//out.print("dodHodowla: " + dodHodowla + "<br>");
						//out.print("dodRoslina: " + dodRoslina + "<br>");
						
						String region="";
						region+= (Europa==null)?"":(Europa+",");
						region+= (Azja==null)?"":(Azja+",");
						region+= (Australia==null)?"":(Australia+",");
						region+= (AmerykaPn==null)?"":(AmerykaPn+",");
						region+= (AmerykaPol==null)?"":(AmerykaPol+",");
						region+= (Afryka==null)?"":(Afryka+",");
						region = region.substring(0,region.length()-1);
						
						String qu = "INSERT INTO `akwakwiat`.`dodinfo` (`idDodInfo`, `dodHodowla`, "+
								"`dodPochodzenie`, `dodRoslina`) VALUES (NULL, '"+dodHodowla+"', '"+doCountry+
								"', '"+dodRoslina+"');";
								//out.print("dodRoslina: " + qu + "<br>");
								
	
						int dod = stmt.executeUpdate(qu,Statement.RETURN_GENERATED_KEYS);
						ResultSet rs = stmt.getGeneratedKeys();
						if(rs==null)
						{
							//out.print("null <br>");
						}
						else
						{
							if(rs.next())
							{
								//out.print(rs.getRow());
								dod = rs.getInt(1);
								
							}
							rs.close();
						}

						qu = "INSERT INTO `akwakwiat`.`gatunek` (`LatinName`, `PolishName`, `region`,`"+
								"lodygowa`,`temperatura_max`, `temperatura_min`, `swiatlo`, `szybkosc`, `trudnosc`, `CO2`,"+
								" `Fe`, `mikro`, `makro`, `idDodInfo`, `idWyglad`, `Rozmnazanie`) VALUES ('"+
								LatinName+"','"+PolishName+"','"+region+"','"+lodygowa+"','"+temperature_max+"','"+
								temperature_min+"','"+wymaganiaSw+"','"+szypkoscWzrostu+"','"+trudnoscUprawy+"',"+
								((CO2==null)?"'0',":"'1',")+((Fe==null)?"'0',":"'1',")+((mikro==null)?"'0',":"'1',")+
								((makro==null)?"'0',":"'1',")+"'"+dod+"',"+ ((mech==-1)?"NULL,":("'"+mech+"',"))+
								"'"+rozmnazanie+"');";

						//out.print(qu + "<br>");
							
							
						stmt.executeUpdate(qu);
						stmt.close();
					}
					finally
					{
						try 
						{
							if (!connection.isClosed()) 
							{
								out.println("Dziękujemy za dodanie kolejnego rekordu do naszej bazy danych!<br>");
								connection.close();
							} 
							else
							{
								out.println("Niestety nie udało się dodać Twojego rekordu, za utrudnienia przepraszamy. [Kod błędu: 1]");
							}
						}							
						catch (Exception e) 
						{
							out.println("Niestety nie udało się dodać Twojego rekordu, za utrudnienia przepraszamy. [Kod błędu: 2]");
						}
					}
				} 
				catch (Exception e) 
				{
					out.println("Niestety nie udało się dodać Twojego rekordu, za utrudnienia przepraszamy. [Kod błędu: 4]");
				}
			} 
			else 
			{
				//jeli to nie będą dane do bazy przekierowujemy go na stronę główną:D
				response.sendRedirect("index.jsp");
			}
			out.print(Function.redirectToIndex());
		%>
		<jsp:include page="Foot.jsp" />
	</body>
</html>