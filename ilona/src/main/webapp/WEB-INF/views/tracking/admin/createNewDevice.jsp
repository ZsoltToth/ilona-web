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

	$("#adminCreateNewDeviceCreateNewDeviceBTN").click(function(event){
		event.preventDefault();
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
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("Error device creation!"+status+error);
			}
		});
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
				
				<label for="adminCreateNewDeviceDeviceidTXT">Deviceid: <br /> For more information:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceidTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
					
				<label for="adminCreateNewDeviceDeviceNameTXT">Device name: <br /> For more information:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceNameTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
					
				<label for="adminCreateNewDeviceDeviceTypeTXT">Device type: <br /> For more information:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceTypeTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
					
				<label for="adminCreateNewDeviceDeviceTypeNameTXT">Device type name: <br /> For more information:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text"
					class="form-control"
					id="adminCreateNewDeviceDeviceTypeNameTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
				
				<input type="button" id="adminCreateNewDeviceCreateNewDeviceBTN" value="Add Device!" class="btn btn-primary">
				<input type="hidden" id="adminCreateNewDeviceOwnerIDHIDDEN" value="${deviceOwnerid}">
			</div>
			<div class="panel-body">${OperationError}</div>
		</div>

	</div>
</div>