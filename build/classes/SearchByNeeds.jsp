<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="paczka.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>AquaKwiat - Wyzzukiwanie po wymaganiach roślin</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<script type="text/JavaScript" src="adds/scripts.js"></script>
		<script type="text/JavaScript">
			function grade() 
			{
			    var elem = document.searchingByNeeds;
			    var send = true;
			    var message='';
			    
			    var  temp = checkGroup(elem.temperatura_max,elem.temperatura_min,'zalecanej temperatury','zalecana temperatura',35,15);
				if(temp != '')
				{
	    			send = false;
	    			message +=temp;
				}
				
				if(findValue('max_wymaganiaSw') < findValue('min_wymaganiaSw'))
				{
	    			send = false;
					message += "Wymagania świetlne maxymalne  < minalnych<br>";
				}

				if(findValue('max_szybkoscWzrostu')<findValue('min_szybkoscWzrostu'))
				{
	    			send = false;
	    			message += "Szybkość wzrostu maxymalna  < minalnej<br>";
				}

				if(findValue('max_trudnoscUprawy') < findValue('min_trudnoscUprawy'))
				{
	    			send = false;
	    			message += "Trudność uprawy maxymalna  < minalnej<br>";
				}
				
			    if(send == true)
			    {
			    	return true; // Return true if you want the form to submit on validation/grade
			    }
			    else
			    {
			    	document.getElementById ("errMess").innerHTML =message+"<br><br>";
			    	window.scrollTo(0, 0);
			    	return false;	
			    }

			    return false;
			}
		</script>
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />

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
		<form  action="SearchResult.jsp" method='POST' name="searchingByNeeds" onsubmit="return grade()">
			<%
				out.print(Function.getMinMax("zalecana temperatura","temperatura",15,35,25));
			%>
			<table>
				<%
					out.print(Function.getMiniMax("wymagania świetlne","wymaganiaSw","bardzo male", "male","srednie","wysokie","bardzo wysokie"));
					out.print("<tr><td><br></td></tr>");
					out.print(Function.getMiniMax("szybkość wzrostu","szybkoscWzrostu","bardzo wolne", "wolne","umiarkowane","szybkie","bardzo szybkie"));
					out.print("<tr><td><br></td></tr>");
					out.print(Function.getMiniMax("trudność uprawy","trudnoscUprawy","bezproblemowa", "latwa","problematycza","trudna","bardzo trudna"));								
				%>
			</table>
			<table>
				<%
					out.print(Function.getTab("CO2")+"<br>");
					out.print(Function.getTab("Fe")+"<br>");
					out.print(Function.getTab("mikro")+"<br>");
					out.print(Function.getTab("makro")+"<br>");
				%>
			</table>
		<br>
		<input type="submit" onclick="grade()"  value='Szukaj'/>
	</form>
	<jsp:include page="Foot.jsp" />
</body>
</html>