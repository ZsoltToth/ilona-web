<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<head>

<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script type="text/javascript">
	
	$(document).ready(function(){
			
		$(".adminpageListUsersEdit").each(function(){
			$(this).click(function(event){
				event.preventDefault();
				$.ajax({
					type : "POST",
					async : true,
					beforeSend : function(xhr) {
						xhr.setRequestHeader($("meta[name='_csrf_header']").attr("content"),
							$("meta[name='_csrf']").attr("content"));
					},
					data : {
						userid :  $(this).attr('href')
					},
					success : function(result, status, xhr) {
						$("#adminMainpageContent").html(result);
					},
					error : function(xhr, status, error) {
						$("#adminMainpageContent").html(error);
					},
					url : "<c:url value='/tracking/createusercreationpage'></c:url>"
				
				});
			});
		});
		
		$(".adminpageListUsersDelete").each(function(){
			$(this).click(function(event){
				event.preventDefault();
				$.ajax({
					type : "POST",
					async : true,
					beforeSend : function(xhr) {
						xhr.setRequestHeader($("meta[name='_csrf_header']").attr("content"),
							$("meta[name='_csrf']").attr("content"));
					},
					data : {
						userid :  $(this).attr('href')
					},
					success : function(result, status, xhr) {
						$("#adminMainpageContent").html(result);
						//$("#adminMainpageContent").html(result);
						/*
						$.ajax({
							async : true,
							type : "POST",
							url :  "<c:url value='/tracking/listallusers'></c:url>",
							beforeSend : function(xhr) {
								xhr.setRequestHeader($("meta[name='_csrf_header']").attr("content"),
									$("meta[name='_csrf']").attr("content"));
							},
							success : function(result, status, xhr) {
								$("#adminMainpageContent").html(result);
							}
						});
						*/
					},
					error : function(xhr, status, error) {
						$("#adminMainpageContent").html(error + status + xhr.responseText);
					},
					url : "<c:url value='/tracking/deleteuserbyid'></c:url>"
				
				});
			});
		});
		
	});
	
	
	
</script>
</head>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Available users in the ILONA System!</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="dataTable_wrapper">
					<table width="100%"
						class="table table-striped table-bordered table-hover"
						id="dataTables-example">
						<thead>
							<tr>
								<th>Userid</th>
								<th>Username</th>
								<th>Password ?! ránézni</th>
								<th>Email</th>
								<th>Enabled</th>
								<th>Nonlocked</th>
								<th>NonExpird</th>
								<th>CredentialsNonExpired</th>
								<td>Edit</td>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>
						
							<c:forEach var="user" items="${users}">
								<c:choose>
									<c:when test="${user.isEnabled() == true}">
										<tr class="odd gradeX danger">
									</c:when>
									<c:otherwise>
										<tr class="odd gradeX">
									</c:otherwise>
								</c:choose>
								
									<td class="left">${user.getUserid()}</td>
									<td class="left">${user.getUsername()}</td>
									<td class="left">${user.getPassword()}</td>
									<td class="left">${user.getEmail()}</td>
									<td class="left">${user.getNonExpired()}</td>
									<td></td>
									<td></td>
									<td></td>
									<td class="center"><a href="${user.getUserid()}" class="adminpageListUsersEdit">
										<span class="glyphicon glyphicon-edit "></span></a>
									</td>
									<td class="center"><a href="${user.getUserid()}" class="adminpageListUsersDelete">
										<span class="glyphicon glyphicon-remove-sign"></span></a>
									</td>								
								</tr>
							</c:forEach>						
						</tbody>
					</table>
				</div>

			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>