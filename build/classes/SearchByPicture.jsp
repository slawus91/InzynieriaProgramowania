<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page language="java"  errorPage="" %> 
<html> 
<head> 
	<title>AquaKwiat - Wyszukiwanie przez zdjęcie</title>
		<link rel="stylesheet" type="text/css" href="adds/style.css" />
	<script type="text/JavaScript" src="adds/scripts.js"></script>
	<script type='text/javascript'>
		function showFileSize() 
		{
	    	var input, file;
	
		    input = document.getElementById('uProperty');
	    	if (!window.FileReader) 
	    	{
	    		if(input.value == "")
		    	{
	    			document.getElementById ("errMess").innerHTML ="Nie podałeś pliku";
		    	    return false;	    	    
		    	}
		    	else
		        {
		    		return true;
		        }
	    	}
	
		    if (!input.files) 
		    {
		    	if(input.value == "")
		    	{
		    		document.getElementById ("errMess").innerHTML ="Nie podałeś pliku";
		    	    return false;	    	    
		    	}
		    	else
		        {
		    		return true;
		        }
		    }
		    else if (!input.files[0]) 
		    {
		    	document.getElementById ("errMess").innerHTML ="Nie podałeś pliku";
		        return false;
		    }
		    else 
		    {
		        file = input.files[0];
		        //document.getElementById('opis');
		        if(file.size > 1024000)
		        {
		        	document.getElementById ("errMess").innerHTML ="Wybrany przez Ciebie plik jest za duży";
		        	return false;
		        }
		        else
		        {
		        	return true;
		        }
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
			window.scrollTo(0, 0);
			if(document.getElementById ("errMess").innerHTML == "")
			{
				document.getElementById("errMess").display="none";
			}
			else
			{
				document.getElementById("errMess").display="block";
			}
		</script>
		
		<form name="frm" onsubmit="return showFileSize()" action=<% out.print("\"SearchResult.jsp\""); %> enctype="multipart/form-data" method="post" onsubmit="return showFileSize()" >

	 
			Wybierz zdjęcie, maksymalny rozmiar to 1000kb : <br>
			<input type="file" id="uProperty" name="uProperty" accept="image/*"/> <br><br> 
 			<input type="submit" name="goUpload" value="Upload" onclick="showFileSize()"/>
		</form> 
		<jsp:include page="Foot.jsp" />
	</body> 
</html>