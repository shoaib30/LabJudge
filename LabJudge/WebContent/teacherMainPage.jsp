<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>
    
<jsp:useBean id="userAuthentication" class="helperClasses.AuthenticationHelper"></jsp:useBean>
<%
	Cookie cookies[] = request.getCookies();
	Cookie sessionCookie = null;
	String user;
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
	    	user = userAuthentication.getUser();
	    	if(!user.startsWith("TH")) {
	    		response.sendRedirect("index.html");
	    	}
	    	
		}
		else {
			//System.out.println("no cookie found");
			response.sendRedirect("index.html");
		}
	}else
		response.sendRedirect("index.html");
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
    <link href="css/jasny-bootstrap.min.css" rel="stylesheet">
  </head>

  <body>
      <div class="container">
          <div class="jumbotron">
	           <div class="container text-center">
                    <a href="/LabJudge"><h1>Lab Judge</h1></a>
                    <p>Teachers Console</p>
	           </div>
        </div>
           <div class="jumbotron">
	<div class="container">
		<h2 class="text-center">Welcome Professor</h2>
		<p>Lab Exams Hosted:</p>
        <table class="table table-hover">
            <thead>
              <tr>
                <th>Lab</th>
                <th>Semester</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody data-link="row" class="rowlink">
               <%
            	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
     	   		String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";
     	   		String USER = "root";
     	   		String PASS = "3070";
     	   		Connection conn;
     	   		userAuthentication.setSessionId(sessionCookie.getValue());
	    		String user_name = userAuthentication.getUser();
			    try{
     	   			Class.forName(JDBC_DRIVER);
			    	conn = DriverManager.getConnection(DB_URL,USER,PASS);
					Statement stmt = conn.createStatement();
					String sql = "select * from lab WHERE teacher_user_name='"+user_name+"'";
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next())
					{
						int status = rs.getInt("status");
			%>
			 <tr class="<%switch(status) 
				 {
				 case 0: out.print("danger"); break;
				 case 1: out.print("info"); break;
				 case 2: out.print("success"); break;
				 }
				 
				 %>">
				 <td>
				 	<a href="teacherLabPage.jsp?<%=rs.getString("lab_code") %>">
				 	<%=rs.getString("lab_name") %>
					</a>
				</td>
				
				<td>
					<%=rs.getInt("semester") %>
				</td>
				<td>
					<% switch(status)
					{
					case 0: out.print("Pending");break;
					case 1: out.print("In progress");break;
					case 2: out.print("Completed");break;
					}
					
					%>
				</td>
			</tr>
			<%
					}
			    }
			    catch(SQLException e)
			    {
			    	
			    }
            
            %>
              <!-- <tr class="success">
                  <td><a href="#OS">Operating Systems</a></td>
                <td>5</td>
                <td>Completed</td>
              </tr>
              <tr class="danger">
                <td><a href="#DS">Data Structure</a></td>
                <td>3</td>
                <td>Pending</td>
              </tr>
              <tr class="info">
                <td><a href="#ADA">Design and Analysis of Algorithms</a></td>
                <td>5</td>
                <td>In Progress</td>
              </tr> -->
            </tbody>
        </table>

        
		<p>
			<a class="btn btn-warning btn-sm" href="teacherAddExam.jsp">Add new exam</a>
		</p>
		<p>
			<a class="btn btn-danger btn-sm" href="Logout">Logout</a>
		</p>
	</div>
</div>
    </div>
     

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-2.2.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jasny-bootstrap.min.js"></script>

  </body>
</html>
