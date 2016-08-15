<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<script type="text/javascript">

	$("#userNavbarHomeMenuitem").click(function(event) {
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			async : true,
			type : "POST",
			url : $("#userNavbarHomeMenuitem").attr('href'),
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				$("#userNavbarNavigationErrorDIV").html("<h2>The tracking service is unreachable!<h2>");
			},
			timeout : 10000
		});
	});
	
	$("#userNavbarAccountManagement").click(function(event) {
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			async : true,
			type : "POST",
			url : $("#userNavbarAccountManagement").attr('href'),
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				$("#userNavbarNavigationErrorDIV").html("<h2>The tracking service is unreachable!<h2>");
			},
			timeout : 10000
		});
	});
	
	$("#userNavbarManageDevices").click(function(event) {
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			async : true,
			type : "POST",
			url : $("#userNavbarManageDevices").attr('href'),
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				$("#userNavbarNavigationErrorDIV").html("<h2>The tracking service is unreachable!<h2>");
			},
			timeout : 10000
		});
	});
	
	$("#userNavbarAddDevice").click(function(event) {
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			async : true,
			type : "POST",
			url : $("#userNavbarAddDevice").attr('href'),
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				$("#userNavbarNavigationErrorDIV").html("<h2>The tracking service is unreachable!<h2>");
			},
			timeout : 10000
		});
	});
	
	$("#userNavbarDeviceTracking").click(function(event) {
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			async : true,
			type : "POST",
			url : $("#userNavbarDeviceTracking").attr('href'),
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				$("#userNavbarNavigationErrorDIV").html("<h2>The tracking service is unreachable!<h2>");
			},
			timeout : 10000
		});
	});
	
	$("#userNavbarLogout").click(function(event) {
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			async : true,
			type : "POST",
			url : $("#userNavbarLogout").attr('href'),
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				$("#userNavbarNavigationErrorDIV").html("<h2>The tracking service is unreachable!<h2>");
			},
			timeout : 10000
		});
	});
</script>

<nav class="navbar navbar-inverse" id="userNavbarDIV">
	<div class="container-fluid">
		<div class="navbar-header">
			<div class="navbar-header">
				<a class="navbar-brand"><b>USER</b></a>
			</div>
		</div>
		<ul class="nav navbar-nav">
			<li>
				<a id="userNavbarHomeMenuitem"
					href="<c:url value='/tracking/user/homepage'></c:url>">
					<span class="fa fa-globe"></span> Home
				</a>
			</li>
		</ul>
		<ul class="nav navbar-nav navbar-left">
			<li>
				<a id="userNavbarAccountManagement"
					href="<c:url value='/tracking/user/accountmanagement'></c:url>">
					<span class="glyphicon glyphicon-edit "></span> Account Management 
				</a>
			</li>
			
			<li>
				<a id="userNavbarManageDevices"
					href="<c:url value='/tracking/user/managedevices'></c:url>">
					<span class="glyphicon glyphicon-user"></span> Manage devices 
				</a>
			</li>
			
			<li>
				<a id="userNavbarAddDevice"
					href="<c:url value='/tracking/user/createdevicepage'></c:url>">
					<span class="glyphicon glyphicon-user"></span> Create device 
				</a>
			</li>
					
			<li>
				<a id="userNavbarDeviceTracking"
					href="<c:url value='/tracking/user/devicetracking'></c:url>">
					<span class="fa fa-share-alt"></span> Tracking 
				</a>
			</li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li>
				<a id="userNavbarLogout"
					href="<c:url value='/tracking/logout'></c:url>">
					<span class="fa fa-power-off"></span> Logut
				</a>
			</li>
		</ul>
	</div>
</nav>

<div>
	<p class="bg-primary text-center" id="userNavbarNavigationErrorDIV"></p>
</div>
