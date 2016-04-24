package helperClasses;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.math.BigInteger;

public class AuthenticationHelper {
	// JDBC driver name and database URL
	   static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	   static final String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";

	   //  Database credentials
	   static final String USER = "root";
	   static final String PASS = "3070";
	   Connection conn;
	   public String user,session;
	   private SecureRandom random = new SecureRandom();
	   public AuthenticationHelper()	{
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
	   boolean authenticateAdmin(String username, String pass)	{
		   String sql = "SELECT * from admin";
			boolean flag = false;
			try {
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())	{
					if(rs.getString("user_name").equals(username))	{
						if(rs.getString("password").equals(pass))	{
							flag = true;
						}
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return flag;
	   }
	   boolean authenticateTeacher(String username, String pass)	{
		   String sql = "SELECT * from teacher";
			boolean flag = false;
			try {
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())	{
					if(rs.getString("user_name").equals(username))	{
						if(rs.getString("password").equals(pass))	{
							flag = true;
						}
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return flag;
	   }
	   String generateSession(String username)	{
		   String sessionId;
		   sessionId = new BigInteger(130, random).toString(32);
		   String sql = "INSERT into sessions (session_id,user_name) values ('"+sessionId+"','"+username+"')";
		   PreparedStatement ps;
			try {
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   return sessionId;
	   }
	   boolean isAuthentic(int status, String username, String pass)	{
		   switch(status)	{
		   case 1:return authenticateAdmin(username,pass);
		   case 2:return authenticateTeacher(username,pass);
		   }		   
		   return false;
	   }
	   public void setSessionId(String session)
		{
			this.session = session;
		}
	   public String getUser()
	   {
		   user = null;
			try {
			   Statement s = conn.createStatement();
			   String sql="select user_name from sessions where session_id = '"+session+"'";
			   ResultSet rs;
			   rs = s.executeQuery(sql);
			   System.out.println("finding user");
			   while(rs.next())
				   user = rs.getString("user_name");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return user;
	   }
	   public boolean logout(String sessionId)	{
		   String sql = "DELETE from sessions where session_id = '"+sessionId+"'";
		   try {
			PreparedStatement ps = conn.prepareStatement(sql);
			int num = ps.executeUpdate();
			if(num>0)
				return true;
			else
				return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		   
	   }
}
