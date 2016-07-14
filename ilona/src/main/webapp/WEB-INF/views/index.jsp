<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<title>ILONA - Indoor Location and Navigation System</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<!-- 
<link href="css/layout.css" rel="stylesheet"/>
-->
<!-- Font-Awesome -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Metis Menu -->
<link href="css/metisMenu.min.css" rel="stylesheet" />
<!-- SB2 Admin css -->
<link href="css/sb-admin-2.css" rel="stylesheet" />



<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/metisMenu.min.js"></script>
<script type="text/javascript" src="js/sb-admin-2.js"></script>

<script type="text/javascript">
	$(document).ready(function() {

		$('a.navbar-brand').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
			//alert($(this).attr('href'));
		});
		$('#menuDashboard').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
		$('#menuShowLogs').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
		$('#menuZoneManagement').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
		$('#menuMeasurementManagement').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
		$('#menuKNNSettings').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
		$('#menuNaiveBayes').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
		$('#trackingMainpage').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
		$('#probalgatasok').click(function(event) {
			event.preventDefault();
			$.get($(this).attr('href'), function(data) {
				$('#page-wrapper').html(data);
			});
		});
	});
</script>


</head>

<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="welcome"> ILONA</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i
						class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a> <!-- /.dropdown-messages --></li>
				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a> <!-- /.dropdown-alerts --></li>
				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a> <!-- /.dropdown-user --></li>
				<!-- /.dropdown -->
			</ul>
			<!-- /.navbar-top-links -->

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">

						<li><a href="welcome" id="menuDashboard"><i
								class="fa fa-dashboard fa-fw"></i> Dashboard</a></li>
						<li><a href="showLogs" id="menuShowLogs"><i
								class="fa fa-exclamation-triangle"> Logs</i></a></li>
						<li><a href="zoneManagement" id="menuZoneManagement"><i
								class="fa fa-sitemap"> Zones </i></a></li>
						<li><a href="#"><i class="fa fa-tags"></i> Symbolic<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="measurementManagement"
									id="menuMeasurementManagement"><i class="fa fa-file-text-o">
											Measurements</i></a></li>
								<li><a href="#"><i class="fa fa-wrench"></i> Options <span
										class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="positioningSetup/naiveBayes"
											id="menuNaiveBayes">Naive Bayes</a></li>
										<li><a href="positioningSetup/knn" id="menuKNNSettings">k-NN</a>
										</li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-crosshairs"></i> Absolute<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="flot.html"><i class="fa fa-wifi">
											Access Points</i></a></li>
								<li><a href="morris.html"><i class="fa fa-wrench"></i>
										Options</a></li>
								<li><a href="#">Third Level <span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="#">Third Level Item</a></li>
										<li><a href="#">Third Level Item</a></li>
										<li><a href="#">Third Level Item</a></li>
										<li><a href="#">Third Level Item</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="tracking/index" id="trackingMainpage"><i
								class="fa fa-dashboard fa-fw"></i> Tracking </a></li>
						<li><a href="tracking/probalgatasok" class="fa fa-dashboard fa-fw" id="probalgatasok">Proba</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>

	</div>

	<div id="page-wrapper"></div>
	<!-- page-wrapper -->
</body>
</html>