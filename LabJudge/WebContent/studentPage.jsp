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

<jsp:useBean id="student" class="helperClasses.StudentHelper"></jsp:useBean>
<%
student.setUSN(user);
student.setDetails();
%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Student Page</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-darkly-theme.min.css" rel="stylesheet" />
    
      <link rel="stylesheet" href="codemirror.css">
     
      <script src="js/jquery-2.2.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
      <script>
          $(document).ready(function()   {
            var totalSeconds = <%=student.getTimeLeft()%>;
            var timerID = setInterval(function()    {
                var time = totalSeconds;
                hours = Math.floor(time / 3600);
                time %= 3600;
                mins = Math.floor(time / 60);
                secs = time % 60;
                $("#timer").html(hours +":"+ mins +":"+ secs)
                  totalSeconds -=1
                  if(totalSeconds<0){
                      alert("end")
                     clearInterval(timerID)
                  }
          },1000)
            $("#questionChnage").on("click",function()  {
                var a = confirm("Are you sure you want to change question?");
                if(a)   {
                    window.location="questionSelectoPage.html";
                }
            })
        })
          
      </script>
      <style>
.top-buffer { margin-top:20px; }
          .rcorners1 {
    border-radius: 25px;
    border: 2px solid #00FFFF;
    padding: 20px; 
    width: 130px;
    height: 100px; 
        
}
	</style>
  </head>

  <body>
      <div class="container">
          <div class="jumbotron">
	           <div class="container text-center">
                    <a href="/LabJudge"><h1>Lab Judge</h1></a>
                    <p>Student Page</p>
	           </div>
        </div>
    </div>
      <div class="container">
          <div class="row">
        <div class="col-xs-9">
            <div class="jumbotron">
	           <div class="container">
		          <h2>Question: <%=student.getQno() %></h2>
		          <p><%=student.getQuestionContent() %></p>
			         <form class="form-horizontal">
                        <fieldset>
                            <!-- Form Name -->
                            <legend class="text-center">Submission</legend>
                            <!-- Textarea -->
                            <div class="form-group">
                              <label class="col-md-2 control-label" for="textarea">Paste Code</label>
                              <div class="col-md-8">                     
                                <textarea class="form-control" id="textarea" name="textarea" rows="8"></textarea>
                              </div>
                            </div>
                            <legend class="text-center"><b>-OR-</b></legend>
                            <!-- File Button --> 
                            <div class="form-group">
                              <label class="col-md-2 control-label" for="filebutton">Upload Code</label>
                              <div class="col-md-4">
                                <input id="filebutton" name="filebutton" class="input-file" type="file"/>
                              </div>
                            </div>
                            <!-- Button (Double) -->
                            <div class="form-group">
                              <label class="col-md-4 control-label" for="btn_code_submit"></label>
                              <div class="col-md-8">
                                <button id="btn_code_submit" name="btn_code_submit" class="btn btn-success">Submit Code</button>
                                <button id="btn_reset_code" name="btn_reset_code" class="btn btn-warning">Clear Code</button>
                              </div>
                            </div>
                        </fieldset>
                    </form>
	           </div>
            </div>
        </div>
              <div class="col-xs-3">
                  <div class="jumbotron">
<!--                      <div class="container">-->
                         <h3> <div class="rcorners1" >Timer
                             <div id="timer"></div>
                             </div>
                      </h3>
                      
                      <button type="button" class="btn btn-primary top-buffer" id="questionChnage">Change Question</button>
                        <p>
                            <a class="btn btn-danger top-buffer" href="Logout">Log Out</a>
                        </p>
<!--	               </div>-->
                </div>
            </div>
      </div>
</div>

      


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    


  </body>
</html>