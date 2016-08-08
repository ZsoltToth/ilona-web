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
	
	//$(document).ready(function() {
		/*
		 Popover and tooltip initialization in the page.
		 This two inicialization must be here, because the architect of the page.
		 If I put this in the main page, that initialization will not initialize the newest elements.
	    */
		$('[data-toggle="tooltip"]').tooltip();
		$('[data-toggle="popover"]').popover();

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
				url : $("#trackingLoginpageLoginform").attr('action'),
				timeout : 10000,
				error : function(xhr, status, error) {
					$("#errorContent").html(xhr.responseText + status + error);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				}
			});
		});
	//});

	
</script>

<jsp:directive.include file="mainpageNavbar.jsp" />

<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">ILONA - Tracking module login page!</h3>
		</div>
		<div class="panel-body">
			<form role="form" id="trackingLoginpageLoginform"
				action="<c:url value='/tracking/processlogin'></c:url>">
				
				<label for="trackingLoginpageUseridInput">Userid:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="<b>The userid maximum length is 20 characters!</b><br><br><b>The minimum length is 5 characters</b>
						<br><br>The userid must <b>start with</b> a letter <b>a-z or A-Z</b> <br><br> after that can contain the following symbols: a-z, A-Z, 0-9
						<br><br> Example: good: a11gbs111s bad: 1das2, because it starts with a number!"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text"
					class="form-control"
					id="trackingLoginpageUseridInput"
					required="required"
					placeholder="Please type in your userid!"
					maxlength="20"
					name="userid">
					
				<label for="trackingLoginpagePasswordInput">Password:
					<span data-toggle="popover"
						data-html="true" 
						data-trigger="hover"
						data-content="<b>The password maximum length is 30 characters!</b><br><br><b>The minimum length is 6 characters!</b>
						<br><br>The password can contain the following elements: <br><br>a-z A-Z ? ! . - _ "
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				
				<input type="password"
					class="form-control"
					id="trackingLoginpagePasswordInput"
					required="required"
					placeholder="Please type in your password!"
					maxlength="30"
					pattern="[a-zA-Z0-9,.-_?]{6,30}"
					name="password">
			</form>
			<button id="trackingLoginpageLoginbutton" type="button" class="btn">Login</button>			
		</div>
	</div>
	
	<div class="panel panel-default" id="trackingLoginpageErrorContent">
	
	</div>
</div>

<div class="row">
	<div class="col-lg-12" id="errorContent">
		<p>${error}</p>
	</div>
</div>



