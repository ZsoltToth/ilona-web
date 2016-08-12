<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>


<!-- CSRF Protection token -->
<meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script type="text/javascript">

	$("#selectUsers").click(function(event){
		event.preventDefault();
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var selectedIndex = document.getElementById("sel2").selectedIndex;
		 
		$.ajax({
			type : "POST",
			async : true,
			url : "<c:url value='/tracking/admin/trackingselectdevicesforuser' ></c:url>",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data : {
				userid : ""
			},
			success : function(result, status, xhr) {
				alert("SUCCESS!")
			},
			error : function(xhr, status, error) {
				alert("ERROR!");
			}
		});
		/*
		var list = document.getElementById("sel2");
		var szov = "";
		while(list.length != 0) {
			list.remove(0);
		}
		
		for (var i = 0; i < list.length; i++) {
			list.remove(i);
		}
		
		for (var i = 0; i < list.length; i++) {
			szov += " " + list[i].text;
		}
		for (var i = 0; i < 10; i++) {
			var option = document.createElement("option");
			option.text = "text" + i;
			list.add(option);
		}		
		$("#szovki").html(szov);
		*/
	});
</script>

<jsp:directive.include file="adminNavbar.jsp" />

<div class="row" id="adminMainpageContent">
	<div class="col-lg-2">
		<div class="panel panel-default">
			<div class="panel-heading">
				Users:
			</div>
			<div class="panel-body">
				<select  class="form-control" id="sel2">
       				<c:forEach items="${userids}" var="userid">
       				<option>${userid}</option>
       				</c:forEach>
      			</select>
      			<br />
      			<input type="button" value="Select user!" id="selectUsers" >
      			<p id="szovki"></p>     			
      			<br /><br /><br />
      			<select  class="form-control" id="sel3">
       				<option>1</option>
       				<option>2</option>
   				    <option>3</option>
    				<option>4</option>
      				<option>5</option>
      			</select>
      			<br />
      			<input type="button" value="Select device!" >
      			
      			Date picker from - to !
			</div>
		</div>
	</div>
	<div class="col-lg-10">
		<div class="panel panel-default">
			<div class="panel-heading">
				User position:
			</div>
			<div class="panel-body">
			</div>
		</div>
     
	</div>
	
</div>