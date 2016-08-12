<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script type="text/javascript">
	
	$("#trackingLoginpageLoginbutton").click(function() {
		$("#errorContent").html("");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
						
		$.ajax({
			async : true,
			type : "POST",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				username : $("#trackingLoginpageUseridInput").val(),
				password : $("#trackingLoginpagePasswordInput").val()
			},
			url : "<c:url value='/tracking/processlogin'></c:url>",
			timeout : 10000,
			error : function(xhr, status, error) {
				$("#errorContent").html(xhr.responseText + status + error);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			}
		});
	});

	$("#trackingLoginpagePasswordReset").click(function() {
		$("#errorContent").html("");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
						
		$.ajax({
			async : true,
			type : "POST",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			url : "<c:url value='/tracking/passwordreset'></c:url>",
			timeout : 10000,
			error : function(xhr, status, error) {
				$("#errorContent").html(xhr.responseText + status + error);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			}
		});
	});
	
</script>

<jsp:directive.include file="mainpageNavbar.jsp" />

<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">ILONA - Tracking module login page!</h3>
		</div>
		<div class="panel-body">
			
				<label for="trackingLoginpageUseridInput">Userid:

				</label>
					
				<input type="text"
					class="form-control"
					id="trackingLoginpageUseridInput"
					required="required"
					placeholder="Please type in your userid!"
					maxlength="20"
					name="userid">  <br/>
					
				<label for="trackingLoginpagePasswordInput">Password:
					
				</label>
				
				<input type="password"
					class="form-control"
					id="trackingLoginpagePasswordInput"
					required="required"
					placeholder="Please type in your password!"
					maxlength="30"
					pattern="[a-zA-Z0-9,.-_?]{6,30}"
					name="password">  <br/>
			
			<input id="trackingLoginpageLoginbutton" type="button"  value="Login">
			<input type="button" value="Password reset" id="trackingLoginpagePasswordReset">			
		</div>
	</div>
	
	<div class="panel panel-body" id="trackingLoginpageErrorContent">
	
	</div>
</div>

<div class="row">
	<div class="col-lg-12" id="errorContent">
		<p>${error}</p>
	</div>
</div>



