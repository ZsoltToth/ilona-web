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

	$("#adminCreateNewDeviceCreateNewDeviceBTN").click(function(event){
		try {
			event.preventDefault();
			
			
			var deviceIdElement = document.getElementById("adminCreateNewDeviceDeviceidTXT");
			var deviceNameElement = document.getElementById("adminCreateNewDeviceDeviceNameTXT");
			var deviceTypeElement = document.getElementById("adminCreateNewDeviceDeviceTypeTXT");
			var deviceTypeNameElement = document.getElementById("adminCreateNewDeviceDeviceTypeNameTXT");
			
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
				$("#adminCreateNewDeviceResultDIV").html(errorText);
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
				url : "<c:url value='/tracking/admin/createnewdeviceforuser'></c:url>",
				data : {
					userid : $("#adminCreateNewDeviceOwnerIDHIDDEN").val(),
					deviceid : $("#adminCreateNewDeviceDeviceidTXT").val(),
					deviceName : $("#adminCreateNewDeviceDeviceNameTXT").val(),
					deviceType : $("#adminCreateNewDeviceDeviceTypeTXT").val(),
					deviceTypeName : $("#adminCreateNewDeviceDeviceTypeNameTXT").val()
				},
				success : function(result, status, xhr) {
					if(result.executionState == true) {
						$("#adminCreateNewDeviceDeviceidTXT").val("");
						$("#adminCreateNewDeviceDeviceNameTXT").val("");
						$("#adminCreateNewDeviceDeviceTypeTXT").val("");
						$("#adminCreateNewDeviceDeviceTypeNameTXT").val("");
						$("#adminCreateNewDeviceResultDIV")
							.html("<p class='text-danger bg-primary'>The device has been created!</p>");
					} else {
						$("#adminCreateNewDeviceDeviceidTXT").val("");
						$("#adminCreateNewDeviceDeviceNameTXT").val("");
						$("#adminCreateNewDeviceDeviceTypeTXT").val("");
						$("#adminCreateNewDeviceDeviceTypeNameTXT").val("");
						var i = 0;
						var messages = result.messages;
						var length = messages.length;
						var resultStatus = "";
						for(i; i < length; i++) {
							resultStatus += "<p class='bg-primary'>" + messages[i] + "</p>";
						}					
						$("#adminCreateNewDeviceResultDIV").html(resultStatus);
					}
				},
				error : function(xhr, status, error) {
					alert("Error device creation!"+status+error);
				}
			});
		} catch(err) {
			console.log(err);
		}
	});	
</script>


<jsp:directive.include file="adminNavbar.jsp" />

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<p>Userid: ${deviceOwnerid}</p>
			</div>
			<div class="panel-body">
				<div id="adminCreateNewDeviceResultDIV"></div>
				
				<label for="adminCreateNewDeviceDeviceidTXT">Deviceid: <br /> 
					<a href="#adminCreateNewDeviceDeviceidDropdown" 
						data-toggle="collapse">Click for more information:
					</a>
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${deviceidRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				<p id="adminCreateNewDeviceDeviceidDropdown" class="collapse">
					${deviceidRestriction}
				</p>
				
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceidTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${deviceidPattern}"
					name="userid"> <br />
					
				<label for="adminCreateNewDeviceDeviceNameTXT">Device name: <br />
					<a href="#adminCreateNewDeviceDeviceNameDropdown" 
						data-toggle="collapse">Click for more information:
					</a>
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${deviceNameRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				<p id="adminCreateNewDeviceDeviceNameDropdown" class="collapse">
					${deviceNameRestriction}
				</p>
					
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceNameTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${deviceNamePattern}"
					name="userid"> <br />
					
				<label for="adminCreateNewDeviceDeviceTypeTXT">Device type: <br />
					<a href="#adminCreateNewDeviceDeviceTypeDropdown" 
						data-toggle="collapse">Click for more information:
					</a>
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${deviceTypeRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				<p id="adminCreateNewDeviceDeviceTypeDropdown" class="collapse">
					${deviceTypeRestriction}
				</p>
					
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceTypeTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${deviceTypePattern}"
					name="userid"> <br />
					
				<label for="adminCreateNewDeviceDeviceTypeNameTXT">Device type name: <br />
					<a href="#adminCreateNewDeviceDeviceTypeNameDropdown" 
						data-toggle="collapse">Click for more information:
					</a>
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${deviceTypeNameRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
				<p id="adminCreateNewDeviceDeviceTypeNameDropdown" class="collapse">
					${deviceTypeNameRestriction}
				</p>
					
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceTypeNameTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${deviceTypeNamePattern}"
					name="userid"> <br />
				
				<input type="button" id="adminCreateNewDeviceCreateNewDeviceBTN" value="Add Device!" class="btn btn-primary">
				<input type="hidden" id="adminCreateNewDeviceOwnerIDHIDDEN" value="${deviceOwnerid}">
			</div>		
		</div>
	</div>
</div>