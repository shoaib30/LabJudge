<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<style>
	th,td {
		padding:10px;
	}
</style>
</head>
<body>
	<table  border="true">
		<tr>
			<th>USN</th>
			<th>Question Number</th>
			<th>Number of changes</th>
			<th>Output</th>
		</tr>
		<%
			Statement stmt = conn.createStatement();
			String sql = "select usn,ques_no,ques_change,status from student where labcode = '"+request.getParameter("labCode")+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				String usn = rs.getString("usn");
				int ques_no = rs.getInt("ques_no");
				int ques_change = rs.getInt("ques_change");
				int status = rs.getInt("status");
		%>
			<tr>
				<td><%=usn %></td>
				<td><%=ques_no %></td>
				<td><%=ques_no %></td>
				<td><% switch(status) {
				case 2:out.println("NO");break;
				case 1:out.println("YES");break;
				}
				%></td>
			</tr>
		<%
			}
		%>
	</table>
	<button id="print" onclick ="printPage()">Print List</button>
</body>
</html>