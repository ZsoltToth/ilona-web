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

<jsp:directive.include file="adminNavbar.jsp" />

<div class="col-lg-12">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h4><b>Heading</b></h4>
		</div>
		<div class="panel-body">
			
			Pane body		
		</div>
		
		<div class="panel-body" id="accountDetailsErrors">
			
		</div>
	</div>
</div>