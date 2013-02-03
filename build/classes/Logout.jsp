<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="klient" scope="session" class="p.Klient"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>AquaKwiat - Wylogowywania</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<script type='text/JavaScript' src="adds/scripts.js"></script>
 	</head>
	<body bgcolor = 76dec7 >
		<%
			boolean before = klient.getLoggedIn(); 
			klient.log(false);
		%>
		<jsp:include page="header.jsp" />  
		<%
			if(before)
			{
		%>
		Wylogowywanie przebiegło poprawnie. <bR>
		Dziękujemy za wizytę i zapraszamy ponownie. <br>
		<%
			}
			else
			{
		%>
		Nie byłeś zalogowany więc nie możesz się wylogować!
		<%
			}
		%>
		<jsp:include page="Foot.jsp" />  
	</body>
</html>