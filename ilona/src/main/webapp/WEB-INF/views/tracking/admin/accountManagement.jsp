<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script type="text/javascript">

	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();

	$("#accountUpdateDetails").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$("#accountDetailsErrors").html("");
		var hadError = 0;
		var errorText = "";
						
		var username = document.getElementById("adminUsername");	
		if (username.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid username!</p>";
			hadError = 1;
		}
				
		var email = document.getElementById("adminEmail");
		if(email.checkValidity()  == false) {
			errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
			hadError = 1;
		}

		if (Boolean(hadError) == true) {
			$("#accountDetailsErrors").html(errorText);
		} else {
			$.ajax({
				type : "POST",
				async : true,
				url : "<c:url value='/tracking/admin/accountchangedetails'></c:url>",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					userid : $("#adminUserid").val(),
					username : $("#adminUsername").val(),
					email : $("#adminEmail").val()
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#accountDetailsErrors").html("<p class='text-danger bg-primary'>An error occured!</p>");	
				}
			});
		}
		
	});
	
	$("#accountPasswordChange").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$("#accountPasswordErrors").html("");
		var hadError = 0;
		var errorText = "";
		var password1 = document.getElementById("accountPassword1");
		var password2 = document.getElementById("accountPassword2");
		
		if (password1.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid password!</p>";
			hadError = 1;
		}
		
		if ( password1.value != password2.value) {
			errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
			hadError = 1;
		}
		
		if(Boolean(hadError) == true) {
			$("#accountPasswordErrors").html(errorText);
		} else {
			$.ajax({
				type : "POST",
				async : true,
				url : "<c:url value='/tracking/admin/accountchangepassword'></c:url>",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					userid : $("#adminUserid").val(),
					password : $("#accountPassword1").val()
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#accountPasswordErrors").html("<p class='text-danger bg-primary'>An error occured!</p>");
				}
			});
		}
		
	});
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="col-lg-12">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h4><b>Account details change: ${successfulModification}</b></h4>
		</div>
		<div class="panel-body">
			<label for="adminUserid" id="adminUseridLabel">Userid: READONLY<span class="glyphicon glyphicon-exclamation-sign">
			</span></label>
			<input id="adminUserid"
				type="text" 
				readonly="readonly" 
				required="required"
				class="form-control"
				value="${useridValue}"><br/>
			
			<label for="adminUsername" id="adminUsernameLabel">Username:
				<span data-toggle="popover"
					data-html="true"
					data-trigger="hover"
					data-content="${usernameRestriction}"
					title="The username can contain the following elements:"
					class="fa  fa-info-circle">
				</span>
			</label>
			<input type="text" 
				id="adminUsername" 
				class="form-control"
				required="required"
				pattern="${usernamePattern}"
				value="${usernameValue}"><br />

			<label for="adminEmail" id="adminEmailLabel">Email address:
				<span data-toggle="popover"
					data-html="true"
					data-trigger="hover"
					data-content="${emailRestriction}"
					title="The email address can contain the following elements:"
					class="fa  fa-info-circle">
				</span>
			</label>
			<input type="text"
				id="adminEmail" 
				class="form-control" 
				required="required"
				value="${emailValue}"><br />
		
			<input type="button" id="accountUpdateDetails" class="btn btn-primary" value="Update account!"><br/>
					
		</div>
		
		<div class="panel-body" id="accountDetailsErrors">
			<c:forEach var="error" items="${changeDetailsErrors}">
				<p class='text-danger bg-primary'>${error}</p>
			</c:forEach>
		</div>
	</div>
		
	<div class="panel panel-danger">
		<div class="panel-heading">
			<h4><b>Account password change:</b></h4>
			
		</div>
		
		<div class="panel-body">
			<label for="accountPassword1" id="accountPassword1Label">Password:
				<span data-toggle="popover"
					data-html="true"
					data-trigger="hover"
					data-content="${passwordRestriction}"
					title="The email address can contain the following elements:"
					class="fa  fa-info-circle">
				</span>
			</label>
			<input type="password"
				id="accountPassword1"
				class="form-control"
				required="required"
				pattern="${passwordPattern}"
				name="password1"
				value=""><br />
			
			<input type="password"
				id="accountPassword2"
				required="required"
				class="form-control"
				name="password2"
				value=""><br />
			
			<input type="button" id="accountPasswordChange" class="btn btn-danger" value="Change password!">
		</div>
		
		<div class="panel-body" id="accountPasswordErrors">
			<c:forEach var="error" items="${passwordErrors}">
				<p class='text-danger bg-primary'>${error}</p>
			</c:forEach>
		</div>
	</div>
</div>
