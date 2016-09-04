var graphNodes = {
	N1 : {
		name : "room100Inner",
		posX : 230,
		posY : 110
	},
	N2 : {
		name : "room100Door",
		posX : 255,
		posY : 178
	},
	N3 : {
		name : "room101Inner",
		posX : 400,
		posY : 110
	},
	N4 : {
		name : "room101Door",
		posX : 408,
		posY : 178
	},
	N5 : {
		name : "room102Inner",
		posX : 570,
		posY : 110
	},
	N6 : {
		name : "room102Door",
		posX : 575,
		posY : 178
	},
	N7 : {
		name : "room103Inner",
		posX : 690,
		posY : 110
	},
	N8 : {
		name : "room103Door",
		posX : 690,
		posY : 178
	},
	N9 : {
		name : "room104Inner",
		posX : 850,
		posY : 110
	},
	N10 : {
		name : "room104Door",
		posX : 908,
		posY : 178
	},
	N11 : {
		name : "room105Inner",
		posX : 1080,
		posY : 110
	},
	N12 : {
		name : "room105Door",
		posX : 1015,
		posY : 178
	},
	N13 : {
		name : "topCorridor1",
		posX : 255,
		posY : 210
	},
	N14 : {
		name : "topCorridor2",
		posX : 408,
		posY : 210
	},
	N15 : {
		name : "topCorridor3",
		posX : 575,
		posY : 210
	},
	N16 : {
		name : "topCorridor4",
		posX : 690,
		posY : 210
	},
	N17 : {
		name : "topCorridor5",
		posX : 908,
		posY : 210
	},
	N18 : {
		name : "topCorridor6",
		posX : 1015,
		posY : 210
	}
};

var ZonesFirstFloor = [ {
	name : "room100",
	startX : 0,
	starY : 0,
	endX : 285,
	endY : 178,
	Points : [ graphNodes["N1"] ]
}, {
	name : "room101",
	startX : 285,
	starY : 0,
	endX : 516,
	endY : 178,
	Points : []
}, {
	name : "room102",
	startX : 516,
	starY : 0,
	endX : 629,
	endY : 178,
	Points : []
}, {
	name : "room103",
	startX : 629,
	starY : 0,
	endX : 740,
	endY : 178,
	Points : []
}, {
	name : "room104",
	startX : 740,
	starY : 0,
	endX : 962,
	endY : 178,
	Points : []
}, {
	name : "room105",
	startX : 962,
	starY : 0,
	endX : 1212,
	endY : 178,
	Points : []
}, {
	name : "topCorridor",
	startX : 0,
	starY : 178,
	endX : 1200,
	endY : 245,
	Points : []
} ];
