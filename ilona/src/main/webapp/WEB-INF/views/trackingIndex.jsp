<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="false"%>
<%@ page isELIgnored="false"%>


<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script type="text/javascript">
	$(document).ready(function() {
		$("#send").click(function(event) {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					username : $("#username11").val(),
					password : $("#password11").val(),
				},
				url : "<c:url value='/login'/>",
				success : function(result, status, xhr) {

					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					alert("hiba!!" + error + status);
				}
			});
		});
	});
</script>

<div>
	<h1>ILONA Tracking module login page</h1>
	<br />
	<h2>Logging or registering</h2>
	<br />
	<c:url value="" var="loginUrl" />
	<form action="<c:url value='/login'/>" method="post" id="form1">
		<c:if test="${param.error != null}">
			<p>Invalid username and password.</p>
		</c:if>
		<c:if test="${param.logout != null}">
			<p>You have been logged out.</p>
		</c:if>
		<p>
			<label for="username">Username</label> <input type="text"
				id="username11" name="username" />
		</p>
		<p>
			<label for="password">Password</label> <input type="password"
				id="password11" name="password" />
		</p>
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />

	</form>

	<input type="button" id="send" class="btn" width="300" height="100">LOGIN
	<p>
		<a href="tracking/registration" target="_self">Registration</a>
	</p>
</div>
