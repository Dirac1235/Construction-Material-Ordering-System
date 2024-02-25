<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.util.Random, java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
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
	<div class="container ml-auto ">
		<h1 class="mb-4">Profile</h1>
		<ul class="nav nav-pills mb-3 border-bottom border-dark-subtle p-2"
			id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active text-dark" id="pills-home-tab"
					data-bs-toggle="pill" data-bs-target="#pills-home" type="button"
					role="tab" aria-controls="pills-home" aria-selected="true">Personal
					Information</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link text-dark" id="pills-profile-tab"
					data-bs-toggle="pill" data-bs-target="#pills-profile" type="button"
					role="tab" aria-controls="pills-profile" aria-selected="false">History</button>
			</li>

		</ul>
		<div class="tab-content" id="pills-tabContent">

			<%
			Connection con = null;
			Statement st = null;
			Statement st2 = null;
			Statement st3 = null;
			int customerId = (int) session.getAttribute("customer_id");

			try {
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmos?autoReconnect=true&useSSL=false",
				"test", "TEST");
				st = con.createStatement();
				st2 = con.createStatement();
				st3 = con.createStatement();
				ResultSet rs = st.executeQuery("select * from customer where customer_id = " + customerId);
				if (rs.next()){
			%>
			<div class="tab-pane fade show active" id="pills-home"
				role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
				<table class="table table-hover mt-4">
					<tbody>
						<tr>
							<td>Id :</td>
							<td><%=customerId%></td>
						</tr>
						<tr>
							<td>Name :</td>
							<td><%=rs.getString(2)%></td>
						</tr>
						<tr>
							<td>Email :</td>
							<td><%=rs.getString(3)%></td>
						</tr>
						<tr>
							<td>Address :</td>
							<td><%=rs.getString(5)%></td>
						</tr>
					</tbody>
				</table>
				<a href="editprofile.jsp" type="button" class="btn btn-primary">Edit Profile</a>
			</div>
			<div class="tab-pane fade" id="pills-profile" role="tabpanel"
				aria-labelledby="pills-profile-tab" tabindex="0">
				<h1>Order History</h1>
			<%
				}
			ResultSet rs2 = st2.executeQuery("select order_id, order_date from orders where customer_id = " + customerId);
			while (rs2.next()) {
				int total = 0;
				int orderId = rs2.getInt(1);
				String orderDate = rs2.getString(2);
			%>
			
				<table class="table mt-4">
					<thead class="text-dark border-top border-bottom border-dark table-group-divider">
						<tr>
							<td>Order Id: <%=orderId%></td>
							<td colspan="2">Order Date: <%=orderDate%></td>
						</tr>
					</thead>
					<thead>
						<tr>
							<th scope="col">Item Name</th>
							<th scope="col">Quantity</th>
							<th scope="col">Sub Total</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
					<%
					ResultSet rs3 = st3.executeQuery(
						    "SELECT o.order_id, o.order_date, m.name, c.quantity, m.price " +
						    "FROM cart c " +
						    "INNER JOIN orders o ON c.order_id = o.order_id " +
						    "INNER JOIN material m ON c.material_id = m.material_id " +
						    "INNER JOIN ( " +
						    
						    "    SELECT order_id" +
						    "    FROM cart c " +
						    "    INNER JOIN material m ON c.material_id = m.material_id " +
						    "    WHERE c.order_id = " + orderId + " " +
						    "    GROUP BY order_id " +
						    ") oi ON oi.order_id = o.order_id"
						);


					while (rs3.next()) {
						
						total += rs3.getInt(4) * rs3.getInt(5);
						System.out.println(rs3.getString(3));
					%>
					
						<tr>
							<td><%=rs3.getString(3)%></td>
							<td><%=rs3.getInt(4)%></td>
							<td><%=rs3.getInt(4) * rs3.getInt(5)%></td>
						</tr>
					
					<%
					}
					%>
					</tbody>
					<tbody>
						<tr>
							<th scope="row"></th>
							<td colspan="1">Total</td>
							<td><%=total%></td>
						</tr>
					</tbody>
				</table>
			
			<%
			}
			con.close();
			} catch (Exception e) {
			System.out.println(e);
			}
			%>
			</div>
		</div>


	</div>
</body>
</html>