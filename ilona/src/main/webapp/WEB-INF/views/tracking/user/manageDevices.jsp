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

<script src="<c:url value='/js/tracking/deviceValidation.js'></c:url>"></script>
<script src="<c:url value='/js/deviceManagement.js'></c:url>"></script>



<script type="text/javascript">
	
	var userManDevDeviceModificationDeleteDeviceLock = true;
	
	var userManDevDeviceidBeforeModification;
	var userManDevDeviceNameBeforeModification;
	var userManDevDeviceTypeBeforeModification;
	var userManDevDeviceTypeNameBeforeModification;
	
	$("#userManDevDeviceModificationDeleteDeviceBTN").click(function(event){
		try {
			event.preventDefault();
			if(userManDevDeviceModificationDeleteDeviceLock == true) {
				userManDevDeviceModificationDeleteDeviceLock = false;
			} else {
				return;
			}
			$.ajax({
				type : "POST",
				async : true,
				url : "<c:url value='/tracking/user/mandevdeletedevice'></c:url>",
				beforeSend : function(xhr) {
					xhr.setRequestHeader($("meta[name='_csrf_header']").attr("content"), 
							$("meta[name='_csrf']").attr("content"));
				},
				data : {
					userid : $("#userManDevOwneridHidden").val(),
					deviceid : $("#userManDevDeviceModificationDeviceid").val(),
					deviceType : $("#userManDevDeviceModificationDeviceType").val(),
					deviceTypeName : $("#userManDevDeviceModificationDeviceTypeName").val()
				},
				success : function(result, status, error) {
					try {
						userManDevDeviceModificationDeleteDeviceLock = true;
						switch(result.responseState) {
						case 100: {
							$("#userManDevResultOrErrorDIV")
								.html("<p class='bg-primary'>Device has been deleted successfully!</p>");
							var deviceid = "#userManDevDeviceRow" + $("#userManDevDeviceModificationDeviceid").val();						
							$(deviceid).remove();
							break;
						}
						case 200: {
							$("#userManDevResultOrErrorDIV")
							.html("<p class='bg-primary'>Device data was invalid!</p>");
							break;
						}
						case 400: {
							$("#userManDevResultOrErrorDIV")
							.html("<p class='bg-primary'>Service error!</p>");
							break;
						}
						case 600: {
							$("#userManDevResultOrErrorDIV")
							.html("<p class='bg-primary'>Device not found and not deleted with id: "
									+ $("#userManDevDeviceModificationDeviceid").val() + "</p>");
							break;
						}
						default: {
							$("#mainpageSignupErrorDIV")
							.html("<p class='bg-primary'>Service error!</p>");
							break;
						}
						}
						$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
						
					} catch(err) {
						console.log(err);
					}
				},
				error : function(xhr, status, error) {
					try {
						userManDevDeviceModificationDeleteDeviceLock = true;
						$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
						$("#userManDevResultOrErrorDIV").html("<p class='text-danger bg-primary'>Service error!</p>");
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(err) {
			userManDevDeviceModificationDeleteDeviceLock = true;
			console.log(err);
		}
	});
	
	$("#userManDevDeviceModificationCancelModificationBTN").click(function(event){
		try {
			event.preventDefault();
			$("#userManDevResultOrErrorDIV").html("");
			$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");
		} catch(err) {
			console.log(err);
		}
	});
	
	$(".userManDevStartDeviceModification").click(function(event){
		try {
			event.preventDefault();
			$("#userManDevResultOrErrorDIV").html("");
			var actualDeviceid = $(this).attr("href");		
			var deviceNameInputValue = document.getElementById("userManDevDeviceName" + actualDeviceid).textContent.trim();
			var deviceTypeInputValue = document.getElementById("userManDevDeviceType" + actualDeviceid).textContent.trim();			
			var deviceTypeNameInputValue =  document.getElementById("userManDevDeviceTypeName" + actualDeviceid).textContent.trim();
			
			$("#userManDevDeviceModificationDeviceid").val(actualDeviceid);
			$("#userManDevDeviceModificationDeviceName").val(deviceNameInputValue);		
			$("#userManDevDeviceModificationDeviceType").val(deviceTypeInputValue);
			$("#userManDevDeviceModificationDeviceTypeName").val(deviceTypeNameInputValue);
			
			userManDevDeviceidBeforeModification = actualDeviceid;
			userManDevDeviceNameBeforeModification = deviceNameInputValue;
			userManDevDeviceTypeBeforeModification = deviceTypeInputValue;
			userManDevDeviceTypeNameBeforeModification = deviceTypeNameInputValue;
			
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

			var inputs = {
				deviceid: document.getElementById("userManDevDeviceModificationDeviceid").value,
				deviceName: document.getElementById("userManDevDeviceModificationDeviceName").value,
				deviceType: document.getElementById("userManDevDeviceModificationDeviceType").value,
				deviceTypeName: document.getElementById("userManDevDeviceModificationDeviceTypeName").value
			};
			
			function restoreDeviceModification() {
				$("#userManDevDeviceModificationDeviceid").val(userManDevDeviceidBeforeModification);
				$("#userManDevDeviceModificationDeviceName").val(userManDevDeviceNameBeforeModification);
				$("#userManDevDeviceModificationDeviceType").val(userManDevDeviceTypeBeforeModification);
				$("#userManDevDeviceModificationDeviceTypeName").val(userManDevDeviceTypeNameBeforeModification);
			}
			
			var dependency = {
				validateInputs : checkDevicesInputsValidity
			};
					
			var result = dependency.validateInputs(inputs);

			if(result.valid == false) {
				$("#userManDevResultOrErrorDIV").html(result.errors);
				restoreDeviceModification();
				return;
			}
			
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					xhr.setRequestHeader($("meta[name='_csrf_header']").attr("content"), 
							$("meta[name='_csrf']").attr("content"));
				},
				data : {
					userid : $("#userManDevOwneridHidden").val(),
					deviceid : document.getElementById("userManDevDeviceModificationDeviceid").value,
					deviceName : document.getElementById("userManDevDeviceModificationDeviceName").value,
					deviceType : document.getElementById("userManDevDeviceModificationDeviceType").value,
					deviceTypeName : document.getElementById("userManDevDeviceModificationDeviceTypeName").value
				},
				url : "<c:url value='/tracking/user/mandevupdatedevicedetails'></c:url>",
				success : function(result, status, xhr) {
					try {
						switch(result.responseState) {
						case 100: {
							$("#userManDevResultOrErrorDIV")
								.html("<p class='bg-primary'>The device has been updated successfully!</p>");
							var deviceid = document.getElementById("userManDevDeviceModificationDeviceid").value;
							$("#userManDevDeviceName"+deviceid)
								.text(document.getElementById("userManDevDeviceModificationDeviceName").value);
							
							dataTableDevices.fnDraw();
							/*
							var deviceid = document.getElementById("userManDevDeviceModificationDeviceid").value;
							document.getElementById("userManDevDeviceName"+deviceid).textContent = 
								document.getElementById("userManDevDeviceModificationDeviceName").value);
			
							document.getElementById("userManDevDeviceType"+deviceid).textContent = 
								document.getElementById("userManDevDeviceModificationDeviceType").value);
	
							document.getElementById("userManDevDeviceTypeName"+deviceid).textContent = 
								document.getElementById("userManDevDeviceModificationDeviceTypeName").value);
							//resizeTableElements();
							*/
							break;
						}
						case 300: {
							$("#userManDevResultOrErrorDIV")
							.html("<p class='bg-primary'>Device data was invalid!</p>");
							restoreDeviceModification();
							return;
						}
						case 400: {
							$("#userManDevResultOrErrorDIV")
							.html("<p class='bg-primary'>Service error!</p>");
							break;
						}
						case 600: {
							$("#userManDevResultOrErrorDIV")
							.html("<p class='bg-primary'>Device not found with this id: " 
									+ $("#userCreateDeviceDeviceidTXT").val() + "</p>");
							break;
						}
						default: {
							$("#userManDevResultOrErrorDIV")
							.html("<p class='bg-primary'>Service error!</p>");
							break;
						}
						}
						$("#userManDevModifyDeviceCollapseDIV").addClass("collapse");											
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

	function resizeTableElements() {
		try {
			var resizeInputs = ["userManDevDeviceidClass", "userManDevDeviceNameClass",
			                    "userManDevDeviceTypeClass", "userManDevDeviceTypeNameClass"];
			//resizeTableElementsByClassname(resizeInputs);		
		} catch(err) {
			console.log(err);
		}
	}
	
	/*
	 * Table column width align.
	 * Every column with the max column length.
	 */
	 var dataTableDevices; 
	 
	$(document).ready(function(){	
		try {
			var userManDevDevices = [["dsdd","dsdsd"]];
			             			
			
			//resizeTableElements();
			//alert(userManDevDevices["dev0001"].deviceid);
			
			$("#proba1").dataTable({
				data: userManDevDevices,
				 columns: [
				            { title: "Name" },
				            { title: "Position" },			           
				        ]
			});
			
			dataTableDevices = $("#userManDevDataTable").dataTable({
				responsive: true
				
			});
		} catch(err) {
			console.log(err);
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
					<div class="table-responsive">
						<table class="display" id="userManDevDataTable">
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
										<td>${device.deviceid}</td>
										
										<td id="userManDevDeviceName${device.deviceid}">${device.deviceName}</td>
											
										<td id="userManDevDeviceType${device.deviceid}">${device.deviceType}</td>
											
										<td id="userManDevDeviceTypeName${device.deviceid}">${device.deviceTypeName}</td>						
											
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
				
			</div> <!-- panel body end -->
			<div class="panel-body">
				${executionError}
				<table id="proba1">
			
			</table>
			</div>
			<div>
			
			</div>
		</div> <!-- panel default ending -->

	</div><!-- col-lg-12 ending -->

</div> <!-- container ending -->