<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script type="text/javascript">

	$("#").click(function(event){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");	
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			url : "",
			data : {
				
			},
			success : function(result, status, xhr) {
				
			},
			error : function(xhr, status, error) {
				
			}
		});
});
</script>

<jsp:directive.include file="mainpageNavbar.jsp" />


<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">ILONA - Password reset!</h3>
				</div>
				<div class="panel-body">
					<label for="trackingPasswordResetUseridTXT">Userid:</label>
					<input type="text" id="trackingPasswordResetUseridTXT"><br /><br />
					
					
					<input type="button" id="trackingPasswordResetSendPasswordResetRequestBTN" value="Reset password">
				</div>
			</div>
		</div>
	</div>
</div>
