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
	 * This two inicialization must be here, because the architect of the page.
	 * If I put this in the main page, that initialization will not initialize the newest elements.
	 */
	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();
	
	$("#btnUserCreation").click(function(event){
		event.preventDefault();
		$("#signupErrors").html("");
		var hadError = 0;
		var errorText = "";
		
		var userid = document.getElementById("useridInput");			
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
			hadError = 1;
		}
		if ( password1.value != password2.value) {
			errorText += "<p class='text-danger bg-primary'>Passwords don't match!</p>";
			hadError = 1;
		}
		
		var email = document.getElementById("emailInput");
		if(email.checkValidity()  == false) {
			errorText += "<p class='text-danger bg-primary'>Email address is invalid!</p>";
			hadError = 1;
		}
		
		if (Boolean(hadError) == true) {
			$("#signupErrors").html(errorText);
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
					userid : $("#useridInput").val(),
					username : $("#usernameInput").val(),
					password : $("#passwordInput1").val(),
					email : $("#emailInput").val(),
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#page-wrapper").html(xhr.responseText);
				}
			});
		}	
		//alert("OK!");
		
	});
</script>

<div class="col-lg-12">

	<jsp:directive.include file="mainpageNavbar.jsp" />
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">ILONA - Tracking module user sign up!</h3>
		</div>
		<div class="panel-body">
			
				
				<label for="useridInput">Userid: <br /> For more information:
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
					id="useridInput"
					required="required"
					placeholder="Please type in your userid!"
					maxlength="20"
					pattern="${useridPattern}"
					name="userid"> <br />
					
				<label for="usernameInput">Username: <br /> For more information:
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
					id="usernameInput"
					required="required"
					placeholder="Please type in your username!"
					maxlength="30"
					pattern="${usernamePattern}"
					name="username" > <br />
					
				<label for="passwordInput1">Password: <br /> For more information:
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
					id="passwordInput1"
					required="required"
					placeholder="Please type in your password!"
					maxlength="30"
					pattern="${passwordPattern}"
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
						data-content="${emailRestriction}"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="email"
					class="form-control"
					id="emailInput"
					required="required"
					placeholder="Please type in your email address!"
					maxlength="100"
					name="userid">

			<button id="btnUserCreation" type="button" class="btn">Login</button>
			
						
		</div>
		
		<div class="panel panel-default" id="signupErrors">
		<c:if test="${errors != null }">
			<c:forEach var="error" items="${errors}" >
				<p class='text-danger bg-primary'>${error}</p> <br/>
			</c:forEach>
		</c:if>
	</div>
	</div>
	
</div>