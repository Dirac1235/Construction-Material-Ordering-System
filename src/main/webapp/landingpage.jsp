
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Welcome</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="CSS/button.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link href="https://fonts.googleapis.com/css?family=Lobster"
	rel="stylesheet" type="text/css">


<style>
body {
	background-size: cover;
	/* Adjusts the size of the background image to cover the entire container */
	background-repeat: no-repeat;
	/* Ensures the background image is not repeated */
	background-position: center; /* Centers the background image */
}
</style>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<% try {
		 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmos", "test",
				"TEST");
    		Statement st = con.createStatement();
    		Statement st2 = con.createStatement();
    		Statement st4 = con.createStatement();
    		Statement st3 = con.createStatement();
    		ResultSet rs = st.executeQuery("select * from category");
    		ResultSet rs3 = st4.executeQuery("select * from category");
    		ResultSet rs4 = st3.executeQuery("select * from category");
   %>
	<nav id="navbar-example2"
		class="navbar bg-dark opacity-20 px-5 py-3 mb-4">
		<a class="navbar-brand text-light" href="Welcome.jsp">CMOS</a>
		<ul class="nav nav-pills">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle text-light"
				data-bs-toggle="dropdown" href="#" role="button"
				aria-expanded="false">Categories</a>
				<ul class="dropdown-menu">
					<%while(rs4.next()) { %>
					<li><a class="dropdown-item" href=<%=rs4.getString(2) %>><%=rs4.getString(2) %></a></li>
					<% } %>
				</ul></li>
			
			<li class="nav-item"><a class="nav-link text-light"
				href="index.html">Login</a></li>
			<li class="nav-item"><a class="nav-link text-light"
				href="Register.jsp">Sign Up</a></li>

		</ul>
	</nav>
	<div class="row ">
		<div class="col col-lg-2 ml-3">
			<h4 class="mt-5 border-bottom border-dark-subtle">Categories</h4>
			<ul class="list-group list-group-border-width-4 list-group-flush ">
				<%while(rs3.next()) { %>
					<li ><a class="list-group-item"href=<%="#" + rs3.getString(2)%>><%=rs3.getString(2)%></a></li>
				<% } %>
			</ul>
		</div>
		<div class="col ">
			<div class="container">
				<% while(rs.next()) { %>
				<h1 id=<%=rs.getString(2)%> class="border-bottom border-dark-subtle"><%=rs.getString(2)%></h1>
				<div class="row">
				<% ResultSet rs2 = st2.executeQuery("select material_id, name, description,image_url, price from material where category_id = " + rs.getInt(1));
					while(rs2.next())
					{
				%>
				
					<div class="col">
						<div class="card">
							<img src=<%=rs2.getString(4)%> class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title"><%=rs2.getString(2) %></h5>
								<p class="card-text"><%=rs2.getString(3) %></p>
								<p class="card-text">Price: <%=rs2.getInt(5) %></p>
								<a href="index.html"><button
										type="button" class="btn btn-primary">Add to cart</button> </a>
							</div>
						</div>
						
					</div>
					<% } %>
				</div>
				<% } %>
			</div>
		</div>
	</div>
	<% con.close(); } catch(Exception e){ System.out.println(e);}
	%>
</body>
</html>
