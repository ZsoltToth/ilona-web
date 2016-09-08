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
					data[i].endY - data[i].startY).attr("width", data[i].endX - data[i].startX).attr(
					"fill", "none").attr("stroke", "red").attr("stroke-width",
					1);

		}
	} catch (error) {
		console.log(error);
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
		drawArea(floorMapSVG, ZonesFirstFloor);
	} catch (error) {
		throw "Function :: createMap Error: " + error;
	}
}