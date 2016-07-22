<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="false"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--  CSS part -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Font-Awesome -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Metis Menu -->
<link href="css/metisMenu.min.css" rel="stylesheet" />
<!-- SB2 Admin css -->
<link href="css/sb-admin-2.css" rel="stylesheet" />

<!-- Javascript part -->
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/metisMenu.min.js"></script>
<script type="text/javascript" src="js/sb-admin-2.js"></script>

<title>Tracking Login Page</title>
</head>

<body>
	<h1>Login page!</h1>
	<form action="<c:url value='/tracking/logindecision'/>" method="post" accept-charset="ISO-8859-1">
		<input type="text" name="username">Username <br /> <input
			type="text" name="password">Password <br /> <input
			type="submit" name="submit">Login <input type="hidden"
			name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</body>
</html>