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

	$("#userCreateDeviceCreatDeviceBTN").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
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
				$("#page-wrapper").html(result);
			},
			error : function(xhr, status, error) {
				alert("Error device creation!"+status+error);
			}
		});
	});	
</script>

<jsp:directive.include file="userNavbar.jsp" />

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<p>Userid: ${deviceOwnerid}</p>
			</div>
			<div class="panel-body">
				
				<label for="userCreateDeviceDeviceidTXT">Deviceid: <br /> For more information:
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
					id="userCreateDeviceDeviceidTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
					
				<label for="userCreateDeviceDeviceNameTXT">Device name: <br /> For more information:
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
					id="userCreateDeviceDeviceNameTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
					
				<label for="userCreateDeviceDeviceTypeTXT">Device type: <br /> For more information:
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
					id="userCreateDeviceDeviceTypeTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
					
				<label for="userCreateDeviceDeviceTypeNameTXT">Device type name: <br /> For more information:
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
					id="userCreateDeviceDeviceTypeNameTXT"
					required="required"
					placeholder="Please type in your userid!"
					pattern="${useridPattern}"
					name="userid"> <br />
				
				<input type="button" id="userCreateDeviceCreatDeviceBTN" value="Add Device!" class="btn btn-primary">
				<input type="hidden" id="userCreateDeviceOwneridHidden" value="${deviceOwnerid}">
			</div>
			<div class="panel-body">${executionError}</div>
		</div>

	</div>
</div>