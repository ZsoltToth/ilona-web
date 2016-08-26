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

<script src="<c:url value='/js/deviceManagement.js'></c:url>"></script>

<script type="text/javascript">
	
	$("#userManDevDeviceModificationDeleteDeviceBTN").click(function(event){
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				url : "<c:url value='/tracking/user/mandevdeletedevice'></c:url>",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					userid : $("#userManDevOwneridHidden").val(),
					deviceid : $("#userManDevDeviceModificationDeviceid").val(),
					deviceType : $("#userManDevDeviceModificationDeviceType").val(),
					deviceTypeName : $("#userManDevDeviceModificationDeviceTypeName").val()
				},
				success : function(result, status, error) {
					try {
						if(result.executionState == true) {							
							$("#userManDevResultOrErrorDIV")
								.html("<p class='text-danger bg-primary'>Device deletion was successful!</p>");
							$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
							var deviceid = "#userManDevDeviceRow" + $("#userManDevDeviceModificationDeviceid").val();						
							$(deviceid).remove();
							
						} else {
							var i = 0;
							var messages = result.messages;
							var length = messages.length;						
							var errorMessages = "";
							for(i; i < length; i++) {
								errorMessages += "<p class='text-danger bg-primary'>" + messages[i] + "</p>";
							}
							$("#userManDevResultOrErrorDIV").html(errorMessages);
							$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
						}
						
					} catch(err) {
						console.log(err);
					}
				},
				error : function(xhr, status, error) {
					try {
						$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
						$("#userManDevResultOrErrorDIV").html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			console.log(err);
		}
	});
	
	$("#userManDevDeviceModificationCancelModificationBTN").click(function(event){
		try {
			event.preventDefault();
			$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
		} catch(err) {
			console.log(err);
		}
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
			$("#userManDevDeviceModificationDeviceTypeName").val(deviceTypeNameInputValue);
			
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
				$("#userManDevDeviceModificationDeviceTypeName").attr("size", inputDefaultSize);
			} else {
				$("#userManDevDeviceModificationDeviceTypeName").attr("size", deviceTypeNameInputValue.length);
			}
			
			$("#userManDevModifyDeviceCollapseDIV").removeClass("collapse");
			document.getElementById("userManDevModifyDeviceCollapseDIV").scrollIntoView();
		} catch(err) {
			console.log(err);
		}
	});
	
	$("#userManDevDeviceModificationConfirmModificationBTN").click(function(event){
		try {
			event.preventDefault();
			$("#userManDevResultOrErrorDIV").html("");
			var deviceidInput = document.getElementById("userManDevDeviceModificationDeviceid");
			var deviceNameInput = document.getElementById("userManDevDeviceModificationDeviceName");				
			var deviceTypeInput = document.getElementById("userManDevDeviceModificationDeviceType");	
			var deviceTypeNameInput = document.getElementById("userManDevDeviceModificationDeviceTypeName");

			var hadError = 0;
			var errorMessage = "";
			
			if(deviceidInput.checkValidity() == false) {
				hadError++;
				errorMessage += "<p class='text-danger bg-primary'>Invalid deviceid!</p>";
			}
			
			if(deviceNameInput.checkValidity() == false) {
				hadError++;
				errorMessage += "<p class='text-danger bg-primary'>Invalid device name!</p>";
			}
			
			if(deviceTypeInput.checkValidity() == false) {
				hadError++;
				errorMessage += "<p class='text-danger bg-primary'>Invalid device type!</p>";
			}
			
			if(deviceTypeNameInput.checkValidity() == false) {
				hadError++;
				errorMessage += "<p class='text-danger bg-primary'>Invalid device type name!</p>";
			}
			
			if(Boolean(hadError)) {
				$("#userManDevResultOrErrorDIV").html(errorMessage);
				return;
			}
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					userid : $("#userManDevOwneridHidden").val(),
					deviceid : deviceidInput.value,
					deviceName : deviceNameInput.value,
					deviceType : deviceTypeInput.value,
					deviceTypeName : deviceTypeNameInput.value
				},
				url : "<c:url value='/tracking/user/mandevupdatedevicedetails'></c:url>",
				success : function(result, status, xhr) {
					try {
						if(result.executionState == true) {							
							$("#userManDevResultOrErrorDIV")
								.html("<p class='text-danger bg-primary'>Device modification was successful!</p>");
							$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
							var deviceid = deviceidInput.value;
							$("#userManDevDeviceName"+deviceid).val(deviceNameInput.value);
							$("#userManDevDeviceType"+deviceid).val(deviceTypeInput.value);
							$("#userManDevDeviceTypeName"+deviceid).val(deviceTypeNameInput.value);
							resizeTableElements();
							
						} else {
							var i = 0;
							var messages = result.messages;
							var length = messages.length;						
							var errorMessages = "";
							for(i; i < length; i++) {
								errorMessages = "<p class='text-danger bg-primary'>" + messages[i] + "</p>";
							}
							$("#userManDevResultOrErrorDIV").html(errorMessages);
							$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
						}					
					} catch(err) {
						alert(err);
					}				
				},
				error : function(xhr, status, error) {
					try {
						$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
						$("#userManDevResultOrErrorDIV").html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}									
				}			
			});			
		} catch(err) {
			alert(err);
		}
	});

	function resizeTableElements() {
		try {
			var resizeInputs = ["userManDevDeviceidClass", "userManDevDeviceNameClass",
			                    "userManDevDeviceTypeClass", "userManDevDeviceTypeNameClass"];
			resizeTableElementsByClassname(resizeInputs);		
		} catch(err) {
			alert(err);
		}
	}
	
	/*
	 * Table column width align.
	 * Every column with the max column length.
	 */ 
	$(document).ready(function(){	
		try {	
			resizeTableElements();			
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
				<div id="userManDevModifyDeviceDataDIV" class="table-responsive" >
					<div id="userManDevModifyDeviceCollapseDIV" class="collapse">
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
											id="userManDevDeviceModificationDeviceid" 
											readonly="readonly"
											pattern="${deviceidPattern}">	
									</td>
									<td>
										<label></label>
										<input type="text" value="" class="form-control"
											id="userManDevDeviceModificationDeviceName"
											pattern="${deviceNamePattern}">	
									</td>
									<td>
										<label></label>
										<input type="text" value="" class="form-control"
											id="userManDevDeviceModificationDeviceType"
											pattern="${deviceTypePattern}">	
									</td>
									<td>
										<label></label>
										<input type="text" value="" class="form-control"
											id="userManDevDeviceModificationDeviceTypeName"
											pattern="${deviceTypeNamePattern}">	
									</td>
								</tr>
								<tr>
									<td>
										<input type="button" value="Confirm modification!"
											id="userManDevDeviceModificationConfirmModificationBTN">
									</td>
									<td>
										<input type="button" value="Cancel modification!"
											id="userManDevDeviceModificationCancelModificationBTN"> 
									</td>
									<td>
										<input type="button" value="Delete device!"
											id="userManDevDeviceModificationDeleteDeviceBTN"> 
									</td>
									<td>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="userManDevResultOrErrorDIV"></div>
				<div style="overflow: auto; height: 800px">
					<div class="table-responsive">
						<table class="table" id="userManDevdataTables-example">
							<thead>
								<tr>
									<th>Deviceid</th>
									<th>Device name</th>
									<th>Device type</th>
									<th>Device type name</th>
									<th>Device modification</th> 
								</tr>
							</thead>
							<tbody>							
								<c:forEach var="device" items="${devices}" >
									<tr id="userManDevDeviceRow${device.deviceid}">
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
											class="userManDevStartDeviceModification">Modify device
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