<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<title>ILONA - Tracking admin page</title>

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
</head>
<!-- Main frame div -->
<div>
	<!-- Menu div part -->
	<div>
		<ul class="trackingTopMenuUL">
			<li class="trackingTopMenuLI"><a class="active" href="#home">List
					users</a></li>
			<li class="trackingTopMenuLI"><a href="" target="#contentDiv">Create
					user</a></li>
			<li class="trackingTopMenuLI"><a href="#contact">Menü 3</a></li>
			<li class="trackingTopMenuLI"><a href="#about">Menü 4</a></li>
		</ul>
		<input type="button" onclick="" class="btn">Gomb</input><br /> <
	</div>
	<!-- Content div part -->
	<div class="col-lg-12" id="contentDiv">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h1>Create user</h1>
				<br>
				<form action="<c:url value='/tracking/createuser'/>" method="POST">
					<input type="text" id="uncu" name="username" width="300">
					Username</input><br /> <input type="password" id="pwcu" name="password"
						width=300> Password</input><br /> <input type="checkbox" id=cbcu
						name="enabled"> Enabled</input><br />
						<input type="checkbox" id=cbcu
						name="isadmin"> IsAmin</input><br />
					<!-- Spring security CSRF protection part -->
					<input type="submit" name="submit">Create</input> <input
						type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</div>
			<div class="panel-body">dasdasdsa</div>
		</div>
	</div>
</div>

</html>