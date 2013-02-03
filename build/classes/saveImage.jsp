<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="org.apache.commons.fileupload.*"%> 
<%@ page import="org.apache.commons.io.output.*"%> 
<%@ page import="org.apache.commons.fileupload.servlet.*"%> 
<%@ page import="org.apache.commons.fileupload.disk.*"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%>
<%@ page import="paczka.*"%>
<jsp:useBean id="klient" scope="session" class="p.Klient"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>AquaKwiat - Dziękujemy za dodanie zdjęcia</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
		<script type='text/JavaScript' src="adds/scripts.js"></script>		
	</head>
	<body bgcolor =76dec7>
		<jsp:include page="header.jsp" />
		<% 
			if(request.getParameter("LatinName")==null || klient.getLoggedIn())
			{
				response.sendRedirect("index.jsp");
			}
		
		   Connection conn=Connections.DataBase.getConnecton(); 
		
		   PreparedStatement psImageInsertDatabase=null; 
		    
		   byte[] b=null; 
		   try
		   { 
			   Statement stmt = conn.createStatement();
			   String q = "Select idGatunku From gatunek where LatinName='"+request.getParameter("LatinName").replaceAll("%20", " ").replaceAll("\"", "")+"'";
			
			   ResultSet rs =stmt.executeQuery(q);
			   int id=0;
			   if(rs.next())
			   {
				   	id=rs.getInt(1);
					rs.close();
			   
			   
			      	String sqlImageInsertDatabase="insert into photos (idGatunek,descriptionPhoto,Photo) values( "+ id+" ,?,?)"; 
			      	psImageInsertDatabase=conn.prepareStatement(sqlImageInsertDatabase); 
			
				    ServletFileUpload sfu = Function.sfu; 
				    List items = sfu.parseRequest(request); 
				      
				    Iterator iter = items.iterator(); 
			      	String opis="";
			
			      	while (iter.hasNext()) 
			      	{ 
			        	FileItem item = (FileItem) iter.next(); 
			         	if (!item.isFormField()) 
			         	{ 
			            	b = item.get(); 
			         	} 
			         	else
			         	{
			        		String name = item.getFieldName();
			        	 	if(name != null)
			        	 	{
			        		 	if(name.equals("opis"))
			        		 	{
			        				opis = item.getString().trim(); 
			        		 	}
			        	 	}
			         	}
			      	} 
			      
			      psImageInsertDatabase.setString(1, opis);
			      psImageInsertDatabase.setBytes(2,b); 
			      psImageInsertDatabase.executeUpdate();
			      psImageInsertDatabase.close();
			      
			      out.print("Dziękujemy za dodanie zdjęcia do naszej bazy<br><br>");
			      conn.close();
			   }
			   else
			   {
				  out.print("Niestety nie udało dodać się Twojego zdjęcia<br><br>");
			   }
		   } 
		   catch(Exception e) 
		   {
			    out.print("Niestety nie udało dodać się Twojego zdjęcia<br><br>" + e + "<br><br>");
		   } 
		   
		   out.print(Function.redirectToIndex());
		   
		%> 
		<jsp:include page="Foot.jsp" />
	</body> 
</html>