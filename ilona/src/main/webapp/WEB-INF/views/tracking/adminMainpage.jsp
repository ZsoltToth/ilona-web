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
		$("#adminNavbarCreateuser").click(function(event){
				event.preventDefault();
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					async : true,
					type : "POST",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					
					url : $("#adminNavbarCreateuser").attr(
							'href'),
					timeout : 10000,
					error : function(xhr, status, error) {
						$("#trackingLoginpageErroroutput").val(
								status + " " + error).css(
								"visibility", "visible");
					},
					success : function(result, status, xhr) {
						$("#page-wrapper").html(result);
					}
				});
		});
	});
	
</script>

</head>

 <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="">Tracking Module - Admin main page</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="">Home</a></li>
      <li><a id="adminNavbarCreateuser" href="<c:url value='tracking/createusercreationpage'></c:url>">Create user</a></li>
      <li><a id="adminNavbarModifyuser" href="">Modify User</a></li>
      <li><a id="adminNavbarListusers" href="tracking/listallusers">List users</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="#"><span class="fa fa-asterisk"></span> Settings</a></li>
      <li><a href="#"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
    </ul>
  </div>
</nav>