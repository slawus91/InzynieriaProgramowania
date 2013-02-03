package paczka;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public final class Function 
{
	public static DiskFileItemFactory factory = new DiskFileItemFactory(); 
	public static ServletFileUpload sfu = new ServletFileUpload(factory); 
	
	private Function()
	{		
	}
	
	public static String redirectToIndex()
	{
		String ret="";
		ret+="<br>Zaraz nastąpi automatyczne przekierowanie na stron� g��wn�<br><br>";
		ret+="<script language=\"javascript\">";
		ret+="setTimeout(\"top.location.href = 'index.jsp'\",10000);";
		ret+="</script>";
		return ret;
	}
 	public static byte[] getPhoto (Blob img, int iNumPhoto) throws Exception
	{
	  
	    byte[] imgData = null ;
	    
	    
	      imgData = img.getBytes(1,(int)img.length());
	    
	    return imgData ;
	}

	public static String getValFrom3Radio(String name,String nameDB, HttpServletRequest request)
	{
		
		String temp = request.getParameter(name);
		
		if(temp.equals("obojetne"))
		{
			return " ";
		}
		else if(temp.equals("tak"))
		{
			return " AND "+ name+"=1 ";
		}
		else if(temp.equals("nie"))
		{
			return " AND "+ name+"=0 ";
		}
		
		return " ";
	}
	  
	public static String getValFromMinMaxRadio(String name,String nameDB, HttpServletRequest request)
	{
		
		int min = Integer.parseInt(request.getParameter("min_"+name));
		int max = Integer.parseInt(request.getParameter("max_"+name));
		
		return " AND  "+ nameDB + " >="+ min + " AND  "+ nameDB + " <="+ max + "    ";
	} 
	
	public static String getTab(String name)
	{
		String ret="";
		
		ret += "<tr>\n";
			ret += "<td>wymagane "+name+":</td>\n";
			ret += "<td>\n ";
				ret += "<table>\n";
					ret += "<tr><td><input type=\"radio\" name=\""+name+"\" value=\"obojetne\" id=\""+name+"_obojete\" CHECKED><label for=\""+name+"_obojete\">obojętne</label></td></tr>\n";
					ret += "<tr><td><input type=\"radio\" name=\""+name+"\" value=\"tak\" id=\""+name+"_tak\"><label for=\""+name+"_tak\">tak</label></td></tr>\n";
					ret += "<tr><td><input type=\"radio\" name=\""+name+"\" value=\"nie\" id=\""+name+"_nie\"><label for=\""+name+"_nie\">nie</label></td></tr>\n";
				ret += "</table>\n";
			ret += "</td>\n";
		ret += "<td><img src=\"img/"+name+".jpg\" alt=\""+name+"\" height=\"100\" width=\"100\"/></td>\n";
		ret += "</tr>\n";
		return ret;
	}

	public static String getMinMax(String tekst,String name, int min, int max , int now)
	{
		String ret="";
			ret += tekst+"<br>\n";
			ret += "min:<input type=\"number\" name=\""+name+"_min\" id=\""+name+"_min\" value='"+now+"' min='"+min+"' max='"+max+"'> &nbsp; &nbsp; &nbsp; max:<input type=\"number\" name=\""+name+"_max\" id=\""+name+"_max\" value='"+now+"' min='"+min+"' max='"+max+"'> <br>	<br>";
		
		return ret;
	}
	
	public static String productVal(String val)
	{
		return val.replaceAll(" ", "_");
	}
	
	public static String getLineRadio(String name, String val, boolean check, int v)
	{
		String valR = productVal(val);
		
		return "<td><input type=\"radio\" name=\""+name+"\" id=\""+name+"_"+valR+"\" value=\""+v+"\"" + (check?"CHECKED":"") +"><label for=\""+name+"_"+valR+"\">"+val+"</label></td>";
		
	}
	
	public static String getRadio5(String tekst, String name,String val1,String val2,String val3,String val4,String val5, int checked)
	{
		String ret="";
		
		ret += "<tr>";
			ret += "<td>"+tekst+": </td>";
			ret += getLineRadio(name,val1,(checked==1),1);
			ret += getLineRadio(name,val2,(checked==2),2);
			ret += getLineRadio(name,val3,(checked==3),3);
			ret += getLineRadio(name,val4,(checked==4),4);
			ret += getLineRadio(name,val5,(checked==5),5);
		ret += "</tr>";
		
		return ret;
	}
	
	public static String getRadio3(String tekst, String name,String val1,String val2,String val3, int checked)
	{
		String ret="";
		
		ret += "<tr>";
			ret += "<td>"+tekst+": </td>";
			ret += getLineRadio(name,val1,(checked==1),1);
			ret += getLineRadio(name,val2,(checked==2),2);
			ret += getLineRadio(name,val3,(checked==3),3);
		ret += "</tr>";
		
		return ret;
	}
	
	public static String getRadio2(String tekst, String name,String val1,String val2, int checked)
	{
		String ret="";
		
		ret += "<tr>";
			ret += "<td>"+tekst+": </td>";
			ret += getLineRadio(name,val1,(checked==1),1);
			ret += getLineRadio(name,val2,(checked==2),2);
		ret += "</tr>";
		
		return ret;
	}

	public static String getMiniMax(String tekst,String name,String val1,String val2,String val3,String val4,String val5)
	{
		String ret="";
		ret += "<tr><td>";
			ret += "<table>";
				ret += "<tr><td>" + tekst + "</td></tr>";
				ret += 	 getRadio5("min","min_"+name,val1,val2,val3,val4,val5,1);
				ret += 	 getRadio5("max","max_"+name,val1,val2,val3,val4,val5,5);
			ret += "</table>";
		ret += "</td></tr>";
		
		return ret;
	}
	
	public static String getMenuButton(String purpose,String tekst)
	{
		String ret="";
		ret+="<tr>";
	//	ret+="<td style=\"width: 150px; max-width: 150px; display:block; min-width:100%;\"><button style=\"min-width:100%; width: 150px; max-width: 150px; display:block; \" onclick=\"DoNav('"+purpose+"');\" width=\"100\">"+tekst+"</button></td>";
		ret+="<td style=\"width: 150px; max-width: 150px; display:block; min-width:100%;\"><button  style=\"min-width:100%; width: 150px; max-width: 150px; display:block; background-color:#336699  ; color:#fff; \" onclick=\"DoNav('"+purpose+"');\" width=\"100\"><figcaption><font size=2 color=#000000  style=font-weight:bold><B><I>"+tekst+"</I></B><BR></figcaption></button></td>";
		ret+="</tr>";
			
		return ret;
	}
	
	public static String getImage(int id, int which)
	{
		return "<img src=\"image?id="+id+"\"&which=\""+which +"\" height=\"100\" width=\"100\"/>";
	}
	
	public static String getImageWithText(int id, int which)
	{
		String ret="";
		ret += "<td>";
		ret += getImage(id, which) + "<br>";
		
		ret+=getDescribeFromImage(id,which);

		ret += "<\td>";
		
		return ret;
	}
	
	public static String getDescribeFromImage(int id, int which)
	{
		Connection con = Connections.DataBase.getConnecton();
		String ret ="<br>";
		if(con != null)
		{
			try 
			{
				Statement st=null;
				try 
				{
					st = con.createStatement();
					
					ResultSet rs=null;
					try 
					{
						rs = st.executeQuery("Select descriptionPhoto From photos Where idGatunek="+ id+ "  LIMIT "+ which +",1");
						if(rs.next())
						{
							ret = rs.getString(1);
							if(ret == null)
							{
								ret ="<br>";
							}
						}
					} 
					catch (SQLException e) 
					{
					}
					finally
					{
						if(rs != null)
						{
							try 
							{
								rs.close();
							} 
							catch (SQLException e) 
							{
							}
						}
					}
				} 
				catch (SQLException e) 
				{
				}
				finally
				{
					if(st != null)
					{
						try 
						{
							st.close();
						} 
						catch (SQLException e) 
						{
							e.printStackTrace();
						}
					}
				}
			}
			finally
			{
				try 
				{
					con.close();
				} 
				catch (SQLException e) 
				{
				}
			}
		}
		if(ret.equals(""))
		{
			ret ="<br>";
		}
		
		return ret;
	}
	
	public static int getNumImage(int id)
	{
		Connection con = Connections.DataBase.getConnecton();
		int ret =0;
		if(con != null)
		{
			try 
			{
				Statement st=null;
				try 
				{
					st = con.createStatement();
					
					ResultSet rs=null;
					try 
					{
						rs = st.executeQuery("Select count(Photo) From photos Where idGatunek="+ id);
						if(rs.next())
						{
							ret = rs.getInt(1);
						}
					} 
					catch (SQLException e) 
					{
					}
					finally
					{
						if(rs != null)
						{
							try 
							{
								rs.close();
							} 
							catch (SQLException e) 
							{
							}
						}
					}
				} 
				catch (SQLException e) 
				{
				}
				finally
				{
					if(st != null)
					{
						try 
						{
							st.close();
						} 
						catch (SQLException e) 
						{
							e.printStackTrace();
						}
					}
				}
			}
			finally
			{
				try 
				{
					con.close();
				} 
				catch (SQLException e) 
				{
				}
			}
		}
		
		return ret;
	}
	
	public static void print(String text)
	{
		System.out.println(text);
	}
	
}
