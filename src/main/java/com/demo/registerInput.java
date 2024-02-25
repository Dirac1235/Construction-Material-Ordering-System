package com.demo;

import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class registerInput
 */
@WebServlet("/registerInput")

public class registerInput extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String name, address, email, password;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	public registerInput() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		name = request.getParameter("name");
		password = request.getParameter("password");
		address = request.getParameter("address");
		email = request.getParameter("email");

		response.setContentType("text/html");

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost:3306/cmos?autoReconnect=true&useSSL=false", "test", "TEST");

			PreparedStatement ps = con
					.prepareStatement("insert into customer (name, email, address, password) values(?,?,?,?)");

			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, address);
			ps.setString(4, password);

			int i = ps.executeUpdate();

			if (i > 0) {
				response.sendRedirect("index.html");
			}
		} catch (Exception e2) {
			System.out.println(e2);
		}

		out.close();
	}
}
