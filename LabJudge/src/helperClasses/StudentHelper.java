package helperClasses;
import java.sql.*;
public class StudentHelper {
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";
	String USER = "root";
	String PASS = "3070";
	Connection conn;
	int qno = 0;
	String questionContent= "";
	long timeLeft = 0;
	boolean attempted = false;
	String usn = "";
	public StudentHelper()	{
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void setUSN(String usn)
	{
		this.usn = usn;
	}
	public void initiateExam() throws SQLException
	{
		Statement s = conn.createStatement();
		String sql = "select attempted from student where usn ='"+usn+"'";
		ResultSet rs = s.executeQuery(sql);
		while(rs.next())
		{
			if(!rs.getBoolean("attempted"))
			{
				PreparedStatement ps=conn.prepareStatement("update student set start_time = NOW() where usn='"+usn+"'");
				ps.executeUpdate();
			}
		}
	}
	
	public void setDetails() throws SQLException
	{
		Statement stmt = conn.createStatement();
		String sql1 = "SELECT student.labcode, student.ques_no, lab_questions.question_content,UNIX_TIMESTAMP(NOW())- UNIX_TIMESTAMP(student.start_time)as timeElapsed,lab.duration, student.attempted FROM student, lab, lab_questions WHERE student.usn = '1MS13IS001' AND student.labcode = lab.lab_code AND student.ques_no = lab_questions.question_num AND student.labcode = lab_questions.lab_code";
		ResultSet rs = stmt.executeQuery(sql1);
		while(rs.next())
		{
			questionContent = rs.getString("question_content");
			timeLeft = rs.getInt("duration") - rs.getInt("timeElapsed");
			qno = rs.getInt("ques_no");
		}
	}
	
	public int getQno()
	{
		return qno;
	}
	
	public String getQuestionContent()
	{
		return questionContent;
		
	}
	public long getTimeLeft()
	{
		return timeLeft;
	}

}
