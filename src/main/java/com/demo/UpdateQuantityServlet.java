package com.demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * Servlet implementation class UpdateQuantityServlet
 */
@WebServlet("/UpdateQuantityServlet")
public class UpdateQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateQuantityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    HashMap<Integer, Integer> hashMap = (HashMap<Integer, Integer>) session.getAttribute("order_collection");
	    
	    // Retrieve parameters sent from the form
	    int Id = Integer.parseInt(request.getParameter("material_id"));
	    int quantity = Integer.parseInt(request.getParameter("quantity"));
	    
	    // Update the quantity in the session HashMap
	    if (hashMap != null) {
	        hashMap.put(Id, quantity);
	        session.setAttribute("order_collection", hashMap);
	    }
	    
	    // Redirect back to the shopping cart page
	    response.sendRedirect("cart.jsp");
	}


}
