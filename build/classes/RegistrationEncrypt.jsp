<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import=" java.security.*"%>
<%@ page import="paczka.*"%>
<jsp:useBean id="klient" scope="session" class="p.Klient"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>AquaKwiat - Dziękujemy zarejestrowanie się</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<script type='text/JavaScript' src="adds/scripts.js"></script>
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />
		<%
			String userName=request.getParameter("userName");
			String password=request.getParameter("pass");
			String name=request.getParameter("name");
			String surname=request.getParameter("surname");
			String email=request.getParameter("email");
			
			if(email == null || surname == null || name == null ||  password == null || email == null || klient.getLoggedIn())
			{
				response.sendRedirect("index.jsp");
			}
			
			try
			{
				Connection  con = Connections.DataBase.getConnecton();
				userName = userName.trim();
				
				Statement stmt = con.createStatement();

				ResultSet set = stmt.executeQuery("Select userName From user Where userName='"+userName+"'");
				if(set.next())
				{
					//mamy już takiego usera
					response.sendRedirect("index.jsp");
					
				}
				
				password = password.trim();
				name = name.trim();
				surname = surname.trim();
				email = email.trim();

				PreparedStatement ps = con.prepareStatement("INSERT INTO user(userName,password,name, surname, email) VALUES( ? , ? , ? , ? , ? )");
				ps.setString(1,userName);
				ps.setString(2,password);
				ps.setString(3,name);
				ps.setString(4,surname);
				ps.setString(5,email);

				int i = ps.executeUpdate();

				ps.close();
				con.close();
			}
			catch(Exception ex)
			{
			}
			out.print( "Dziękujemy za rejestrację  w portalu AquaKwiat :) <br><br>");
			out.print(Function.redirectToIndex());

		%> 
		<jsp:include page="Foot.jsp" />
	</body> 
</html>