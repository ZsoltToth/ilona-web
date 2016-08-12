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
		
	$("#adminUserModUpdateUserDetailsBTN").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var enabledCB = document.getElementById("adminUserModEnabledCheckbox");
		var adminRoleCB = document.getElementById("adminUserModAdminRoleCheckbox");
		
		var isEnabled = false;
		var hasAdminRole = false;
		
		if(enabledCB.checked) {
			isEnabled = true;
		}
		
		if(adminRoleCB.checked) {
			hasAdminRole = true;
		}
		
		$.ajax({
			type : "POST",
			async : true,
			url : "<c:url value='/tracking/admin/usermodchangeaccountdetails'></c:url>",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#adminUserModUseridHidden").val(),
				username : $("#adminUserModUsernameTXT").val(),
				email : $("#adminUserModEmailTXT").val(),
				enabled : isEnabled,
				adminRole : hasAdminRole
			},
			success : function(result, status, xhr) {
				alert("success!");
			},
			error : function(xhr, status, error) {
				alert("error!"+status+error);
			}
		});
	});
	
	$("#adminUserModManautomaticPasswordResetBTN").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "POST",
			async : true,
			url : "<c:url value='/tracking/admin/automatedpasswordreset'></c:url>",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#adminUserModUseridHidden").val()
			},
			success : function(result, status, xhr) {
				alert("success!");
			},
			error : function(xhr, status, error) {
				alert("error!"+status+error);
			}
		});
	});
	
	$("#adminUserModManualPasswordChangeBTN").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		//password validity check!
		
		$.ajax({
			type :"POST",
			async : true,
			url : "<c:url value='/tracking/admin/usermodmanualpasswordchange'></c:url>",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#adminUserModUseridHidden").val(),
				password : $("#adminUserModPassword1TXT").val()
			},
			success : function(result, status, xhr) {
				$("#adminUserModManualPasswordChangeResponseParagh").html(result);
				$("#adminUserModPassword1TXT").val("");
				$("#adminUserModPassword2TXT").val("");
			},
			error : function(xhr, status, error) {
				$("#adminUserModManualPasswordChangeResponseParagh").html("Error :'(");
				$("#adminUserModPassword1TXT").val("");
				$("#adminUserModPassword2TXT").val("");
			}
		});
	});
	
	$("#adminUserModResetAccountExpirationBTN").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#adminUserModUseridHidden").val()
			},
			url : "<c:url value='/tracking/admin/usermodresetaccountexpiration'></c:url>",
			success : function(result, status, xhr) {
				$("#adminUserModLastLoginDateParagh").html("Last login date: " + new Date(result));
			},
			error : function(xhr, status, error) {
				alert("error!"+status+error);
			}		 
		});
	});
	
	$("#adminUserModResetPasswordExpirationBTN").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#adminUserModUseridHidden").val()
			},
			url : "<c:url value='/tracking/admin/usermodresetpasswordexpiration'></c:url>",
			success : function(result, status, xhr) {
				$("#adminUserManPasswordValidUntilParagh").html("Account valid until: " + new Date(result));
				$("#id001test").html("<p class='text-success'>The current password is not expired!</p>");
				$("#adminUserManResetPasswordExpirationResultParagh").html("Successful modification!");
				
			},
			error : function(xhr, status, error) {
				alert("error!"+status+error);
			}		 
		});
	});
	
	$("#adminUserManLoginAttemptsClearBTN").click(function(event){
		event.preventDefault();
		var attempts = document.getElementById("adminUserManLoginAttemptsSelect");
		while(attempts.length != 0) {
			attempts.remove(0);
		}
	});
	
	$("#adminUserManLoginAttemptsDeleteSelectedBTN").click(function(event){
		event.preventDefault();
		var attempts = document.getElementById("adminUserManLoginAttemptsSelect");
		var selected = 1;
		var maxlimit =attempts.length * attempts.length;
		while(selected != 0 || maxlimit == 0) {
			selected = 0;
			for(var i = 0; i < attempts.length; i++) {
				if(attempts[i].selected) {
					attempts.remove(i);
					selected++;
				}
			}
			maxlimit--;
		}
	});
	
	$("#adminUserManLoginAttemptsConfirmChangesBTN").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var attempts = document.getElementById("adminUserManLoginAttemptsSelect");
		var attemptArray = [];
		for (var i = 0; i < attempts.length; i++) {
			attemptArray[i] = attempts[i].value;
		}	

		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#adminUserModUseridHidden").val(),
				attempts : attemptArray
			},
			url : "<c:url value='/tracking/admin/usermodupdateloginattempts'></c:url>",
			success : function(result, status, xhr) {
				alert("success!");
				
			},
			error : function(xhr, status, error) {
				alert("error!"+status+error);
			}		 
		});
	});
	
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="row">
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				User base details:
			</div>
			<div class="panel-body">
				<label for="adminUserModUseridTXT">Userid:
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
					id="adminUserModUseridTXT"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"
					value="${Userid}"><br />
					
				<input type="hidden" id="adminUserModUseridHidden" value="${Userid}">
					
				<label for="adminUserModUsernameTXT">Username:
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
					id="adminUserModUsernameTXT"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"
					value="${Username}"><br />
					
				<label for="adminUserModEmailTXT">Email address:
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
					id="adminUserModEmailTXT"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"
					value="${Email}"><br />
				
				<label for="adminUserModEnabledCheckbox">Enabled:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"				
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label> <br />
					
				<input type="checkbox" 
					id="adminUserModEnabledCheckbox"
					required="required"
					${Enabled}
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />
				
				<label for="adminUserModAdminRoleCheckbox">Admin role:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						${Enabled}
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label> <br />
				
				<input type="checkbox" 
					id="adminUserModAdminRoleCheckbox"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"
					${IsAdmin}><br /><br />
					
				<input type="button" class="btn btn-default" value="Update account details!" id="adminUserModUpdateUserDetailsBTN"><br /><br /><br />
					<c:choose >
							<c:when test="${AccountExpiration == 'ERROR'}">
								<p class="text-danger">The current account is expired!</p>
							
							</c:when>
							<c:otherwise>
								<p class="text-success">The current account is not expired!</p>
							</c:otherwise>
						</c:choose>
					
					<p id ="adminUserModLastLoginDateParagh">Last login date: ${lastLoginDate}</p><br />
				<input type="button" class="btn btn-default" value="Reset account expiration!" id="adminUserModResetAccountExpirationBTN"><br />
						
			</div>
		</div>
	</div>
	
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				User password change:
			</div>
			<div class="panel-body">
				<label for="creationUserid">Password:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="password" 
					class="form-control"
					id="adminUserModPassword1TXT"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="password1"><br />			
					
				<input type="password" 
					class="form-control"
					id="adminUserModPassword2TXT"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="password2"><br />
					
				<input type="button" value="Change password!" id="adminUserModManualPasswordChangeBTN">
				<input type="button" value="Generate and send password!" id="adminUserModManautomaticPasswordResetBTN">
				<p id="adminUserModManualPasswordChangeResponseParagh"></p><br />
				<p><b>Account expiration details:</b></p>
				<div id="id001test">
				<c:choose>
					<c:when test="${passwordExpiration == 'ERROR'}">
						<p class="text-danger">The current password is expired!</p>
					</c:when>
					<c:otherwise>
						<p class="text-success">The current password is not expired!</p>
					</c:otherwise> 				
				</c:choose>
				</div>	
				<p id="adminUserManPasswordValidUntilParagh">Account valid until: ${passwordValidUntil}</p>
				<br />
				<input type="button" value="Reset password expiration!" id="adminUserModResetPasswordExpirationBTN">
				<p id="adminUserManResetPasswordExpirationResultParagh"></p>
				
			</div>
		</div>
	</div>
	
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				Account locked details:
			</div>
			<div class="panel-body">
				<p>Bad login attempts: (Hold ctrl to select more!)</p>
				<select multiple class="form-control" id="adminUserManLoginAttemptsSelect" size="15">
       				<c:forEach items="${loginAttempts}" var="attempt">
       					<option value="${attempt.formatMilliseconds}">${attempt.formatDate}</option>
       				</c:forEach>
      			</select> <br />		
      			<input type="button" value="Clear all!" id="adminUserManLoginAttemptsClearBTN"> 
      			<input type="button" value="Clear selected!" id="adminUserManLoginAttemptsDeleteSelectedBTN"> 
      			<input type="button" value="Confirm changes!" id="adminUserManLoginAttemptsConfirmChangesBTN">		
			</div>
		</div>
	</div>
</div>
