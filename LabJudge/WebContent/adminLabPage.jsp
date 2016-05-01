<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ page language="java" import="java.sql.*" %>
    
<jsp:useBean id="userAuthentication" class="helperClasses.AuthenticationHelper"></jsp:useBean>
<%
	Cookie cookies[] = request.getCookies();
	Cookie sessionCookie = null;
	if( cookies != null ){
		//System.out.println("Found Cookie");
		for(Cookie cookie : cookies)	{
			//System.out.println("CookieName:"+cookie.getName());
			if(cookie.getName().equals("sessionId")){
				sessionCookie = cookie;
				break;
			}
		}
		if(sessionCookie != null){
			//System.out.println("Cookie:"+sessionCookie.getValue());
	    	userAuthentication.setSessionId(sessionCookie.getValue());
	    	String user = userAuthentication.getUser();
	    	if(!user.equals("admin")) {
	    		response.sendRedirect("index.jsp");
	    	}
	    	
		}
		else {
			//System.out.println("no cookie found");
			response.sendRedirect("index.jsp");
		}
	}else
		response.sendRedirect("index.jsp");
%>
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Lab Judge</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-darkly-theme.min.css" rel="stylesheet" />
  </head>

  <body>
      <div class="container">
          <div class="jumbotron">
	           <div class="container text-center">
                    <a href="/LabJudge"><h1>Lab Judge</h1></a>
	           </div>
        </div>
    <div class="jumbotron">
        <div class="container">
        	<%
        	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
 	   		String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";
 	   		String USER = "root";
 	   		String PASS = "3070";
 	   		String labCode=request.getParameter("labCode");
 	   		Connection conn;
 	   		String teacherCode="";
 	   		int duration=0;
 	   		int status=0;
 	   		int sem=0;
 	   		String teacherName = "";
		    try{
 	   			Class.forName(JDBC_DRIVER);
		    	conn = DriverManager.getConnection(DB_URL,USER,PASS);
				Statement stmt = conn.createStatement();
				String sql = "select * from lab where lab_code = '"+labCode+"'";
				ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())
				{
					String labName = rs.getString("lab_name");
					teacherCode = rs.getString("teacher_user_name");
					duration = rs.getInt("duration");
					status = rs.getInt("status");
					sem = rs.getInt("semester");
			%>
			<h2><%=labName %></h2>
			<table class="table">
                <tr>
                    <td><b>Lab Name:</b></td>
                    <td><%=labName %></td>
                </tr>
                <tr>
                	<td><b>Lab Code:</b></td>
                    <td><%=labCode %>
                </tr>
			<%	
				}
				int hours = duration/3600;
				int minutes = (duration%3600)/60;
				String time="";
				if((hours/10) == 0)
					time = "0";
				 time += hours+":";
				 if((minutes/10) == 0)
					 time +="0";
				 time += minutes;
				
				Statement stmt2 = conn.createStatement();
				String sql2 = "select name from teacher where user_name = '"+teacherCode+"'";
				ResultSet rs2 = stmt2.executeQuery(sql2);
				while(rs2.next())
				{
					teacherName = rs2.getString("name");
				}
			%>
			<tr>
                    <td><b>Teacher Incharge:</b></td>
                    <td><%=teacherName %></td>
            </tr>
            <tr>
            		<td><b>Duration:</b></td>
                    <td><%=time %></td>
            </tr>
            <tr>
            		<td><b>Status:</b></td>
                    <td><% switch(status)
                    		{
                    		case 0: out.print("Pending"); break;
           				 	case 1: out.print("In progress"); break;
           				 	case 2: out.print("Completed"); break;
                    		}
                    		
                    	%>
                    </td>
            </tr>
            </table>
			<%
		    } catch(Exception e)
		    {
		    	e.printStackTrace();
		    }
        	%>
            
            <!-- <h2>Operating Systems Lab</h2>
            <hr>
            <table class="table">
                <tr>
                    <td><b>Lab Name:</b></td>
                    <td>OS Lab</td>
                </tr>
                <tr>
                    <td><b>Lab Code:</b></td>
                    <td>IS402L</td>
                </tr>
                 <tr>
                    <td><b>Teacher Incharge:</b></td>
                    <td>Sandeep BL</td>
                </tr>
                 <tr>
                    <td><b>Duration:</b></td>
                    <td>03:00</td>
                </tr>
                 <tr>
                    <td><b>Status:</b></td>
                    <td>In Progress</td>
                </tr>
            </table>
             -->
            
            <p>
                <a class="btn btn-success">Start Exam</a>
                <a class="btn btn-info">Stop Exam</a>
                <a class="btn btn-danger">Delete Exam</a>
            </p>
        </div>  
    </div>

    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-2.2.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>


  </body>
</html>
