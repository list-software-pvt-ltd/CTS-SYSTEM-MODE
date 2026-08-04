<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="cts.*"%>
<%@page import="java.util.Date.*"%>

<%!
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	StringBuffer strBuff;
	int counter=0;
%>
<%
	strBuff=new StringBuffer("");
//report_date
 String report_date = request.getParameter("report_date");
	System.out.println("In getAllCYCLE JSP........"+report_date);
	try
	{//1
		String sql=" select  distinct  CLI_CONTI_CYCNO from CLEARINGINWARD where CLI_DDMMYYYY='"+report_date+"' order by 1";
		con=Configuration.getConnection();
		if(con!=null)
		{//2
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			
			while(rs.next())
			{
				strBuff.append(rs.getString(1)+"!Q!"+rs.getString(1)+"#");	
				counter++;
			}	
			if(counter==0)
				strBuff.append("No Data Found#");
		}//2
	}//1
	catch(SQLException e)
	{
		System.out.println("\n\t SQLException in getAllCYCLE.jsp:>>"+e);
		strBuff.append("No Data Found#");	
	}
	catch(Exception e)
	{
		System.out.println("\n\t Exception in getAllCYCLE.jsp:>>"+e);
		strBuff.append("No Data Found#");	
	}
	finally
	{
		try
		{
			if(con!=null && rs!=null && ps!=null)
			{
				rs.close();
				ps.close();
				con.close();				
			}
		}catch(Exception e){}
	}
		System.out.println("\n\t exit from getAllCYCLE.jsp:"+strBuff.toString());
%>
<%=strBuff.toString()%>