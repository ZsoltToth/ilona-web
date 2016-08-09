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
	
	$("#createUserButton").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$("#adminUserCreationError").html("");
		var hadError = 0;
		var errorText = "";
		
		var userid = document.getElementById("creationUserid");			
		if (userid.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid userid!</p>";		
			hadError = 1;
		}
		
		var username = document.getElementById("creationUsername");	
		if (username.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid username!</p>";
			hadError = 1;
		}
		
		var password1 = document.getElementById("creationPassword1");
		var password2 = document.getElementById("creationPassword2");
		if (password1.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid password!</p>";
			hadError = 1;
		}
		if ( password1.value != password2.value) {
			errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
			hadError = 1;
		}
		
		var email = document.getElementById("creationEmail");
		if(email.checkValidity()  == false) {
			errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
			hadError = 1;
		}
		if (Boolean(hadError) == true) {
			$("#adminUserCreationError").html(errorText);
		} else {
			
			var enabled1 = false;
			var admin1 = false;
			var UserEnabled = document.getElementById('creationIsUserEnabled');
			var AdminRole = document.getElementById('creationIsAdmin');
			if(UserEnabled.checked) {
				enabled1 = true;
			}
			if(AdminRole.checkek) {
				admin1 = true;
			}
			
			$.ajax({
				async : true,
				type : "POST",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				url : "<c:url value='tracking/admin/registeruser'></c:url>",
				data : {
					userid : $("#creationUserid").val(),
					username : $("#creationUsername").val(),
					email : $("#creationEmail").val(),
					password : $("#creationPassword1").val(),
					enabled : enabled1.toString(),
					adminRole : admin1.toString()
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#adminUserCreationError").html("<p class='text-danger bg-primary'>An error occured!</p>" + status + error);
				},
				timeout : 10000
			});
		}	
		
		
	});
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">ILONA CREATE USER</h3>
		</div>

		<div class="panel-body">
				
				<label for="creationUserid">Userid:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text" 
					class="form-control"
					id="creationUserid"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />
					
				<label for="creationUsername">Username:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${usernameRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				
				<input type="text" 
					class="form-control"
					id="creationUsername"
					required="required"
					placeholder="Please type in the username"
					pattern="${usernamePattern}"
					name="username"><br />	
					
				<label for="creationEmail">Email address:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${emailRestriction}"
						class="fa  fa-info-circle">
					</span>
				</label>
				
				<input type="text" 
					class="form-control"
					id="creationEmail"
					required="required"
					placeholder="Please type in the email address!"
					name="email"><br />		
					
				<label for="creationPassword1">Password:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${passwordRestriction}"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="password" 
					class="form-control"
					id="creationPassword1"
					required="required"
					placeholder="Please type in the password!"
					pattern="${passwordPattern}"
					name="password"> <br />
					
				<input type="password" 
					class="form-control"
					id="creationPassword2"
					required="required"
					placeholder="Please type in the password!"
					pattern="${passwordPattern}"
					name="password"> <br />
					
				<label for="creationIsUserEnabled">Enabled:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${enabledRestriction}"
						class="fa  fa-info-circle">
					</span>
				</label><br>
					
				<input type="checkbox" 
					class="form-control-left"
					id="creationIsUserEnabled"
					name="enabled" checked="checked"><br /><br />
					
				<label for="creationIsAdmin">Admin role:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${userRoleRestriction}"
						class="fa  fa-info-circle">
					</span>
				</label><br>
					
				<input type="checkbox" 
					class="form-control-left"
					id="creationIsAdmin"
					name="adminRole"><br/><br/>

			<input type="button" id="createUserButton" class="btn btn-primary" value="CreateUser">
		</div>
		
		<div class="panel-body" id="adminUserCreationError">
			<c:forEach var="error" items="${validityErrors}">
				<p class='text-danger bg-primary'>${error}</p>
			</c:forEach>
		</div>
	</div>
</div>
