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

	var adminAccManSavedUsername = $("#adminAccManUsernameTXT").val();
	var adminAccManSavedEmail = $("#adminAccManEmailTXT").val();
	
	$("#accountUpdateDetails").click(function(event){
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			$("#adminAccManAccountDetailsChangeResultDIV").html("");
			var hadError = 0;
			var errorText = "";
							
			var username = document.getElementById("adminAccManUsernameTXT");	
			if (username.checkValidity() == false) {
				errorText += "<p class='text-danger bg-primary'>Invalid username!</p>";
				hadError = 1;
			}
					
			var email = document.getElementById("adminAccManEmailTXT");
			if(email.checkValidity()  == false) {
				errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
				hadError = 1;
			}
	
			if (Boolean(hadError) == true) {
				$("#adminAccManUsernameTXT").val(adminAccManSavedUsername);
				$("#adminAccManEmailTXT").val(adminAccManSavedEmail);
				$("#adminAccManAccountDetailsChangeResultDIV").html(errorText);
			} else {
				$.ajax({
					type : "POST",
					async : true,
					url : "<c:url value='/tracking/admin/accountchangedetails'></c:url>",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					data : {
						userid : $("#adminAccManUseridTXT").val(),
						username : username.value,
						email : email.value
					},
					success : function(result, status, xhr) {
						if(result.executionState == true) {
							$("#adminAccManAccountDetailsChangeResultDIV")
								.html("<p class='text-danger bg-primary'>The password has been changed!</p>");
						} else {
							$("#adminAccManUsernameTXT").val(adminAccManSavedUsername);
							$("#adminAccManEmailTXT").val(adminAccManSavedEmail);
							var i = 0;
							var messages = result.messages;
							var length = messages.length;
							var resultText = "";
							for(i; i < length; i++) {
								resultText += "<p class='text-danger bg-primary'>" + messages[i] + "</p>"
							}				
							$("#adminAccManAccountDetailsChangeResultDIV").html(resultText);
						}
					},
					error : function(xhr, status, error) {
						try {
							$("#adminAccManAccountDetailsChangeResultDIV")
								.html("<p class='text-danger bg-primary'>An error occured!</p>");	
						} catch(err) {
							console.log(err);
						}
					}
				});
			}
		} catch(err) {
			console.log(err);
		}	
	});
	
	$("#adminAccManPasswordChangeBTN").click(function(event){
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			$("#adminAccManPasswordChangeResultDIV").html("");
			var hadError = 0;
			var errorText = "";
			var password1 = document.getElementById("adminAccManPasswordChange1TXT");
			var password2 = document.getElementById("adminAccManPasswordChange1TXT");
			
			if (password1.checkValidity() == false) {
				errorText += "<p class='text-danger bg-primary'>Invalid password!</p>";
				hadError = 1;
			}
			
			if ( password1.value != password2.value) {
				errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
				hadError = 1;
			}
			
			if(Boolean(hadError) == true) {
				$("#adminAccManPasswordChange1TXT").val("");
				$("#adminAccManPasswordChange2TXT").val("");
				$("#adminAccManPasswordChangeResultDIV").html(errorText);
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
						password : $("#adminAccManPasswordChange1TXT").val()
					},
					success : function(result, status, xhr) {
						try {
							if(result.executionState == true) {
								$("#adminAccManPasswordChange1TXT").val("");
								$("#adminAccManPasswordChange2TXT").val("");
								$("#adminAccManPasswordChangeResultDIV")
									.html("<p class='text-danger bg-primary'>The password has been changed!</p>");
							} else {
								$("#adminAccManPasswordChange1TXT").val("");
								$("#adminAccManPasswordChange2TXT").val("");
								var i = 0;
								var messages = result.messages;
								var length = messages.length;
								var resultText = "";
								for(i; i < length; i++) {
									resultText += "<p class='text-danger bg-primary'>" + messages[i] + "</p>"
								}				
								$("#adminAccManPasswordChangeResultDIV").html(resultText);
							}
						} catch(err) {
							console.log(err);
						}
					},
					error : function(xhr, status, error) {
						$("#adminAccManPasswordChangeResultDIV").html("<p class='text-danger bg-primary'>An error occured!</p>");
					}
				});
			}
		} catch(err) {
			console.log(err);
		}
	});
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4><b>Account details change:</b></h4>
				</div>
				<div class="panel-body">
					<label for="adminAccManUseridTXT">Userid: READONLY<span class="glyphicon glyphicon-exclamation-sign">
					</span></label>
					<input id="adminAccManUseridTXT"
						type="text" 
						readonly="readonly" 
						required="required"
						class="form-control"
						value="${useridValue}"><br/>
					
					<label for="adminAccManUsernameTXT">Username: <br />
						<a href="#adminAccManUsernameDropdown" 
							data-toggle="collapse">Click for more information:
						</a>
						<span data-toggle="popover"
							data-html="true"
							data-trigger="hover"
							data-content="${usernameRestriction}"
							title="The username can contain the following elements:"
							class="fa  fa-info-circle">
						</span>
					</label>
					<p id="adminAccManUsernameDropdown" class="collapse">
						${usernameRestriction}
					</p>
					
					<input type="text" 
						id="adminAccManUsernameTXT" 
						class="form-control"
						required="required"
						pattern="${usernamePattern}"
						value="${usernameValue}"><br />
		
					<label for="adminAccManEmailTXT">Email address:<br />
						<a href="#adminAccManEmailDropdown" 
							data-toggle="collapse">Click for more information:
						</a>
						<span data-toggle="popover"
							data-html="true"
							data-trigger="hover"
							data-content="${emailRestriction}"
							title="The email address can contain the following elements:"
							class="fa  fa-info-circle">
						</span>
					</label>
					<p id="adminAccManEmailDropdown" class="collapse">
						${emailRestriction}
					</p>
					
					<input type="email"
						id="adminAccManEmailTXT" 
						class="form-control" 
						required="required"
						value="${emailValue}"><br />
				
					<input type="button" id="accountUpdateDetails" class="btn btn-primary" value="Update account!"><br/>
							
				</div>
				
				<div class="panel-body" id="adminAccManAccountDetailsChangeResultDIV">
					
				</div>
			</div>
				
			<div class="panel panel-danger">
				<div class="panel-heading">
					<h4><b>Account password change:</b></h4>					
				</div>
				
				<div class="panel-body">
					<label for="adminAccManPasswordChange1TXT">Password: <br/>
						<a href="#adminAccManPasswordDropdown" 
							data-toggle="collapse">Click for more information:
						</a>
						<span data-toggle="popover"
							data-html="true"
							data-trigger="hover"
							data-content="${passwordRestriction}"
							title="The email address can contain the following elements:"
							class="fa  fa-info-circle">
						</span>
					</label>
					<p id="adminAccManPasswordDropdown" class="collapse">
						${passwordRestriction}
					</p>
					
					<input type="password"
						id="adminAccManPasswordChange1TXT"
						class="form-control"
						required="required"
						pattern="${passwordPattern}"
						name="password1"
						placeholder="Please type in the new password!"
						value=""><br />
					
					<input type="password"
						id="adminAccManPasswordChange2TXT"
						required="required"
						class="form-control"
						name="password2"
						placeholder="Please type in the new password again!"
						value=""><br />
					
					<input type="button" id="adminAccManPasswordChangeBTN" class="btn btn-danger" value="Change password!">
				</div>
				
				<div class="panel-body" id="adminAccManPasswordChangeResultDIV">
				
				</div>
			</div>
		</div> <!-- col-lg-12 end -->
	</div> <!-- row end -->
</div> <!-- container fluid end -->
