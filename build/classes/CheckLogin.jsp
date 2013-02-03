<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" import="java.sql.*" import="paczka.*"%>
 <jsp:useBean id="klient" scope="session" class="p.Klient"/>
 
 <html>
	<head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
		<title>AquaKwiat - Logowanie</title>  
        <script type='text/JavaScript' src="adds/scripts.js"></script>
         
 	</head>
	<body bgcolor = 76dec7 >
		<%
			try
			{
				String user=request.getParameter("user");
				String pass=request.getParameter("pass");
				
				if(user == null || pass ==null)
				{
					response.sendRedirect("index.jsp");
				}
			 
			 	Connection conn= Connections.DataBase.getConnecton(); 
			    Statement st=conn.createStatement();
			    ResultSet rs=st.executeQuery("select id from user where userName='"+user+"' and password='"+pass+"'");
			    
			    if(rs.next())
			    {
			    	klient.log(true);
			    }
		%>
		
		<jsp:include page="header.jsp" />  
		
		<%
			    if(klient.getLoggedIn())
			    {
			    	out.println("Dziękujemy za zalogowanie się <br>");	 
				}
			    else
			    {
			    	out.println("Została użyta nie poprawna para kluczy Nazwa Użytkownika/Hasło <br>");
				}
			    rs.close();
			    st.close();
			    conn.close();
			}
			catch(Exception e)
			{
			}
		%>
		<jsp:include page="Foot.jsp" />
	</body>
</html>