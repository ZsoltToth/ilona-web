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

	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();

	$("#userCreateDeviceCreatDeviceBTN").click(function(event){
		try {
			event.preventDefault();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$("#userCreateDeviceCreationErrorDIV").html("");
			
			var deviceIdElement = document.getElementById("userCreateDeviceDeviceidTXT");
			var deviceNameElement = document.getElementById("userCreateDeviceDeviceNameTXT");
			var deviceTypeElement = document.getElementById("userCreateDeviceDeviceTypeTXT");
			var deviceTypeNameElement = document.getElementById("userCreateDeviceDeviceTypeNameTXT");
			
			var hadError = 0;
			var errorText = "";
			
			if (deviceIdElement.checkValidity() == false) {
				hadError++;
				errorText += "<p class='text-danger bg-primary'>Invalid deviceid!</p>";
			}
			
			if(deviceNameElement.checkValidity() == false) {
				hadError++;
				errorText += "<p class='text-danger bg-primary'>Invalid device name!</p>";
			}
			
			if(deviceTypeElement.checkValidity() == false) {
				hadError++;
				errorText += "<p class='text-danger bg-primary'>Invalid device type!</p>";
			}
			
			if(deviceTypeNameElement.checkValidity() == false) {
				hadError++;
				errorText += "<p class='text-danger bg-primary'>Invalid device type name!</p>";
			}
			
			if(Boolean(hadError)) {
				$("#userCreateDeviceCreationErrorDIV").html(errorText);
				return;
			}
			
			$.ajax({
				type : "POST",
				async : true,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				url : "<c:url value='/tracking/user/createnewdevice'></c:url>",
				data : {
					userid : $("#userCreateDeviceOwneridHidden").val(),
					deviceid : $("#userCreateDeviceDeviceidTXT").val(),
					deviceName : $("#userCreateDeviceDeviceNameTXT").val(),
					deviceType : $("#userCreateDeviceDeviceTypeTXT").val(),
					deviceTypeName : $("#userCreateDeviceDeviceTypeNameTXT").val()
				},
				success : function(result, status, xhr) {
					var i = 0;
					length = result.length;
					resultStatus = "";
					for(i; i < length; i++) {
						resultStatus += "<p class='bg-primary'>" + result[i] + "</p>";
					}					
					$("#userCreateDeviceDeviceidTXT").val("");
					$("#userCreateDeviceDeviceNameTXT").val("");
					$("#userCreateDeviceDeviceTypeTXT").val("");
					$("#userCreateDeviceDeviceTypeNameTXT").val("");
					$("#userCreateDeviceCreationErrorDIV").html(resultStatus);
				},
				error : function(xhr, status, error) {
					$("#userCreateDeviceDeviceidTXT").val("");
					$("#userCreateDeviceDeviceNameTXT").val("");
					$("#userCreateDeviceDeviceTypeTXT").val("");
					$("#userCreateDeviceDeviceTypeNameTXT").val("");				
					$("#userCreateDeviceCreationErrorDIV").html("<p class='bg-primary'>Service error!</p>");
				}
			});
		} catch(err) {
			try {
				$("#userCreateDeviceCreationErrorDIV").html("<p class='bg-primary'>Service error!</p>");
			} catch(error) {
				console.log(error);
			}
		}
	});	
</script>

<jsp:directive.include file="userNavbar.jsp" />
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<p>Userid: ${deviceOwnerid}</p>
				</div>
				<div class="panel-body">
					<div id="userCreateDeviceCreationErrorDIV"></div>
										
					<label for="userCreateDeviceDeviceidTXT">Deviceid: <br />
					 	<a href="#userCreateDeviceDeviceidDropdown" 
							data-toggle="collapse">Click for more information:
						</a>
						<span data-toggle="popover"
							data-html="true"
							data-trigger="hover"
							data-content="${deviceidRestriction}"
							title="The deviceid can contain the following elements:"
							class="fa  fa-info-circle">
						</span>
					</label>
					<p id="userCreateDeviceDeviceidDropdown" class="collapse">
						${deviceidRestriction}
					</p>
						
					<input type="text"
						class="form-control"
						id="userCreateDeviceDeviceidTXT"
						required="required"
						placeholder="Please type in your userid!"
						pattern="${deviceidPattern}"
						name="deviceid"> <br />
						
					<label for="userCreateDeviceDeviceNameTXT">Device name: <br />
						<a href="#userCreateDeviceDeviceNameDropdown" 
							data-toggle="collapse">Click for more information:
						</a>
						<span data-toggle="popover"
							data-html="true"
							data-trigger="hover"
							data-content="${deviceNameRestriction}"
							title="The device name can contain the following elements:"
							class="fa  fa-info-circle">
						</span>
					</label>
					<p id="userCreateDeviceDeviceNameDropdown" class="collapse">
						${deviceNameRestriction}
					</p>
						
					<input type="text"
						class="form-control"
						id="userCreateDeviceDeviceNameTXT"
						required="required"
						placeholder="Please type in your userid!"
						pattern="${deviceNamePattern}"
						name="devicename"> <br />
						
					<label for="userCreateDeviceDeviceTypeTXT">Device type: <br />
						<a href="#userCreateDeviceDeviceTypeDropdown" 
							data-toggle="collapse">Click for more information:
						</a>
						<span data-toggle="popover"
							data-html="true"
							data-trigger="hover"
							data-content="${deviceTypeRestriction}"
							title="The device type can contain the following elements:"
							class="fa  fa-info-circle">
						</span>
					</label>
					<p id="userCreateDeviceDeviceTypeDropdown" class="collapse">
						${deviceTypeRestriction}
					</p>
						
					<input type="text"
						class="form-control"
						id="userCreateDeviceDeviceTypeTXT"
						required="required"
						placeholder="Please type in your userid!"
						pattern="${deviceTypePattern}"
						name="devicetype"> <br />
						
					<label for="userCreateDeviceDeviceTypeNameTXT">Device type name: <br />
						<a href="#userCreateDeviceDeviceTypeNameDropdown" 
							data-toggle="collapse">Click for more information:
						</a>
						<span data-toggle="popover"
							data-html="true"
							data-trigger="hover"
							data-content="${deviceTypeNameRestriction}"
							title="The device type name can contain the following elements:"
							class="fa  fa-info-circle">
						</span>
					</label>
					<p id="userCreateDeviceDeviceTypeNameDropdown" class="collapse">
						${deviceTypeNameRestriction}
					</p>
						
					<input type="text"
						class="form-control"
						id="userCreateDeviceDeviceTypeNameTXT"
						required="required"
						placeholder="Please type in your userid!"
						pattern="${deviceTypeNamePattern}"
						name="devicetypename"> <br />
					
					<input type="button" id="userCreateDeviceCreatDeviceBTN" value="Add Device!" class="btn btn-primary">
					<input type="hidden" id="userCreateDeviceOwneridHidden" value="${deviceOwnerid}">
				</div>
				<div>
					<c:if test="${executionError != null}">
						<p class="bg-primary">Service error device cannot be loaded!</p>
					</c:if>			
				</div>
			</div>
	
		</div>
	</div>
</div>