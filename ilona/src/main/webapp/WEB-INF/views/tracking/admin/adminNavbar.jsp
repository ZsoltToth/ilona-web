<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<script type="text/javascript">

	$("#adminNavbarHome").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarHome").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				},
				timeout : 10000
			});
		} catch(err) {
			console.log(err);
		}
	});

	$("#adminNavbarAccountManagement").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarAccountManagement").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				},
				timeout : 10000
			});
		} catch(err) {
			console.log(err);
		}
	});

	$("#adminNavbarCreateuser").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarCreateuser").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});

	$("#adminNavbarListUsers").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarListUsers").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});

	$("#adminNavbarCentralManagement").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarCentralManagement").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});
	
	$("#adminNavbarTrack").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarTrack").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});
	
	$("#adminNavbarStat").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarStat").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});
	
	$("#adminNavbarLogout").click(function(event) {
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				async : true,
				type : "POST",
				url : $("#adminNavbarLogout").attr('href'),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result, status, xhr) {
					$("#page-wrapper").html(result);
				},
				error : function(xhr, status, error) {
					try {
						$("#adminNavbarNavigationErrorDIV")
							.html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});
	
</script>

<nav class="navbar navbar-inverse" id="manipageNavbar">
	<div class="container-fluid">
		<div class="navbar-header">
			<div class="navbar-header">
				<a class="navbar-brand"><b>ADMIN</b></a>
			</div>
		</div>
		<ul class="nav navbar-nav">
			<li><a id="adminNavbarHome"
				href="<c:url value='/tracking/admin/homepage'></c:url>"><span
					class="fa fa-globe"></span> Home</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-left">
			<li><a id="adminNavbarAccountManagement"
				href="<c:url value='/tracking/admin/accountmanagement'></c:url>"><span
					class="glyphicon glyphicon-edit "></span> Account Management </a></li>
			<li><a id="adminNavbarCreateuser"
				href="<c:url value='/tracking/admin/createuser'></c:url>"><span
					class="glyphicon glyphicon-user"></span> Create User </a></li>
			<li><a id="adminNavbarListUsers"
				href="<c:url value='/tracking/admin/listallusers'></c:url>"><span
					class="fa  fa-users"></span> List Users</a></li>
			<li><a id="adminNavbarCentralManagement"
				href="<c:url value='/tracking/admin/centralmanagement'></c:url>"><span
					class="fa fa-gear"></span> Central management</a></li>
			<li><a id="adminNavbarTrack"
				href="<c:url value='/tracking/admin/trackingmainpage'></c:url>"><span
					class="fa fa-share-alt"></span> Track</a></li>
			<li><a id="adminNavbarStat"
				href="<c:url value='/tracking/admin/statistics'></c:url>"><span
					class="glyphicon glyphicon-tasks"></span> Statistics</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a id="adminNavbarLogout"
				href="<c:url value='/tracking/logout'></c:url>"><span
					class="fa fa-power-off"></span> Logut</a></li>
		</ul>
	</div>
</nav>
<div id="adminNavbarNavigationErrorDIV"></div>