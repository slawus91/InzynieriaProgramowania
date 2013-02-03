<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="klient" scope="session" class="p.Klient"/>

<html>
	<head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
		<title>AquaKwiat - Logowanie</title>  
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
        <script type='text/JavaScript' src="adds/scripts.js"></script>
 	</head>
	<body bgcolor = 76dec7 >
	<jsp:include page="header.jsp" />
		<%
			if(!klient.getLoggedIn())
			{
		%>
		<form name="form" method="post" action="CheckLogin.jsp" >
		<table>
			<tr><td>Nazwa Użytkownika:</td><td><input type="text" name="user"></td></tr>
			<tr><td>Hasło:</td><td><input type="password" name="pass"></td></tr>
			<tr><td></td><td><input type="submit" value="Zaloguj"></td></tr>
			</table>
		</form>
		<%
			}
			else
			{
		%>
			Jesteś już zalogowany !<br>
		<%
			}
		%>
		<jsp:include page="Foot.jsp" />
	</body>
</html>

