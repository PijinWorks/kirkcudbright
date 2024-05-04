controlsSetup();
getControls();

if (global.paused) {
	image_speed = 0;
	global.paused = true;
	exit;
} else {
	image_speed = 1;
}
	
if(collision_circle(x, y, radius, objTestPlayer, false, true)) && accept_key_pressed && !instance_exists(objTextBox){
	createTextBox(_text_id);
}