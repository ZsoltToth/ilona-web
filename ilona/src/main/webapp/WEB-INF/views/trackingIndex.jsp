<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="false"%>


<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<title>Tracking logging page</title>
<link rel="stylesheet" href="css/trackingLoginScheme.css">
</head>
<body>

	<h1>Tracking Main Page!</h1>
	<br />
	<h2>Logging or registering</h2>
	<br />
	<p th:text>${message}</p>
	<c:url value="/login" var="loginUrl" />
	<form action="${loginUrl}" method="post">
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
	<p><a href="/trackingRegistration">Registration</a></p>
</body>
</html>
<!-- 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="/css/trackingLoginScheme.css">
        <title>Tracking main page</title>
    </head>
    <body>
        <form method="post" action="login.jsp">
            <center>
            <table border="1" width="30%" cellpadding="3">
                <thead>
                    <tr>
                        <th colspan="2">${message}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>User Name?!</td>
                        <td><input type="text" name="uname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Password?!</td>
                        <td><input type="password" name="pass" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Login" /></td>
                        <td><input type="reset" value="Reset" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">Regisztrálás esetén:?! <a href="trackingMain">Register??</a></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>
    </body>
</html>
-->
