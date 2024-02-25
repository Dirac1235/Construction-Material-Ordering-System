<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
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
	<div class="container">
		<h1 class="mt-5">Edit Profile</h1>
		<form action="editprofile" method="post" class=" g-3">
			<div class="col-md-6 mt-4">
				<label for="name" class="form-label">Name</label> <input
					type="text" class="form-control" id="name" name="name">
			</div>
			<div class="col-md-6 mt-4">
				<label for="inputEmail4" class="form-label">Email</label> <input
					type="email" class="form-control" id="inputEmail4" name="email">
			</div>
			<div class="col-md-6 mt-4">
				<label for="inputPassword4" class="form-label">Password</label> <input
					type="password" class="form-control" id="inputPassword4" name="password">
			</div>
			<div class="col-md-6 mt-4">
				<label for="inputAddress" class="form-label">Address</label> <input
					type="text" class="form-control" id="inputAddress" name="address"
					>
			</div>
			<button type="submit" class="btn btn-primary mt-4 mb-4 ">Edit</button>
		</form>

	</div>
</body>
</html>