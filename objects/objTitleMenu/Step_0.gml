// get inputs
// Get Controls
getControls();
accept_key_pressed = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face2);
accept_key_pressed = clamp(accept_key_pressed, 0, 1);

// Store number of options in current menu
opLength = array_length(option[menuLevel]);

// Move through the menu using called controls
pos += crouch_key_pressed - up_key_pressed;
if pos >= opLength {
	pos = 0;
}

if pos < 0 {
	pos = opLength - 1;
}

// using the options
if (accept_key_pressed) {

var startMenuLevel = menuLevel;

switch(menuLevel) {
			case 0:
				switch(pos) {
					// Start Game
						case 0:
							instance_create_depth(0, 0, -10000, objFade);
							break;
					// Load Game
						case 1:
							break;
					// Gallery
						case 2:
							break;
					// Settings
						case 3:
							menuLevel = 3;
							break;
					// Quit Game
						case 4:
							instance_create_depth(0, 0, -10000000000, objFade);
							game_end();
							break;
					}
			break;
			
// Settings Menu
	case 3:
		switch(pos) {
			// Window size
			case 0:
				break;
			// Brightness
			case 1:
				break;
			// Controls
			case 2:
				break;
			// Back to Main Menu
			case 3:
				menuLevel = 0;
				break;
			}
		}
		
		if startMenuLevel != menuLevel {
			pos = 0;
			opLength = array_length(option[menuLevel]);
		}
}