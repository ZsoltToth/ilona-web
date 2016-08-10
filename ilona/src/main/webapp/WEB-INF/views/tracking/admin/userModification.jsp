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
	
	$("#automaticPasswordChange").click(function(event){
		event.preventDefault();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "POST",
			async : true,
			url : "<c:url value='/tracking/admin/automatedpasswordreset'></c:url>",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : "patriku"
			},
			success : function(result, status, xhr) {
				alert("success!");
			},
			error : function(xhr, status, error) {
				alert("error!"+status+error);
			}
		});
	});
	
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="row">
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				User base details:
			</div>
			<div class="panel-body">
				<label for="creationUserid">Userid:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text" 
					class="form-control"
					id="adminUserModUseridTXT"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />
					
				<label for="creationUserid">Username:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text" 
					class="form-control"
					id="creationUserid"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />
					
				<label for="creationUserid">Email address:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text" 
					class="form-control"
					id="creationUserid"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />
				
				<label for="creationUserid">Enabled:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label> <br />
					
				<input type="checkbox" 
					id="creationUserid"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />
			</div>
		</div>
	</div>
	
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				User password change
			</div>
			<div class="panel-body">
				<label for="creationUserid">Password:
					<span data-toggle="popover"
						data-html="true"
						data-trigger="hover"
						data-content="${useridRestriction}"
						title="The userid pattern can contain the following elements:"
						class="fa  fa-info-circle">
					</span>
				</label>
					
				<input type="text" 
					class="form-control"
					id="creationUserid"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />			
					
				<input type="text" 
					class="form-control"
					id="creationUserid"
					required="required"
					placeholder="Please type in the userid!"
					pattern = "${useridPattern}"
					name="userid"><br />
					
				<input type="button" value="Change password!" id="changepadasd"><br /><br /><br />
				<input type="button" value="Generate and send password!" id="automaticPasswordChange">
				
			</div>
		</div>
	</div>
</div>
