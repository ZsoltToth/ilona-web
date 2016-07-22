<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<title>ILONA - Tracking Login Page</title>
<meta charset="UTF-8">
<meta name="description"
	content="University of Miskolc ILONA Indoor Positioning System.">
<meta name="keywords" content="HTML,CSS,XML,JavaScript, jsp, springmvc">
<meta name="author" content="Patryk / a5usl0">
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Font-Awesome -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Metis Menu -->
<link href="css/metisMenu.min.css" rel="stylesheet" />
<!-- SB2 Admin css -->
<link href="css/sb-admin-2.css" rel="stylesheet" />
</head>
<body>
	<div class="col-lg-12">
		<div class="panel panel-default"></div>
	</div>
	<h1></h1>
	<br />
	<h1>Tracking Login Page</h1><br />
	<c:url value='j_spring_security_logout' />
	<form action="<c:url value='j_spring_security_logout'/>">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<button type="submit" class="btn">Log in</button>
	</form>

	<c:url var="logoutUrl" value="/tracking/logout" />
	<form action="${logoutUrl}" method="post">
		<input type="submit" value="Log out" /> <input type="hidden"
			name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

	<a href=""<c:url value="/j_spring_security_logout" />">Kilepes</a>
</body>
</html>