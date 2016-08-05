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

<jsp:directive.include file="mainpageNavbar.jsp" />

<script type="text/javascript">
	/*
	 * Popover and tooltip initialization.
	 * This two inicialization must be here, because the architect of the page.
	 * If I put this in the main page, that initialization will not initialize the newest elements.
	 */
	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();
	
	$("#btnUserCreation").click(function(event){
		event.preventDefault();
		$("#signupErrors").html("");
		var hadError = 0;
		
		var userid = document.getElementById("useridInput");	
		var errorText = "";
		if (userid.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid userid!</p>";
			
			hadError = 1;
		}
		
		var username = document.getElementById("usernameInput");	
		if (username.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid username!</p>";
			hadError = 1;
		}
		
		var password1 = document.getElementById("passwordInput1");
		var password2 = document.getElementById("passwordInput2");
		if (password1.checkValidity() == false) {
			errorText += "<p class='text-danger bg-primary'>Invalid password!</p>";
		}
		if ( password1.value != password2.value) {
			errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
		}
		
		var email = document.getElementById("emailInput");
		if(email.checkValidity()  == false) {
			errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
		}
		
		if (Boolean(hadError) == true) {
			$("#signupErrors").html(errorText);
		} else{
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				url : "?",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					userid : $("#useridInput").val(),
					username : $("#usernameInput").val(),
					password : $("#passwordInput1").val(),
					email : $("#emailInput").val(),
				},
				success : function(result, status, xhr) {
					
				},
				error : function(xhr, status, error) {
					
				}
			});
		}	
		//alert("OK!");
		
	});
</script>

<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">ILONA - Tracking module user sign up!</h3>
		</div>
		<div class="panel-body">
			
				
				<label for="useridInput">Userid: <br /> For more information:
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
					id="useridInput"
					required="required"
					placeholder="Please type in your userid!"
					maxlength="20"
					pattern="[a-zA-Z][a-zA-Z0-9]{4,19}"
					name="userid"> <br />
					
				<label for="usernameInput">Username: <br /> For more information:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="<b>The username maximum length is 20 characters!</b><br><br><b>The minimum length is 5 characters</b>
						<br><br>The userid must <b>start with</b> a letter <b>a-z or A-Z</b> <br><br> after that can contain the following symbols: a-z, A-Z, 0-9
						<br><br> and can contain special characters like á é ő ű ú ó ü ö"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text"
					class="form-control"
					id="usernameInput"
					required="required"
					placeholder="Please type in your username!"
					maxlength="30"
					name="userid" > <br />
					
				<label for="passwordInput1">Password: <br /> For more information:
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
					id="passwordInput1"
					required="required"
					placeholder="Please type in your password!"
					maxlength="30"
					pattern="[a-zA-Z0-9,.-_?]{6,30}"
					name="password"> <br />
					
				<input type="password"
					class="form-control"
					id="passwordInput2"
					required="required"
					placeholder="Please type in your password!"
					maxlength="30"
					pattern="[a-zA-Z0-9,.-_?]{6,30}"
					name="password"> <br />
					
				<label for="emailInput">Email address: <br /> For more information:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="The email address must be a valid address!"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text"
					class="form-control"
					id="emailInput"
					required="required"
					placeholder="Please type in your email address!"
					maxlength="100"
					name="userid">

			<button id="btnUserCreation" type="button" class="btn">Login</button>			
		</div>
	</div>
	
	<div class="panel panel-default" id="signupErrors">
	
	</div>
</div>