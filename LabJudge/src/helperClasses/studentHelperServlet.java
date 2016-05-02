package helperClasses;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
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
	static String dataPath = System.getProperty("user.dir")+"/Documents/Programming/JavaProject/LabJudge/data/labs/";
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
		if(request.getParameter("chq").equals("1"))
		{
			try {
				changeQuestion(user);
				response.sendRedirect("studentStartExam.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(request.getParameter("chq").equals("2")){
		int status = 0;
		try {
			status = submitCode(user,request.getParameter("code"));
		} catch (SQLException | URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(status==1)	{
			
			try {
				PreparedStatement ps2 = conn.prepareStatement("UPDATE student set status=1 where usn='"+user+"'");
				ps2.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		response.sendRedirect("studentSubmissionResponse.jsp");
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
		String sql2 = "update student set ques_no = ?,ques_change = ques_change+1 where usn='"+usn+"'";
		PreparedStatement ps = conn.prepareStatement(sql2);
		ps.setInt(1, newqno);
		ps.executeUpdate();
	}
	private int submitCode(String usn, String code) throws SQLException, IOException, URISyntaxException	{
		Statement stmt = conn.createStatement();
		String labCode = "";
		int qno = 0;
		String sql = "select labcode, ques_no from student where usn='"+usn+"'";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next())	{
			labCode = rs.getString("labcode");
			qno = rs.getInt("ques_no");
		}
		URI uri = new URI("file:///"+dataPath+labCode+"/"+qno+"/submissions/" + usn + ".cpp");
		File sourceCode = new File(uri);
		//System.out.println("file: " + sourceCode.getAbsolutePath());
		if(!sourceCode.exists())
			sourceCode.createNewFile();
		
		FileWriter out = new FileWriter(sourceCode.getAbsolutePath());
		BufferedWriter bw = new BufferedWriter(out);
		bw.write(code);
		bw.close();
		//String command = "bash "+dataPath+"compile.sh "+usn+" "+labCode+" "+qno;
		//String command[] = {"bash",dataPath+"compile.sh ", usn, labCode, String.valueOf(qno)};
		ProcessBuilder builder = new ProcessBuilder("bash","compile.sh",usn,labCode,String.valueOf(qno));
		//ProcessBuilder builder = new ProcessBuilder("bash",dataPath+"compile.sh ",usn,labCode,String.valueOf(qno));
		Process p = builder.start();
		InputStream is = p.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
	    BufferedReader br = new BufferedReader(isr);
	    String line;
	    int status = 0;
	    while ((line = br.readLine()) != null) {
	    	//System.out.println(line);
	      status = Integer.parseInt(line);
	    }
	    return status;
	    
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
