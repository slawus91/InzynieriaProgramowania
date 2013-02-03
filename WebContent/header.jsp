<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="paczka.*"%>

<jsp:useBean id="klient" scope="session" class="p.Klient"/>
	<table align="center"><tr><td><img src="img/banner.png" align="middle">
	</td></tr></table>
	<br>
		<table align="top">
			<tr>
				
				<td valign="top">
					<table>
						
						<tr>
							<td align="center"><h1>Menu:</h1></td>
						</tr>
						<% 
							out.print(Function.getMenuButton("index.jsp","Strona główna"));
							out.print(Function.getMenuButton("SearchByName.jsp","Szukaj po nazwach"));
							out.print(Function.getMenuButton("SearchByNeeds.jsp","Szukaj po wymaganiach"));
							out.print(Function.getMenuButton("SearchByAppearance.jsp","Szukaj po wyglądzie"));
							out.print(Function.getMenuButton("SearchByPicture.jsp","Szukaj po zdjęciu"));
							
							if(klient.getLoggedIn())
							{
								out.print(Function.getMenuButton("addType.jsp","Dodaj gatunek"));
							}
							else
							{
								out.print(Function.getMenuButton("Login.jsp","Zaloguj"));
								out.print(Function.getMenuButton("RegistrationForm.jsp","Zarejestruj"));
							}
							
							out.print(Function.getMenuButton("Contact.jsp","Kontakt"));
							
							if(klient.getLoggedIn())
							{
								out.print(Function.getMenuButton("Logout.jsp","Wyloguj"));
							}
						%>			
					</table>
				</td>
				<td>
				&nbsp; &nbsp; &nbsp;
				</td>
				<td>