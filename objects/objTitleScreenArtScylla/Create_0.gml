global.mainTitleArtSequence = -1;

function createTitleArt () {
	// Create art instance
	var mainTitleArt = layer_create(-1000, "MainTitleArt");
	
	// Create art sequence
	global.mainTitleArtSequence = layer_sequence_create("MainTitleArt", x+50, y, seqTitleScreenScylla);
}