<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*"%>

<jsp:useBean id="userAuthentication"
	class="helperClasses.AuthenticationHelper"></jsp:useBean>
<%
	Cookie cookies[] = request.getCookies();
	Cookie sessionCookie = null;
	String user="";
	if (cookies != null) {
		//System.out.println("Found Cookie");
		for (Cookie cookie : cookies) {
			//System.out.println("CookieName:"+cookie.getName());
			if (cookie.getName().equals("sessionId")) {
				sessionCookie = cookie;
				break;
			}
		}
		if (sessionCookie != null) {
			//System.out.println("Cookie:"+sessionCookie.getValue());
			userAuthentication.setSessionId(sessionCookie.getValue());
			user = userAuthentication.getUser();
			if (!user.startsWith("1MS")) {
				response.sendRedirect("index.jsp");
			}

		} else {
			//System.out.println("no cookie found");
			response.sendRedirect("index.jsp");
		}
	} else
		response.sendRedirect("index.jsp");
%>
<%
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";
	String USER = "root";
	String PASS = "3070";
	Connection conn;
	Class.forName(JDBC_DRIVER);
	conn = DriverManager.getConnection(DB_URL,USER,PASS);
	Statement stmt = conn.createStatement();
	String sql = "SELECT status from student where usn='"+user+"'";
	ResultSet rs = stmt.executeQuery(sql);
	int status=0;
	while(rs.next())
		status = rs.getInt("status");
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
        <%
        if(status == 0){
        %>
        <div class="jumbotron alert alert-danger">
	       <div class="container text-center">
                <h1>Wrong Submission</h1>
                <p>Please Try Again</p>
                <p>
                    <a class="btn btn-default btn-lg" href="studentPage.jsp">Return</a>
                </p>
	       </div>
        </div>
        <%
        }else{%>
          <div class="jumbotron alert alert-success">
	       <div class="container text-center">
                <h1>Submission Accepted</h1>
               <p>Well Done</p>
                <p>
                    <a class="btn btn-default btn-lg" href="Logout">Logout</a>
                </p>
	       </div>
        </div>
        <%} %>
      </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-2.2.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>


  </body>
</html>