/**
 * 
 * @param inputs
 * @returns
 */
function resizeInputElements(inputs) {
	try {
		var length = inputs.length;
		var i = 0;
		var input;
		var minlength = 20;
		for(i; i < length; i++) {
			input = document.getElementById(inputs[i]);
			input.size = input.value.length > 20 ? input.value : 20;
		}	
	} catch (error) {
		throw "Function :: resizeInputElements Error: " + error;
	}
}