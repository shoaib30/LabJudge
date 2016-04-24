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
	    	if(user.equals("admin")) {
	    		response.sendRedirect("adminMainPage.jsp");
	    	}
		}
		else {
			//System.out.println("no cookie found");
		}
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

    <title>Admin Login</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-darkly-theme.min.css" rel="stylesheet" />
  </head>

  <body>
    <div class="container">
          <div class="jumbotron">
	           <div class="container text-center">
                    <a href="/LabJudge"><h1>Lab Judge</h1></a>
                    <p>Admin Console</p>
	           </div>
        </div>
    </div>
    <div class="container">
      <p>
          <div class="row">
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="jumbotron">
                    <div class="container">
                        <form class="form-horizontal" action="Authentication" method="get">
                            <fieldset>

                                <!-- Form Name -->
                                <legend class="text-center">Admin Login</legend>

                                <!-- Text input-->
                                    <div class="form-group">
                                  <label class="col-md-4 control-label" for="username">Admin Name</label>  
                                  <div class="col-md-4">
                                  <input id="username" name="username" type="text" placeholder="Name" class="form-control input-md" required="">

                                  </div>
                                </div>

                                <!-- Password input-->
                                <div class="form-group">
                                  <label class="col-md-4 control-label" for="pass">Password</label>
                                  <div class="col-md-4">
                                    <input id="pass" name="pass" type="password" placeholder="password" class="form-control input-md" required="">

                                  </div>
                                </div>

                                <!-- Button -->
                                <div class="form-group">
                                <input type="hidden" name="status" value="1"/>
                                  <label class="col-md-4 control-label" for="btn_admin_login"></label>
                                  <div class="col-md-4">
                                    <button id="btn_admin_login" name="btn_admin_login" class="btn btn-primary">Login</button>
                                  </div>
                                </div>

                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="jumbotron">
                    <div class="container">
                        <form class="form-horizontal" action="Authentication">
                            <fieldset>

                                <!-- Form Name -->
                                <legend class="text-center">Teacher Login</legend>

                                <!-- Text input-->
                                    <div class="form-group">
                                  <label class="col-md-4 control-label" for="text_teacher_name">Teacher Name</label>  
                                  <div class="col-md-4">
                                  <input id="text_teacher_name" name="username" type="text" placeholder="Name" class="form-control input-md" required="">

                                  </div>
                                </div>

                                <!-- Password input-->
                                <div class="form-group">
                                  <label class="col-md-4 control-label" for="pwd_teacher_pass">Password</label>
                                  <div class="col-md-4">
                                    <input id="pwd_teacher_pass" name="pass" type="password" placeholder="password" class="form-control input-md" required="">

                                  </div>
                                </div>

                                <!-- Button -->
                                <div class="form-group">
                                <input type="hidden" name="status" value="2"/>
                                  <label class="col-md-4 control-label" for="btn_teacher_login"></label>
                                  <div class="col-md-4">
                                    <button id="btn_teacher_login" name="btn_teacher_login" class="btn btn-primary">Login</button>
                                  </div>
                                </div>

                            </fieldset>
                        </form>
                    </div>
                </div>
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
