<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<title>ILONA - Tracking dummy page</title>

<!-- Metadata part -->
<meta charset="UTF-8">
<meta name="description"
	content="University of Miskolc ILONA Indoor Positioning System.">
<meta name="keywords" content="HTML,CSS,XML,JavaScript, jsp, springmvc">
<meta name="author" content="Patryk / a5usl0">

<!--  CSS part -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Font-Awesome -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Metis Menu -->
<link href="css/metisMenu.min.css" rel="stylesheet" />
<!-- SB2 Admin css -->
<link href="css/sb-admin-2.css" rel="stylesheet" />
<link href="css/trackingDesign.css" rel="stylesheet" />

<!-- Javascript part -->
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/metisMenu.min.js"></script>
<script type="text/javascript" src="js/sb-admin-2.js"></script>
</head>
<body>
	<!-- Main frame div -->
	<div>
		<p>
			Paraméter1: ${param1} <br />
			Paraméter2: ${param2} <br />
			Paraméter3: ${param3} <br />
		</p>
	</div>
</body>
</html>