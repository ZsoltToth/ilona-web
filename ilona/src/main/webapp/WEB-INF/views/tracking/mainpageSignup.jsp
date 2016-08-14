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
	/*
	 * Popover and tooltip initialization.
	 * This two inicializations must be here, because the architect of the page.
	 * If I put this in the main page, that initialization will not initialize the newest elements.
	 */
	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();
	
	$("#mainpageSignupRegistrationBTN").click(function(event){
		event.preventDefault();
		/*
		 * Clear the error div.
		 */
		$("#mainpageSignupErrorDIV").html("");
		
		/*
		 * Validity checking.
		 */
		var hadError = 0;
		var errorText = "";
		
		var userid = document.getElementById("mainpageSignupUseridTXT");			
		if (userid.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid userid!</p>";
			
			hadError = 1;
		}
		
		var username = document.getElementById("mainpageSignupUsernameTXT");	
		if (username.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid username!</p>";
			hadError = 1;
		}
		
		var password1 = document.getElementById("mainpageSignupPassword1TXT");
		var password2 = document.getElementById("mainpageSignupPassword2TXT");
		if (password1.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid password!</p>";
			hadError = 1;
		}
		if ( password1.value != password2.value) {
			errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
			hadError = 1;
		}
		
		var email = document.getElementById("mainpageSignupEmailTXT");
		if(email.checkValidity()  == false) {
			errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
			hadError = 1;
		}
		
		/*
		 * Bad validity.
		 */
		if (Boolean(hadError) == true) {
			$("#mainpageSignupErrorDIV").html(errorText);
			/*
			 * After good validity.
			 */
		} else{
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				url : "<c:url value='/tracking/registeruser'></c:url>",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					userid : $("#mainpageSignupUseridTXT").val(),
					username : $("#mainpageSignupUsernameTXT").val(),
					password : $("#mainpageSignupPassword1TXT").val(),
					email : $("#mainpageSignupEmailTXT").val(),
				},
				success : function(result, status, xhr) {
					$("#mainpageSignupUseridTXT").val("");
					$("#mainpageSignupUsernameTXT").val("");
					$("#mainpageSignupPassword1TXT").val("");
					$("#mainpageSignupPassword2TXT").val("");
					$("#mainpageSignupEmailTXT").val("");				
					var resultText = "";
					for(var i = 0; i < result.length; i++) {						
						resultText+= "<p class='bg-primary'>" + result[i] +"</p>"
					}
					$("#mainpageSignupErrorDIV").html(resultText);

				},
				error : function(xhr, status, error) {
					$("#mainpageSignupUseridTXT").val("");
					$("#mainpageSignupUsernameTXT").val("");
					$("#mainpageSignupPassword1TXT").val("");
					$("#mainpageSignupPassword1TXT").val("");
					$("#mainpageSignupEmailTXT").val("");
					$("#mainpageSignupErrorDIV").
					html("<p class='bg-primary'>There has been an error with the service!</p>");
				}
			});
		}			
	});
</script>

<jsp:directive.include file="mainpageNavbar.jsp" />

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">		
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">ILONA - Tracking module user sign up!</h3>
				</div>
				<div class="panel-body">
						<div id="mainpageSignupErrorDIV">
							
						</div>				
						<label for="mainpageSignupUseridTXT">Userid: <br /> For more information:
							<span data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${useridRestriction}"
								title="The userid can contain the following elements:"
								class="fa  fa-info-circle">
							</span>
						</label>
							
						<input type="text"
							class="form-control"
							id="mainpageSignupUseridTXT"
							required="required"
							placeholder="Please type in your userid!"
							pattern="${useridPattern}"
							name="userid"> <br />
							
						<label for="mainpageSignupUsernameTXT">Username: <br /> For more information:
							<span data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${usernameRestriction}"
								title="The username can contain the following elements:"
								class="fa  fa-info-circle">
							</span>
						</label>
							
						<input type="text"
							class="form-control"
							id="mainpageSignupUsernameTXT"
							required="required"
							placeholder="Please type in your username!"
							pattern="${usernamePattern}"
							name="username" > <br />
							
						<label for="mainpageSignupPassword1TXT">Password: <br /> For more information:
							<span data-toggle="popover"
								data-html="true" 
								data-trigger="hover"
								data-content="${passwordRestriction}"
								title="The userid pattern can contain the following elements:"
								class="fa  fa-info-circle">
							</span>
						</label>
						
						<input type="password"
							class="form-control"
							id="mainpageSignupPassword1TXT"
							required="required"
							placeholder="Please type in your password!"
							pattern="${passwordPattern}"
							name="password"> <br />
							
						<input type="password"
							class="form-control"
							id="mainpageSignupPassword2TXT"
							required="required"
							placeholder="Please type in your password!"
							pattern="[a-zA-Z0-9,.-_?]{6,30}"
							name="password"> <br />
							
						<label for="mainpageSignupEmailTXT">Email address: <br /> For more information:
							<span data-toggle="popover"
								data-html="true"
								data-trigger="hover"
								data-content="${emailRestriction}"
								class="fa  fa-info-circle">
							</span>
						</label>
							
						<input type="email"
							class="form-control"
							id="mainpageSignupEmailTXT"
							required="required"
							placeholder="Please type in your email address!"
							name="userid"><br />
		
					<button id="mainpageSignupRegistrationBTN" type="button" class="btn">Register</button>
							
				</div>	<!-- panel body end -->							
			</div> <!-- panel default end -->
		</div> <!-- col-12 end -->
	</div> <!-- Row end -->
</div> <!-- container fluid end -->