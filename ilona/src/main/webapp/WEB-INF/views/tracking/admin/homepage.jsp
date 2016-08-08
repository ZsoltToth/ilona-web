<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<script type="text/javascript">
	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();
</script>

<jsp:directive.include file="adminNavbar.jsp" />


<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Admin main content heading!</h3>
		</div>
		<div class="panel-body">
			<h3 class="panel-title">Admin main content content!</h3>
		</div>
	</div>
</div>