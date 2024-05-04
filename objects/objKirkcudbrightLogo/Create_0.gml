global.mainLogoSequence = -1;

function createLogo () {
	// Create logo instance
	var mainLogo = layer_create(-1000000000, "MainLogo");
	
	// Create logo sequence
	global.mainLogoSequence = layer_sequence_create("MainLogo", x, y, seqKirkcudbrightLogo);
}