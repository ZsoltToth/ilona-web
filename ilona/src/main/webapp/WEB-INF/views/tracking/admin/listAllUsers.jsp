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
	
	$(".adminListUsersDeviceListClass").click(function(event){
		try {
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
				url : "<c:url value='/tracking/admin/listusers/getusersdevices'></c:url>",
				success : function(result, status, xhr) {
					try {
						$("#page-wrapper").html(result);
					} catch(err) {
						console.log(err);
					}
				},
				error : function(xhr, status, error) {
					try {
						$("#adminListUsersResultAndErrorDIV")
							.html("<p class='bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});
	
	$(".adminListUsersModifyUserClass").click(function(event){
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
			url : "<c:url value='/tracking/admin/listusers/modifyuser'></c:url>",
			success : function(result, status, xhr) {
				try {
					$("#page-wrapper").html(result);
				} catch(err) {
					console.log(err);
				}
			},
			error : function(xhr, status, error) {
				try {
					$("#adminListUsersResultAndErrorDIV")
						.html("<p class='bg-primary'>Service error!</p>");
				} catch(err) {
					console.log(err);
				}
			}
		});
	});
	
	$(".adminListUsersDeleteUserClass").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var userid = $(this).attr('href');
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : userid
			},
			url : "<c:url value='/tracking/admin/listusers/deleteuser'></c:url>",
			success : function(result, status, xhr) {
				try {
					if(result.executionState == true) {
						$("#adminListUsersResultAndErrorDIV")
						.html("<p class='bg-primary'>User deleted!</p>");
						$("#adminListUsers" + userid).remove();
					} else {
						var i = 0;
						var messages = result.messages;
						var length = messages.length;
						var errorText = "";
						for(i; i < length; i++) {
							errorText += "<p class='bg-primary'>" + messages[i] + "</p>";
						}
						$("#adminListUsersResultAndErrorDIV").html(errorText);
					}
				} catch(err) {
					console.log(err);
				}
			},
			error : function(xhr, status, error) {
				try {
					$("#adminListUsersResultAndErrorDIV")
						.html("<p class='bg-primary'>Service error!</p>");
				} catch(err) {
					console.log(err);
				}
			}
		});
	});
	
	$("#adminListUsersShowAdminsCHB").change(function(){
		var AdminCHB = document.getElementById("adminListUsersShowAdminsCHB");
		if(AdminCHB.checked) {
			var adminRows = document.getElementsByClassName("adminListUsersAdminRow");
			var i = 0;
			var length = adminRows.length;
			for(i; i < length; i++) {
				adminRows[i].style.visibility = "visible";
				$(adminRows[i]).removeClass("collapse");
			}			
		} else {
			var adminRows = document.getElementsByClassName("adminListUsersAdminRow");
			var i = 0;
			var length = adminRows.length;
			for(i; i < length; i++) {
				adminRows[i].style.visibility = "hidden";
				$(adminRows[i]).addClass("collapse");
			}
		}
	});
	
	$("#adminListUsersShowUsersCHB").change(function(){
		var AdminCHB = document.getElementById("adminListUsersShowUsersCHB");
		if(AdminCHB.checked) {
			var adminRows = document.getElementsByClassName("adminListUsersUserRow");
			var i = 0;
			var length = adminRows.length;
			for(i; i < length; i++) {
				adminRows[i].style.visibility = "visible";
				$(adminRows[i]).removeClass("collapse");
			}			
		} else {
			var adminRows = document.getElementsByClassName("adminListUsersUserRow");
			var i = 0;
			var length = adminRows.length;
			for(i; i < length; i++) {
				adminRows[i].style.visibility = "hidden";
				$(adminRows[i]).addClass("collapse");
			}
		}
	});
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
				<input type="checkbox" checked="checked" id="adminListUsersShowAdminsCHB"> Show Admins
				<input type="checkbox" checked="checked" id="adminListUsersShowUsersCHB"> Show Users
				</div>
				<div class="panel-body">
					<div id="adminListUsersResultAndErrorDIV"><p class="bg-primary">${serviceError}</p></div>
					<div style="overflow: auto; height: 800px">
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
												<tr class="odd gradeX danger adminListUsersAdminRow" id="adminListUsers${user.userid}">
											</c:when>
											<c:otherwise>
												<tr class="odd gradeX adminListUsersUserRow" id="adminListUsers${user.userid}">
											</c:otherwise>
										</c:choose>
										<td>${user.userid}</td>
										<td>${user.username}</td>
										<td>${user.email}</td>
										<td>
											<a href="${user.userid}" 
												class="adminListUsersDeviceListClass">Devices 
												<span class="fa fa-database"></span>
											</a>
										</td>
										<td>
											<a href="${user.userid}" 
												class="adminListUsersModifyUserClass">Edit account 
												<span class="fa fa-pencil-square "></span>
											</a>
										</td>
										<td>
											<a href="${user.userid}" 
												class="adminListUsersDeleteUserClass">Delete account 
												<span class="glyphicon glyphicon-remove-sign "></span>
											</a>
										</td>	 						
										</tr>
									</c:forEach>						
								</tbody>
							</table>
						</div>	<!-- table responsive end -->
					</div> <!-- table height overflow auto end -->
				</div>	<!-- panel body end -->
			</div>	<!-- panel default end -->
		</div>	<!-- colg-lg-12 end -->
	</div> <!-- row end -->
</div> <!-- container fluid end -->