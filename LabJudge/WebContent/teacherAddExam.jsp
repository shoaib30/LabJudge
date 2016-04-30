<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userAuthentication" class="helperClasses.AuthenticationHelper"></jsp:useBean>
<%
	String user="";
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
      <script src="js/jquery-2.2.0.min.js"></script>
      <script>
      $(document).ready(function()  {
          var numberOfStudents = 0;
          var singleStudents = 0;
          var numberOfQuestions=0;
          $("#stud-usn-start").on("input", function()    {
              //alert($("#stud-usn-start").val())
              var str = $("#stud-usn-start").val().substring(0,4)
              
              $("#endprepend").html("1MS"+str)
          })
          $("#addsinglestudent").on("click",function()  {
            	numberOfStudents++;
              singleStudents++;
              $("#single-students").append("<div class='col-md-3'><div class='input-group'><span class='input-group-addon'>1MS</span><input id='student"+singleStudents+"' name='student"+singleStudents+"' class='form-control' placeholder='13IS101' type='text'>")
              $("#num-of-studs").html(numberOfStudents);
              $("#singleStudents").attr("value",singleStudents);
          })
          $("#stud-usn-end").on("blur", function()  {
              //alert("end:"+$("#stud-usn-end").val()+"\nstart: "+$("#stud-usn-start").val().substring(4,7))
              
              numberOfStudents += parseInt($("#stud-usn-end").val()) - parseInt($("#stud-usn-start").val().substring(4,7)) + 1
              $("#num-of-studs").html(numberOfStudents);
          })
          $("#add-ques").on("click",function()  {
              numberOfQuestions++;
              $("#num-of-ques").html(numberOfQuestions)
              $("#NumberOfQuestions").attr("value",numberOfQuestions);
              $("#question-area").append(" <div class='form-group'><input type='hidden' name='Q"+numberOfQuestions+"num' value='"+numberOfQuestions+"'/><label class='col-md-4 control-label' for='Q'>Question: "+numberOfQuestions+"</label><div class='col-md-4'><textarea class='form-control' id='Q"+numberOfQuestions+"' name='Q"+numberOfQuestions+"'></textarea></div></div><div class='form-group'><label class='col-md-4 control-label' for='source'>Source Code</label><div class='col-md-8'><textarea class='form-control' id='textarea' name='Q"+numberOfQuestions+"code' rows='8'></textarea></div></div><div class='form-group'><label class='col-md-4 control-label' for='testCase'>Test Cases</label><div class='col-md-3'><textarea class='form-control ' id='Q"+numberOfQuestions+"testCase1' name='Q"+numberOfQuestions+"testCase1'></textarea></div><div class='col-md-3'><textarea class='form-control' id='Q"+numberOfQuestions+"testCase2' name='Q"+numberOfQuestions+"testCase2'></textarea></div></div><hr/>")
          })
      })
      //<div class='col-md-4'><input id='Q"+numberOfQuestions+"source' name='Q"+numberOfQuestions+"source' class='input-file' type='file'></div>
       ""
      </script>
  </head>

  <body>
<div class="container">
  <div class="jumbotron">
       <div class="container text-center">
            <a href="/LabJudge"><h1>Lab Judge</h1></a>
            <p>New Lab</p>
       </div>
    </div>
<form class="form-horizontal" action="addExam">
<!--<fieldset>  -->
    <div class="jumbotron">
        <div class="container">

            

            <!-- Form Name -->
            <legend>Add New Lab</legend>

            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="lbname">Lab Name</label>  
              <div class="col-md-4">
              <input id="lbname" name="lbname" type="text" placeholder="Lab Name" class="form-control input-md" required="">
              <span class="help-block">Enter the Lab Name</span>  
              </div>
            </div>

            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="lbcode">Lab Subject Code</label>  
              <div class="col-md-4">
              <input id="lbcode" name="lbcode" type="text" placeholder="Lab Subject Code" class="form-control input-md" required="">
              <span class="help-block">Enter the subject code for the lab</span>  
              </div>
            </div>
            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="semester">Semester</label>  
              <div class="col-md-2">
              <input id="semester" name="semester" type="number" placeholder="semester" class="form-control input-md" required="" min="1" max="8">
              <span class="help-block">Enter the semester</span>  
              </div>
            </div>
            <!--Duration-->
           <div class="form-group">
              <label class="col-md-4 control-label" for="durationHours">Duration</label>
              <div class="col-md-2">
                <div class="input-group">
                  <span class="input-group-addon">hr:</span>
                  <input id="durationHours" name="durationHours" class="form-control" placeholder="hr" type="number" required="">
                </div>
                  <span class="help-block">Duration of exam</span>
              </div>
               <div class="col-md-2">
                <div class="input-group">
                  <span class="input-group-addon">min:</span>
                  <input id="durationMins" name="durationMins" class="form-control" placeholder="min" type="number" required="">
                </div>
              </div>
            </div>
			<input type="hidden" name="teacherCode" value="<%=user%>"/>
            
        </div>
    </div>
    <div class="jumbotron">
	<div class="container">
        <legend>Student List <br/>Number of students: <span id="num-of-studs"></span></legend>
        <input type="hidden" name="singleStudents" value="0" id="singleStudents"/>
		 <!-- Prepended text-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="stud-usn-start">Student USN</label>
              <div class="col-md-3">
                <div class="input-group">
                  <span class="input-group-addon">1MS</span>
                  <input id="stud-usn-start" name="stud-usn-start" class="form-control" placeholder="13IS101" type="text" required="">
                </div>
            <!--    <p class="help-block">Enter the Starting USN</p>-->
              </div>
                <label class="col-md-1 control-label" for="stud-usn-end">------></label>
              <div class="col-md-3">
                <div class="input-group">
                  <span class="input-group-addon" id="endprepend">1MS</span>
                  <input id="stud-usn-end" name="stud-usn-end" class="form-control" placeholder="101" type="text" required="">
                </div>
            <!--    <p class="help-block">Enter the ending USN</p>-->
              </div>
            </div>
        <div class="form-group">
            <div class="row">
                <div id="single-students">


                </div>
                </div>

        
        </div>
        <button type="button" class="btn btn-primary" id="addsinglestudent">Add Single student</button>
	</div>
</div>
 <div class="jumbotron">
	<div class="container">
        <legend>Question List<br/>Number of Questions: <span id="num-of-ques"></span></legend>
        <input type="hidden" name="NumberOfQuestions" value="0" id="NumberOfQuestions"/>
        <div id="question-area"></div>
        <button type="button" class="btn btn-primary" id="add-ques">Add New Question</button>
       
            
        </div>

	</div>
    
    
    <div class="jumbotron">
	<div class="container">
		<div class="form-group">
              <label class="col-md-4 control-label" for="btnsubmit"></label>
              <div class="col-md-8">
                <button id="btnsubmit" name="btnsubmit" class="btn btn-success">Add Lab</button>
                <input type="reset" id="btnreset" name="btnreset" class="btn btn-danger" value="Reset Details"/>
              </div>
            
            </div>
        </div>
    </div>
   


<!-- </fieldset> -->
</form>
</div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
    <script src="js/bootstrap.min.js"></script>


  </body>
</html>
