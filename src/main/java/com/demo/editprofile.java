package com.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class editprofile
 */
@WebServlet("/editprofile")
public class editprofile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editprofile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    System.out.println("i was here");
		HttpSession session = request.getSession();
	    int id = (int) session.getAttribute("customer_id");
	    String name = request.getParameter("name");
	    String email = request.getParameter("email");
	    String address = request.getParameter("address");
	    String password = request.getParameter("password");
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        
	        
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmos", "test", "TEST");
	        
	        // Using a prepared statement to prevent SQL injection
	        PreparedStatement st = con.prepareStatement("UPDATE customer SET name = ?, email = ?, address = ?, password = ? WHERE customer_id = ?");
	        st.setString(1, name);
	        st.setString(2, email);
	        st.setString(3, address);
	        st.setString(4, password);
	        st.setInt(5, id);
	        
	        st.executeUpdate();
	        System.out.println("i have done it");
	        con.close();
	        response.sendRedirect("profile.jsp");
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	}


}
