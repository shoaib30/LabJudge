package helperClasses;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Authentication
 */
@WebServlet("/Authentication")
public class Authentication extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static AuthenticationHelper authenticator = new AuthenticationHelper();
	String SessionId;
	String UserName;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Authentication() {
        super();
        // TODO Auto-generated constructor stub
        
    }
    public void init(){
    	
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");
		int status = Integer.parseInt(request.getParameter("status"));
		//System.out.println("u:"+username+" p:"+pass+" s:"+status);
		if(authenticator.isAuthentic(status, username, pass)){
			Cookie c = new Cookie("sessionId", authenticator.generateSession(username));
			c.setMaxAge(60*60*3);
			response.addCookie(c);
			switch(status){
			case 1:response.sendRedirect("adminMainPage.jsp");
					break;
			case 2:response.sendRedirect("teacherMainPage.jsp");
					break;
			}
		}
		else
			response.sendRedirect("invalidCredentials.html");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
