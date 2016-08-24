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
		$("#adminUserCreationError").html("");
		var hadError = 0;
		var errorText = "";
		
		var userid = document.getElementById("adminCreateUserUseridTXT");			
		if (userid.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid userid!</p>";		
			hadError = 1;
		}
		
		var username = document.getElementById("adminCreateUserUsernameTXT");	
		if (username.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid username!</p>";
			hadError = 1;
		}
		
		var password1 = document.getElementById("adminCreateUserPassword1TXT");
		var password2 = document.getElementById("adminCreateUserPassword1TXT");
		if (password1.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid password!</p>";
			hadError = 1;
		}
		if ( password1.value != password2.value) {
			errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
			hadError = 1;
		}
		
		var email = document.getElementById("adminCreateUserEmailTXT");
		if(email.checkValidity()  == false) {
			errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
			hadError = 1;
		}
		if (Boolean(hadError) == true) {
			$("#adminUserCreationError").html(errorText);
		} else {
			
			var enabled = false;
			var admin = false;
			var UserEnabled = document.getElementById('creationIsUserEnabled');
			var AdminRole = document.getElementById('creationIsAdmin');
			if(UserEnabled.checked) {
				enabled = true;
			}
			if(AdminRole.checked) {
				admin = true;
			}
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				url : "<c:url value='tracking/admin/registeruser'></c:url>",
				data : {
					userid : userid.value,
					username : username.value,
					email : email.value,
					password : password1.value,
					enabled : enabled,
					adminRole : admin
				},
				success : function(result, status, xhr) {
					try {
						if(result.executionState == true) {
							$("#adminUserCreationError").html("<p class='text-danger bg-primary'>The account has been created!</p>");
							$("#adminCreateUserUseridTXT").val("");
							$("#adminCreateUserUsernameTXT").val("");
							$("#adminCreateUserEmailTXT").val("");
							$("#adminCreateUserPassword1TXT").val("");
						} else {
							$("#adminCreateUserUseridTXT").val("");
							$("#adminCreateUserUsernameTXT").val("");
							$("#adminCreateUserEmailTXT").val("");
							$("#adminCreateUserPassword1TXT").val("");
							var i = 0;
							var errorMessage = "";
							var messages = result.messages;
							var length = messages.length;
							for(i; i < length; i++) {
								errorMessage += "<p class='text-danger bg-primary'>" + messages[i] + "</p>"
							}
							$("#adminUserCreationError").html(errorMessage);
						}
					} catch(err) {
						console.log(err);
					}
					
					
				},
				error : function(xhr, status, error) {
					try {
						$("#adminUserCreationError")
							.html("<p class='text-danger bg-primary'>An error occured!</p>");
					} catch(err) {
						console.log(err);
					}
				},
				timeout : 10000
			});
		}	
		
		
	});
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">ILONA CREATE USER</h3>
				</div>	
				<div class="panel-body">
						<div id="adminUserCreationError">					
						</div>	
											
						<label for="adminCreateUserUseridTXT">Userid: <br />
							<a href="#adminCreateUserUseridDropdown" 
								data-toggle="collapse">Click for more information:
							</a>
							<span data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${useridRestriction}"
								title="The userid pattern can contain the following elements:"
								class="fa  fa-info-circle">
							</span>
						</label>
						<p id="adminCreateUserUseridDropdown" class="collapse">
							${useridRestriction}
						</p>
							
						<input type="text" 
							class="form-control"
							id="adminCreateUserUseridTXT"
							required="required"
							placeholder="Please type in the userid!"
							pattern = "${useridPattern}"
							name="userid"><br />
							
						<label for="adminCreateUserUsernameTXT">Username: <br />
							<a href="#adminCreateUserUsernameDropdown" 
								data-toggle="collapse">Click for more information:
							</a>
							<span
								data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${usernameRestriction}"
								title="The userid pattern can contain the following elements:"
								class="fa  fa-info-circle">
							</span>
						</label>
						<p id="adminCreateUserUsernameDropdown" class="collapse">
							${usernameRestriction}
						</p>
						
						<input type="text" 
							class="form-control"
							id="adminCreateUserUsernameTXT"
							required="required"
							placeholder="Please type in the username!"
							pattern="${usernamePattern}"
							name="username"><br />	
							
						<label for="adminCreateUserEmailTXT">Email address: <br />
							<a href="#adminCreateUserEmailDropdown" 
								data-toggle="collapse">Click for more information:
							</a>
							<span
								data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${emailRestriction}"
								class="fa  fa-info-circle">
							</span>
						</label>
						<p id="adminCreateUserEmailDropdown" class="collapse">
							${emailRestriction}
						</p>		
						
						<input type="email" 
							class="form-control"
							id="adminCreateUserEmailTXT"
							required="required"
							placeholder="Please type in the email address!"
							name="email"><br />		
							
						<label for="adminCreateUserPassword1TXT">Password: <br />
							<a href="#adminCreateUserPasswordDropdown" 
								data-toggle="collapse">Click for more information:
							</a>
							<span
								data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${passwordRestriction}"
								class="fa  fa-info-circle">
							</span>
						</label>
						<p id="adminCreateUserPasswordDropdown" class="collapse">
							${passwordRestriction}
						</p>
							
						<input type="password" 
							class="form-control"
							id="adminCreateUserPassword1TXT"
							required="required"
							placeholder="Please type in the password!"
							pattern="${passwordPattern}"
							name="password"> <br />
							
						<input type="password" 
							class="form-control"
							id="adminCreateUserPassword2TXT"
							required="required"
							placeholder="Please type in the password again!"
							pattern="${passwordPattern}"
							name="password"> <br />
							
						<label for="creationIsUserEnabled">Enabled: <br />
							<a href="#adminCreateUserEnabledDropdown" 
								data-toggle="collapse">Click for more information:
							</a>
							<span
								data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${enabledRestriction}"
								class="fa  fa-info-circle">
							</span>
						</label>
						<p id="adminCreateUserEnabledDropdown" class="collapse">
							${enabledRestriction}
						</p>
						<br>
							
						<input type="checkbox" 
							class="form-control-left"
							id="creationIsUserEnabled"
							name="enabled" checked="checked"><br /><br />
							
						<label for="creationIsAdmin">Admin role: <br />
							<a href="#adminCreateUserAdminRoleDropdown" 
								data-toggle="collapse">Click for more information:
							</a>
							<span
								data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${userRoleRestriction}"
								class="fa  fa-info-circle">
							</span>
						</label>
						<p id="adminCreateUserAdminRoleDropdown" class="collapse">
							${userRoleRestriction}
						</p>
						<br>
							
						<input type="checkbox" 
							class="form-control-left"
							id="creationIsAdmin"
							name="adminRole"><br/><br/>
		
					<input type="button" id="createUserButton" class="btn btn-primary" value="CreateUser">
				</div>			
			</div>
		</div>
	</div>
</div>