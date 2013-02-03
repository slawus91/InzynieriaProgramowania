<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="paczka.*"%>
<jsp:useBean id="klient" scope="session" class="p.Klient"/>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
		<title>AquaKwiat - Dodaj nową roślinę</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		
		<script type="text/JavaScript" src="adds/scripts.js"></script>
		<script type="text/JavaScript">
			function hideNieMechowate()
			{
				hidestuff('nieMechowate');
				hidestuff('wygladListka');
			}
			
			function showNieMechowate()
			{
				showstuff('nieMechowate');
				if(document.getElementById('listki_lisciaste').checked)
				{
					showstuff('wygladListka');
				}
			}
			
			function grade() 
			{
			    //**Would I do something like this?
			    //if(elem.value.length == 0){
			    // alert("Whoops, looks like you didn't answer a question.")}
			    var elem = document.adding;
			    var send = true;
			    var message='';
			    
			    var latname = new Array();
				
			    <%
			    	Connection conn= Connections.DataBase.getConnecton();
			    	Statement stmt = conn.createStatement();
			    	ResultSet rs =stmt.executeQuery("Select LatinName From gatunek");
			    	int i=0;
			    	while(rs.next())
			    	{
			    		out.print("latname["+i+"]=\""+ rs.getString(1)+"\";\n");
					    i++; 
			    	} 
			    	rs.close();
			    	stmt.close();
			    	conn.close();
			    %>
			   
			    //będziemy tu też przygotowywać zapytanie
			   send = true;
			    if (elem.LatinName.value == '')
			    {
			    	send = false;
			    	message += 'Nazwa łacińska nie została podana\n'+"<br>";
			    }
			    else if (elem.LatinName.value.lenght >255)
			    {
			    	send = false;
			    	message += 'Nazwa łacińska jest zbyt długa, maxymalna ilość znaków to 255\n'+"<br>";
			    }
			    else if(latname.indexOf(elem.LatinName.value) != -1)
			    {
			    	send = false;
			    	message += 'Podana Nazwa łacińska juz istnieje w bazie\n'+"<br>";
			    }
			    
			    if (elem.PolishName.value != '' && elem.PolishName.value.lenght >255)
			    {
			    	send = false;
			    	message += 'Polska Nazwa jest zbyt długa, maxymalna ilość znaków to 255\n'+"<br>";
			    }
			    
			    if(!elem.Europa.checked && !elem.Azja.checked && !elem.Afryka.checked && !elem.Australia.checked 
			    		&& !elem.AmerykaPn.checked && !elem.AmerykaPol.checked)
			    {
			    	send = false;
			    	message += 'Nie wybrano kontynentu pochodzenia\n'+"<br>";	
			    }
			   if(document.getElementById('nieMechowate').style.display != 'none')
			    {	
					var temp;
				   
					if(document.getElementById('wygladListka').style.display != 'none')
			    	{
						temp = checkGroup(elem.wide_max,elem.wide_min,'szerokości liścia','szerokość liścia',65,4);
						if(temp != '')
						{
			    			send = false;
			    			message +=temp;
						}
			    	}
					
					temp = checkGroup(elem.lenght_max,elem.lenght_min,'długości liścia','długość liścia',1000,10);
					if(temp != '')
					{
		    			send = false;
		    			message +=temp;
					}

					temp = checkGroup(elem.height_max,elem.height_min,'wysokości liścia','wysokość liścia',2000,10);
					if(temp != '')
					{
		    			send = false;
		    			message +=temp;
					}

					temp = checkGroup(elem.weight_max,elem.weight_min,'szerokości liścia','szerokość liścia',200,1);
					if(temp != '')
					{
		    			send = false;
		    			message +=temp;
					}
			    }
			   
			    temp = checkGroup(elem.temperature_max,elem.temperature_min,'zalecanej temperatury','zalecana temperatura',35,10);
				if(temp != '')
				{
	    			send = false;
	    			message +=temp;
				}

			    if(send == true)
			    {
			    	return true; // Return true if you want the form to submit on validation/grade
			    }
			    else
			    {
			    	document.getElementById ("errMess").innerHTML =message+"<br><br>";
			    	//alert(message);//zamiast tego w przyszłosći pole tekstowe wipysujące te wszystkie błędy lub kawałek html wypisująca
			    	window.scrollTo(0, 0);
			    	return false;	
			    }

			    return false;
			}
		</script>
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />
		<%
			if(klient.getLoggedIn())
			{
		%>
		<div id="errMess" class="errMess">

		</div>
		<script type="text/JavaScript">
			if(document.getElementById ("errMess").innerHTML == "")
			{
				document.getElementById("errMess").display="none";
			}
			else
			{
				document.getElementById("errMess").display="block";
			}
		</script>
			
		<form action="ThanksForAdd.jsp" method='POST' name="adding" onsubmit="return grade()">
				<table>
					<tr>
						<td>Nazwa łacińska:</td>
						<td><input type="text" name="LatinName" id="LatinName" value=""></td>
					</tr>
					<tr><td></td></tr>
					<tr>
						<td>Nazwa polska:</td>
						<td><input type="text" name="PolishName" id="PolishName" value=""></td>
					</tr>
				</table>
			<br>
				Region pochodzenia:
				<table>
						<tr>
							<td><label for="Europa"><img src="img\Europa.jpg" alt="Europa" height="150" width="150"/></label></td>
							<td><label for="Azja"><img src="img\Azja.jpg" alt="Azja" height="150" width="150"/></label></td>
							<td><label for="Australia"><img src="img\Australia.jpg" alt="Australia" height="150" width="150"/></label></td>
						</tr>
						<tr>
							<td><input type="checkbox" name="Europa" id="Europa" value="Europa"><label for="Europa">Europa</label></td>
							<td><input type="checkbox" name="Azja" id="Azja" value="Azja"><label for="Azja">Azja</label></td>
							<td><input type="checkbox" name="Australia" id="Australia" value="Australia"><label for="Australia">Australia</label></td>
						</tr>
						<tr>
							<td><label for="AmerykaPn"><img src="img\AmerykaPn.jpg" alt="AmerykaPn" height="150" width="150"/></label></td>
							<td><label for="AmerykaPol"><img src="img\AmerykaPol.jpg" alt="AmerykaPol" height="150" width="150"/></label></td>
							<td><label for="Afryka"><img src="img\Afryka.jpg" alt="Afryka" height="150" width="150"/></label></td>
						</tr>
						<tr>
							<td><input type="checkbox" name="AmerykaPn" id="AmerykaPn" value="AmerykaPn"><label for="AmerykaPn">Ameryka Północna</label></td>
							<td><input type="checkbox" name="AmerykaPol" id="AmerykaPol" value="AmerykaPol"><label for="AmerykaPol">Ameryka Południowa</label></td>
							<td><input type="checkbox" name="Afryka" id="Afryka" value="Afryka"><label for="Afryka">Afryka</label></td>
						</tr>		
					</table>
				<br>
					Dodatkowe informacje dotyczące pochodzenia: <br>
					<textarea rows="6" cols="100" name="doCountry"></textarea><br>
				<br>
				<br>
			Łodygowa:
				<table>
					<tr>
						<td><label for="lodygowa_lodygowa"><img src="img\lodygowa.jpg" alt=" " height="150" width="150"/></label></td>
						<td><label for="lodygowa_kepata"><img src="img\kepate.jpg" alt=" " height="150" width="150"/></label></td> 
						<td><label for="lodygowa_bezlodygowa"><img src="img\bezlodygowe.jpg" alt=" " height="150" width="150"/></label></td>
						<td><label for="lodygowa_mech"><img src="img\mechowate.jpg" alt=" " height="150" width="150"/></label></td>
						<td><label for="lodygowa_trawiasta"><img src="img\trawiaste.jpg" alt=" " height="150" width="150"/></label></td>			
					</tr>
					<tr>
						<td><input type="radio" name="lodygowa" id="lodygowa_lodygowa" value="lodygowa" CHECKED onclick="showNieMechowate();" ><label for="lodygowa_lodygowa">łodygowa</label></td>
						<td><input type="radio" name="lodygowa" id="lodygowa_kepata" value="kepata" onclick="showNieMechowate();"><label for="lodygowa_kepata">kępata</label></td> 
						<td><input type="radio" name="lodygowa" id="lodygowa_bezlodygowa" value="bezlodygowa" onclick="showNieMechowate();"><label for="lodygowa_bezlodygowa">bezłodygowa</label></td>
						<td><input type="radio" name="lodygowa" id="lodygowa_mech" value="mech" onclick="hideNieMechowate();"><label for="lodygowa_mech">mechowate</label></td>
						<td><input type="radio" name="lodygowa" id="lodygowa_trawiasta" value="trawiasta" onclick="showNieMechowate();"><label for="lodygowa_trawiasta">trawiasta</label></td>
					</tr>
				</table>
			<br>
			<div id="nieMechowate"> 
					Rodzaj uliścienia :<br>
					<table>
						<tr>
						  <td><label for="listki_lisciaste"><img src="img\zielone.jpg" alt=" " height="150" width="150"/></label></td>
						  <td><label for="listki_iglaste"><img src="img\iglaste.jpg" alt=" "  height="150" width="150"/></label></td>
						</tr>
						<tr>
						  <td><input type="radio" name="listki" id="listki_lisciaste" value="lisciaste" CHECKED onclick="showstuff('wygladListka');"><label for="listki_lisciaste">liściaste</label></td>
						  <td><input type="radio" name="listki" id="listki_iglaste" value="iglaste" onclick="hidestuff('wygladListka');"><label for="listki_iglaste">iglaste</label></td>
						 </tr>
					 </table> 
				<br>
					Kolor uliścienia : <br>
					<table>
						<tr>
						  <td><label for="kolor_zielony"><img src="img\zielone.jpg" alt=" " height="150" width="150"/></label></td>
						  <td><label for="kolor_pomaranczowy"><img src="img\pomaranczowe.jpg" alt=" "  height="150" width="150"/></label></td>
						  <td><label for="kolor_czerwony"><img src="img\czerwone.jpg" alt=" "  height="150" width="150"/></label></td>
						</tr>
						<tr>
						  <td><input type="radio" name="kolor" id="kolor_zielony" value="zielony" CHECKED><label for="kolor_zielony">zielony</label></td>
						  <td><input type="radio" name="kolor" id="kolor_pomaranczowy" value="pomaranczowy"><label for="kolor_pomaranczowy">pomarańczowy</label></td>
						  <td><input type="radio" name="kolor" id="kolor_czerwony" value="czerwony"><label for="kolor_czerwony">czerwony</label></td>
						</tr>
					</table>
				<br>
				<div id="wygladListka">
						Wygląd liścia : <br>
						<table>
							<tr>
								<td><label for="ksztalt_podluzny"><img src="img\podluzne.jpg" alt="" height="150" width="150"/></label></td>
								<td><label for="ksztalt_okragly"><img src="img\okragle.jpg" alt=""  height="150" width="150"/></label></td>
								<td><label for="ksztalt_falbankowy"><img src="img\falbana.jpg" alt=""  height="150" width="150"/></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="ksztalt" id="ksztalt_podluzny" value="podluzny" CHECKED><label for="ksztalt_podluzny">podłużny</label></td>
								<td><input type="radio" name="ksztalt" id="ksztalt_okragly" value="okragly"><label for="ksztalt_okragly">okrągły</label></td>
								<td><input type="radio" name="ksztalt" id="ksztalt_falbankowy" value="falbankowy"><label for="ksztalt_falbankowy">zakończony falbanką</label></td>
							</tr>		
						</table>
					<br>
						<table>
							<tr>
								<td><label for="kwiat">Posiada kwiaty  : </label></td>
								<td><label for="korzen">Może rosnąć na korzeniu/kamieniu  : </label></td>
							</tr>
							<tr>
								<td><label for="kwiat"><img src="img\kwiaciaste.jpg" alt="" height="150" width="150"/></label></td>
								<td><label for="korzen"><img src="img\korzen.jpg" alt="" height="150" width="150"/></label></td>
							</tr>
							<tr>
								<td><input type="checkbox" name="kwiat" id="kwiat" value="kwiat"><label for="kwiat">tak</label></td>
								<td><input type="checkbox" name="korzen" id="korzen" value="korzen"><label for="korzen">tak</label></td>
							</tr>		
						</table>
					<br> 
					<% 
						out.print(Function.getMinMax("Szerokość liścia (w mm):", "wide", 1, 65, 10));
					%>
					
				</div>
				<% 
					out.print(Function.getMinMax("Długość liścia (w mm):", "lenght", 10, 1000, 80));
					out.print(Function.getMinMax("Wysokość rośliny (w mm):", "height", 10, 2000, 250));
					out.print(Function.getMinMax("Szerokość rośliny (w mm):", "weight", 1, 200, 25));
				%>
			</div>
			Rozmnażanie przez: <br>
					<table>
						<tr>
							<td><label for="rozmnazanie_podzial"><img src="img\podzial.jpg" alt="" height="150" width="150"/></label></td>
							<td><label for="rozmnazanie_klacza"><img src="img\klacza.jpg" alt=""  height="150" width="150"/></label></td>
							<td><label for="rozmnazanie_cebulki"><img src="img\cebulki.jpg" alt=""  height="150" width="150"/></label></td>
						</tr>
						<tr>
							<td><input type="radio" name="rozmnazanie" id="rozmnazanie_podzial" value="podzial" CHECKED><label for="rozmnazanie_podzial">podział</label></td>
							<td><input type="radio" name="rozmnazanie" id="rozmnazanie_klacza" value="klacza"><label for="rozmnazanie_klacza">kłącza</label></td>
							<td><input type="radio" name="rozmnazanie" id="rozmnazanie_cebulki" value="cebulki"><label for="rozmnazanie_cebulki">cebulki</label></td>
						</tr>		
					</table><br>
				zalecana temperatura<br>
				max:<input type="number" name="temperature_max" id="temperature_max" value='25' min='15' max='35'> &nbsp; &nbsp; &nbsp;  min:<input type="number" name="temperature_min" id="temperature_min" value='25' min='15' max='35'><br>
			<br>
				<table>
					<tr>
						<td>Wymagania świetlne</td>
						<td><input type="radio" name="wymaganiaSw" id="wymaganiaSw_bmale" value="bmale"><label for="wymaganiaSw_bmale">b. małe</label></td>
						<td><input type="radio" name="wymaganiaSw" id="wymaganiaSw_male" value="male"><label for="wymaganiaSw_male">male</label></td>
						<td><input type="radio" name="wymaganiaSw" id="wymaganiaSw_umiarkowane" value="umiarkowane" CHECKED><label for="wymaganiaSw_umiarkowane">umiarkowane</label></td>
						<td><input type="radio" name="wymaganiaSw" id="wymaganiaSw_wysokie" value="wysokie"><label for="wymaganiaSw_wysokie">wysokie</label></td>			
						<td><input type="radio" name="wymaganiaSw" id="wymaganiaSw_bwysokie" value="bwysokie"><label for="wymaganiaSw_bwysokie">b. wysokie</label></td>
					</tr>
					<tr>
						<td>Szybkość wzrostu</td>
						<td><input type="radio" name="szypkoscWzrostu" id="szypkoscWzrostu_bwolne" value="bwolne"><label for="szypkoscWzrostu_bwolne">b. wolne</label></td>
						<td><input type="radio" name="szypkoscWzrostu" id="szypkoscWzrostu_wolne" value="wolne"><label for="szypkoscWzrostu_wolne">wolne</label></td>
						<td><input type="radio" name="szypkoscWzrostu" id="szypkoscWzrostu_umiarkowane" value="umiarkowane" CHECKED><label for="szypkoscWzrostu_umiarkowane">umiarkowane</label></td>
						<td><input type="radio" name="szypkoscWzrostu" id="szypkoscWzrostu_szybkie" value="szybkie"><label for="szypkoscWzrostu_szybkie">szybkie</label></td>			
						<td><input type="radio" name="szypkoscWzrostu" id="szypkoscWzrostu_bszybkie" value="bszybkie"><label for="szypkoscWzrostu_bszybkie">b. szybkie</label></td>
					</tr>
					<tr>
						<td>Trudność uprawy</td>
						<td><input type="radio" name="trudnoscUprawy" id="trudnoscUprawy_bezproblemowa" value="bezproblemowa"><label for="trudnoscUprawy_bezproblemowa">bezproblemowe</label></td>
						<td><input type="radio" name="trudnoscUprawy" id="trudnoscUprawy_latwa" value="latwa"><label for="trudnoscUprawy_latwa">łatwe</label></td>
						<td><input type="radio" name="trudnoscUprawy" id="trudnoscUprawy_problematczyna" value="problematyczna" CHECKED><label for="trudnoscUprawy_problematczyna">problematyczne</label></td>
						<td><input type="radio" name="trudnoscUprawy" id="trudnoscUprawy_trudna" value="trudna"><label for="trudnoscUprawy_trudna">trudne</label></td>
						<td><input type="radio" name="trudnoscUprawy" id="trudnoscUprawy_btrudna" value="btrudna"><label for="trudnoscUprawy_btrudna">b. trudne</label></td>
					</tr>		
				</table><br>
				<table>
					<tr>
						<td><label for="CO2">CO2</label></td>
						<td><label for="Fe">Fe</label></td>
						<td><label for="mikro">mikro</label></td>
						<td><label for="makro">makro</label></td>
					</tr>
					<tr>
						<td><label for="CO2"><img src="img\CO2.jpg" alt="" height="150" width="150"/></label></td>
						<td><label for="Fe"><img src="img\Fe.jpg" alt="" height="150" width="150"/></label></td>
						<td><label for="mikro"><img src="img\mikro.jpg" alt="" height="150" width="150"/></label></td>
						<td><label for="makro"><img src="img\makro.jpg" alt="" height="150" width="150"/></label></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="CO2" id="CO2" value="CO2"><label for="CO2">tak</label></td>
						<td><input type="checkbox" name="Fe" id="Fe" value="Fe"><label for="Fe">tak</label></td>
						<td><input type="checkbox" name="mikro" id="mikro" value="mikro"><label for="mikro">tak</label></td>
						<td><input type="checkbox" name="makro" id="makro" value="makro"><label for="makro">tak</label></td>
					</tr>		
				</table>
			<br>
				Dodatkowe informacje dotyczące hodowli: <br>
				<textarea rows="6" cols="100" name="dodHodowla"></textarea>
			<br>
				Dodatkowe informacje o roślinie: <br>
				<textarea rows="6" cols="100" name="dodRoslina"></textarea>
			<br>

			<script type="text/JavaScript">	
				if(document.getElementById('lodygowa_mech').checked)
				{
					hideNieMechowate();
				}
				else
				{
					showNieMechowate();	
				}
			</script>
			
			<input type='submit' onclick='grade()' value='Dodaj'/>
			<%
				}
				else
				{
			%>
				Nie masz uprawnień aby dodać nowy gatunek!
			<%
				}
			%>
			<jsp:include page="Foot.jsp" />
		</form>
	</body>
</html> 