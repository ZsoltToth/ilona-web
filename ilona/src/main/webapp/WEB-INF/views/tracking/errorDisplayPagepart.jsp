<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">ERRORS</h3>
		</div>
		<div class="panel-body">
			<c:forEach var="error" items="${errors}">
				<input type="text"
					class="form-control" name="name" value="${error}"></input>
				<br />
			</c:forEach>
		</div>

	</div>
</div>

