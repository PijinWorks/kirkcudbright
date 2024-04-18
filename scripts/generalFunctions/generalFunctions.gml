function controlsSetup()
{
	buffer_time = 3;
	
	jump_key_buffered = 0;
	jump_key_buffer_timer = 0;	
}

function getControls()
{
	// directional inputs
	right_key = keyboard_check(ord("D")) + gamepad_button_check(0, gp_padr);
	right_key = clamp(right_key, 0, 1);
	
	left_key = keyboard_check(ord("A")) + gamepad_button_check(0, gp_padl);
	left_key = clamp(left_key, 0, 1);
	
	up_key = keyboard_check(ord("W")) + gamepad_button_check(0 ,gp_padu);
	up_key = clamp(up_key, 0, 1);
	
	down_key = keyboard_check(ord("S")) + gamepad_button_check(0 ,gp_padd);
	down_key = clamp(down_key, 0, 1);
	
	//action inputs
	running_key_pressed = keyboard_check_pressed(vk_shift) + gamepad_button_check_pressed(0, gp_face2);
	running_key_pressed = clamp(running_key_pressed, 0, 1);
	
	jump_key_pressed = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face2);
	jump_key_pressed = clamp(jump_key_pressed, 0, 1);
	
	jump_key = keyboard_check(vk_space) + (gamepad_button_check(0, gp_face2));
	jump_key = clamp(jump_key, 0, 1);
	
	// jump key buffering
	if jump_key_pressed 
	{
		jump_key_buffer_timer = buffer_time;
	}
	
	if jump_key_buffer_timer > 0
	{
		jump_key_buffered = 1;
		jump_key_buffer_timer--;
	} else {
		jump_key_buffered = 0;
	}
}