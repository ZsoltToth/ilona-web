function trackCalculateX(posX) {
	return 1184 - (23.68 * posX);
}

function trackCalculateY(posY) {
	return 685 - 24.46 * posY;
}

function clearSelectElement(id) {
	try {
		var select = document.getElementById(id);
		while (select.size != 0) {
			select.remove(0);
		}
	} catch (error) {
		throw "Function :: clearSelectElement Error: " + error;
	}
}

function fillSelectElement(id, elements) {
	try {
		var select = document.getElementById(id);
		var length = elements.length;
		var i = 0;
		for (i; i < length; i++) {
			var option = document.createElement("option");
			option.text = elements[i];
			option.value = elements[i];
			select.add(option);
		}
	} catch (error) {
		throw "Function :: fillSelectElement Error: " + error;
	}
}

function clearAndFillSelectElement(id, elements) {
	try {
		clearSelectElement(id);
		fillSelectElement(id, elements);
	} catch (error) {
		throw "Function :: clearAndFillSelectElement Error: " + error;
	}
}

function fillDataTableWithValues(dataTable, data) {
	try {
		var length = data.length;
		var i = 0;
		for (i; i < length; i++) {
			var row = [ data[i].position.uuid, data[i].position.zone.id,
					data[i].position.zone.name, data[i].position.coordinate.x,
					data[i].position.coordinate.y,
					data[i].position.coordinate.z, new Date(data[i].date) ];
			dataTable.row.add(row).draw(false);
			// console.log("ROW: " + row);
		}
	} catch (error) {
		throw "Function :: fillDataTableWithValues Error: " + error;
	}
}

function drawArea(map, data) {
	try {
		var length = data.length;
		var i = 0;
		for (i; i < length; i++) {
			map.append("rect").attr("x", data[i].startX).attr("y",
					data[i].startY).attr("height",
					data[i].endY - data[i].startY).attr("width",
					data[i].endX - data[i].startX).attr("fill", "none").attr(
					"stroke", "red").attr("stroke-width", 1);

		}
	} catch (error) {
		console.log(error);
	}
}

function drawGraphPoints(map, data) {
	try {
		for (i in data) {
			map.append("circle").attr("cx", data[i].posX).attr("cy", data[i].posY).attr("r", 3);
		}
	} catch(error) {
		throw "Function :: drawGraphPoints Error: " + error;
	}
}

function createMap(div, imageSource) {
	try {

		$("#" + div).html("");
		floorMapSVG = d3.select("#" + div).append("svg").attr("width", "100%")
				.attr("height", "100%").attr("viewBox", "0 0 1196 705");
		floorMapSVG.append("image").attr("xlink:href", imageSource)
				.attr("x", 0).attr("y", 0).attr("width", 1196).attr("height",
						705);
		//drawGraphPoints(floorMapSVG, graphNodesFirstFloor);
		//drawArea(floorMapSVG, ZonesFirstFloor);
		return floorMapSVG;
		// drawArea(floorMapSVG, ZonesFirstFloor);
	} catch (error) {
		throw "Function :: createMap Error: " + error;
	}
}

function drawPositions(positions, floors, marker) {
	try {
		var length = positions.length;
		var i = 0;
		for (i; i < length; i++) {
			var z = positions[i].position.coordinate.z;
			var posX = trackCalculateX(positions[i].position.coordinate.x);
			var posY = trackCalculateY(positions[i].position.coordinate.y);
			if (z <= 3) {
				floors[0].append("circle").attr("cx", posX).attr("cy", posY).attr("r", 5);
				floors[0].append("image").attr("xlink:href", marker)
					.attr("x", posX - 15).attr("y", posY - 30).attr("width", 30).attr("height", 30);
				continue;
			}
			
			if (3 < z && z <= 6) {
				floors[1].append("circle").attr("cx", posX).attr("cy", posY).attr("r", 5);
				floors[1].append("image").attr("xlink:href", marker)
					.attr("x", posX - 15).attr("y", posY - 30).attr("width", 30).attr("height", 30);
				continue;
			}
			
			floors[2].append("circle").attr("cx", posX).attr("cy", posY).attr("r", 5);
			floors[2].append("image").attr("xlink:href", marker)
				.attr("x", posX - 15).attr("y", posY - 30).attr("width", 30).attr("height", 30);
			
			
		}
	} catch (error) {
		throw "Function :: drawPositions Error: " + error;
	}
}
