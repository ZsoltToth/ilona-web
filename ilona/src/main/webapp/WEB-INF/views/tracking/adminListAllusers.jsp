<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"></h3>
			</div>
		</div>

		<div class="panel-body">
			<div class="dataTable_wrapper">
				<div id="dataTables-example_wrapper"
					class="dataTables_wrapper form-inline dt-bootstrap no-footer">
					<div class="row">
						<div class="col-sm-6">
							<div id="dataTables-example_length" class="dataTables_length">
								<label>Show <select class="form-control input-sm"
									aria-controls="dataTables-example"
									name="dataTables-example_length">
										<option value="10">10</option>
										<option value="25">25</option>
										<option value="50">50</option>
										<option value="100">100</option>
								</select>
								</label>
							</div>
						</div>
						<div class="col-sm-6">
							<div id="dataTables-example_filter" class="dataTables_filter">
								<label>Search: <input class="form-control input-sm"
									aria-controls="dataTables-example" type="search">
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table id="dataTables-example"
								class="table table-striped table-bordered table-hover dataTable no-footer"
								aria-describedby="dataTables-example_info" role="grid">
								<thead></thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					<div class="row"></div>
				</div>
			</div>
			<c:forEach var="user" items="${users}">
				<input type="text" class="form-control" readonly="readonly"
					required="required" value="${user.getUserid()}">
				<span></span>
				<br>
				<br>
			</c:forEach>
	
		</div>
	</div>
</div>
