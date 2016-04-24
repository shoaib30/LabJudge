<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                    <a href="mainPage.html"><h1>Lab Judge</h1></a>
                    <p>Add Teacher</p>
	           </div>
        </div>
        <div class="jumbotron">
	<div class="container">
		<form class="form-horizontal" action="AddTeacher" method="get">
			<fieldset>
			
			<!-- Form Name -->
			
			<!-- Text input-->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="teacherName">Teacher's Name</label>  
			  <div class="col-md-4">
			  <input id="teacherName" name="teacherName" type="text" placeholder="Name" class="form-control input-md" required="">
			  <span class="help-block">Enter the name of the teacher</span>  
			  </div>
			</div>
			
			<!-- Prepended text-->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="teacherUserName">Username</label>
			  <div class="col-md-4">
			    <div class="input-group">
			      <span class="input-group-addon">TH</span>
			      <input id="teacherUserName" name="teacherUserName" class="form-control" placeholder="username" type="text" required="">
			    </div>
			    <span class="help-block">Set the username</span>
			  </div>
			</div>
			
			<!-- Text input-->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="teacherPass">Password</label>  
			  <div class="col-md-4">
			  <input id="teacherPass" name="teacherPass" type="text" placeholder="password" class="form-control input-md" required="">
			  <span class="help-block">Set the password for the teacher</span>  
			  </div>
			</div>
			
			<!-- Button -->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="submit"></label>
			  <div class="col-md-4">
			    <button id="submit" name="submit" class="btn btn-primary">Add Teacher</button>
			  </div>
			</div>
			
			</fieldset>
		</form>
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
