<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="klient" scope="session" class="p.Klient"/>

<html>
	<head>
		<title>AquaKwiat - Rejestracja</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<script type="text/javascript" src="adds/scripts.js"> </script>
		<script type="text/javascript">
			var message='';
			var http= createRequestObject();
			var send=true;
			
			function createRequestObject() {
				var ro;
				var browser = navigator.appName;
				if(browser == "Microsoft Internet Explorer") {
					ro = new ActiveXObject("Microsoft.XMLHTTP");
				}else {
					ro = new XMLHttpRequest();
				}
				return ro;
			}
			
			 function handleResponse() 
			 {
				if(http.readyState == 4) 
				{
					var update = http.responseText;
				    	if(update=="exist") 
				    	{
				    		message +=  "Nazwa użytkownika zajęta <br>";
				    		send = false;
						}
				    	else
				    	{
				    		
				    	}
					}
				}
			
			function grade()
			{
				message='';
				var elem = document.userform;
				send = true;
				
				if (elem.userName.value.fulltrim() == '')
				{
				   	message += 'Nazwa Użytkownika nie została podana'+"<br>";
				   	send = false;
				}
				else if (elem.userName.value.fulltrim().length > 255)
				{
				  	message += 'Nazwa Użytkownika jest zbyt długa, maxymalna długość to 255'+"<br>";
				   	send = false;
				}
				else if (elem.userName.value.fulltrim().length < 8)
				{
				  	message += 'Nazwa Użytkownika jest zbyt krótka, minimalna długość to 8'+"<br>";
				   	send = false;
				}
				else
				{
					http.open('get', 'CheckUserName?userName=' + elem.userName.value.fulltrim(),true);
					
					http.onreadystatechange = handleResponse;
					http.send("userName=" + elem.userName.value.fulltrim());
					
					//message += 'pupa'+"<br>";
				   	
					//errMess.location.href='CheckUserName?userName='+elem.userName.fulltrim();
				   	//send = false;
				}
				
				if (elem.pass.value.fulltrim() == '')
				{
				   	message += 'Hasło nie zostało podane'+"<br>";
				   	send = false;
				}
				else if (elem.pass.value.fulltrim().length >255)
				{
				  	message += 'Hasło jest zbyt długie, maxymalna ilość znaków to 255'+"<br>";
				   	send = false;
				}
				else if(elem.pass.value.fulltrim().length < 8)
				{
				  	message += 'Hasło jest zbyt krótkie, minimalna ilość znaków to 8'+"<br>";
				   	send = false;
				}
				
				if (elem.name.value.fulltrim() == '')
				{
				   	message += 'Imię nie zostało podane'+"<br>";
				   	send = false;
				}
				else if (elem.name.value.fulltrim().length >255)
				{
				  	message += 'Imię jest zbyt długie, maxymalna ilość znaków to 255'+"<br>";
				   	send = false;
				}
				else if(elem.name.value.fulltrim().length < 3)
				{
				  	message += 'Imię jest zbyt krótkie, minimalna ilość znaków to 3'+"<br>";
				   	send = false;
				}
				
				if (elem.surname.value.fulltrim() == '')
				{
				   	message += 'Nazwisko nie zostało podane'+"<br>";
				   	send = false;
				}
				else if (elem.surname.value.fulltrim().length >255)
				{
				  	message += 'Nazwisko jest zbyt długie, maxymalna ilość znaków to 255'+"<br>";
				   	send = false;
				}
				else if(elem.surname.value.fulltrim().length < 3)
				{
				  	message += 'Nazwisko jest zbyt krótkie, minimalna ilość znaków to 3'+"<br>";
				   	send = false;
				}

				if (elem.email.value.fulltrim() == '')
				{
				   	message += 'Adres email nie został podany'+"<br>";
				   	send = false;
				}
				else if (elem.email.value.fulltrim().length >255)
				{
				  	message += 'Adres email jest zbyt długi, maxymalna ilość znaków to 255'+"<br>";
				   	send = false;
				}
				else if(elem.email.value.fulltrim().length < 7)
				{
				  	message += 'Adres email jest zbyt krótki, minimalna ilość znaków to 7'+"<br>";
				   	send = false;
				}   
				else
				{
					var t = elem.email.value.fulltrim().indexOf("@");
					if(t == -1)
					{
					   	message += 'Adres email jest błędny, brak @'+"<br>";	
					   	send = false;						
					}
					else
					{
						var t2 = elem.email.value.fulltrim().indexOf("@",t+1);
						
						if(t2 != -1)
						{
							message += 'Adres email jest błędny, podano za dużo znaków @'+"<br>";	
						   	send = false;
						}
						else
						{
							t2 = elem.email.value.fulltrim().indexOf(".",t+1);
							
							if(t2 == -1)
							{
							   	message += 'Adres email jest błędny, brak znaku .'+"<br>";	
							   	send = false;						
							}
							else
							{
								t = elem.email.value.fulltrim().indexOf(".",t2+1);
								
								if(t != -1)
								{
								   	message += 'Adres email jest błędny, zbyt duża liczba znaków .   po znaku @'+"<br>";
								   	send = false;							
								}
							}
						}
					}
				}
				
				if(elem.passAgain.value != elem.pass.value)
				{
					message += "Hasła są różne <br>";
				}
				
				if(!send)
				{
					document.getElementById ("errMess").innerHTML =message+"<br><br>";
					return false;
				}
				else
				{
					return true;
				}
			}
		</script>
		
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />
		<%
			if(klient.getLoggedIn())
			{
		%>
		Jesteś już zalogowanyie możesz tworzyć nowego konta!
		<%
			}
			else
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
		
		<form name="userform" method="post" onsubmit="return grade()" action="RegistrationEncrypt.jsp">
			<table>
				<tr><td>Nazwa Użytkownika</td><td><input type="text" name="userName"></td></tr>
				<tr><td>Hasło</td><td><input type="password" name="pass"></td></tr>
				<tr><td>Powtórz hasło</td><td><input type="password" name="passAgain"></td></tr>
				<tr><td>Imie</td><td><input type="text" name="name"></td></tr>
				<tr><td>Nazwisko</td><td><input type="text" name="surname"></td></tr>
				<tr><td>Adres email</td><td><input type="email" name="email"></td></tr>
				<tr><td><input type="submit" value="Zatwierdź" onclick='grade()'></td></tr>
			</table>
		</form>
		<%
			}
		%>
	<jsp:include page="Foot.jsp" />
	</body>
</html>