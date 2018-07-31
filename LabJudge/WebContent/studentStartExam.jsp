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
String usn = user;
Class.forName(JDBC_DRIVER);
String labCode = "";
int qno = 0;
int numOfQues = 0;
conn = DriverManager.getConnection(DB_URL, USER, PASS);
try {
	Statement stmt = conn.createStatement();
	String sql = "select * from student where usn = '" + usn + "'";
	ResultSet rs = stmt.executeQuery(sql);
	while(rs.next())	{
		labCode = rs.getString("labcode");
		qno = rs.getInt("ques_no");
	}
	Statement stmt2 = conn.createStatement();
	String sql2 = "select count(*) as numOfQues from lab_questions where lab_code = '"+labCode+"'";
	ResultSet rs2 = stmt2.executeQuery(sql2);
	while(rs2.next())
	{
		numOfQues = rs2.getInt("numOfQues");
	}
}catch (Exception e) {
		e.printStackTrace();
	}
	
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
       <script src="js/jquery-2.2.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
      <script>
        $(document).ready(function()    {        			
            var questionNumber = <%=qno%>;
            var totalQuestions = <%=numOfQues%>;
            var numberOfLoops;
            var speed;
            var i=1;
            var intervalID;
            var setQuestion = function()    {
                
                $("#quesNo").html(i);
                
                clearInterval(intervalID)
                speed+=5
                if(numberOfLoops > 0 || i != (questionNumber))    {
                	i++
                    if(i%(totalQuestions+1) == 0)   {
                        i=1;
                        numberOfLoops--
                    }
                	//alert("loop: "+numberOfLoops+"   question: "+questionNumber +"  i: "+i);
                    intervalID = setInterval(setQuestion,speed)
                }
                else{
//                    $("#quesBtn").innerHTML("Start");
                    $("#quesBtn").attr("href","studentPage.jsp");
                    //$("#quesBtn").removeClass("disabled")
                    $("#btnSpace").html("<a class='btn btn-primary btn-lg' href='studentPage.jsp'>Start Exam</a>")
                }
                
            }
            $("#quesBtn").on("click",function()  {
                    i = 1;
                    speed = 10
                    numberOfLoops = 5;
                    $("#quesBtn").addClass("disabled")
                    intervalID = setInterval(setQuestion,speed)
                    
            })
        })
      </script>
  </head>

  <body>
      <div class="container">
          <div class="jumbotron">
	           <div class="container text-center">
                    <a href="/LabJudge"><h1>Lab Judge</h1></a>
	           </div>
        </div>
          <div class="jumbotron">
	<div class="container text-center">
        <h1><div id="quesNo"></div></h1>
        <div id="btnSpace"><a class="btn btn-primary btn-lg"id="quesBtn">Get Question</a></div>
        <p>
            
<!--            <button type="button" class="btn btn-primary btn-lg"  id="quesBtn">Get Question</button>-->
		</p>
	</div>
</div>

    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   


  </body>
</html>