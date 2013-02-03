<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
    <%@ page import="java.util.*"  %>
    <%@ page import="paczka.*"%>
<jsp:useBean id="klient" scope="session" class="p.Klient"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<%
		String name = null;
		String polishName= null;
		String region= null;
		String lodygowa= null;
		int temp_max= 0;
		int temp_min= 0;
		String swiatlo= null;
		String szybkosc= null;
		String trudnosc= null;
		boolean CO2= false;
		boolean Fe = false;
		boolean mikro= false;
		boolean makro= false;
		int idDodInfo= 0;
		int idWyglad= 0;
		String rozmnazanie= null;
		int idGatunku = 0;
		
		String dodHodowla= null;
		String dodPochodzenie= null;
		String dodRoslina= null;
		
		int idLisc= 0;
		int dlugosc_liscia_max= 0;
		int dlugosc_liscia_min= 0;
		int wysokosc_rosliny_max= 0;
		int wysokosc_rosliny_min= 0;
		int szerokosc_rosliny_max= 0;
		int szerokosc_rosliny_min= 0;
		String kolorLiscia= null;
		String rodzajLiscia= null;
		
		boolean kwiat = false;
		boolean korzen = false;
		int Szerokosc_liscia_max = 0;
		int Szerokosc_liscia_min = 0;
		String ksztaltLiscia = null;
		int ileZdjec=0;
		
		try
		{
			name=request.getParameter("latinName");
			if(name == null)
			{
				response.sendRedirect("index.jsp");
			}
		
			Connection conn= Connections.DataBase.getConnecton(); 
		    Statement st = conn.createStatement();
		    ResultSet rs=st.executeQuery("select PolishName, region, lodygowa, temperatura_max, temperatura_min, swiatlo, szybkosc, trudnosc, CO2, Fe, mikro, makro, idDodInfo, idWyglad, rozmnazanie, idGatunku from gatunek where LatinName='"+name+"'");
		    
		    while(rs.next())
			{
		  		polishName = rs.getString(1);
		        region = rs.getString(2);
		        lodygowa = rs.getString(3);
		        temp_max = rs.getInt(4);
		        temp_min = rs.getInt(5);
		        swiatlo = rs.getString(6);
		        szybkosc = rs.getString(7);
		        trudnosc = rs.getString(8);
		        CO2 = rs.getBoolean(9);
		        Fe = rs.getBoolean(10);
		        mikro = rs.getBoolean(11);
		        makro = rs.getBoolean(12);
		        idDodInfo = rs.getInt(13);
		        idWyglad = rs.getInt(14);
		        rozmnazanie = rs.getString(15);
				idGatunku = rs.getInt(16);
		    }

		    ileZdjec = Function.getNumImage(idGatunku);
		    
		    rs=st.executeQuery("select dodHodowla, dodPochodzenie, dodRoslina from dodinfo where idDodInfo='"+idDodInfo+"'");
		    
			while(rs.next())
		    {
		      
		        dodHodowla = rs.getString(1);
		        dodPochodzenie = rs.getString(2);
		    	dodRoslina = rs.getString(3);
		    }
		           
		    rs=st.executeQuery("select idLisc, dlugosc_liscia_max, dlugosc_liscia_min, wysokosc_rosliny_max, wysokosc_rosliny_min,  	szerokosc_rosliny_max, szerokosc_rosliny_min, kolorLiscia, rodzajLiscia from wyglad where idWyglad='"+idWyglad+"'");
		           
		    while(rs.next())
			{
		        idLisc = rs.getInt(1);
		        dlugosc_liscia_max = rs.getInt(2);
		        dlugosc_liscia_min = rs.getInt(3);
		        wysokosc_rosliny_max = rs.getInt(4);
		        wysokosc_rosliny_min = rs.getInt(5);
		        szerokosc_rosliny_max = rs.getInt(6);
		        szerokosc_rosliny_min = rs.getInt(7);
		        kolorLiscia = rs.getString(8) ;
		    	rodzajLiscia = rs.getString(9) ;    	   
		    }
		    rs=st.executeQuery("select kwiat, korzen, Szerokosc_liscia_max, Szerokosc_liscia_min, ksztaltLiscia from lisc where idLisc='"+idLisc+"'");
		          
		    while(rs.next())
			{
		        kwiat = rs.getBoolean(1);
		        korzen = rs.getBoolean(2);
		        Szerokosc_liscia_max = rs.getInt(3);
		        Szerokosc_liscia_min = rs.getInt(4);
		    	ksztaltLiscia = rs.getString(5);
			}
		}
		catch(Exception e)
		{
		}
	%>
	<%!
		String test(boolean i)
		{
			if(i)
				return "tak";
			else
				return "nie";
			
		}
		
		String testSwiatlo(String tekst)
		{
			if(tekst.equals("bwysokie"))
			{
				tekst=  "bardzo wysokie";
			}
			else if(tekst.equals("bmale"))
			{
				tekst=  "bardzo maĹ‚e";
			}
			else if(tekst.equals("male"))
			{
				tekst=  "maĹ‚e";
			}
			return tekst;
		}
		
		String testWzrost(String tekst)
		{
			if(tekst.equals("bszybkie"))
			{
				return "bardzo szybkie";
			}
			else if(tekst.equals("bwolne"))
			{
				return "bardzo wolne";
			}
			else 
				return tekst;
		}
		
		String testTrudnosc(String tekst)
		{
			if(tekst.equals("btrudna"))
			{
				tekst= "bardzo trudna";
			}
			if(tekst.equals("latwa"))
			{
				tekst= "Ĺ‚atwa";
			}
			return tekst;
		}
		
		String testLodygowa(String tekst)
		{
			if(tekst.equals("mech"))
			{
				tekst = "mechowata";
			}
			if(tekst.equals("lodygowa"))
			{
				tekst = "Ĺ‚odygowa";
			}
			if(tekst.equals("bezlodygowa"))
			{
				tekst = "bezĹ‚odygowa";
			}
			return tekst;
		}
		
		String testPochodzenie(String tekst)
		{
			if(tekst.contains("Australia"))
			{
				//tekst.replaceAll("Australia", " sdf");
				tekst = tekst.replaceAll("Australia", " Australia");
			}
			if(tekst.contains("AmerykaPol"))
			{
				tekst = tekst.replaceAll("AmerykaPol", " Ameryka PoĹ‚udniowa");
			}
			if(tekst.contains("Azja"))
			{
				tekst = tekst.replaceAll("Azja", " Azja");
			}
			if(tekst.contains("AmerykaPn"))
			{
				tekst = tekst.replaceAll("AmerykaPn", " Ameryka PĂłĹ‚nocna");
			}
			if(tekst.contains("Afryka"))
			{
				tekst = tekst.replaceAll("Afryka", " Afryka");
			}
			
			return tekst;
		}
		
		String testKsztalt(String tekst)
		{
			if(tekst.equals("podluzny"))
			{
				tekst = "podĹ‚uĹĽny";
			}
			if(tekst.equals("okragly"))
			{
				tekst = "okrÄ…gĹ‚y";
			}
			return tekst;
		}
		
		String testRodzajLiscia(String tekst)
		{
			if(tekst.equals("lisciaste"))
			{
				tekst = "liĹ›ciaste";
			}
			return tekst;
		}
	%>
		<title>AquaKwiat - <%= name %> </title>
		
		<script type="text/JavaScript" src="adds/scripts.js"></script>
		<script type="text/javascript">
		
		
	    	var img = 0;
	    	var message = new Array();
			
	    	function createRequestObject() {
				var ro;
				var browser = navigator.appName;
				if(browser == "Microsoft Internet Explorer")
				{
					ro = new ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					ro = new XMLHttpRequest();
				}
				return ro;
			}
			
			 function handleResponse() 
			 {
				if(http.readyState == 4) 
				{
					var update = http.responseText;
					message[num] = update;
				}
			 }
	    	
	      	function switchImage(image,desc,d)
	      	{
	        	const imgs = <%= ileZdjec  %>;  // Total number of images
	      	
				img+=d;
	        	if(img>=imgs)
				{
					img=img-imgs;
				}
	        	else if(img<0)
				{
					img=imgs+img;
					if(img<0)
					{
						img=imgs+img;
					}
				}
	        	image.src = "image?id="+<%= idGatunku %>+"&which="+img;
	        	
	        	descibe(desc);
	      	}
	      	
	      	function descibe(desc)
	      	{
	      		var http= createRequestObject();
				
	      		http.open('get', "DescribeImage?id="+<%= idGatunku %>+"&which="+img,true);
				http.onreadystatechange =function (){
					if(http.readyState == 4) 
					{
						var update = http.responseText;
						desc.innerHTML = update+"<br>";
					}
				 };
				http.send(null);

	  			//desc.innerHTML=message[num]+"<br>";
	      	}
	    </script>
	</head>
	<body bgcolor =76dec7>
	<jsp:include page="header.jsp" />
		<TABLE ALIGN ="CENTER" WIDTH="750" HEIGHT="0"  >
			<tr>	
				<td valign="top" width="750"><p align="center">
				<BR>
		
				<FONT COLOR="#000000"></FONT>
				<FONT SIZE="+4" COLOR="0e0b6a"><B><I><%=name %></I></B><BR> </FONT>
				 <FONT SIZE="+2" COLOR="9b0b67"><B>
				 - <%=polishName %></B></FONT><BR><BR>
				<BR><p ALIGN="justify" >
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Region pochodzenia:</I> </B></FONT>
				<%=testPochodzenie(region) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Dodatkowe informacje dotyczące pochodzenia: </I> </B></FONT>
				<%=dodPochodzenie %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Łodygowa: </I></B></FONT>
				<%=testLodygowa(lodygowa) %><BR>
				
				<%
				if(!lodygowa.equals("mech"))
				{
				%>
				
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Rodzaj uliścienia: </I></B></FONT>
				<%=testRodzajLiscia(rodzajLiscia) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Kolor uliścienia: </I></B></FONT>
				<%=kolorLiscia %><BR>
				
				
				
				<%
				if(rodzajLiscia.equals("lisciaste"))
				{
				%>
				
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Wygląd Liścia: </I></B></FONT>
				<%=testKsztalt(ksztaltLiscia) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Posiada kwiaty: </I></B></FONT>
				<%=test(kwiat) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Może rosnąć na korzeniu/kamieniu: </I></B></FONT>
				<%=test(korzen) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Szerokość liścia (w mm): </I></B></FONT>
				max: <%=Szerokosc_liscia_max %>   min: <%=Szerokosc_liscia_min %><BR>
				
				<%
				}
				%>
				
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Dłuugość liśccia (w mm): </I></B></FONT>
				max: <%=dlugosc_liscia_max %>   min: <%=dlugosc_liscia_min %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Wysokość rośliny  (w mm): </I></B></FONT>
				max: <%=wysokosc_rosliny_max %>   min: <%=wysokosc_rosliny_min %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Szerokość rośliny (w mm): </I></B></FONT>
				max: <%=szerokosc_rosliny_max %>   min: <%=szerokosc_rosliny_min %><BR>
				
				<%
				}
				%>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Rozmnażanie przez: </I></B></FONT>
				<%=rozmnazanie %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Zalecana temperatura: </I></B></FONT>
				max: <%=temp_max %>   min: <%=temp_min %><BR>
				 
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Wymagania świetlne: </I></B></FONT>
				<%=testSwiatlo(swiatlo) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Szybkość wzrostu: </I></B></FONT>
				<%=testWzrost(szybkosc) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Trudność uprawy: </I></B></FONT>
				<%=testTrudnosc(trudnosc) %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Dodatkowe informacje dotyczące hodowli: </I></B></FONT>
				<%=dodHodowla %><BR>
				
				<FONT SIZE="+1" COLOR="3333FF"><B><I> Dodatkowe informacje o roślinie: </I></B></FONT>
				<P><%=dodRoslina %></P><BR>
				<% 
					out.print("<td>");
						out.print("<img src=\"image?id="+idGatunku+"\" height=\"300\" width=\"300\"/>");
					out.print("</td>");
				%>
				</td>
			</tr>
			<tr>
			<td> <h2><FONT COLOR="3333FF">Wszystkie zdjęcia roślinki : </FONT></h2></td>
			</tr>
		</TABLE>
				<table><tr>
			<%
				if(ileZdjec ==0)
				{ // tutaj nic nie bÄ™dziemy robiÄ‡ wkoĹ„cu zdjÄ™Ä‡ brak :D
				}
				else if(ileZdjec ==1)
				{
			%>
				
    			<td><img id="myImg1" src="image?id=<%=idGatunku%>&which=0" height="300" width="300"/><br><p id="myDesc1"><%= Function.getDescribeFromImage(idGatunku,0)	%><br></p></td>
			<%
				}
				else if(ileZdjec ==2)
				{
			%>
    			<td><img id="myImg1" src="image?id=<%=idGatunku%>&which=0" height="300" width="300"/><br><p id="myDesc1"><%= Function.getDescribeFromImage(idGatunku,0)	%><br></p></td>    
    			<td><img id="myImg2" src="image?id=<%=idGatunku%>&which=1" height="300" width="300"/><br><p id="myDesc2"><%= Function.getDescribeFromImage(idGatunku,1)	%><br></p></td>
			<%
				}
				else if(ileZdjec ==3)
				{
			%>
    			<td><img id="myImg1" src="image?id=<%=idGatunku%>&which=0" height="300" width="300"/><br><p id="myDesc1"><%= Function.getDescribeFromImage(idGatunku,0)	%><br></p></td>    
    			<td><img id="myImg2" src="image?id=<%=idGatunku%>&which=1" height="300" width="300"/><br><p id="myDesc2"><%= Function.getDescribeFromImage(idGatunku,1)	%><br></p></td> 
    			<td><img id="myImg3" src="image?id=<%=idGatunku%>&which=2" height="300" width="300"/><br><p id="myDesc3"><%= Function.getDescribeFromImage(idGatunku,2)	%><br></p></td>
			<%
				}
				else
				{
			%>
				<td><input type="button" value="Prev" onClick="switchImage(document.getElementById('myImg1'),document.getElementById('myDesc1'),-5);switchImage(document.getElementById('myImg2'),document.getElementById('myDesc2'),1);switchImage(document.getElementById('myImg3'),document.getElementById('myDesc3'),1);"/></td>
    			<td><img id="myImg1" src="image?id=<%=idGatunku%>&which=0" height="300" width="300"/><br><p id="myDesc1"><%= Function.getDescribeFromImage(idGatunku,0)	%><br></p></td>    
    			<td><img id="myImg2" src="image?id=<%=idGatunku%>&which=1" height="300" width="300"/><br><p id="myDesc2"><%= Function.getDescribeFromImage(idGatunku,1)	%><br></p></td> 
    			<td><img id="myImg3" src="image?id=<%=idGatunku%>&which=2" height="300" width="300"/><br><p id="myDesc3"><%= Function.getDescribeFromImage(idGatunku,2)	%><br></p></td>
    			<td><input type="button" value="Next" onClick="switchImage(document.getElementById('myImg1'),document.getElementById('myDesc1'),1);switchImage(document.getElementById('myImg2'),document.getElementById('myDesc2'),1);switchImage(document.getElementById('myImg3'),document.getElementById('myDesc3'),1);"/></td>
			<%
				}
			%>
			
			</tr>
			<%
				if(klient.getLoggedIn())
				{
			%>
			<tr>
			<td><button type="button" onclick="DoNav('imageUpload.jsp?latinName=<%=name %>');">Dodaj nowe zdjęcie</button></td>
			</tr>
			<%
				}
			%>
			</table>
			
	<jsp:include page="Foot.jsp" />
	</body>
</html>   
