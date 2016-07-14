<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="false"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<title>ILONA Tracking login page</title>
<meta charset="UTF-8">
<meta name="description" content="University of Miskolc ILONA Indoor Positioning System.">
<meta name="keywords" content="HTML,CSS,XML,JavaScript, jsp, springmvc">
<meta name="author" content="Patryk / a5usl0">
<link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>

	<h1>ILONA Tracking module login page</h1>
	<br />
	<h2>Logging or registering</h2>
	<br />
	<p th:text>${message}</p>
	<c:url value="" var="loginUrl" />
	<form action="<c:url value='/login'/>" method="post">
		<c:if test="${param.error != null}">
			<p>Invalid username and password.</p>
		</c:if>
		<c:if test="${param.logout != null}">
			<p>You have been logged out.</p>
		</c:if>
		<p>
			<label for="username">Username</label> <input type="text"
				id="username" name="username" />
		</p>
		<p>
			<label for="password">Password</label> <input type="password"
				id="password" name="password" />
		</p>
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<button type="submit" class="btn">Log in</button>
	</form>
	<p>
		<a href="tracking/registration" target="_self">Registration</a>
	</p>
</body>
</html>
