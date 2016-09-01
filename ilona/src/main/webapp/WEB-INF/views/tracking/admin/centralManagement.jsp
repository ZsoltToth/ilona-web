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

<script>
	
	var states = {
			enabledCheck : ${enabledCheck},
			enabledCheckLock: {value: true}
	}
	
	$(document).ready(function(){
		generateText();
		
		if(states.enabledCheck == true) {
			$("#adminCentManEnableCheckOnOff").attr("value", "ON");
			$("#adminCentManEnableCheckOnOff").addClass("btn-success");
		} else {
			$("#adminCentManEnableCheckOnOff").attr("value", "OFF");
			$("#adminCentManEnableCheckOnOff").addClass("btn-danger");
		}
	});
	
	var accountExpirationTime = ${accExpTime};
	var accountExpirationMaximumTime = 3 * 31536000000;
	var accountExpirationMinimumTime = 2678400000;
	
	var oneYear = 31536000000;
	var oneMonth = 2678400000;
	var oneDay = 86400000;
	var oneHour = 3600000;
	
	function calculateYearMonthDayHour(time) {
		
		var expirationTemp = accountExpirationTime;
		
		data = {
				years: 0,
				months: 0,
				days: 0,
				hours: 0
		}
		/*
		data.years = expirationTemp / oneYear;
		expirationTemp = expirationTemp % oneYear;
		
		data.months = expirationTemp / oneMonth;
		expirationTemp = expirationTemp % oneMonth;
		
		data.days = expirationTemp / oneYear;
		expirationTemp = expirationTemp % oneDay;
		
		// seconds + milliseconds division
		data.hours = expirationTemp / 3600000;
		*/
		
					
		while (expirationTemp - oneYear >= 0) {
			expirationTemp -= oneYear;
			data.years++;
		}
		
		while (expirationTemp - oneMonth >= 0) {
			expirationTemp -= oneMonth;
			data.months++;
		}
		
		while (expirationTemp - oneDay >= 0) {
			expirationTemp -= oneDay;
			data.days++;
		}
		
		while (expirationTemp - oneHour >= 0) {
			expirationTemp -= oneHour;
			data.hours++;
		}	
		return data;
	}
	
	function generateText() {
		try {		
			var data = calculateYearMonthDayHour()
			$("#adminCentManAccountExpirationOutputDIV")
				.html("<h4>Year: " + data.years + "y  Months: " + data.months 
						+ "m  days: " + data.days + "d  hours: " + data.hours + "h</h4>");
			
		} catch(error) {
			console.log(error);	
		}
	}
	
	$(".adminCentManAccountExpirationValueClass").click(function(event){
		try {
		
			var value = $(this).attr("data-expirationtime");
			console.log(value);
			function checkAccountExpiration() {
				if (accountExpirationTime > accountExpirationMaximumTime) {
					accountExpirationTime = accountExpirationMaximumTime;
				}
				if (accountExpirationTime < accountExpirationMinimumTime) {
					accountExpirationTime = accountExpirationMinimumTime;
				}
			}
			
			switch(value) {
			case "yearplus": 
				accountExpirationTime += oneYear;
				checkAccountExpiration();
				break;		
			case "yearminus":
				accountExpirationTime -= oneYear;
				checkAccountExpiration();
				break;			
			case "monthplus":
				accountExpirationTime += oneMonth;
				checkAccountExpiration();
				break;		
			case "monthminus":
				accountExpirationTime -= oneMonth;
				checkAccountExpiration();
				break;			
			case "dayplus":
				accountExpirationTime += oneDay;
				checkAccountExpiration();
				break;			
			case "dayminus":
				accountExpirationTime -= oneDay;
				checkAccountExpiration();
				break;			
			case "hourplus":
				accountExpirationTime += oneHour;
				checkAccountExpiration();
				break;		
			case "hourminus": 
				accountExpirationTime -= oneHour;
				checkAccountExpiration();
				break;		
			default:
				break;
			}
	
			generateText();
		} catch(error) {
			console.log(error);
		}
	});
	
	$(".onOffButton").click(function(event){
		try {
			var value = $(this).attr("value");
			if(value == "ON") {
				$(this).removeClass("btn-success");
				$(this).addClass("btn-danger");
				$(this).attr("value", "OFF");
			} else {
				$(this).removeClass("btn-danger");
				$(this).addClass("btn-success");			
				$(this).attr("value", "ON");
			}
		} catch(error) {
			console.log(error);
		}
	});
	
	$(".centManUpdateState").click(function(event){
		try {
			event.preventDefault();
			var value = $("#"+$(this).attr("data-value")).attr("value");
			var lock = $(this).attr("data-lock");
			updateDetails($(this).attr("data-url"), {data: value},
					$(this).attr("data-result"), states["" + lock]);
		} catch(error) {
			console.log(error);
		}
	});
	
	function updateDetails(url, data, resultDiv, lock) {
		try {
			if(lock.value == true) {
				lock.value = false;
			} else {
				return;
			}
			$.ajax({
				type: "POST",
				async: true,
				url: url,
				data: data,
				timeout: 10000,
				beforeSend : function(xhr) {
					xhr.setRequestHeader($("meta[name='_csrf_header']").attr("content"),
						$("meta[name='_csrf']").attr("content"));
				},
				success: function(result, status, xhr) {
					try {
						lock.value = true;
						if(result.responseState == 100) {
							$("#" + resultDiv).html("<p class='bg-primary'>Update success!</p>");
						} else {
							$("#" + resultDiv).html("<p class='bg-primary'>Update failed!!</p>");
						}
					} catch(error) {
						console.log(error);
					}			
				},
				error: function(xhr, status, error) {
					try {
						lock.value = true;
						$("#" + resultDiv).html("<p class='bg-primary'>Update failed!!</p>");
						console.log("" + status + " " + error);
					} catch(err) {
						console.log(err);
					}
				}
			});
		} catch(error) {
			try {
				lock.value = true;
				$("#" + resultDiv).html("<p class='bg-primary'>Update failed!!</p>");
			} catch(err) {
				console.log(err);
			}
		}
	}
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-4">
			<div class="panel panel-default">
				<div class="panel-heading">					
						<b>Account expiration duration</b>
				</div>
				<div class="panel-body">
					<div>
						<table class="table table-condensed">
							<thead>
								<tr>
									<td>Years</td>
									<td>Months</td>
									<td>Days</td>
									<td>Hours</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<input type="button" value="+" class="col-sm adminCentManAccountExpirationValueClass" 
											data-expirationtime="yearplus">
										<input type="button" value="-" class="col-sm adminCentManAccountExpirationValueClass"
											data-expirationtime="yearminus">
									</td>
									<td>
										<input type="button" value="+" class="col-sm adminCentManAccountExpirationValueClass"
											data-expirationtime="monthplus">
										<input type="button" value="-" class="col-sm adminCentManAccountExpirationValueClass" 
											data-expirationtime="monthminus">
									</td>
									<td>
										<input type="button" value="+" class="col-sm adminCentManAccountExpirationValueClass" 
											data-expirationtime="dayplus">
										<input type="button" value="-" class="col-sm adminCentManAccountExpirationValueClass" 
											data-expirationtime="dayminus">
									</td>
									<td>
										<input type="button" value="+" class="col-sm adminCentManAccountExpirationValueClass" 
											data-expirationtime="hourplus">
										<input type="button" value="-" class="col-sm adminCentManAccountExpirationValueClass" 
											data-expirationtime="hourminus">
									</td>
								</tr>
							</tbody>
						</table>
						<label>Last login validity time:</label>
						<div id="adminCentManAccountExpirationOutputDIV"></div>
					</div>
				</div> <!-- panel body ending -->
			</div> <!-- panel ending -->
		</div> <!-- COL-LG-4 ending -->
		
		<div class="col-lg-4">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>
						<b>Heading</b>
					</h4>
				</div>
				<div class="panel-body">Pane body</div>
			</div>
		</div>
		
		<div class="col-lg-4">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>
						<b>Heading</b>
					</h4>
				</div>
				<div class="panel-body">Pane body</div>
			</div>
		</div>
	</div> <!-- ROW ending -->
	
	<div class="row">
		<div class="col-lg-3">
			<div class="panel panel-default">
				<div class="panel-heading">					
						<b>Account enabled check </b>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table class="table">
							<tbody>
								<tr>
									<td>
										<input type="button" value="" class="btn onOffButton"
											id="adminCentManEnableCheckOnOff" >									
									</td>
									<td>
										<input type="button" value="Update" class="btn btn-primary centManUpdateState"
											data-url="<c:url value='/tracking/admin/centman/updateenabled'/>" 
											data-result="adminCentManAccountEnabledResultDIV"
											data-value="adminCentManEnableCheckOnOff"
											data-lock="enabledCheckLock">
									</td>
								</tr>
							</tbody>
						</table>
						<div id="adminCentManAccountEnabledResultDIV"></div>			
					</div>
				</div> <!-- panel body ending -->
			</div> <!-- panel ending -->
		</div>
		
		<div class="col-lg-3">
			<div class="panel panel-default">
				<div class="panel-heading">					
						<b>Account enabled check </b>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table class="table">
							<tbody>
								<tr>
									<td>
										<input type="button" value="" class="btn onOffButton"
											id="adminCentManAccExpirationCheckOnOff" >									
									</td>
									<td>
										<input type="button" value="Update" class="btn btn-primary centManUpdateState"
											data-url="<c:url value='/tracking/admin/centman/updateaccexpcheck'/>" 
											data-result="adminCentManAccExpirationCheckResultDIV"
											data-value="adminCentManAccExpirationCheckOnOff"
											data-lock="enabledCheckLock">
									</td>
								</tr>
							</tbody>
						</table>
						<div id="adminCentManAccExpirationCheckResultDIV"></div>			
					</div>
				</div> <!-- panel body ending -->
			</div> <!-- panel ending -->
		</div>

	</div>
	
	<div class="row">
		<div class="col-lg-3">
			<div class="panel panel-default">
				<div class="panel-heading">					
						<b>Account enabled check </b>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table class="table">
							<tbody>
								<tr>
									<td>
										<input type="button" value="ON" class="btn btn-success onOffButton">									
									</td>
									<td>
										<input type="button" value="Update" class="btn btn-primary">
									</td>
								</tr>
							</tbody>
						</table>
											
					</div>
				</div> <!-- panel body ending -->
			</div> <!-- panel ending -->
		</div>
		

	</div>
</div>