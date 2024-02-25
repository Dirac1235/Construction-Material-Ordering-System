
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cart</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
</head>

<body>
	<nav id="navbar-example2"
		class="navbar bg-dark opacity-20 px-5 py-3 mb-4">
		<a class="navbar-brand text-light" href="Welcome.jsp">CMOS</a>
		<ul class="nav nav-pills">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle text-light"
				data-bs-toggle="dropdown" href="#" role="button"
				aria-expanded="false">Categories</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="#scrollspyHeading3">First</a></li>
					<li><a class="dropdown-item" href="#scrollspyHeading4">Second</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="#scrollspyHeading5">Third</a></li>
				</ul></li>
			<li class="nav-item  "><a class="nav-link text-light"
				href="cart.jsp">Cart</a></li>
			<li class="nav-item"><a class="nav-link text-light"
				href="profile.jsp">Profile</a></li>
			<li class="nav-item"><a class="nav-link text-light"
				href="logout.jsp">Logout</a></li>

		</ul>
	</nav>

	<%@ page import="java.sql.*, java.util.HashMap"%>
	<div class="container">
		<h1>Cart</h1>
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Item Name</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price per Quantity</th>
					<th scope="col">Sub Total</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<%
				HashMap<Integer, Integer> hashMap = (HashMap<Integer, Integer>) session.getAttribute("order_collection");
				int total = 0;
				Connection con = null;
				Statement st1 = null;
				ResultSet rs = null;
				try {
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmos?autoReconnect=true&useSSL=false", "test",
					"TEST");
					st1 = con.createStatement();
					if (hashMap != null) {
						for (Integer key : hashMap.keySet()) {
					int value = hashMap.get(key);
					rs = st1.executeQuery("select name, price, material_id from material where material_id = " + key);
					if (rs.next()) {
						total += value * rs.getInt(2);
				%>
				<tr>
					<th scope="row"><%=key%></th>
					<td><%=rs.getString(1)%></td>
					<td>
						<form action="UpdateQuantityServlet" method="post">
							<input type="hidden" name="material_id" value="<%=key%>">
							<input type="number" name="quantity" value="<%=value%>">
							<button type="submit" class="btn btn-sm btn-secondary">Update</button>
						</form>
					</td>
					<td><%=rs.getInt(2)%></td>
					<td><%=value * rs.getInt(2)%></td>
					<td><a href=<%="delete?id="+ rs.getInt(3) %> type="submit" class="btn btn-sm btn-danger">delete</a></td>
				</tr>
				<%
				}
				}
				}
				%>
				<tr>
					<th scope="row"></th>
					<td colspan="3">Total</td>
					<td><%=total%></td>
				</tr>
			</tbody>
		</table>
		<a type="button" class="btn btn-primary" href="Checkout.jsp">Place Order</a>
		<%
		session.setAttribute("totalbill", total);
		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		// Close resources in the finally block
		try {
			if (rs != null)
				rs.close();
			if (st1 != null)
				st1.close();
			if (con != null)
				con.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		}
		%>
	</div>
</body>
</html>




