<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<script type="text/javascript">

	//$(document).ready(function() {
		/*
			Get the login page content in the place of the changing content.
		 */
		$('#navbarLoginpage').click(function(event) {
			event.preventDefault();
			
			//var token = $("meta[name='_csrf']").attr("content");
			//var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					//xhr.setRequestHeader(header, token);
				},
				url : $("#navbarLoginpage").attr('href'),
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#page-wrapper").html(xhr.responseText);
				}
			});
		});

		/*
			Get the tracking main page and put the content into the main content div.
		 */
		$('#navbarHome').click(function(event) {
			event.preventDefault();
			//var token = $("meta[name='_csrf']").attr("content");
			//var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					//xhr.setRequestHeader(header, token);
				},
				url : $("#navbarHome").attr('href'),
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, result, error) {
					$("#page-wrapper").html(xhr.responseText);
				}
			});
		});

		$("#navbarSignuppage").click(function(event) {
			event.preventDefault();
			//var token = $("meta[name='_csrf']").attr("content");
			//var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				url : $("#navbarSignuppage").attr("href"),
				beforeSend : function(xhr) {
					//xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#page-wrapper").html(xhr.responseText);
				}
			});
		});
	//});
</script>

<nav class="navbar navbar-inverse" id="manipageNavbar">
	<div class="container-fluid">
		<div class="navbar-header">
			<div class="navbar-header">
				<a class="navbar-brand">ILONA - Main page</a>
			</div>
		</div>
		<ul class="nav navbar-nav">
			<li class="active"><a id="navbarHome"
				href="<c:url value='/tracking/getmainpagehome'></c:url>"> Home</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-left">
			<li><a id="navbarSignuppage"
				href="<c:url value='/tracking/getmainpagesignup'></c:url>"><span
					class="glyphicon glyphicon-user"></span> Sign Up</a></li>
			<li><a id="navbarLoginpage"
				href="<c:url value='/tracking/getloginpage'></c:url>"><span
					class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</ul>
	</div>
</nav>