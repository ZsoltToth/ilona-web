<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>

<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script type="text/javascript">

	$(".listDevicesDeleteDevice").click(function(event){
		event.preventDefault();
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var link1 = "userManDevDeviceName"+$(this).attr('href');
		var deviceName = document.getElementById(link1).value;
		
		var link2 = "userManDevDeviceType"+$(this).attr('href');
		var deviceType = document.getElementById(link2).value;
		
		var link3 = "userManDevDeviceTypeName"+$(this).attr('href');
		var deviceTypeName = document.getElementById(link3).value;
		
		$.ajax({
			type : "POST",
			async : true,
			url : "<c:url value='/tracking/user/mandevdeletedevice'></c:url>",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#userManDevOwneridHidden").val(),
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
		
		var link1 = "userManDevDeviceName"+$(this).attr('href');
		var deviceName = document.getElementById(link1).value;
		
		var link2 = "userManDevDeviceType"+$(this).attr('href');
		var deviceType = document.getElementById(link2).value;
		
		var link3 = "userManDevDeviceTypeName"+$(this).attr('href');
		var deviceTypeName = document.getElementById(link3).value;
			
		$.ajax({
			type : "POST",
			async : true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : $("#userManDevOwneridHidden").val(),
				deviceid : $(this).attr('href'),
				deviceName : deviceName,
				deviceType : deviceType,
				deviceTypeName : deviceTypeName
			},
			url : "<c:url value='/tracking/user/mandevupdatedevicedetails'></c:url>",
			success : function(result, status, xhr) {
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("error!");
			}
			
		});
	});
	
	$(".userManDevStartDeviceModification").click(function(event){
		try {
			event.preventDefault();
			
			var actualDeviceid = $(this).attr("href");
			
			var deviceNameInputValue = $("#" + "userManDevDeviceName" + actualDeviceid).val();
			var deviceTypeInputValue = $("#" + "userManDevDeviceType" + actualDeviceid).val();			
			var deviceTypeNameInputValue =  $("#" + "userManDevDeviceTypeName" + actualDeviceid).val();
			
			$("#userManDevDeviceModificationDeviceid").val(actualDeviceid);
			$("#userManDevDeviceModificationDeviceName").val(deviceNameInputValue);		
			$("#userManDevDeviceModificationDeviceType").val(deviceTypeInputValue);
			$("#userManDevDeviceModificationTypeName").val(deviceTypeNameInputValue);
			
			// too small input size?! min size?!
			var inputDefaultSize = 20;		
			if(actualDeviceid.length < inputDefaultSize) {
				$("#userManDevDeviceModificationDeviceid").attr("size", inputDefaultSize);
			} else {
				$("#userManDevDeviceModificationDeviceid").attr("size", actualDeviceid.length);
			}	 	
			if(deviceNameInputValue.length < inputDefaultSize) {
				$("#userManDevDeviceModificationDeviceName").attr("size", inputDefaultSize);
			} else {
				$("#userManDevDeviceModificationDeviceName").attr("size", deviceNameInputValue.length);
			}
					
			if(deviceTypeInputValue.length < inputDefaultSize) {
				$("#userManDevDeviceModificationDeviceType").attr("size", inputDefaultSize);
			} else {
				$("#userManDevDeviceModificationDeviceType").attr("size", deviceTypeInputValue.length);
			}
			
			if(deviceTypeNameInputValue.length < inputDefaultSize) {
				$("#userManDevDeviceModificationTypeName").attr("size", inputDefaultSize);
			} else {
				$("#userManDevDeviceModificationTypeName").attr("size", deviceTypeNameInputValue.length);
			}
			
			
			
			//alert(deviceNameInputValue);
		} catch(err) {
			alert(err);
		}
	});
	
	function alignDeviceidInputs(size) {
		try {
			var deviceidInputs = $(".userManDevDeviceidClass");
			var i = 0;
			var length = deviceidInputs.length;
			for(i = 0; i < length; i++) {
				deviceidInputs[i].size = size;
			}
		} catch(err) {
			console.log(err);
		}
	} 
	
	/*
	 * Table column width align.
	 * Every column with the max column length.
	 */ 
	$(document).ready(function(){
		
		try {	
			/*
			 * deviceid align
			 */
			var deviceInputs = $(".userManDevDeviceidClass");
			var maxSize = 0;
			var length = deviceInputs.length;
			var i = 0;
			for(i; i < length; i++) {
				if (maxSize < deviceInputs[i].size) {
					maxSize = deviceInputs[i].size;
				}
			}
			for(i = 0; i < length; i++) {
				deviceInputs[i].size = maxSize;
			}
			
			/*
			 * device name align
			 */
			deviceInputs = $(".userManDevDeviceNameClass");
			maxSize = 0;
			length = deviceInputs.length;
			i = 0;
			for(i; i < length; i++) {
				if (maxSize < deviceInputs[i].size) {
					maxSize = deviceInputs[i].size;
				}
			}
			for(i = 0; i < length; i++) {
				deviceInputs[i].size = maxSize;
			}
			
			deviceInputs = $(".userManDevDeviceTypeClass");
			maxSize = 0;
			length = deviceInputs.length;
			i = 0;
			for(i; i < length; i++) {
				if (maxSize < deviceInputs[i].size) {
					maxSize = deviceInputs[i].size;
				}
			}
			for(i = 0; i < length; i++) {
				deviceInputs[i].size = maxSize;
			}
			
			deviceInputs = $(".userManDevDeviceTypeNameClass");
			maxSize = 0;
			length = deviceInputs.length;
			i = 0;
			for(i; i < length; i++) {
				if (maxSize < deviceInputs[i].size) {
					maxSize = deviceInputs[i].size;
				}
			}
			for(i = 0; i < length; i++) {
				deviceInputs[i].size = maxSize;
			}
			
			
		} catch(err) {
			alert(err);
		}
	});
</script>

<!-- Bootstrap input width override,
	 because without this the input value is not visible!-->
<style>
	input.form-control {
  width: auto;
}
</style>

<jsp:directive.include file="userNavbar.jsp" />

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<p>Device onwerid: ${deviceOwnerid} <br/> Device owner name: ${deviceOwnerName}</p>
			</div>
			<div class="panel-body">
				<div id="userManDevModifyDeviceDataDIV" class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th>Deviceid</th>
								<th>Device name</th>
								<th>Device type</th>
								<th>Delete type name</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<label></label>
									<input type="text" value="" class="form-control"
										id="userManDevDeviceModificationDeviceid" readonly="readonly">	
								</td>
								<td>
									<label></label>
									<input type="text" value="" class="form-control"
										id="userManDevDeviceModificationDeviceName">	
								</td>
								<td>
									<label></label>
									<input type="text" value="" class="form-control"
										id="userManDevDeviceModificationDeviceType">	
								</td>
								<td>
									<label></label>
									<input type="text" value="" class="form-control"
										id="userManDevDeviceModificationTypeName">	
								</td>
							</tr>
							<tr>
								<td>
									<input type="button" value="Confirm modification!">
								</td>
								<td>
									<input type="button" value="Cancel modification!"> 
								</td>
								<td>
									
								</td>
								<td>
									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="userManDevDeleteDeviceDIV">dadsa</div>
				<div style="overflow: auto; height: 800px">
					<div class="table-responsive">
						<table class="table" id="userManDevdataTables-example">
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
										<td>
											<input type="text" readonly="readonly" 
												value="${device.deviceid}"
												class="form-control userManDevDeviceidClass" 
												size="${fn:length(device.deviceid)}">
										</td>
										
										<td><input type="text" 
											value="${device.deviceName}"
											class="form-control userManDevDeviceNameClass" 
											id="userManDevDeviceName${device.deviceid}"
											size="${fn:length(device.deviceName)}"
											readonly="readonly">
										</td>
											
										<td><input type="text" 
											value="${device.deviceType}"
											class="form-control userManDevDeviceTypeClass" 
											id="userManDevDeviceType${device.deviceid}"
											size="${fn:length(device.deviceType)}"
											readonly="readonly">
										</td>
											
										<td><input type="text" value="${device.deviceTypeName}" 
											class="form-control userManDevDeviceTypeNameClass"
											id="userManDevDeviceTypeName${device.deviceid}"
											size="${fn:length(device.deviceTypeName)}"
											readonly="readonly">
										</td>
											
										<td><a href="${device.deviceid}" 
										
											class="">Delete device 
											<span class="glyphicon glyphicon-ban-circle "></span></a>
										</td>
											
										<td><a href="${device.deviceid}" 
											class="userManDevStartDeviceModification">Confirm modifications
											<span class="glyphicon glyphicon-ok-sign "></span></a>
										</td>
												
									</tr>
								</c:forEach>						
							</tbody>
						</table>
						<input type="hidden" id="userManDevOwneridHidden" value="${deviceOwnerid}">
					</div> <!-- table responsive end -->
				</div> <!-- overflow div end -->
			</div> <!-- panel body end -->
			<div class="panel-body">
				${executionError}
			</div>
		</div>

	</div>

</div>