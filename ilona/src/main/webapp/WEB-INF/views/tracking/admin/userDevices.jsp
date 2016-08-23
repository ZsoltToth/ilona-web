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

<script type="text/javascript">

	function showModification() {
		$(".listDevicesUpdateDevice").css("visibility","visible");
	};

	$(".deviceTypeNameClass").change(function(){
		var id = $(this).attr('id');
		id = id.slice(7);
		var elements = document.getElementsByClassName("listDevicesUpdateDevice");
	
		for(var i = 0; i < elements.length; i++) {
			if(elements[i].getAttribute('href') == id) {
				elements[i].style.visibility = "visible";				
			}
		}		
		
	});

	$(".listDevicesDeleteDevice").click(function(event){
		event.preventDefault();
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var link1 = "devName"+$(this).attr('href');
		var deviceName = document.getElementById(link1).value;
		
		var link2 = "devType"+$(this).attr('href');
		var deviceType = document.getElementById(link2).value;
		
		var link3 = "devTypeName"+$(this).attr('href');
		var deviceTypeName = document.getElementById(link3).value;
		
		$.ajax({
			type : "POST",
			async : true,
			url : "<c:url value='/tracking/admin/deleteuserdevice'></c:url>",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#listDevicesOwnerid").val(),
				deviceid : $(this).attr('href'),
				deviceName : deviceName,
				deviceType : deviceType,
				deviceTypeName : deviceTypeName
			},
			success : function(result, status, error) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("error!");
			}
		});
	});


	$(".listDevicesUpdateDevice").click(function(event){		
		event.preventDefault();
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var link1 = "devName"+$(this).attr('href');
		var deviceName = document.getElementById(link1).value;
		
		var link2 = "devType"+$(this).attr('href');
		var deviceType = document.getElementById(link2).value;
		
		var link3 = "devTypeName"+$(this).attr('href');
		var deviceTypeName = document.getElementById(link3).value;
			
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#listDevicesOwnerid").val(),
				deviceid : $(this).attr('href'),
				deviceName : deviceName,
				deviceType : deviceType,
				deviceTypeName : deviceTypeName
			},
			url : "<c:url value='/tracking/admin/updatedevicedetails'></c:url>",
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("error!");
			}
			
		});
	});
	
	$("#adminUserDevAddNewDeviceBTN").click(function(event){
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
				userid : $("#listDevicesOwnerid").val(),			
			},
			url : "<c:url value='/tracking/admin/userdevcreatenewdevicepagerequest'></c:url>",
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("error!");
			}
		});
	});

</script>


<jsp:directive.include file="adminNavbar.jsp" />

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<p>${deviceOwner}</p>
				<p><input id="adminUserDevAddNewDeviceBTN" class="btn btn-default" value="Add new device"> </p>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table"
						class="table table-striped table-bordered table-hover"
						id="dataTables-example">
						<thead>
							<tr>
								<th>Deviceid</th>
								<th>Device name</th>
								<th>Device type</th>
								<th>Device type name</th>
								<th>Delete device</th>
								<th>Confirm modifications</th> 
							</tr>
						</thead>
						<tbody>
							
							<c:forEach var="device" items="${devices}" >
								<tr>
									<td>${device.deviceid}</td>
									<td>
										<input type="text" 
											value="${device.deviceName}" 
											id="devName${device.deviceid}" 
											onchange="showModification();">
									</td>
									<td>
										<input type="text" 
											value="${device.deviceType}" 
											id="devType${device.deviceid}" 
											class="deviceTypeNameClass">
									</td>
									<td>
										<input type="text" 
											value="${device.deviceTypeName}" 
											id="devTypeName${device.deviceid}">
									</td>
									<td>
										<a href="${device.deviceid}" 
											class="listDevicesDeleteDevice">Delete device 
											<span class="glyphicon glyphicon-ban-circle "></span>
										</a>
									</td>
									<td><a style="visibility:hidden" 
										href="${device.deviceid}" 
										class="listDevicesUpdateDevice">Confirm modifications 
											<span 
												class="glyphicon glyphicon-ok-sign ">
											</span>
										</a>
									</td>
											
								</tr>
							</c:forEach>						
						</tbody>
					</table>
					<input type="hidden" id="listDevicesOwnerid" value="${deviceOwner}">
				</div>

			</div>
			<div class="panel-body">
				${executionError}
			</div>
		</div>

	</div>

</div>

