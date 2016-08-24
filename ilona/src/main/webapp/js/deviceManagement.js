/**
 * Device management javascript resources
 */

/**
 * Resizes the input elements.
 * The 
 */
function resizeTableElementsByClassname(classnameList) {		
	try  {
		var item = 0;
		var items = classnameList.length;
		for (item; item < items; item++) {			
			var deviceInputs = document.getElementsByClassName(classnameList[item]);
			var maxSize = 0;
			var length = deviceInputs.length;
			var i = 0;
			for(i; i < length; i++) {
				if (maxSize < deviceInputs[i].value.length) {
					maxSize = deviceInputs[i].value.length;
				}
			}
			for(i = 0; i < length; i++) {
				deviceInputs[i].size = maxSize;
			}
		}
	} catch(err) {
		console.log(err);
	}
}

function sendDeviceData(device, url) {
	try {
		
	} catch(err) {
		
	}
}