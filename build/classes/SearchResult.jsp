<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="paczka.*"%>
<%@ page import="org.apache.commons.fileupload.*"%> 
<%@ page import="org.apache.commons.io.output.*"%> 
<%@ page import="org.apache.commons.fileupload.servlet.*"%> 
<%@ page import="org.apache.commons.fileupload.disk.*"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%>
<%@ page import="paczka.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>AquaKwiat - Wyniki wyszukiwania</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		
	    <script type="text/JavaScript" src="adds/scripts.js"></script>
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />
	
		<%
			boolean run=true;
			String SearchByName =request.getParameter("searchByName");
			String temperatura_max  = request.getParameter("temperatura_max");
			byte b[] = null;
			
			
			String query= "Select `gatunek`.`LatinName`, `gatunek`.`PolishName`, `gatunek`.`idGatunku` FROM `gatunek` WHERE ";
		
			if(SearchByName != null)
			{
				String where="";
				String pozycja = request.getParameter("pozycja");
				String jezyk = request.getParameter("jezyk");
				
				ArrayList<String> list = new ArrayList<String>();
				
				if(jezyk.equals("1"))
				{
					list.add("`gatunek`.`LatinName`"); 	
					list.add("`gatunek`.`PolishName`");
				}
				else if(jezyk.equals("2"))
				{
					list.add("`gatunek`.`PolishName`");
				}
				else if(jezyk.equals("3"))
				{
					list.add("`gatunek`.`LatinName`"); 	
				}
				else
				{
					//próba sabotażu !
					out.print(Function.redirectToIndex());
					run=false;
				}
				
				
				if(pozycja.equals("1"))
				{
					for(int i =0 ;i < list.size();i++)
					{
						list.set(i,list.get(i)+" Like '%"+SearchByName+"%'");
					}
				}
				else if(pozycja.equals("2"))
				{
					for(int i =0 ;i < list.size();i++)
					{
						list.set(i,list.get(i)+" Like '%"+SearchByName+"'");
					}
				}
				else if(pozycja.equals("3"))
				{
					for(int i =0 ;i < list.size();i++)
					{
						list.set(i,list.get(i)+" Like '"+ SearchByName+"%'");
					}
				}
				else
				{
					//próba sabotażu !
					out.print(Function.redirectToIndex());
					run=false;
				}
				
				if(list.size() > 0)
				{
					where = list.get(0);
					
					for(int i =1 ;i < list.size();i++)
					{
						where += (" OR " + list.get(i));
					}
				}
				
				query += where;
			}//tu trzeba wstawić kolejne możliwości wyszukiwania 
			else if(temperatura_max != null)
			{
				String where="  ";
				double temp_max = Integer.parseInt(temperatura_max);
				double temp_min = Integer.parseInt(request.getParameter("temperatura_min"));
				where += temp_min + " <= `gatunek`.`temperatura_min` AND " + temp_max + " >= `gatunek`.`temperatura_max`  "; 
				
				where += Function.getValFrom3Radio("Fe","`gatunek`.`Fe`",request);
				where += Function.getValFrom3Radio("CO2","`gatunek`.`CO2`",request);
				where += Function.getValFrom3Radio("mikro","`gatunek`.`mikro`",request);
				where += Function.getValFrom3Radio("makro","`gatunek`.`makro`",request);
				
				where +=  Function.getValFromMinMaxRadio("wymaganiaSw","`gatunek`.`swiatlo`",request);
				where +=  Function.getValFromMinMaxRadio("szybkoscWzrostu","`gatunek`.`szybkosc`",request);
				where +=  Function.getValFromMinMaxRadio("trudnoscUprawy","`gatunek`.`trudnosc`",request);
				
				query += where;
				//out.print(query+"<br>");
			}
			else
			{
				try
				{
					ServletFileUpload sfu = Function.sfu; 
				    List items = sfu.parseRequest(request); 
				      
				    Iterator iter = items.iterator(); 
			
			      	while (iter.hasNext()) 
			      	{ 
			        	FileItem itemm = (FileItem) iter.next(); 
			         	if (!itemm.isFormField()) 
			         	{ 
			            	b = itemm.get(); 
			         	}
			      	}
					}
				catch(Exception e)
				{
					
				}
				
		      	if(b == null)
		      	{
					//próba sabotażu !
					out.print(Function.redirectToIndex());
					run=false;
		      	}
			
			}
			
			//wysyłamy zapytanie do bazy :D
			if(run)
			{
				try
				{
			
					Connection connection = Connections.DataBase.getConnecton();
					
					Statement stmt;
					stmt= connection.createStatement();
					
					try
					{
						ResultSet set =null;
						if(b == null )
						{
							set = stmt.executeQuery(query);
						}
						else
						{
							PreparedStatement stmtp = connection.prepareStatement("Select `gatunek`.`LatinName`, `gatunek`.`PolishName`, `gatunek`.`idGatunku` FROM `gatunek` join `photos` on `photos`.`idGatunek` =`gatunek`.`idGatunku` where `photos`.`Photo`= ? ");
							stmtp.setBytes(1, b);
							set = stmtp.executeQuery();
							
						}
						
						
						out.print("Wyniki wyszukiwania<br>");
						
						int ileWynikow=0;
						
						out.print("<table>");
						String latino="";
						
						while(set.next())
						{
							ileWynikow++;
							latino = set.getString(1);
							String polonino =set.getString(2);
							out.print("<tr onclick=\"DoNav('Result.jsp?latinName="+latino+"');\">");
								out.print("<td>");
									out.print("<img src=\"image?id="+ set.getInt(3)+"\" height=\"100\" width=\"100\"/>");
								out.print("</td>");
								out.print("<td>");
									out.print("<table>");
										out.print("<tr><td>"+latino + "</td></tr>");
										out.print("<tr><td>"+polonino + "</td></tr>");
									out.print("</table>");
								out.print("</td>");
							
							out.print("</tr>");
						}
						
						set.close();
						stmt.close();
						connection.close();
						
						if(ileWynikow == 0)
						{
							out.print("Brak wyników wyszukiwania<br>");
						}
						else if(ileWynikow ==1)
						{							 
								out.print("<script type=\"text/JavaScript\">");
								out.print("DoNav('Result.jsp?latinName="+latino+"'");
							   	out.print("</script>");
						}
						
						out.print("</table>");
					}
					catch (Exception e) 
					{
						out.println("Niestety nie udało się wykonać wyszukiwania rekordu, za utrudnienia przepraszamy. [Kod błędu: 1] "+ e);
						 out.println(Function.redirectToIndex());
					}
				} 
				catch (Exception e) 
				{
					out.println("Niestety nie udało się wykonać wyszukiwania rekordu, za utrudnienia przepraszamy. [Kod błędu: 3] "+ e);
					 out.println(Function.redirectToIndex());
				}
			}
			
		%>
		<jsp:include page="Foot.jsp" />
	</body>
</html>