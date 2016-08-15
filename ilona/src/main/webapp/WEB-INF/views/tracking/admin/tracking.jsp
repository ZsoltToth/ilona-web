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

<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="<c:url value='/js/Donut3D.js'></c:url>"></script>

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
	});
		$("#draw111").click(function(){
			var url = "<c:url value='/img/first2.jpg'></c:url>"
				
	        svgMain
	        .append("image")
	        .attr("xlink:href", url)
	        .attr("x", 0)
	        .attr("y", 0)
	        .attr("width", 1287.5)
	        .attr("height", 870);
			
			svgMain.append("circle").attr("cx", 300).attr("cy", 150).attr("r", 8);
			svgMain.append("circle").attr("cx", 350).attr("cy", 500).attr("r", 8).attr("id","circleJo");
			svgMain.append("circle").attr("cx", 700).attr("cy", 700).attr("r", 8);
		});
		
		$("#draw1").click(function(){
			//svgMain.selectAll("*").remove("*");
			var dataSet1 = [{ "x": 300,   "y": 150},  { "x": 300,  "y": 250},
			               { "x": 300,   "y": 400},  { "x": 350,  "y": 500},
			               { "x": 400,   "y": 600},  { "x": 700,  "y": 700}];
			//var lineGrapha = d3.svg.line().x( function(d) { return d.x; }).y( function(d) {return d.y; }).interpolate("linear"); // v3
			var lineGrapha = d3.line().x( function(d) { return d.x; }).y( function(d) {return d.y; }).curve(d3.curveBasis);	// v4
			svgMain.append("path").attr("d", lineGrapha(dataSet1)).attr("stroke", "blue").attr("stroke-width",5).attr("fill", "none");
			
	        //$("#circleJo").hide();
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
		var svgMain = d3.select("#trackingDrawingContent").append("svg").attr("width",1500).attr("height",1000);
		
	
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
      			
      			<input type="button" value="DRAW!" id="draw111">
      			<input type="button" value="DRAW!" id="draw1">
			</div>
		</div>
	</div>
	<div class="col-lg-10">
		<div class="panel panel-default">
			<div class="panel-heading">
				User position:
			</div>
			<div class="panel-body" id="trackingDrawingContent">
				
			</div>
		</div>
     
	</div>
	
</div>