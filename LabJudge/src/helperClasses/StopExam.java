package helperClasses;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StopExam
 */
@WebServlet("/StopExam")
public class StopExam extends HttpServlet {
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
    public StopExam() {
        super();
        // TODO Auto-generated constructor stub
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
		Statement stmt;
		try {
			stmt = conn.createStatement();
			String sql = "SELECT * FROM  student WHERE labcode =  '" + labCode + "'";
			ResultSet rs = stmt.executeQuery(sql);
			PreparedStatement ps = conn.prepareStatement("INSERT into results (lab_code,usn,ques_no,ques_change,status) values (?,?,?,?,?)");
			while(rs.next())	{
				ps.setString(1, rs.getString("labcode"));
				ps.setString(2, rs.getString("usn"));
				ps.setInt(3, rs.getInt("ques_no"));
				ps.setInt(4, rs.getInt("ques_change"));
				ps.setInt(5, rs.getInt("status"));
				ps.executeUpdate();
			}
			sql = "DELETE FROM student WHERE labcode =  '" + labCode + "'";
			PreparedStatement ps1 = conn.prepareStatement(sql);
			ps1.executeUpdate();
			sql = "UPDATE lab SET status = 2 WHERE lab_code =  '" + labCode + "'";
			PreparedStatement ps2 = conn.prepareStatement(sql);
			ps2.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("adminMainPage.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	public void destroy()	{
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
