import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
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
	   private SecureRandom random = new SecureRandom();
	   AuthenticationHelper()	{
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
					if(rs.getString(3).equals(username))	{
						if(rs.getString(4).equals(pass))	{
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
		   String SessionId;
		   SessionId = new BigInteger(130, random).toString(32);
		   return SessionId;
	   }
	   boolean isAuthentic(int status, String username, String pass)	{
		   if(status == 1)	{
			   return authenticateAdmin(username,pass);
		   }
		   return false;
	   }
}
