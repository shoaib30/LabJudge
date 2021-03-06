<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	    	if(user.startsWith("1MS")) {
	    		response.sendRedirect("studentStartExam.jsp");
	    	}
		}
		else {
			//System.out.println("no cookie found");
		}
	}
%>
   

<%
String JDBC_DRIVER = "com.mysql.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";
String USER = "root";
String PASS = "3070";
Connection conn;
Class.forName(JDBC_DRIVER);
conn = DriverManager.getConnection(DB_URL, USER, PASS);
try {
	String sql = "delete from sessions where time < (NOW()- INTERVAL 3 HOUR)";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.executeUpdate();
} catch (Exception e) {
	
}
%>
<!DOCTYPE html>
<html lang="en">
<head><title>AutoLab Judge</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
<!--
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/2.3.2/js/bootstrap.min.js"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
-->
    <script type="text/javascript" src="js/jquery-2.2.0.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js" ></script>
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet">
     <link href="css/bootstrap-pingendo.css" rel="stylesheet" type="text/css">
    </head><body>
        <div class="cover">
            <div class="navbar">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-ex-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="http://www.techgeekme.com"><span>TechGeekMe</span></a>
                    </div>
                    <div class="collapse navbar-collapse" id="navbar-ex-collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="active">
                                <a href="adminConsole.jsp">Admin Console</a>
                            </li>
                            
                        </ul>
                    </div>
                </div>
            </div>
            <div class="cover-image" style="background-image : url('img/mainPageBg.jpg')"></div>
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <h1 class="text-inverse">Lab Judge</h1>
                        <p class="text-inverse">A project to implement a judge for lab exams in various languages</p>
                        <br>
                        <br>
                        <a class="btn btn-lg btn-primary"   data-toggle="modal" data-target="#myModalNorm">Login</a>
                        
                        
                    

                        <!-- Modal -->
                        <div class="modal fade" id="myModalNorm" tabindex="-1" role="dialog" 
                             aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <button type="button" class="close" 
                                           data-dismiss="modal">
                                               <span aria-hidden="true">&times;</span>
                                               <span class="sr-only">Close</span>
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel">
                                            Student Login
                                        </h4>
                                    </div>

                                    <!-- Modal Body -->
                                    <div class="modal-body">

<!--
                                        <form role="form">
                                          <div class="form-group">
                                            <label for="exampleInputEmail1">USN</label>
                                              <input type="text" class="form-control"
                                              id="exampleInputEmail1" placeholder="USN: 1MS<batch><Dept><RollNo>" pattern="1MS[0-9]{2}[A-Z]{2}[0-9]{3}"/>
                                          </div>
                                          <div class="form-group">
                                            <label for="exampleInputPassword1">Password</label>
                                              <input type="password" class="form-control"
                                                  id="exampleInputPassword1" placeholder="Password"/>
                                          </div>
                                          <div class="checkbox">
                                            <label>
                                                <input type="checkbox"/> Check me out
                                            </label>
                                          </div>
                                          <button type="submit" class="btn btn-default">Login</button>
                                        </form>
-->
                                        <form class="form-horizontal" action="Authentication">
                                        <fieldset>


                                        <!-- Prepended text-->
                                        <div class="form-group">
                                          <label class="col-md-4 control-label" for="username" >USN</label>
                                          <div class="col-md-5">
                                            <div class="input-group">
                                              <span class="input-group-addon">1MS</span>
                                              <input id="username" name="username" class="form-control" placeholder="USN" type="text" required="" pattern="[0-9]{2}[A-Z]{2}[0-9]{3}" title="USN in uppercase">
                                            </div>

                                          </div>
                                        </div>

                                        <!-- Password input-->
                                        <div class="form-group">
                                          <label class="col-md-4 control-label" for="passw">Password</label>
                                          <div class="col-md-5">
                                            <input id="pass" name="pass" type="password" placeholder="Password" class="form-control input-md" required="">

                                          </div>
                                        </div>
										<input type="hidden" name="status" value="3"/>
                                        <!-- Button -->
                                        <div class="form-group">
                                          <label class="col-md-4 control-label" for="loginBtn"></label>
                                          <div class="col-md-4">                                            
                                            <button id="loginBtn" name="loginBtn" class="btn btn-primary">Login</button>
                                          </div>
                                        </div>

                                        </fieldset>
                                        </form>



                                    </div>

                                    <!-- Modal Footer -->
<!--
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default"
                                                data-dismiss="modal">
                                                    Close
                                        </button>
                                        <button type="button" class="btn btn-primary">
                                            Save changes
                                        </button>
                                    </div>
-->
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <img src="img/student_page.png" class="img-responsive">
                    </div>
                    <div class="col-md-6">
                        <h1 class="text-primary">Student</h1>
                        <h3>Interactive Layout</h3>
                        <p>The student logs into an interactive layout where he/she can start the examination once the system selects a random question from the list provided. The students can code in the IDE of their choice and upload the code to the application. Or the student can type the code directly into the provided text box. On submission of a code. The system replies back with the result&nbsp;immediately. The student also gets an option to change question, which will run the random question selector once again.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h1 class="text-primary">Teacher</h1>
                        <h3>Powerful console</h3>
                        <p>The console made for the teachers to set the questions for lab is powerful enough to not only provide different options for set up, i.e. by uploading a program for generating output(recommended) or by giving different cases of input and output. The teacher can set up any number of boudry test cases to be checked when the student submits the code. On completion of the exam, the Teacher can export the results in form of a spreadsheet or take a printout of the results directly from the application.</p>
                    </div>
                    <div class="col-md-6">
                        <img src="img/teacher_page.png" class="img-responsive">
                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <img src="img/admin_page.png" class="img-responsive">
                    </div>
                    <div class="col-md-6">
                        <h1 class="text-primary">Administrator</h1>
                        <h3>Overall Control</h3>
                        <p>The admin console gives the administrator the power over all exams. To provide better control over the lab exams, the Admin is given control over starting stopping and deleting exams as opposed to the teacher. This will avoid inconsistancy like two teachers starting exams simultaneously for the same student.  </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h1 class="text-center text-primary">Team</h1>
                        <p class="text-center">We are a group of skilled individuals.</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 text-center">
                        <img src="img/shoaib-ahmed.jpg" class="center-block img-circle img-responsive" width="150" height="150">
                        <h3 class="text-center">Shoaib Ahmed</h3>
                        <p class="text-center">Developer</p>
                    </div>
                     <div class="col-md-6 text-center">
                        <img src="img/shreyansh-jain.jpg" class="center-block img-circle img-responsive" width="150" height="150">
                        <h3 class="text-center">Shreyansh Jain</h3>
                        <p class="text-center">Developer</p>
                    </div>
                    
                </div>
            </div>
        </div>
    </body>
</html>