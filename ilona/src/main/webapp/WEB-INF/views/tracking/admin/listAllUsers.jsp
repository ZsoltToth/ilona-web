<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script type="text/javascript">
	
	$(".deviceList").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $(this).attr('href')
			},
			url : "<c:url value='/tracking/admin/listusergetuserdevices'></c:url>",
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("error" + status + error);
			}
		});
	});
	
	$(".modifyUser").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $(this).attr('href')
			},
			url : "<c:url value='/tracking/admin/listusersmodifyuser'></c:url>",
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("error" + status + error);
			}
		});
	});
	
	$(".deleteuser").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $(this).attr('href')
			},
			url : "<c:url value='/tracking/admin/listuserdeleteuser'></c:url>",
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("error" + status + error);
			}
		});
	});
	
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
			<input type="checkbox" checked="checked"> Show Admins (Red background!)
			</div>
			<div class="panel-body">
				<div><p class="bg-primary">${serviceError}</p></div>
				<div class="table-responsive">
					<table class="table"
						class="table table-striped table-bordered table-hover"
						id="dataTables-example">
						<thead>
							<tr>
								<th>Userid</th>
								<th>Username</th>
								<th>Email</th>
								<th>List devices</th> 
								<th>Edit account</th>
								<th>Delete account</th>
							</tr>
						</thead>
						<tbody>
						
							<c:forEach var="user" items="${users}">
								<c:choose>
									<c:when test="${user.adminRole == true}">
										<tr class="odd gradeX danger">
									</c:when>
									<c:otherwise>
										<tr class="odd gradeX">
									</c:otherwise>
								</c:choose>
								<td>${user.userid}</td>
								<td>${user.username}</td>
								<td>${user.email}</td>
								<td><a href="${user.userid}" class="deviceList">Devices <span class="fa fa-database"></span></a></td>
								<td><a href="${user.userid}" class="modifyUser">Edit account <span class="fa fa-pencil-square "></span></a></td>
								<td><a href="${user.userid}" class="deleteuser">Delete account <span class="glyphicon glyphicon-remove-sign "></span></a></td>	 						
								</tr>
							</c:forEach>						
						</tbody>
					</table>
				</div>

			</div>

		</div>

	</div>

</div>