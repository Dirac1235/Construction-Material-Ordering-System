<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Checkout</title>
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

	<%@ page
		import="java.sql.*, java.util.Random, java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.util.HashMap"%>
	<%
	Connection con = null;
	PreparedStatement st = null;
	PreparedStatement st2 = null;
	Statement st3 = null;
	int orderId = new Random().nextInt(100000); // Generate a random order ID
	int customerId = (int) session.getAttribute("customer_id"); // Assuming customer ID is stored as an integer
	int totalbill = (int) session.getAttribute("totalbill"); // Assuming total bill is stored as an integer
	HashMap<Integer, Integer> hashMap2 = new HashMap<Integer, Integer>();
	LocalDateTime currentDateTime = LocalDateTime.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	String formattedTimestamp = currentDateTime.format(formatter);
	session.setAttribute("order_id", orderId);
	try {
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmos?autoReconnect=true&useSSL=false", "test",
		"TEST");
		st = con.prepareStatement("INSERT INTO orders VALUES (?, ?, ?, ?)");
		st2 = con.prepareStatement("Insert into cart values (?,?,?,?,?)");
		st3 = con.createStatement();

		st.setInt(1, orderId);
		st.setInt(2, customerId);
		st.setString(3, formattedTimestamp);
		st.setInt(4, totalbill);

		st.executeUpdate();
		HashMap<Integer, Integer> hashMap = (HashMap<Integer, Integer>) session.getAttribute("order_collection");

		for (Integer key : hashMap.keySet()) {
			ResultSet rs = st3.executeQuery("SELECT price FROM material WHERE material_id = " + key);
			int cart_id = new Random().nextInt(100000);
			int value = 0; // Default value
			if (rs.next()) {
		value = rs.getInt(1);
			}
			int quantity = hashMap.get(key);
			int total_price = value * quantity;
			System.out.println(key);
			st2.setInt(1, cart_id);
			st2.setInt(2, orderId);
			st2.setInt(3, key);
			st2.setInt(4, quantity);
			st2.setInt(5, total_price);

			st2.executeUpdate();

			session.setAttribute("order_collection", hashMap2);
		}
	%>

	<div class="card w-25 m-auto" style="width: 18rem;">
		<img src="CSS/success.png" class="card-img-top" alt="...">
		<div class="card-body">
			<h5 class="card-title">Successful</h5>
			<p class="card-text">
				Great! Your order with order_id
				<%=orderId%>
				has been confirmed.
			</p>
			<p>Thank you for ordering with us!</p>
			<a href="Welcome.jsp" class="btn btn-primary">Go Home</a>
		</div>
	</div>
	
	<%
	} catch (Exception e) {
	System.out.println(e);
	} finally {
	if (st != null) {
		st.close();
	}
	if (con != null) {
		con.close();
	}
	}
	%>

	
</body>
</html>
