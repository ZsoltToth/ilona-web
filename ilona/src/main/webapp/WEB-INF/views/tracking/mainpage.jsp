<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>


<!DOCTYPE html>
<html>
<head>

<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tracking module</title>

<meta charset="UTF-8">
<meta name="description"
	content="University of Miskolc ILONA Indoor Positioning System.">
<meta name="keywords" content="HTML,CSS,XML,JavaScript, jsp, springmvc">
<meta name="author" content="Patrik / A5USL0">

<!-- CSS / Bootstrap / Other styles -->

<link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet" />
<!-- Custom styles for this template -->
<!-- 
<link href="css/layout.css" rel="stylesheet"/>
-->
<!-- Font-Awesome -->
<link href="<c:url value='/css/font-awesome.min.css'/>" rel="stylesheet" />
<!-- Metis Menu -->
<link href="<c:url value='/css/metisMenu.min.css'/>" rel="stylesheet" />
<!-- SB2 Admin css -->
<link href="<c:url value='css/sb-admin-2.css' />" rel="stylesheet" />

<!-- Scripting section! -->

<script type="text/javascript"
	src="<c:url value='js/jquery-2.1.3.min.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='js/bootstrap.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='js/metisMenu.min.js' />"></script>
<script type="text/javascript" src="<c:url value='js/sb-admin-2.js' />"></script>

<script type="text/javascript">

	/*
		Get the login page content in the place of the changing content.
	 */
	$('#navbarLoginpage').click(function(event) {
		event.preventDefault();
		$.get($(this).attr('href'), function(data, status) {
			$('#actual-content').html(data);
		});
	});

	/*
		Get the tracking main page and put the content into the main content div.
	 */
	$('#navbarHome').click(function(event) {
		event.preventDefault();
		$.get($(this).attr('href'), function(data, status) {
			/*
				The page-wrapper is in the index.jsp.
				This is the id(div) of the actual page content.
			 */
			$('#page-wrapper').html(data);
		});
	});
</script>

</head>
<body>
	<nav class="navbar navbar-inverse" id="manipageNavbar">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand"><b style="color: white">ILONA
						Tracking Module</b></a>
			</div>
			<ul class="nav navbar-nav">
				<li class="active"><a id="navbarHome"
					href="<c:url value='/tracking/maincontent'></c:url>">Home</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-left">
				<li><a id="navbarSignupage" href="#"><span
						class="glyphicon glyphicon-user"></span> Sign Up(Under construction!)</a></li>
				<li><a id="navbarLoginpage"
					href="<c:url value='/tracking/login'></c:url>"><span
						class="glyphicon glyphicon-log-in"></span> Login</a></li>
			</ul>
		</div>
	</nav>

	<!-- The actual content of the tracking module comes here!
		This content will change if the user click one of the menu elements.
	 -->
	<div id="actual-content">
		<img class="img-responsive"
			src="<c:url value='/jpg/ilonaFrontpage.jpg'/>"
			alt="Indoor positioning front image!" width="80%" height="60%">
	</div>
</body>
</html>
<!-- 
	This page is responsible for providing a main frame to the tracking site.
 -->