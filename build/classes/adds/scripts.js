String.prototype.fulltrim=function(){return this.replace(/(?:(?:^|\n)\s+|\s+(?:$|\n))/g,'').replace(/\s+/g,' ');};

function showstuff(boxid)
{
	document.getElementById(boxid).style.display = "block";
}
				 
function hidestuff(boxid)
{
   document.getElementById(boxid).style.display = "none";
}

function DoNav(theUrl)
{
	document.location.href = theUrl;
}

function checkGroup( max, min, textForOne, textForTwo, maxV, minV)
{
	var message ='';
	var checkvalueMin=true;
	var checkvalueMax=true;
					
	if( max.value == '')
	{
		checkvalueMax =false;
		message +='Nie podano maxymalnej ' +textForOne+ "<br>";
	}
	
	if(min.value == '')
	{
		checkvalueMin =false;
		message +='Nie podano minimalnej ' +textForOne+ "<br>";
	}
	
	if(checkvalueMax &&  checkvalueMin && parseFloat(max.value) < parseFloat(min.value))
	{
		message +='Maxymalna ' + textForTwo +' jest mniejsza od minimalnej'+ "<br>";
	}
	
	if(checkvalueMax && maxV < parseFloat(max.value))
	{
		message +='Przekroczono dozwolona maxymaln¹ ' + textForTwo + "<br>";
	}
	
	if(checkvalueMin && minV > parseFloat(min.value))
	{
		message +='Przekroczono dozwolona minimaln¹ ' + textForTwo + "<br>";
	}
	
	return message;
}

function findValue(name)
{
	var radios = document.getElementsByName(name);

	for (var i = 0, length = radios.length; i < length; i++) 
	{
	    if (radios[i].checked) 
	    {
	        return radios[i].value;
	    }
	}
}

		