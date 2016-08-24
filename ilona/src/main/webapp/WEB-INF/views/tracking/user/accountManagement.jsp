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

	var userAccManSavedUsername = $("#userAccManUsernameTXT").val();
	var userAccManSavedEmail = $("#userAccManEmailTXT").val();

	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();

	$("#userAccManUpdateDetailsBTN").click(function(event){
		try {
			event.preventDefault();
			/*
			 * get CSTF Token
			 */
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			/*
			 * Validity 
			 */
			$("#userAccManUpdateDetailsErrorDIV").html("");
			$("#userAccManUserChangeErrorSpan").html("");
			var hadError = 0;
			var errorText = "";
			
			var username = document.getElementById("userAccManUsernameTXT");	
			if (username.checkValidity() == false) {
				errorText += "<p class='text-danger bg-primary'>Invalid username!</p>";
				hadError = 1;
			}
					
			var email = document.getElementById("userAccManEmailTXT");
			if(email.checkValidity()  == false) {
				errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
				hadError = 1;
			}
			
			if (Boolean(hadError) == true) {
				$("#userAccManUsernameTXT").val(userAccManSavedUsername);
				$("#userAccManEmailTXT").val(userAccManSavedEmail);
				$("#userAccManUpdateDetailsErrorDIV").html(errorText);
			} else {
				$.ajax({
					type : "POST",
					async : true,
					url : "<c:url value='/tracking/user/accountmanagement/changeuserdetails'></c:url>",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					data : {
						userid : $("#userAccManUseridTXT").val(),
						username : $("#userAccManUsernameTXT").val(),
						email : $("#userAccManEmailTXT").val()
					},
					success : function(result, status, xhr) {
						try {
							if(result.executionState == true) {							
								$("#userAccManUpdateDetailsErrorDIV")
									.html("<p class='text-danger bg-primary'>Account updated successfully!</p>");
								userAccManSavedUsername = $("#userAccManUsernameTXT").val();
								userAccManSavedEmail = $("#userAccManEmailTXT").val();
							} else {
								var i = 0;
								var messages = result.messages;
								var length = messages.length;						
								var errorMessages = "";
								for(i; i < length; i++) {
									errorMessages += "<p class='text-danger bg-primary'>" + messages[i] + "</p>";
								}							
								$("#userAccManUpdateDetailsErrorDIV").html(errorMessages);
							}
						} catch(err) {
							console.log(err);
						}
						
						/*
						 * Write the response JSON into the text fields.
						 */
						
						
					},
					error : function(xhr, status, error) {
						try {
							$("#userAccManUsernameTXT").val(userAccManSavedUsername);
							$("#userAccManEmailTXT").val(userAccManSavedEmail);						
							$("#userAccManUpdateDetailsErrorDIV").html("<p class='text-danger bg-primary'>Tracking service is offline!</p>");
						} catch(err) {
							console.log(err);
						}					
					}
				});
			}
		} catch(err) {
			try {
				$("#userAccManUpdateDetailsErrorDIV").html("<p class='text-danger bg-primary'>Service error!</p>");
			} catch(error) {
				console.log(error);
			}
		}
	});
	
	$("#userAccManChangePasswordBTN").click(function(event){
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			$("#userAccManChangePasswordErrorsDIV").html("");
			var hadError = 0;
			var errorText = "";
			var password1 = document.getElementById("userAccManPassword1TXT");
			var password2 = document.getElementById("userAccManPassword2TXT");
			
			if (password1.checkValidity() == false) {
				errorText += "<p class='text-danger bg-primary'>Invalid password!</p>";
				hadError = 1;
			}
			
			if ( password1.value != password2.value) {
				errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
				hadError = 1;
			}
	
			if(Boolean(hadError) == true) {
				$("#userAccManChangePasswordErrorsDIV").html(errorText);
			} else {
				$.ajax({
					type : "POST",
					async : true,
					url : "<c:url value='/tracking/user/accountmanagement/changepassword'></c:url>",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					data : {
						userid : $("#userAccManUseridTXT").val(),
						password : $("#userAccManPassword1TXT").val()
					},
					success : function(result, status, xhr) {
						var ResultText = "";
						for(var i = 0; i < result.length; i++) {
							ResultText += "<p class='text-danger bg-primary'>" + result[i] + "</p>";
						}
						$("#userAccManChangePasswordErrorsDIV").html(ResultText);
					},
					error : function(xhr, status, error) {
						$("#userAccManChangePasswordErrorsDIV").html("<p class='text-danger bg-primary'>Tracking service error!</p>"+error);
					}
				});
			}
		} catch(err) {
			try {
				$("#userAccManChangePasswordErrorsDIV").html("<p class='text-danger bg-primary'>Tracking service error!</p>"+error);
			} catch(error) {
				console.log(error);
			}
		}
	});
</script>

<jsp:directive.include file="userNavbar.jsp" />

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4><b>Account details change:</b></h4>
				</div>
				<div class="panel-body">
					<label for="userAccManUseridTXT"id="userAccManUseridTXTLabel">
						 Userid: READONLY
						 <span class="glyphicon glyphicon-exclamation-sign">
						</span>
					</label>
					<input id="userAccManUseridTXT"
						type="text" 
						readonly="readonly" 
						required="required"
						class="form-control"
						value="${useridValue}"><br/>
					
					<label for="userAccManUsernameTXT" id="userAccManUsernameTXTLabel">Username: <br />
						<a href="#userAccManUsernameDropdown" 
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
					<p id="userAccManUsernameDropdown" class="collapse">
						${usernameRestriction}
					</p>
					
					<input type="text" 
						id="userAccManUsernameTXT" 
						class="form-control"
						required="required"
						pattern="${usernamePattern}"
						value="${usernameValue}"><br />
		
					<label for="userAccManEmailTXT" id="userAccManEmailTXTLabel">
						Email address: <br />
						<a href="#userAccManEmailDropdown" 
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
					<p id="userAccManEmailDropdown" class="collapse">
						${emailRestriction}
					</p>
					
					<input type="email"
						id="userAccManEmailTXT" 
						class="form-control" 
						required="required"
						value="${emailValue}"><br />
				
					<input type="button" 
						id="userAccManUpdateDetailsBTN" 
						class="btn btn-primary" 
						value="Update account!"><br/>
							
				</div>
				
				<div class="panel-body" id="userAccManUpdateDetailsErrorDIV">
					
				</div>
			</div> <!-- panel primary basic details end -->
				
			<div class="panel panel-danger">
				<div class="panel-heading">
					<h4><b>Account password change:</b></h4>
					
				</div>
				
				<div class="panel-body">
					<label for="userAccManPassword1TXT" id="userAccManPassword1TXTLabel">
						Password: <br />
						<a href="#userAccManPasswordDropdown" 
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
					<p id="userAccManPasswordDropdown" class="collapse">
						${passwordRestriction}
					</p>
					
					<input type="password"
						id="userAccManPassword1TXT"
						class="form-control"
						required="required"
						pattern="${passwordPattern}"
						name="userAccManPassword1TXTName"
						value="">
					<br />
					
					<input type="password"
						id="userAccManPassword2TXT"
						required="required"
						class="form-control"
						name="userAccManPassword2TXTName"
						value="">
					<br />
					
					<input type="button" 
						id="userAccManChangePasswordBTN" 
						class="btn btn-danger" 
						value="Change password!">
				</div>
				
				<div class="panel-body" id="userAccManChangePasswordErrorsDIV">
					
				</div>
			</div> <!-- panel danger account password end -->
		</div> <!-- colg 12 end -->
	</div> <!-- row end -->
</div><!-- container end -->