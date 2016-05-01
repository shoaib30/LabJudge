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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class studentHelperServlet
 */
@WebServlet("/studentHelperServlet")
public class studentHelperServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";

	   //  Database credentials
	static final String USER = "root";
	static final String PASS = "3070";
	   Connection conn;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public studentHelperServlet() {
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
			AuthenticationHelper userAuthentication = new AuthenticationHelper();
			if (sessionCookie != null) {
				//System.out.println("Cookie:"+sessionCookie.getValue());
				userAuthentication.setSessionId(sessionCookie.getValue());
				user = userAuthentication.getUser();
				} else {
				//System.out.println("no cookie found");
				response.sendRedirect("index.jsp");
				}
			} else
				response.sendRedirect("index.jsp");
		if(!request.getParameter("chq").isEmpty())
		{
			try {
				changeQuestion(user);
				response.sendRedirect("studentStartExam.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		

	}
	protected int findNumQues(String labCode) throws SQLException	{
		String sql = "SELECT COUNT( * ) AS questions FROM lab_questions WHERE lab_code =  '" + labCode + "'";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next())
			return rs.getInt("questions");
		return 0;
	}
	private void changeQuestion(String usn) throws SQLException	{
		Statement stmt = conn.createStatement();
		String labCode = "";
		String sql = "select labcode from student where usn='"+usn+"'";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next())
		{
			labCode = rs.getString("labcode");
		}
		Random r =new Random();
		int newqno = r.nextInt(findNumQues(labCode))+1;
		String sql2 = "update student set ques_no = ?,ques_change = ques_change+1 ";
		PreparedStatement ps = conn.prepareStatement(sql2);
		ps.setInt(1, newqno);
		ps.executeUpdate();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
