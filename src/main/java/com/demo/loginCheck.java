package com.demo;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 * Servlet implementation class loginCheck
 */
@WebServlet("/loginCheck")
public class loginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	String emailID, password;
    
	/**
     * @see HttpServlet#HttpServlet()
     */
    public loginCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		emailID=request.getParameter("email");
		password=request.getParameter("password"); 
		
		
		try {  
		    Class.forName("com.mysql.jdbc.Driver");  
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmos?autoReconnect=true&useSSL=false", "test", "TEST");  
		    Statement stmt = con.createStatement();
		    
		    ResultSet rs = stmt.executeQuery("SELECT * FROM customer WHERE email='" + emailID + "'");
		    // Checks if the email is the same as the user input
		    while(rs.next()) {    
		        if(rs.getString("password").equals(password)) {  
		            HttpSession session = request.getSession();  
		            session.setAttribute("customer_id", rs.getInt("customer_id"));
		            RequestDispatcher rd = request.getRequestDispatcher("Welcome.jsp");  
		            rd.forward(request, response);  
		        } else {  
		            RequestDispatcher rd = request.getRequestDispatcher("loginError.html");  
		            rd.forward(request, response);  
		        }
		    }
		    
		    // If the loop completes without forwarding to Welcome.jsp, it means email was not found or password didn't match
		    if (!response.isCommitted()) {  
		        RequestDispatcher rd = request.getRequestDispatcher("loginError.html");  
		        rd.include(request, response);  
		    }
		    
		    con.close();  
		} catch(Exception e) {  
		    e.printStackTrace();  
		}

		
    }
}
