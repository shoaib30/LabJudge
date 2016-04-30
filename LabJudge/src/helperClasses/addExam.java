package helperClasses;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addExam
 */
@WebServlet("/addExam")
public class addExam extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";

	   //  Database credentials
	static final String USER = "root";
	static final String PASS = "3070";
	Connection conn;
	static String dataPath = System.getProperty("user.dir")+"/Documents/Programming/JavaProject/LabJudge/data/labs/";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addExam() {
        super();
        try{
		      //STEP 2: Register JDBC driver
		      Class.forName(JDBC_DRIVER);
		      //STEP 3: Open a connection
		      conn = DriverManager.getConnection(DB_URL,USER,PASS);
		   }catch(SQLException se){
		      //Handle errors for JDBC
		      se.printStackTrace();
		   }catch(Exception e){
		      //Handle errors for Class.forName
		      e.printStackTrace();
		   }
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String labName = request.getParameter("lbname");
		String labCode = request.getParameter("lbcode");
		int drHours = Integer.parseInt(request.getParameter("durationHours"));
		int drMins = Integer.parseInt(request.getParameter("durationMins"));
		String teacherCode = request.getParameter("teacherCode");
		int sem = Integer.parseInt(request.getParameter("semester"));
		new File(dataPath+labCode).mkdirs();
		String sql="insert into lab(lab_name,lab_code,duration,teacher_user_name,semester) values (?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, labName);
			ps.setString(2, labCode);
			ps.setInt(3, (drHours*60*60 + drMins*60));
			ps.setString(4, teacherCode);
			ps.setInt(5, sem);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String usnPrepend = request.getParameter("stud-usn-start");
		int usnStart = Integer.parseInt(usnPrepend.substring(4));
		usnPrepend = usnPrepend.substring(0, 4);
		int usnEnd = Integer.parseInt(request.getParameter("stud-usn-end"));
		String allStudents = "";
		for(int i=usnStart; i<=usnEnd; i++)
		{
			allStudents+="1MS" + usnPrepend;
			if((i/100) ==0)
			{
				allStudents+="0";
				if((i/10)==0)
					allStudents+="0";
				
			}
			allStudents+=i+",";
		}
		int singleStudents = Integer.parseInt(request.getParameter("singleStudents"));
		for(int i=1;i<=singleStudents; i++)
			allStudents+="1MS"+request.getParameter("student"+i)+",";
		String sql2 = "insert into lab_student(lab_code,student_list) values (?,?)";
		try {
			PreparedStatement ps2 = conn.prepareStatement(sql2);
			ps2.setString(1, labCode);
			ps2.setString(2, allStudents);
			ps2.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int numOfQues = Integer.parseInt(request.getParameter("NumberOfQuestions"));
		String sql3 = "insert into lab_questions (lab_code,question_num,question_content,solution_path,testcase_1,testcase_2) values (?,?,?,?,?,?)";
		String questionContent, questionCode = null, testCase1, testCase2;
		try {
			PreparedStatement ps3 = conn.prepareStatement(sql3);
			for(int i=1;i<=numOfQues;i++) {
				ps3.setString(1, labCode);
				ps3.setInt(2, i);
				questionContent = request.getParameter("Q"+i);
				questionCode = request.getParameter("Q"+i+"code");
				testCase1 = request.getParameter("Q"+i+"testCase1");
				testCase2 = request.getParameter("Q"+i+"testCase2");
				ps3.setString(3, questionContent);
				ps3.setString(4, questionCode);
				ps3.setString(5, testCase1);
				ps3.setString(6, testCase2);
				ps3.executeUpdate();
				createSourceCodeFile(labCode,String.valueOf(i), questionCode);
				createTestCaseFile(labCode,String.valueOf(i),testCase1,testCase2);
			}
		} catch (SQLException | URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("teacherMainPage.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void createSourceCodeFile(String labCode,String questionNum, String source) throws IOException, URISyntaxException{
		new File(dataPath+labCode+"/"+questionNum+"/solutions").mkdirs();
		URI uri = new URI("file:///"+dataPath+labCode+"/"+questionNum+"/solutions/source.cpp");
		File sourceCode = new File(uri);
		sourceCode.createNewFile();
		System.out.println("file: " + sourceCode.getAbsolutePath());
		FileWriter out = new FileWriter(sourceCode.getAbsolutePath());
		BufferedWriter bw = new BufferedWriter(out);
		bw.write(source);
		bw.close();
	}
	protected void createTestCaseFile(String labCode,String questionNum, String test1, String test2) throws IOException, URISyntaxException{
		new File(dataPath+labCode+"/"+questionNum+"/testcases").mkdirs();
		URI uri1 = new URI("file:///"+dataPath+labCode+"/"+questionNum+"/testcases/test1.txt");
		URI uri2 = new URI("file:///"+dataPath+labCode+"/"+questionNum+"/testcases/test2.txt");
		File testCase1 = new File(uri1);
		File testCase2 = new File(uri2);
		testCase1.createNewFile();
		testCase2.createNewFile();
		//System.out.println("file: " + sourceCode.getAbsolutePath());
		FileWriter out1 = new FileWriter(testCase1.getAbsolutePath());
		FileWriter out2 = new FileWriter(testCase2.getAbsolutePath());
		BufferedWriter bw1 = new BufferedWriter(out1);
		BufferedWriter bw2 = new BufferedWriter(out2);
		bw1.write(test1);
		bw2.write(test2);
		bw1.close();
		bw2.close();
	}
}
class question
{
	
}