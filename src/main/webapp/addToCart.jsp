<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add to cart</title>
</head>
<body>
	<%@ page
		import="java.sql.*, java.util.Random, java.util.HashMap, java.util.ArrayList"%>

	<%
	String input = request.getParameter("p");
	HashMap<Integer, Integer> hashMap;
	int selectedID = 0;

	if (session.getAttribute("order_collection") == null) {
		hashMap = new HashMap<>();
	}
	else{
		 hashMap = (HashMap<Integer, Integer>) session.getAttribute("order_collection");
	}

	try {
		selectedID = Integer.parseInt(input);
	} catch (NumberFormatException ex) {
		System.err.println("Illegal input");
	}
	if (hashMap.containsKey(selectedID)) {
		// Key exists, increment value by 1
		hashMap.put(selectedID, hashMap.get(selectedID) + 1);
	} else {
		// Key doesn't exist, put key with value 1
		hashMap.put(selectedID, 1);
	}
	session.setAttribute("order_collection", hashMap);
	response.sendRedirect("Welcome.jsp");
	%>


</body>
</html>
