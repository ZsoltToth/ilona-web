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
	
	$("#mainpageLoginLoginBTN").click(function() {
		$("#errorContent").html("");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var rememberMe = document.getElementById("mainpageLoginRemeberMeCHB");
		var rememberMevalue = false;
		if(rememberMe.checked) {
			rememberMevalue = true;
		}
		$.ajax({
			async : true,
			type : "POST",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				username : $("#mainpageLoginUseridTXT").val(),
				password : $("#mainpageLoginPasswordTXT").val(),
				rememberme : rememberMevalue
			},
			url : "<c:url value='/tracking/processlogin'></c:url>",
			timeout : 10000,
			error : function(xhr, status, error) {
				$("#mainpageLoginErrorContent").html("Service error!");
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			}
		});
	});

	$("#mainpageLoginPasswordResetBTN").click(function() {
		$("#errorContent").html("");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
						
		$.ajax({
			async : true,
			type : "POST",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			url : "<c:url value='/tracking/resetpassword'></c:url>",
			data : {
				userid : $("#mainpageLoginResetPasswordTXT").val()
			},
			timeout : 10000,
			error : function(xhr, status, error) {
				$("#mainpageLoginPasswordResetErrorParagh").html("Service error!");
			},
			success : function(result, status, xhr) {
				//$("#page-wrapper").html(result);
				$("#mainpageLoginPasswordResetErrorParagh").html(result);
			}
		});
	});
	
</script>

<jsp:directive.include file="mainpageNavbar.jsp" />
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">ILONA - Tracking module login page!</h3>
				</div>
				<div class="panel-body">
											
						<p class="bg-primary" id="mainpageLoginErrorContent">
							<c:if test="${error != null}">
								Authentication failed, bad login data!
							</c:if>
						</p>
					
						<label for="mainpageLoginUseridTXT">Userid:</label>
							
						<input type="text"
							class="form-control"
							id="mainpageLoginUseridTXT"
							required="required"
							placeholder="Please type in your userid!"
							name="userid">  <br/>
							
						<label for="mainpageLoginPasswordTXT">Password:
							
						</label>
						
						<input type="password"
							class="form-control"
							id="mainpageLoginPasswordTXT"
							required="required"
							placeholder="Please type in your password!"
							name="password">  <br/>
							
					<label for="mainpageLoginRemeberMeCHB">Remember me:</label>
					 <input type="checkbox" 
						id="mainpageLoginRemeberMeCHB">
						
					<br />
					
					<input id="mainpageLoginLoginBTN"
						type="button"  
						value="Login">
							
				</div>
			</div>
			
			
		</div>
	</div> <!-- login content row div end -->
	
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">ILONA - Password reset!</h3>
				</div>
				<div class="panel-body">
	
					<label for="mainpageLoginResetPasswordTXT">Userid:						
					</label>
						
					<input type="text"
						class="form-control"
						id="mainpageLoginResetPasswordTXT"
						required="required"
						placeholder="Please type in your userid!"
						name="password">  <br/>
		
					<input type="button" 
						value="Password reset" 
						id="mainpageLoginPasswordResetBTN">
					<br /><br />	
					<p class="bg-primary" id="mainpageLoginPasswordResetErrorParagh"></p>		
				</div>
			</div>
		
		</div>
	</div> <!-- Password reset row end -->
	
</div> <!-- container fluid  end -->


