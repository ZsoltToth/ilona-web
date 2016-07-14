<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<title>Create user</title>
<!-- Metadata part -->
<meta charset="UTF-8">
<meta name="description"
	content="University of Miskolc ILONA Indoor Positioning System.">
<meta name="keywords" content="HTML,CSS,XML,JavaScript, jsp, springmvc">
<meta name="author" content="Patryk / a5usl0">

<!--  CSS part -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Font-Awesome -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Metis Menu -->
<link href="css/metisMenu.min.css" rel="stylesheet" />
<!-- SB2 Admin css -->
<link href="css/sb-admin-2.css" rel="stylesheet" />
<link href="css/trackingDesign.css" rel="stylesheet" />

<!-- Javascript part -->
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/metisMenu.min.js"></script>
<script type="text/javascript" src="js/sb-admin-2.js"></script>

<script type="text/javascript">

	
	function addUser(){

	$.ajax(
	var formData = JSON.stringify($("#myForm").serializeArray());
	{
		type: "POST",
		datatype : 'JSON',
  	url: "/tracking/createuser",
	 data: JSON.stringify({ username: "Gerry", password: "dasdas", enabled: true }),
  contentType: 'application/json'
	}
	)
/*
	$.get(
			"addUser", 
			{
				username : $('input[name="username"]').val(),
				passwod : $('input[name="password"]').val(),
				enabeld : $('input[name="enabled"]').val()
			},
			function(data,status){;
			});
*/
}
</script>
</head>
<body>
	<div>
		<h1>Create user</h1>
		<br>
		<form action="<c:url value='/tracking/createuser'/>" method="POST" id="myForm">
			<input type="text" id="uncu" name="username" width="300">
			Username</input><br /> <input type="password" id="pwcu" name="password"
				width=300> Password</input><br /> <input type="checkbox" id=cbcu
				name="enabled"> Enabled</input><br /> <input type="checkbox"
				id=cbcu name="isadmin"> IsAmin</input><br />
			<!-- Spring security CSRF protection part -->
			<input type="submit" name="submit" onclick="addUser()">Create</input>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}">
		</form>
		<input type="button" onclick="addUser()">AA</input>
	</div>
</body>
</html>