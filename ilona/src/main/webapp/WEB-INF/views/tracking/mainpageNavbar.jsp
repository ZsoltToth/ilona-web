<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<script type="text/javascript">
		
		/*
		 * Get tracking login page
		 */
		$('#mainpageNavbarGetLoginpageMenuitem').click(function(event) {
			event.preventDefault();
			
			/*
			 * CSRF token from the parent page.
			 */
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			/*
			 * Page ajax request.
			 */
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					/*
					 * Set the csrf token into the header.
					 */
					xhr.setRequestHeader(header, token);
				},
				url : $("#mainpageNavbarGetLoginpageMenuitem").attr('href'),
				timeout : 10000,
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#mainpageNavbarErrorMenuitem").html("<h2>The tracking service is unreachable!</h2>");
				}
			});
		});

		/*
			Get the tracking main page and put the content into the main content div.
		 */
		$('#mainpageNavbarGetHomepageMenuitem').click(function(event) {
			event.preventDefault();
			/*
			 * CSRF token from the parent page.
			 */
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			/*
			 * Page ajax request.
			 */
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					/*
					 * Set the csrf token into the header.
					 */
					xhr.setRequestHeader(header, token);
				},
				url : $("#mainpageNavbarGetHomepageMenuitem").attr('href'),
				timeout : 10000,
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, result, error) {
					$("#mainpageNavbarErrorMenuitem").html("<h2>The tracking service is unreachable!</h2>");
				}
			});
		});

		$("#mainpageNavbarGetSignuppageMenuitem").click(function(event) {
			event.preventDefault();
			/*
			 * CSRF token from the parent page.
			 */
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			$.ajax({
				type : "POST",
				async : true,
				url : $("#mainpageNavbarGetSignuppageMenuitem").attr("href"),
				timeout : 10000,
				beforeSend : function(xhr) {
					/*
					 * Set the csrf token into the header.
					 */
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					$("#mainpageNavbarErrorMenuitem").html("<h2>The tracking service is unreachable!</h2>");
				}
			});
		});

</script>

<nav class="navbar navbar-inverse" id="mainpageNavbarNavigationDIV">
	<div class="container-fluid">
		<div class="navbar-header">			
			<a class="navbar-brand">ILONA - Main page</a>			
		</div>
		<ul class="nav navbar-nav">
			<li class="active">
				<a id="mainpageNavbarGetHomepageMenuitem"
					href="<c:url value='/tracking/getmainpagehome'></c:url>">
					<span class="fa fa-th-large"></span> Home			
				</a>
			</li>
		</ul>
		<ul class="nav navbar-nav navbar-left">
			<li>
				<a id="mainpageNavbarGetSignuppageMenuitem"
					href="<c:url value='/tracking/getmainpagesignup'></c:url>">
					<span class="glyphicon glyphicon-user"></span> Sign Up
				</a>
			</li>
			
			<li>
				<a id="mainpageNavbarGetLoginpageMenuitem"
					href="<c:url value='/tracking/getloginpage'></c:url>">
					<span class="glyphicon glyphicon-log-in"></span> Login
				</a>
			</li>
		</ul>
	</div>		
</nav>

<div>
	<p class="bg-primary text-center" id="mainpageNavbarErrorMenuitem"></p>
</div>