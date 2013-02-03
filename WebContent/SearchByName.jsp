<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%@ page import="paczka.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>AquaKwiat - Wyszukiwanie po nazwie</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<script type="text/JavaScript" src="adds/scripts.js"></script>
		<script type="text/JavaScript">
			function check()
			{
				hidestuff("dive");
				document.getElementById( "dive" ).innerHTML ="";
				if(document.main.name.value.fulltrim() == "")
				{
					document.getElementById( "dive" ).innerHTML="Nie podałeś żadnego znaku na podstawie mamy wyszukiwać<br><br>";
					showstuff("dive");
					return false;
				}
				
				if(document.main.searchByName.value.lenght() >255)
				{
					document.getElementById( "dive" ).innerHTML="Wpisany ciąg jest zbyt długi<br><br>";
					showstuff("dive");
					return false;
				}
				
				return true;
			}
			
		</script>
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />
		<div id="dive" class="errMess"></div>		
		
		<script type="text/JavaScript">
			if(document.getElementById( "dive" ).innerHTML.fulltrim()=='')
			{
				hidestuff("dive");
			}
			else
			{
				showstuff("dive");
			}				
		</script>
		
		<form method='POST' onsubmit="return check()" name='main' action="SearchResult.jsp">
		<!--  tak naprawdę nie będziemy wysyłać wielu danych, a gotowe zapytanie  -->
		
			<input type="text" id="searchByName" name="searchByName" ><br>
		<br>
		<br>
			<table>
				<%
					out.print(Function.getRadio3("Wyraz:", "pozycja","Obojętne","Początku","Końcu", 1));
					out.print(Function.getRadio3("Język przeszukiwań:", "jezyk","Każdy","Polski","Łaciński", 1));
				%>
			</table>
			<input type="submit" name="szukaj" value="szukaj" onclick='check()'>
		</form>
		<jsp:include page="Foot.jsp" /> 
	</body>
</html>