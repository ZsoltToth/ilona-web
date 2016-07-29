<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
		$('[data-toggle="popover"]').popover();
	});
		
</script>
</head>

<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">ILONA CREATE USER</h3>
		</div>

		<div class="panel-body">
			<form role="form" id="trackingAdminpageCreateuserForm"
				action='<c:url value='tracking/baseAuthenticate'></c:url>'>
				
				<label for="trackingAdminpageCreateUserUserid">Userid:
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
					id="trackingAdminpageCreateUserUserid"
					required="required"
					placeholder="Please type in the userid!"
					maxlength="20"
					pattern = "^[a-zA-Z]{1}[a-zA-Z0-9]{4,19}"
					name="userid">
					
				<label for="trackingAdminpageCreateUserUsername">Username:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="The username can contain the following elements:<br><br>a-z A-Z 0-9"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				
				<input type="text" 
					class="form-control"
					id="trackingAdminpageCreateUserUsername"
					required="required"
					placeholder="Please type in the username"
					maxlength="20"
					pattern="[a-zA-Z0-9]{0,30}"
					name="username">	
					
				<label for="trackingAdminpageCreateUserEmail">e-mail address:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="The email must be a valid email address.<br><br>Example:<br>- a2dsa.dasdas-dasdsa@dasdas.dasdasd.com"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				
				<input type="text" 
					class="form-control"
					id="trackingAdminpageCreateUserEmail"
					required="required"
					placeholder="Please type in the userid!"
					maxlength="20"
					name="email">		
					
				<label for="trackingAdminpageCreateUserPassword">Password:
					<span
						data-toggle="popover"
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
					id="trackingAdminpageCreateUserPassword"
					required="required"
					placeholder="Please type in the password!"
					maxlength="30"
					pattern="[a-zA-Z0-9,.-_?]{6,30}"
					name="password">
					
				<label for="trackingAdminpageCreateUserEnabled">Enabled:
					<span
						data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="If enabled is true, then the will be enabled in the system.<br><br>
						If the current value is false, then the current account will be disabled."
						class="fa  fa-info-circle">
					</span>
				</label><br>
					
				<input type="checkbox" 
					class="form-control-left"
					id="trackingAdminpageCreateUserEnabled"
					name="password" checked="checked">
					
			</form>
			<button id="trackingLoginpageLoginbutton" type="button" class="btn">Login</button>
		</div>
	</div>
</div>
