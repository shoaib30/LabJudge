package helperClasses;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StartExam
 */
@WebServlet("/StartExam")
public class StartExam extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// JDBC driver name and database URL
	   static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	   static final String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";

	   //  Database credentials
	   static final String USER = "root";
	   static final String PASS = "3070";
	   Connection conn;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StartExam() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
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
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String labCode = request.getParameter("labCode");
		try {
			startExam(labCode);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("adminLabPage.jsp?labCode="+labCode);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected String passwordGenrator()	{
		Random r = new Random();
		String pass = "";
		for(int i = 0; i < 10; i++)	{
			pass += r.nextInt(10);
		}
		return pass;
	}
	protected int findNumQues(String labCode) throws SQLException	{
		String sql = "SELECT COUNT( * ) AS questions FROM lab_questions WHERE lab_code =  '" + labCode + "'";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next())
			return rs.getInt("questions");
		return 0;
	}
	public void startExam(String labCode) throws SQLException	{
		Statement stmt = conn.createStatement();
		String sql = "SELECT student_list from lab_student where lab_code = '"+labCode+"'";
		String individualUSN []= null;
		String allStudents = "";
		Random r = new Random();
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next())
		{
			allStudents = rs.getString("student_list");
		}
		individualUSN = allStudents.split(",");
		String insertSQL = "INSERT into student (usn,pass,labcode,ques_no) values (?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(insertSQL);
		int numberOfQuestions = findNumQues(labCode);
		for( String usn : individualUSN)	{
			String pass = passwordGenrator();
			int questNum  = r.nextInt(numberOfQuestions)+1;
			ps.setString(1, usn);
			ps.setString(2, pass);
			ps.setString(3, labCode);
			ps.setInt(4, questNum);
			ps.executeUpdate();
		}
		for(int i=1; i<=numberOfQuestions; i++){
			ProcessBuilder builder = new ProcessBuilder("bash","initiateExam.sh",labCode,String.valueOf(i));
			try {
				Process p = builder.start();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		String statusSQL = "UPDATE lab SET STATUS =1 WHERE lab_code =  '" + labCode + "'";
		PreparedStatement ps2 = conn.prepareStatement(statusSQL);
		ps2.executeUpdate();
	}

}
