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
            <h2>Operating Systems Lab</h2>
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
            
            
            <p>
                <a class="btn btn-info">Results</a>
            </p>
        </div>  
    </div>
        <div class="jumbotron">
            <div class="container">
                <h2>Student List</h2>
                <table class="table table-condensed text-center">       
                <tbody>
                    <tr>
                        <td>1MS13IS101</td>
                        <td>1MS13IS101</td>
                        <td>1MS13IS101</td>
                    </tr>
                    <tr>
                        <td>1MS13IS101</td>
                        <td>1MS13IS101</td>
                        <td>1MS13IS101</td>
                    </tr>
                </tbody>
            </table>

                <p class="text-center">
                    <a class="btn btn-primary">Print List</a>
                </p>
            </div>
        </div>
          <div class="jumbotron">
	<div class="container">
		<h2>Question List</h2>
        <table class="table table-bordered table-hover">
        <tbody>
            <tr>
                <td>Question 1</td>
                <td>Write a program to compute the first n fiboncci numbers</td>
                
            </tr>
            <tr>
                <td>Question 2</td>
                <td>Write a program to compute factorial of n</td>
            </tr>
        </tbody>
        </table>		
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
