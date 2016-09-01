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

<script src="<c:url value='/js/d3.min.js'></c:url>"></script>
<script src="<c:url value='/js/Donut3D.js'></c:url>"></script>

<script type="text/javascript">

	var groundFloorImageSource = "<c:url value='/img/groundFloor.jpg'></c:url>";
	var firstFloorImageSource = "<c:url value='/img/firstFloor.jpg'></c:url>";
	var secondFloorImageSource = "<c:url value='/img/secondFloor.jpg'></c:url>";

	var floorMapSVG;
	
	var graphPontCircleRadius = 3;
	
	$(document).ready(function(){
		
	});
	
	
	$("#adminTrackingPositionsTableDrawMenuItem").click(function(event){
		event.preventDefault();
		$("#adminTrackingDrawingContent").html("Position table content!");
		
		// delete svg?!
				
		
	});
	
	$("#adminTrackingGroundFloorMapDrawMenuItem").click(function(event){
		event.preventDefault();
		$("#adminTrackingDrawingContent").html("");
		floorMapSVG = d3.select("#adminTrackingDrawingContent").append("svg").attr("width",1500).attr("height",1000);
		
		floorMapSVG
        .append("image")
        .attr("xlink:href", groundFloorImageSource)
        .attr("x", 0)
        .attr("y", 0)
        .attr("width", 1196)
        .attr("height", 705);
		
		/*
		 * AREAS
		 */
		 // TOP ROOMS
		floorMapSVG.append("rect").attr("x", 0).attr("y", 0).attr("width", 247).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 247).attr("y", 0).attr("width", 115).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 362).attr("y", 0).attr("width", 111).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 473).attr("y", 0).attr("width", 217).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 690).attr("y", 0).attr("width", 267).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 957).attr("y", 0).attr("width", 250).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		
		
		// TOP CORRIDOR	
		floorMapSVG.append("rect").attr("x", 0).attr("y", 178).attr("width", 1200).attr("height", 67)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// middle left corridor top
		floorMapSVG.append("rect").attr("x", 0).attr("y", 245).attr("width", 508).attr("height", 107)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
				
		// middle left corridor bottom
		floorMapSVG.append("rect").attr("x", 0).attr("y", 352).attr("width", 510).attr("height", 97)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Middle rooms top 		
		floorMapSVG.append("rect").attr("x", 508).attr("y", 245).attr("width", 173).attr("height", 107)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 681).attr("y", 245).attr("width", 42).attr("height", 107)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 723).attr("y", 245).attr("width", 85).attr("height", 107)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 808).attr("y", 245).attr("width", 33).attr("height", 107)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 841).attr("y", 245).attr("width", 35).attr("height", 107)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 876).attr("y", 245).attr("width", 75).attr("height", 74)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 876).attr("y", 319).attr("width", 75).attr("height", 33)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1008).attr("y", 245).attr("width", 190).attr("height", 204)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		
		// Middle rooms bottom
		
		floorMapSVG.append("rect").attr("x", 510).attr("y", 352).attr("width", 110).attr("height", 97)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 620).attr("y", 352).attr("width", 108).attr("height", 97)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 728).attr("y", 352).attr("width", 70).attr("height", 97)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 798).attr("y", 352).attr("width", 74).attr("height", 97)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 872).attr("y", 352).attr("width", 79).attr("height", 97)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);		
		
		// corridor right
		floorMapSVG.append("rect").attr("x", 951).attr("y", 178).attr("width", 57).attr("height", 342)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Bottom corridor
		
		floorMapSVG.append("rect").attr("x", 0).attr("y", 449).attr("width", 1230).attr("height", 71)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		floorMapSVG.append("rect").attr("x", 1032).attr("y", 449).attr("width", 39).attr("height", 113)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Bottom rooms
		
		floorMapSVG.append("rect").attr("x", 0).attr("y", 520).attr("width", 304).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 304).attr("y", 520).attr("width", 111).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 415).attr("y", 520).attr("width", 116).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 531).attr("y", 520).attr("width", 116).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 647).attr("y", 520).attr("width", 114).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 761).attr("y", 520).attr("width", 79).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 840).attr("y", 520).attr("width", 111).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		
		/*
			
		floorMapSVG.append("rect").attr("x", 958).attr("y", 520).attr("width", 74).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1032).attr("y", 562).attr("width", 39).attr("height", 150)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1071).attr("y", 520).attr("width", 130).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		*/
		var topInRoomLinePosY = 110;
		floorMapSVG.append("circle").attr("cx", 110).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 230).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 350).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 450).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 570).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 690).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 800).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 900).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1020).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1111).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		/*
		 * ROOM DOOR LINE
		 */
		var topRoomDoorPosY = 178;
		floorMapSVG.append("circle").attr("cx", 255).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 408).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 575).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 690).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 908).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1015).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var topCorridorPosY = 210;
		floorMapSVG.append("circle").attr("cx", 255).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 408).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 575).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 680).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 760).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);		
		floorMapSVG.append("circle").attr("cx", 908).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 978).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1015).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1120).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		
		var MiddleUpperRoomDoorPosY = 245;
		floorMapSVG.append("circle").attr("cx", 678).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 760).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 925).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1040).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var MiddleUpperInRoomLinePosY = 270;
		floorMapSVG.append("circle").attr("cx", 560).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 678).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 770).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 925).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1040).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		
		var middleLowerRoomDoorPosY = 449;
		floorMapSVG.append("circle").attr("cx", 548).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 688).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 740).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 815).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 850).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1050).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var bottomRoomDoorPosY = 520;
		floorMapSVG.append("circle").attr("cx", 253).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 330).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 448).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 560).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 672).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 785).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 900).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1050).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		floorMapSVG.append("circle").attr("cx", 1071).attr("cy", 540).attr("r", graphPontCircleRadius);
	});
	
	$("#adminTrackingFirstFloorMapDrawMenuItem").click(function(event){
		event.preventDefault();
		$("#adminTrackingDrawingContent").html("");
		floorMapSVG = d3.select("#adminTrackingDrawingContent").append("svg").attr("width",1500).attr("height",1000);
		
		floorMapSVG
        .append("image")
        .attr("xlink:href", firstFloorImageSource)
        .attr("x", 0)
        .attr("y", 0)
        .attr("width", 1196)
        .attr("height", 705);
		
		/*
		 * AREAS
		 */
		 // TOP ROOMS
		floorMapSVG.append("rect").attr("x", 0).attr("y", 0).attr("width", 285).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 285).attr("y", 0).attr("width", 231).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 516).attr("y", 0).attr("width", 113).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 629).attr("y", 0).attr("width", 111).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 740).attr("y", 0).attr("width", 222).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 962).attr("y", 0).attr("width", 250).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		
		// TOP CORRIDOR	
		floorMapSVG.append("rect").attr("x", 0).attr("y", 178).attr("width", 1200).attr("height", 67)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// middle left corridor top
		floorMapSVG.append("rect").attr("x", 0).attr("y", 245).attr("width", 507).attr("height", 106)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
				
		// middle left corridor bottom
		floorMapSVG.append("rect").attr("x", 0).attr("y", 351).attr("width", 507).attr("height", 98)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Middle rooms top 		
		floorMapSVG.append("rect").attr("x", 507).attr("y", 245).attr("width", 212).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 719).attr("y", 245).attr("width", 100).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 819).attr("y", 245).attr("width", 35).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 854).attr("y", 245).attr("width", 42).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 896).attr("y", 245).attr("width", 55).attr("height", 60)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 896).attr("y", 305).attr("width", 55).attr("height", 46)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1008).attr("y", 245).attr("width", 190).attr("height", 108)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		
		// Middle rooms bottom
		floorMapSVG.append("rect").attr("x", 507).attr("y", 351).attr("width", 104).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 611).attr("y", 351).attr("width", 102).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 713).attr("y", 351).attr("width", 81).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 794).attr("y", 351).attr("width", 38).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 832).attr("y", 351).attr("width", 38).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 870).attr("y", 351).attr("width", 81).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1008).attr("y", 353).attr("width", 200).attr("height", 96)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		
		// corridor right
		floorMapSVG.append("rect").attr("x", 951).attr("y", 178).attr("width", 57).attr("height", 342)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Bottom corridor
		
		floorMapSVG.append("rect").attr("x", 0).attr("y", 449).attr("width", 1230).attr("height", 71)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		floorMapSVG.append("rect").attr("x", 1032).attr("y", 449).attr("width", 39).attr("height", 113)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Bottom rooms
		
		floorMapSVG.append("rect").attr("x", 0).attr("y", 520).attr("width", 273).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 273).attr("y", 520).attr("width", 120).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 393).attr("y", 520).attr("width", 111).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 504).attr("y", 520).attr("width", 116).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 620).attr("y", 520).attr("width", 114).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 734).attr("y", 520).attr("width", 114).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 848).attr("y", 520).attr("width", 110).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 958).attr("y", 520).attr("width", 74).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1032).attr("y", 562).attr("width", 39).attr("height", 150)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1071).attr("y", 520).attr("width", 130).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		
		var topInRoomLinePosY = 110;
		floorMapSVG.append("circle").attr("cx", 110).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 230).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 350).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 450).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 570).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 690).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 800).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 900).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1020).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1111).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		/*
		 * ROOM DOOR LINE
		 */
		var topRoomDoorPosY = 178;
		floorMapSVG.append("circle").attr("cx", 255).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 408).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 575).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 690).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 908).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1015).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var topCorridorPosY = 210;
		floorMapSVG.append("circle").attr("cx", 255).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 408).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 575).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 680).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 760).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);		
		floorMapSVG.append("circle").attr("cx", 908).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 978).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1015).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1120).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		
		var MiddleUpperRoomDoorPosY = 245;
		floorMapSVG.append("circle").attr("cx", 678).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 760).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 925).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1040).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var MiddleUpperInRoomLinePosY = 270;
		floorMapSVG.append("circle").attr("cx", 560).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 678).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 770).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 925).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1040).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		
		var middleLowerRoomDoorPosY = 449;
		floorMapSVG.append("circle").attr("cx", 548).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 688).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 740).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 815).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 850).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1050).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var bottomRoomDoorPosY = 520;
		floorMapSVG.append("circle").attr("cx", 253).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 330).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 448).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 560).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 672).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 785).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 900).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1050).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		floorMapSVG.append("circle").attr("cx", 1071).attr("cy", 540).attr("r", graphPontCircleRadius);
	});
	
	$("#adminTrackingSecondFloorMapDrawMenuItem").click(function(event){
		event.preventDefault();
		$("#adminTrackingDrawingContent").html("");
		floorMapSVG = d3.select("#adminTrackingDrawingContent").append("svg").attr("width",1500).attr("height",1000);
		
		floorMapSVG
        .append("image")
        .attr("xlink:href", secondFloorImageSource)
        .attr("x", 0)
        .attr("y", 0)
        .attr("width", 1196)
        .attr("height", 705);
	
		/*
		 * AREAS
		 */
		 // TOP ROOMS
		floorMapSVG.append("rect").attr("x", 0).attr("y", 0).attr("width", 285).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 285).attr("y", 0).attr("width", 231).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 516).attr("y", 0).attr("width", 113).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 629).attr("y", 0).attr("width", 111).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 740).attr("y", 0).attr("width", 222).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 962).attr("y", 0).attr("width", 250).attr("height", 178)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		
		// TOP CORRIDOR	
		floorMapSVG.append("rect").attr("x", 0).attr("y", 178).attr("width", 1200).attr("height", 67)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// middle left corridor top
		floorMapSVG.append("rect").attr("x", 0).attr("y", 245).attr("width", 507).attr("height", 106)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
				
		// middle left corridor bottom
		floorMapSVG.append("rect").attr("x", 0).attr("y", 351).attr("width", 507).attr("height", 98)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Middle rooms top 		
		floorMapSVG.append("rect").attr("x", 507).attr("y", 245).attr("width", 212).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 719).attr("y", 245).attr("width", 100).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 819).attr("y", 245).attr("width", 35).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 854).attr("y", 245).attr("width", 42).attr("height", 106)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 896).attr("y", 245).attr("width", 55).attr("height", 60)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 896).attr("y", 305).attr("width", 55).attr("height", 46)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1008).attr("y", 245).attr("width", 190).attr("height", 108)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		
		// Middle rooms bottom
		floorMapSVG.append("rect").attr("x", 507).attr("y", 351).attr("width", 104).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 611).attr("y", 351).attr("width", 102).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 713).attr("y", 351).attr("width", 81).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 794).attr("y", 351).attr("width", 38).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 832).attr("y", 351).attr("width", 38).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 870).attr("y", 351).attr("width", 81).attr("height", 98)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1008).attr("y", 353).attr("width", 200).attr("height", 96)
		.attr("fill", "none").attr("stroke", "green").attr("stroke-width",1);
		
		// corridor right
		floorMapSVG.append("rect").attr("x", 951).attr("y", 178).attr("width", 57).attr("height", 342)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Bottom corridor
		
		floorMapSVG.append("rect").attr("x", 0).attr("y", 449).attr("width", 1230).attr("height", 71)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		floorMapSVG.append("rect").attr("x", 1032).attr("y", 449).attr("width", 39).attr("height", 113)
		.attr("fill", "none").attr("stroke", "blue").attr("stroke-width",1);
		
		// Bottom rooms
		
		floorMapSVG.append("rect").attr("x", 0).attr("y", 520).attr("width", 273).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 273).attr("y", 520).attr("width", 120).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 393).attr("y", 520).attr("width", 111).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 504).attr("y", 520).attr("width", 116).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 620).attr("y", 520).attr("width", 114).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 734).attr("y", 520).attr("width", 114).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 848).attr("y", 520).attr("width", 110).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 958).attr("y", 520).attr("width", 74).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1032).attr("y", 562).attr("width", 39).attr("height", 150)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		floorMapSVG.append("rect").attr("x", 1071).attr("y", 520).attr("width", 130).attr("height", 200)
		.attr("fill", "none").attr("stroke", "red").attr("stroke-width",1);
		
		var topInRoomLinePosY = 110;
		floorMapSVG.append("circle").attr("cx", 110).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 230).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 350).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 450).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 570).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 690).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 800).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 900).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1020).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1111).attr("cy", topInRoomLinePosY).attr("r", graphPontCircleRadius);
		/*
		 * ROOM DOOR LINE
		 */
		var topRoomDoorPosY = 178;
		floorMapSVG.append("circle").attr("cx", 255).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 408).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 575).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 690).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 908).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1015).attr("cy", topRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var topCorridorPosY = 210;
		floorMapSVG.append("circle").attr("cx", 255).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 408).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 575).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 680).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 760).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);		
		floorMapSVG.append("circle").attr("cx", 908).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 978).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1015).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1120).attr("cy", topCorridorPosY).attr("r", graphPontCircleRadius);
		
		var MiddleUpperRoomDoorPosY = 245;
		floorMapSVG.append("circle").attr("cx", 678).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 760).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 925).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1040).attr("cy", MiddleUpperRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var MiddleUpperInRoomLinePosY = 270;
		floorMapSVG.append("circle").attr("cx", 560).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 678).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 770).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 835).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 925).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1040).attr("cy", MiddleUpperInRoomLinePosY).attr("r", graphPontCircleRadius);
		
		var middleLowerRoomDoorPosY = 449;
		floorMapSVG.append("circle").attr("cx", 548).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 688).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 740).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 815).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 850).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1050).attr("cy", middleLowerRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		var bottomRoomDoorPosY = 520;
		floorMapSVG.append("circle").attr("cx", 253).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 330).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 448).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 560).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 672).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 785).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 900).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		floorMapSVG.append("circle").attr("cx", 1050).attr("cy", bottomRoomDoorPosY).attr("r", graphPontCircleRadius);
		
		floorMapSVG.append("circle").attr("cx", 1071).attr("cy", 540).attr("r", graphPontCircleRadius);
		
	});
	
	
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
			$("#adminTrackingDrawingContent").html("");
			svgMain = d3.select("#adminTrackingDrawingContent").append("svg").attr("width","100%").attr("height","100%")
				.attr("viewBox", "0 0 1500 1000");
	        svgMain
	        .append("image")
	        .attr("xlink:href", url)
	        .attr("x", 0)
	        .attr("y", 0)
	        .attr("width", 1200) // 1200
	        .attr("height", 700); // 700
			
	        svgMain.append("circle").attr("cx", 0).attr("cy", 0).attr("r", 100).attr("id","myID")
	        	.on("click", function(d,i) {
	        		alert("D: " + d);
	        		alert("i: " + i);
	        		alert("ID:" + d3.select(this).attr("id"));
	        	});
	        
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
		var svgMain = d3.select("#adminTrackingDrawingContent").append("svg").attr("width",1500).attr("height",1000);
		
		$("#draw2").click(function(event){
			svgMain = d3.select("#adminTrackingDrawingContent").append("svg").attr("width",1500).attr("height",1000).attr("viewBox","0 0 1500 1000");
			svgMain.append("circle").attr("cx", 335).attr("cy", 600).attr("r", 5);
		});

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
	      			<br />
				</div>
			</div>
		</div>
		
		<div class="col-lg-2">
			<div class="panel panel-default">
				<div class="panel-heading">
					Devices:
				</div>
				<div class="panel-body">
   			
	      			<select  class="form-control" id="sel3">
	       				<option>1</option>
	       				<option>2</option>
	   				    <option>3</option>
	    				<option>4</option>
	      				<option>5</option>
	      			</select>
	      			<br />
	      			<input type="button" value="Select device!" >   			
				</div>
			</div>
		</div>
		
		<div class="col-lg-2">
			<div class="panel panel-default">
				<div class="panel-heading">
					Position details:
				</div>
				<div class="panel-body">	
	      			<br />
	      			<input type="text" value="Select device!" >
			</div>
			</div>
		</div>
		
		<div class="col-lg-6">
			<div class="panel panel-default">
				<div class="panel-heading">			
					Date picker from - to !	      			
	      			<input type="button" value="DRAW111!" id="draw111">
	      			<input type="button" value="DRAW1!" id="draw1"><br />
	      			<input type="button" value="DRAW2!" id="draw2">
				</div>
				
			</div>
	     
		</div>
		
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<ul class="breadcrumb">
					  <li><a id="adminTrackingPositionsTableDrawMenuItem" href="#">Positions table</a></li>
					  <li><a id="adminTrackingGroundFloorMapDrawMenuItem" href="#">Ground floor</a></li>
					  <li><a id="adminTrackingFirstFloorMapDrawMenuItem" href="#">First floor</a></li>
					  <li><a id="adminTrackingSecondFloorMapDrawMenuItem">Second floor</a></li> 
					</ul>
				</div>
				<div class="panel-body" id="adminTrackingDrawingContent">
					
				</div>
			</div>
		</div>
	</div>
</div>