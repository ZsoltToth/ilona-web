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


	var zones = [
	             {
	            	 zoneid: "zone1",
	            	 startx: 0,
	            	 starty: 0,
	            	 endx: 291,
	            	 endy: 180,
	            	 points: []
	             },
	             {
	            	 zoneid: "zone2",
	            	 startx: 291,
	            	 starty: 0,
	            	 endx: 519,
	            	 endy: 180,
	            	 points: []
	             },
	             {
	            	 zoneid: "zone3",
	            	 startx: 519,
	            	 starty: 0,
	            	 endx: 632,
	            	 endy: 180,
	            	 points: []
	             },
	             {
	            	 zoneid: "zone4",
	            	 startx: 632,
	            	 starty: 0,
	            	 endx: 961,
	            	 endy: 180,
	            	 points: []
	             },
	             {
	            	 zoneid: "zone5",
	            	 startx: 0,
	            	 starty: 180,
	            	 endx: 1250,
	            	 endy: 243,
	            	 points: []
	             }];
	var points = [{
		pointid: "point1",
		pointx: 110,
		pointy: 90
	}, {
		pointid: "point2",
		pointx: 205,
		pointy: 175
	}, {
		pointid: "point3",
		pointx: 405,
		pointy: 210
	}, {
		pointid: "point4",
		pointx: 585,
		pointy: 175
	}, {
		pointid: "point5",
		pointx: 585,
		pointy: 95
	}];

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
			var url = "<c:url value='/img/ilona-firstFloor.jpg'></c:url>"
			
			var urlMarker = "<c:url value='/img/marker.png'></c:url>"
			
	        svgMain
	        .append("image")
	        .attr("xlink:href", url)
	        .attr("x", 0)
	        .attr("y", 0)
	        .attr("width", 1200)
	        .attr("height", 700);
			
			svgMain
		    	.append("image")
		        .attr("xlink:href", urlMarker)
		        .attr("x", 400)
		        .attr("y", 300)
		        .attr("width", 30)
		        .attr("height", 30);
			
			var circleRadius = 3;
			
			/*
			 * TOP ROOMS AREA
			 */
			svgMain.append("rect").attr("x", 0).attr("y", 0).attr("height", 180).attr("width", 291)
				.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
			
			svgMain.append("rect").attr("x", 291).attr("y", 0).attr("height", 180).attr("width", 228)
			.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
			
			svgMain.append("rect").attr("x", 519).attr("y", 0).attr("height", 180).attr("width", 113)
			.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
			
			svgMain.append("rect").attr("x", 632).attr("y", 0).attr("height", 180).attr("width", 329)
			.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
			
			svgMain.append("rect").attr("x", 961).attr("y", 0).attr("height", 180).attr("width", 230)
			.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
			
			/*
			 * TOP CORRIDOR AREA
			 */
			 svgMain.append("rect").attr("x", 0).attr("y", 180).attr("height", 63).attr("width", 1250)
				.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
			
			 svgMain.append("rect").attr("x", 0).attr("y", 243).attr("height", 273).attr("width", 512)
				.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
			/*
			 * LINE-1 inner room
			 */
			svgMain.append("circle").attr("cx", 110).attr("cy", 95).attr("r", circleRadius); // LINE-1-1
			svgMain.append("circle").attr("cx", 205).attr("cy", 95).attr("r", circleRadius); // LINE-1-2
			svgMain.append("circle").attr("cx", 405).attr("cy", 95).attr("r", circleRadius); // LINE-1-3
			svgMain.append("circle").attr("cx", 585).attr("cy", 95).attr("r", circleRadius); // LINE-1-4
			svgMain.append("circle").attr("cx", 765).attr("cy", 95).attr("r", circleRadius); // LINE-1-5
			svgMain.append("circle").attr("cx", 870).attr("cy", 95).attr("r", circleRadius); // LINE-1-6
			svgMain.append("circle").attr("cx", 1030).attr("cy", 95).attr("r", circleRadius); // LINE-1-7
			svgMain.append("circle").attr("cx", 1120).attr("cy", 95).attr("r", circleRadius); // LINE-1-8
			
			/*
			 * Line-2 doors
			 */
			svgMain.append("circle").attr("cx", 205).attr("cy", 175).attr("r", circleRadius); 
			svgMain.append("circle").attr("cx", 405).attr("cy", 175).attr("r", circleRadius).attr("id","circleJo");
			svgMain.append("circle").attr("cx", 585).attr("cy", 175).attr("r", circleRadius); 
			svgMain.append("circle").attr("cx", 765).attr("cy", 175).attr("r", circleRadius); 
			svgMain.append("circle").attr("cx", 1030).attr("cy", 175).attr("r", circleRadius); 
			
			/*
			 * Line-3 top corridor
			 */
			svgMain.append("circle").attr("cx", 205).attr("cy", 205).attr("r", circleRadius); 
			svgMain.append("circle").attr("cx", 405).attr("cy", 210).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 585).attr("cy", 210).attr("r", circleRadius);			
			svgMain.append("circle").attr("cx", 585).attr("cy", 210).attr("r", circleRadius);		
			svgMain.append("circle").attr("cx", 765).attr("cy", 210).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 835).attr("cy", 210).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 895).attr("cy", 210).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 980).attr("cy", 210).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1080).attr("cy", 210).attr("r", circleRadius);
			
			/*
			 * Line-4 middle room door
			 */		
			svgMain.append("circle").attr("cx", 560).attr("cy", 242).attr("r", circleRadius); 		
			svgMain.append("circle").attr("cx", 760).attr("cy", 242).attr("r", circleRadius); 		
			svgMain.append("circle").attr("cx", 835).attr("cy", 242).attr("r", circleRadius); 			
			svgMain.append("circle").attr("cx", 895).attr("cy", 242).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1080).attr("cy", 242).attr("r", circleRadius);
			
			/*
			 * Line-5 middle upper room inner
			 */
			svgMain.append("circle").attr("cx", 250).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 405).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 560).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 660).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 760).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 835).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 895).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 980).attr("cy", 295).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1080).attr("cy", 295).attr("r", circleRadius);
			
			/*
			 * Line-6 middle lower room inner
			 */
			svgMain.append("circle").attr("cx", 405).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 560).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 660).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 755).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 815).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 850).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 905).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 980).attr("cy", 399).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1080).attr("cy", 399).attr("r", circleRadius);
			
			/*
			 * Line-7 middle lower room door
			 */
			svgMain.append("circle").attr("cx", 575).attr("cy", 445).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 675).attr("cy", 445).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 755).attr("cy", 445).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 815).attr("cy", 445).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 850).attr("cy", 445).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 920).attr("cy", 445).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1070).attr("cy", 445).attr("r", circleRadius);
			
			/*
			 * Line-3 top corridor
			 */
			svgMain.append("circle").attr("cx", 410).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 575).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 675).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 755).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 815).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 850).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 915).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 980).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1050).attr("cy", 480).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1130).attr("cy", 480).attr("r", circleRadius);
			
			/*
			 * Line-3 top corridor
			 */
			svgMain.append("circle").attr("cx", 150).attr("cy", 515).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 340).attr("cy", 515).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 445).attr("cy", 515).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 565).attr("cy", 515).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 690).attr("cy", 515).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 790).attr("cy", 515).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 905).attr("cy", 515).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1050).attr("cy", 515).attr("r", circleRadius);	
			
			/*
			 * Line-3 top corridor
			 */
			svgMain.append("circle").attr("cx", 1030).attr("cy", 540).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 1070).attr("cy", 535).attr("r", circleRadius);	
			
			/*
			 * Line-3 top corridor
			 */
			svgMain.append("circle").attr("cx", 335).attr("cy", 600).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 450).attr("cy", 600).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 565).attr("cy", 600).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 680).attr("cy", 600).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 790).attr("cy", 600).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 900).attr("cy", 600).attr("r", circleRadius);	
			svgMain.append("circle").attr("cx", 1010).attr("cy", 600).attr("r", circleRadius);
			svgMain.append("circle").attr("cx", 1130).attr("cy", 600).attr("r", circleRadius);	
			
			
		});
		
		$("#draw1").click(function(){
			var startLocation = [108,85];
			var endLocation=[580,93];

			var startPoint;
			var endPoint;
			// calculated start point
			startPoint = points[0];
			var distance = Math.sqrt(Math.pow(points[0].pointx - startLocation[0],2)+
					Math.pow(points[0].pointy - startLocation[1],2));
			for(var i = 1; i < points.length; i++) {
				var distancePoints = Math.sqrt(Math.pow(points[i].pointx - startLocation[0],2)+
						Math.pow(points[i].pointy - startLocation[1],2));
				if(distance > distancePoints) {
					distance = distancePoints;
					startPoint = points[i];
				}
			}
			endPoint = points[0];
			distance = Math.sqrt(Math.pow(points[0].pointx - endLocation[0],2)+
					Math.pow(points[0].pointy - endLocation[1],2));
			
			for(var i = 1; i < points.length; i++) {
				var distancePoints = Math.sqrt(Math.pow(points[i].pointx - endLocation[0],2)+
						Math.pow(points[i].pointy - endLocation[1],2));
				if(distance > distancePoints) {
					distance = distancePoints;
					endPoint = points[i];
				}
			}
			//alert(startPoint.pointid);
			//alert(endPoint.pointid);
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var actualPoint;
			$.ajax({
				type : "POST",
				async : false,
				url : "<c:url value='/tracking/admin/tracking/calculatedpath' ></c:url>",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					start : startPoint.pointid,
					end : endPoint.pointid
				},
				success : function(result, status, xhr) {
					actualPoint = result;
				},
				error : function(xhr, status, error) {
					alert("Error" + status + error);
				}
				
			});
			
			var drawPoints = [];
			for(var i = 0; i < actualPoint.length; i++) {
				for(var j = 0; j < points.length; j++) {
					if(points[j].pointid == actualPoint[i]) {
						drawPoints.push(points[j]);
						continue;
					}
				}
			}
			
			
			//alert(drawPoints);
			//svgMain.selectAll("*").remove("*");
			var startPointData =[];
			startPointData.push({"x" : startLocation[0], "y": startLocation[1]});
			for(var i = 0; i < drawPoints.length; i++) {
				startPointData.push({"x": drawPoints[i].pointx, "y": drawPoints[i].pointy});
			}
			startPointData.push({"x": endLocation[0], "y": endLocation[1]});
			/*
			
			var dataSet1 = [{ "x": 300,   "y": 150},  { "x": 300,  "y": 250},
			               { "x": 300,   "y": 400},  { "x": 350,  "y": 500},
			               { "x": 400,   "y": 600},  { "x": 700,  "y": 700}];
			*/
			//var lineGrapha = d3.svg.line().x( function(d) { return d.x; }).y( function(d) {return d.y; }).interpolate("linear"); // v3
			var lineGrapha = d3.line().x( function(d) { return d.x; }).y( function(d) {return d.y; }).curve(d3.curveBasis);	// v4
			svgMain.append("path").attr("d", lineGrapha(startPointData)).attr("stroke", "blue").attr("stroke-width",2).attr("fill", "none");
			var urlMarker = "<c:url value='/img/marker.png'></c:url>"
			svgMain
	    	.append("image")
	        .attr("xlink:href", urlMarker)
	        .attr("x", startLocation[0] - 7)
	        .attr("y", startLocation[0] - 40)
	        .attr("width", 14)
	        .attr("height", 20);
			
			svgMain
	    	.append("image")
	        .attr("xlink:href", urlMarker)
	        .attr("x", endLocation[0] - 30)
	        .attr("y", endLocation[1] - 30)
	        .attr("width", 30)
	        .attr("height", 30)
	        .attr("id","vege");
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
<div class="container-fluid">
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
	      			
	      			<input type="button" value="DRAW111!" id="draw111"><br />
	      			<input type="button" value="DRAW1!" id="draw1"><br />
	      			<input type="button" value="DRAW2!" id="draw2">
				</div>
			</div>
		</div>
		<div class="col-lg-10">
			<div class="panel panel-default">
				<div class="panel-heading">
					User position:
					<ul class="breadcrumb">
					  <li><a href="#">Home</a></li>
					  <li><a href="#">Private</a></li>
					  <li><a href="#">Pictures</a></li>
					  <li class="active">Vacation</li> 
					</ul>
				</div>
				<div class="panel-body" id="trackingDrawingContent">
					
				</div>
			</div>
	     
		</div>
		
	</div>
</div>