<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page session="true"%>
<%@ page isELIgnored="true"%>

<script type="text/javascript">
	
	function proba() {
		alert("dasdasddsads");
	}
	/*
		Popover and tooltip initialization in the page.
		This two inicialization must be here, because the architect of the page.
	 */
	

	function loginFormValidate() {
		return true;
	};

	function sendDataa() {
		alert("dsdasdas");
		$.get($("#loginForm").attr('value'),
			{
				userid: ${'#loginUserid'}.val(),
				password: ${'#loginUserid'}.val()		
			}, function(data){
				$('#page-wrapper').html(data);
			});	
	};
	
	$("#gomb").click(function(){
		alert("dsdasdas");
		$.get($("#loginForm").attr('value'),
			{
				userid: ${'#loginUserid'}.val(),
				password: ${'#loginUserid'}.val()		
			}, function(data){
				$('#page-wrapper').html(data);
			});
	});
	/*
	$("#loginForm").submit(function(event) {
		event.preventDefault();
		$.get($(this).attr('action'),
				{
					userid : ${'#loginUserid'}.val(),
					password : ${'#loginUserid'}.val()		
				}
				,function(data) {
			$('#actual-content').html(data);
		});
	});
	*/
	/*
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
		$('[data-toggle="popover"]').popover();
		
	});
	*/
</script>

<div>

	<input type="text" class="form-control" id="loginUserid1"
			required="required" placeholder="Please type in your userid!"
			maxlength="20" name="userid">
	<input type="password"
			class="form-control" id="loginPassword1" required="required"
			placeholder="Please type in your password!" maxlength="30"
			pattern="[a-zA-Z0-9,.-_?]{6,30}" name="password">
	<input id="gomb" type="button" onclick="sendDataa();"
		class="btn btn-default">Send
</div>

<form role="form" id="loginForm"
	action='<c:url value='tracking/baseAuthenticate'></c:url>'
	onsubmit="return loginFormValidate()">
	<div class="form-group">
		<label for="userid">Userid: <span data-toggle="popover"
			data-html="true" data-trigger="hover"
			data-content="<b>The userid maximum length is 20 characters!</b><br><br>The userid must <b>start with</b> a letter <b>a-z or A-Z</b> <br><br> after that can contain the following symbols: a-z, A-Z, 0-9
			<br><br> Example: good: a11gbs111s bad: 1das2, because it starts with a number!"
			title="The userid pattern can contain the following elements:"
			class="fa  fa-info-circle"></span>
		</label> <input type="text" class="form-control" id="loginUserid"
			required="required" placeholder="Please type in your userid!"
			maxlength="20" name="userid">
	</div>
	<div class="form-group">
		<label for="pwd">Password: <span data-toggle="popover"
			data-html="true" data-trigger="hover"
			data-content="<b>The password maximum length is 30 characters!</b><br><br>The password can contain the following elements: <br><br>
			a-z A-Z ? ! . - _ "
			title="The userid pattern can contain the following elements:"
			class="fa  fa-info-circle"></span></label> <input type="password"
			class="form-control" id="loginPassword" required="required"
			placeholder="Please type in your password!" maxlength="30"
			pattern="[a-zA-Z0-9,.-_?]{6,30}" name="password">
	</div>
	<div class="checkbox">
		<label><input type="checkbox"> Remember me</label>
	</div>
	<button id="gomb" type="submit" onclick="sendDataa()"
		class="btn btn-default">Send</button>
</form>



