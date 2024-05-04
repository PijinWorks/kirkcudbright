if (global.paused = true) {
image_speed = 0;
speed = 0;
}

if (fadeOut) {
    image_alpha += fadeSpeed;
    if (image_alpha >= 1) {
        fadeOut = false;
		global.paused = true;
		room_goto(rmInit);
    }
} else {
	if (image_alpha >= 0) {
    image_alpha -= fadeSpeed;
	global.paused = true;
	} else { 
		global.paused = false; 
		}
}