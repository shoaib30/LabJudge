<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*" %>
<%
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	String DB_URL = "jdbc:mysql://localhost:3306/lab_judge";
	String USER = "root";
	String PASS = "3070";
	Connection conn;
	Class.forName(JDBC_DRIVER);
	conn = DriverManager.getConnection(DB_URL,USER,PASS);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Lab Judge</title>
<script type="text/javascript">
	function printPage()
	{
		window.print();
	}
</script>
</head>
<body>
	<table>
		<%
			Statement stmt = conn.createStatement();
			String sql = "select usn,pass from student where labcode = '"+request.getParameter("labCode")+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				String usn = rs.getString("usn");
				String pass = rs.getString("pass");
		%>
			<tr>
				<td><%=usn %></td>
				<td><%=pass %></td>
			</tr>
		<%
			}
		%>
	</table>
	<button id="print" onclick ="printPage()">Print List</button>
</body>
</html>