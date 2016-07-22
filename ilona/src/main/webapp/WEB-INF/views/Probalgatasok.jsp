<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<title>ILONA - Tracking dummy page</title>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
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
	function hiding() {
		$(this).hide();
	}
</script>
</head>
<body>
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
			<input type="button" id="" onclick="setEnabledValueToTrue()"
				class="btn">Gomb<br />
		</div>
		<!-- Content div part -->
		<div class="col-lg-12" id="contentDiv">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h1>Create user</h1>
					<br>
					<form action="<c:url value='/tracking/createuser'/>" method="POST"
						accept-charset="">
						<input type="text" id="uncu" name="userid" width="300"
							value="${userid}"> Userid <br /> <input type="text"
							name="username" value="${username}"> Username <br /> <input
							type="text" name="email" value="${email}"> email address<br />

						<input type="password" id="pwcu" name="password" width=300
							value="${password}"> password <br />

						<c:choose>
							<c:when test="${enabled == true}">
								<input type="checkbox" id="cbcu" name="enabled"
									checked="checked"> Enabled <br />
							</c:when>
							<c:otherwise>
								<input type="checkbox" id="cbcu" name="enabled"> Enabled<br />
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${accountNonExpired == true}">
								<input type="checkbox" id="cbcu" name="accountNonExpired"
									checked="checked"> AccountNonExpired<br />
							</c:when>
							<c:otherwise>
								<input type="checkbox" id="cbcu" name="accountNonExpired"> AccountNonExpired <br />
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${accountNonLocked == true}">
								<input type="checkbox" id="cbcu" name="accountNonLocked"
									checked="checked"> AccountNonLocked <br />
							</c:when>
							<c:otherwise>
								<input type="checkbox" id="cbcu" name="accountNonLocked"> AccountNonLocked <br />
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${credentialsNonExpired == true}">
								<input type="checkbox" id="cbcu" name="credentialsNonExpired"
									checked="checked"> CredentialsNonExpired <br />
							</c:when>
							<c:otherwise>
								<input type="checkbox" id="cbcu" name="credentialsNonExpired"> CredentialsNonExpired <br />
							</c:otherwise>
						</c:choose>

						<!-- Spring security CSRF protection part  accept-charset="ISO-8859-1"-->
						<input type="submit" name="submit">Create <input
							type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
					</form>

					<h2>User sending</h2>

					<form action="<c:url value='/tracking/probalgatasok'/>"
						method="POST" id="createUserForm" accept-charset="ISO-8859-1">
						<input type="text" id="uncu" name="userid" width="300"
							value="${userid}"> Userid <br /> <input type="text"
							name="username" value="${username}"> Username <br /> <input
							type="text" name="email" value="${email}"> email address<br />

						<input type="password" id="pwcu" name="password" width=300
							value="${password}"> password <br /> <input
							type="checkbox" id="cbcu" name="enabled" checked="checked">
						Enabled <br /> <input type="checkbox" id="cbcu"
							name="accountNonExpired" checked="checked">
						AccountNonExpired<br /> <input type="checkbox" id="cbcu"
							name="accountNonLocked" checked="checked">
						AccountNonLocked <br /> <input type="checkbox" id="cbcu"
							name="credentialsNonExpired" checked="checked">
						CredentialsNonExpired <br />

						<p>UserRoles</p>

						<input type="checkbox" name="roleadmin" value="ROLE_ADMIN">
						ROLE: ADMIN <br /> <input type="checkbox" name="roleuser"
							checked="checked"> ROLE: USER<br />
						<!-- Spring security CSRF protection part -->

						<input type="submit" name="submit" onclick="">Create <input
							type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
					</form>
					${kijelzes}
					
				</div>
				<div class="panel-body">dasdasdsa</div>
			</div>
		</div>
	</div>
</body>
</html>